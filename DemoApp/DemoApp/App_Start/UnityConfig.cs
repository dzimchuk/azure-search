using System;
using System.Configuration;
using DemoApp.Controllers;
using DemoApp.Mappers;
using DemoApp.Services;
using Microsoft.Azure.Search;
using Microsoft.Practices.Unity;

namespace DemoApp.App_Start
{
    /// <summary>
    /// Specifies the Unity configuration for the main container.
    /// </summary>
    public class UnityConfig
    {
        #region Unity Container
        private static readonly Lazy<IUnityContainer> Container = new Lazy<IUnityContainer>(() =>
        {
            var container = new UnityContainer();
            RegisterTypes(container);
            return container;
        });

        /// <summary>
        /// Gets the configured Unity container.
        /// </summary>
        public static IUnityContainer GetConfiguredContainer()
        {
            return Container.Value;
        }
        #endregion

        /// <summary>Registers the type mappings with the Unity container.</summary>
        /// <param name="container">The unity container to configure.</param>
        /// <remarks>There is no need to register concrete types such as controllers or API controllers (unless you want to 
        /// change the defaults), as Unity allows resolving a concrete type even if it was not previously registered.</remarks>
        private static void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<ISearchService, SearchService>();
            container.RegisterType<IDocumentService, DocumentService>();
            container.RegisterType<IProductMapper, ProductMapper>();
            container.RegisterType<ISearchIndexClient, SearchIndexClient>(new InjectionConstructor(
                ConfigurationManager.AppSettings["search:service"],
                ConfigurationManager.AppSettings["search:index"],
                new SearchCredentials(ConfigurationManager.AppSettings["search:key"])));
        }
    }
}
