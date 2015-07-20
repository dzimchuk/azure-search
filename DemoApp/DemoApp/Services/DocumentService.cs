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

        public DocumentService(ISearchIndexClient indexClient)
        {
            this.indexClient = indexClient;
        }

        public async Task<ProductInfo> FindAsync(int productId)
        {
            var result = await indexClient.Documents.GetAsync<ProductInfo>(productId.ToString());
            return result.StatusCode != HttpStatusCode.OK ? null : result.Document;
        }

        public Task UpdateAsync(ProductInfo document)
        {
            var action = new IndexAction<ProductInfo>(IndexActionType.MergeOrUpload, document);
            return indexClient.Documents.IndexAsync(IndexBatch.Create(action));
        }
    }
}