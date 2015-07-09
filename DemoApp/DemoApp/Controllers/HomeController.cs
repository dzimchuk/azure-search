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

        public async Task<ActionResult> Search(string searchText, string color, string category, string subcategory, double? priceFrom, double? priceTo, string sort)
        {
            var result = await searchService.SearchAsync(searchText, color, category, subcategory, priceFrom, priceTo, sort);
            ViewBag.SearchText = searchText;
            ViewBag.Color = color;
            ViewBag.Category = category;
            ViewBag.Subcategory = subcategory;
            ViewBag.PriceFrom = priceFrom;
            ViewBag.PriceTo = priceTo;
            ViewBag.Sort = sort;

            return View("Index", result);
        }
    }
}