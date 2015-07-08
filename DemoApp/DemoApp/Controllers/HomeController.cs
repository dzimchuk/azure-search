using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace DemoApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ISearchService searchService;

        public HomeController(ISearchService searchService)
        {
            this.searchService = searchService;
        }

        public ActionResult Index()
        {
            return View();
        }

        public async Task<ActionResult> Search(string searchText)
        {
            var result = await searchService.SearchAsync(searchText);
            ViewBag.searchText = searchText ?? string.Empty;
            
            return View("Index", result);
        }
    }
}