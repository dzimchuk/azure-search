using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using DemoApp.Models;

namespace DemoApp.Controllers
{
    public class ProductController : Controller
    {
        private readonly IDocumentService documentService;
        private readonly IProductMapper productMapper;

        public ProductController(IDocumentService documentService, IProductMapper productMapper)
        {
            this.documentService = documentService;
            this.productMapper = productMapper;
        }

        public async Task<ActionResult> Details(int id)
        {
            var document = await documentService.FindAsync(id);
            if (document == null)
                return HttpNotFound();

            return View(productMapper.MapFrom(document));
        }

        public async Task<ActionResult> Edit(int id)
        {
            var document = await documentService.FindAsync(id);
            if (document == null)
                return HttpNotFound();

            return View(productMapper.MapFrom(document));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(Product product)
        {
            if (ModelState.IsValid)
            {
                await documentService.UpdateAsync(productMapper.MapFrom(product));
                return View("Complete", product);
            }

            return View(product);
        }
    }
}
