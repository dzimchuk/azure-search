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

        public ProductController(IDocumentService documentService)
        {
            this.documentService = documentService;
        }

        public async Task<ActionResult> Details(int id)
        {
            var document = await documentService.FindAsync(id);
            if (document == null)
                return HttpNotFound();

            return View(document);
        }

        public async Task<ActionResult> Edit(int id)
        {
            var document = await documentService.FindAsync(id);
            if (document == null)
                return HttpNotFound();

            return View(document);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(Product product)
        {
            if (ModelState.IsValid)
            {
                await documentService.UpdateAsync(product);
                return View("Complete", product);
            }

            return View(product);
        }
    }
}
