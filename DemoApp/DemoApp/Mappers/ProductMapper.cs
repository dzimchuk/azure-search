using System.Globalization;
using DemoApp.Models;

namespace DemoApp.Mappers
{
    internal class ProductMapper : IProductMapper
    {
        public Product MapFrom(ProductInfo info)
        {
            return new Product
                   {
                       ProductId = int.Parse(info.ProductId, CultureInfo.InvariantCulture),
                       Name = info.Name,
                       Description = info.Description,
                       Category = info.Category,
                       Color = info.Color,
                       ListPrice = decimal.Parse(info.ListPrice, CultureInfo.InvariantCulture),
                       ProductModel = info.ProductModel,
                       ProductNumber = info.ProductNumber,
                       Subcategory = info.Subcategory
                   };
        }

        public ProductInfo MapFrom(Product product)
        {
            return new ProductInfo
            {
                ProductId = product.ProductId.ToString(CultureInfo.InvariantCulture),
                Name = product.Name,
                Description = product.Description,
                Category = product.Category,
                Color = product.Color,
                ListPrice = product.ListPrice.ToString(CultureInfo.InvariantCulture),
                ProductModel = product.ProductModel,
                ProductNumber = product.ProductNumber,
                Subcategory = product.Subcategory
            };
        }
    }
}