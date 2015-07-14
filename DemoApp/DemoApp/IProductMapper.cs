using System;
using DemoApp.Models;

namespace DemoApp
{
    public interface IProductMapper
    {
        Product MapFrom(ProductInfo info);
        ProductInfo MapFrom(Product product);
    }
}