using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using DemoApp.Controllers;
using DemoApp.Models;
using Microsoft.Azure.Search;
using Microsoft.Azure.Search.Models;

namespace DemoApp.Services
{
    internal class SearchService : ISearchService
    {
        private readonly ISearchIndexClient indexClient;

        public SearchService()
        {
            indexClient = new SearchIndexClient(
                ConfigurationManager.AppSettings["search:service"],
                ConfigurationManager.AppSettings["search:index"],
                new SearchCredentials(ConfigurationManager.AppSettings["search:key"]));
        }

        public async Task<DocumentSearchResponse<ProductInfo>> SearchAsync(string searchText, string color, string category, string subcategory, double? priceFrom, double? priceTo, string sort)
        {
            if (string.IsNullOrWhiteSpace(searchText))
                searchText = "*";

            var parameters = new SearchParameters
            {
                SearchMode = SearchMode.All,
                HighlightFields = new List<string> { "Name", "Description" },
                HighlightPreTag = "<b>",
                HighlightPostTag = "</b>",
                IncludeTotalResultCount = true,
                Top = 10,
                Facets = new List<string> { "Color", "ListPrice,values:10|25|100|500|1000|2500", "Subcategory", "Category" }
            };

            var filter = BuildFilter(color, category, subcategory, priceFrom, priceTo);
            if (!string.IsNullOrEmpty(filter))
                parameters.Filter = filter;

            if (!string.IsNullOrWhiteSpace(sort))
                parameters.OrderBy = new List<string> { sort };

            var result = await indexClient.Documents.SearchAsync<ProductInfo>(searchText, parameters);
            return result.StatusCode != HttpStatusCode.OK ? null : result;
        }

        public async Task<IList<SuggestResult<ProductInfo>>> SuggestAsync(string searchText)
        {
            var parameters = new SuggestParameters
            {
                UseFuzzyMatching = true,
//                HighlightPreTag = "<b>",
//                HighlightPostTag = "</b>"
            };

            var result = await indexClient.Documents.SuggestAsync<ProductInfo>(searchText, "product-suggester", parameters);
            return result.StatusCode != HttpStatusCode.OK ? null : result.Results;
        }

        private static string BuildFilter(string color, string category, string subcategory, double? priceFrom, double? priceTo)
        {
            var filter = new StringBuilder();

            if (!string.IsNullOrWhiteSpace(color))
            {
                filter.AppendFormat("Color eq '{0}'", EscapeODataString(color));
            }

            if (!string.IsNullOrWhiteSpace(category))
            {
                AppendAnd(filter);
                filter.AppendFormat("Category eq '{0}'", EscapeODataString(category));
            }

            if (!string.IsNullOrWhiteSpace(subcategory))
            {
                AppendAnd(filter);
                filter.AppendFormat("Subcategory eq '{0}'", EscapeODataString(subcategory));
            }

            if (priceFrom.HasValue)
            {
                AppendAnd(filter);
                filter.AppendFormat(CultureInfo.InvariantCulture, "ListPrice ge {0}", priceFrom);
            }

            if (priceTo.HasValue && priceTo > 0)
            {
                AppendAnd(filter);
                filter.AppendFormat(CultureInfo.InvariantCulture, "ListPrice le {0}", priceTo);
            }

            return filter.ToString();
        }

        private static void AppendAnd(StringBuilder filter)
        {
            if (filter.Length > 0)
                filter.Append(" and ");
        }

        private static string EscapeODataString(string s)
        {
            return Uri.EscapeDataString(s).Replace("\'", "\'\'");
        }
    }
}