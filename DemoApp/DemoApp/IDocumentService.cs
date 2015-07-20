using System;
using System.Threading.Tasks;
using DemoApp.Models;

namespace DemoApp
{
    public interface IDocumentService
    {
        Task<ProductInfo> FindAsync(int productId);
        Task UpdateAsync(ProductInfo document);
    }
}