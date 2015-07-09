using System;
using System.Threading.Tasks;
using DemoApp.Models;
using Microsoft.Azure.Search.Models;

namespace DemoApp.Controllers
{
    public interface ISearchService
    {
        Task<DocumentSearchResponse<ProductInfo>> SearchAsync(string searchText, string color, string category, string subcategory, double? priceFrom, double? priceTo, string sort);
    }
}