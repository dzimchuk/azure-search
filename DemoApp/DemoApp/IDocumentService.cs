using System;
using System.Threading.Tasks;
using DemoApp.Models;

namespace DemoApp
{
    public interface IDocumentService
    {
        Task<Product> FindAsync(int productId);
        Task UpdateAsync(Product product);
    }
}