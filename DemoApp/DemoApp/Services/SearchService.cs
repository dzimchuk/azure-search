using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
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

        public async Task<IList<SearchResult<ProductInfo>>> SearchAsync(string searchText)
        {
            if (string.IsNullOrWhiteSpace(searchText))
                searchText = "*";

            var parameters = new SearchParameters
            {
                SearchMode = SearchMode.All,
                HighlightFields = new List<string> { "Name", "Description" },
                HighlightPreTag = "<b>",
                HighlightPostTag = "</b>"
            };

            var result = await indexClient.Documents.SearchAsync<ProductInfo>(searchText, parameters);
            return result.StatusCode != HttpStatusCode.OK ? null : result.Results;
        }
    }
}