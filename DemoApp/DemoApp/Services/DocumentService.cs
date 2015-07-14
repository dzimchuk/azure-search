using System;
using System.Net;
using System.Threading.Tasks;
using DemoApp.Models;
using Microsoft.Azure.Search;
using Microsoft.Azure.Search.Models;

namespace DemoApp.Services
{
    internal class DocumentService : IDocumentService
    {
        private readonly ISearchIndexClient indexClient;
        private readonly IProductMapper productMapper;

        public DocumentService(ISearchIndexClient indexClient, IProductMapper productMapper)
        {
            this.indexClient = indexClient;
            this.productMapper = productMapper;
        }

        public async Task<Product> FindAsync(int productId)
        {
            var result = await indexClient.Documents.GetAsync<ProductInfo>(productId.ToString());
            return result.StatusCode != HttpStatusCode.OK ? null : productMapper.MapFrom(result.Document);
        }

        public Task UpdateAsync(Product product)
        {
            var document = productMapper.MapFrom(product);
            var action = new IndexAction<ProductInfo>(IndexActionType.MergeOrUpload, document);
            return indexClient.Documents.IndexAsync(IndexBatch.Create(action));
        }
    }
}