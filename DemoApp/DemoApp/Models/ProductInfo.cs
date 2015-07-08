namespace DemoApp.Models
{
    public class ProductInfo
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public string ProductNumber { get; set; }
        public string Color { get; set; }
        public decimal ListPrice { get; set; }
        public string ProductModel { get; set; }
        public string Description { get; set; }
        public string ThumbnailPhotoFileName { get; set; }
        public string LargePhotoFileName { get; set; }
        public string Subcategory { get; set; }
        public string Category { get; set; }
    }
}