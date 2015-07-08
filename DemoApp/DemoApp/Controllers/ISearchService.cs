using System.Collections.Generic;
using System.Threading.Tasks;
using DemoApp.Models;
using Microsoft.Azure.Search.Models;

namespace DemoApp.Controllers
{
    public interface ISearchService
    {
        Task<IList<SearchResult<ProductInfo>>> SearchAsync(string searchText);
    }
}