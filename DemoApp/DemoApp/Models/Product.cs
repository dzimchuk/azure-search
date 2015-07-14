using System.ComponentModel.DataAnnotations;

namespace DemoApp.Models
{
    public class Product
    {
        public int ProductId { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 3, ErrorMessage = "Product name should be within 3 to 30 characters")]
        public string Name { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 3)]
        public string ProductNumber { get; set; }

        [Required]
        [StringLength(10, MinimumLength = 3)]
        public string Color { get; set; }

        [Required]
        [Range(0.0, 20000.0)]
        public decimal ListPrice { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 3)]
        public string ProductModel { get; set; }

        [Required]
        public string Description { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 2, ErrorMessage = "Subcategory name should be within 2 to 30 characters")]
        public string Subcategory { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 2, ErrorMessage = "Category name should be within 2 to 30 characters")]
        public string Category { get; set; } 
    }
}