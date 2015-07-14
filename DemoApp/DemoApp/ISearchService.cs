using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using DemoApp.Models;
using Microsoft.Azure.Search.Models;

namespace DemoApp
{
    public interface ISearchService
    {
        Task<DocumentSearchResponse<ProductInfo>> SearchAsync(string searchText, string color, string category, string subcategory, double? priceFrom, double? priceTo, string sort);
        Task<IList<SuggestResult<ProductInfo>>> SuggestAsync(string searchText);
    }
}