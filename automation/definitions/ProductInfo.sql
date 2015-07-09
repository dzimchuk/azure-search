USE [AdventureWorks2012]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Production].[vProductInfo] 
WITH SCHEMABINDING 
AS 
SELECT product.[ProductID],
       product.[Name],
       product.[ProductNumber],
       product.[Color],
       CAST(product.[ListPrice] as float) as ListPrice,
	   pm.[Name] as [ProductModel],
	   pd.[Description],
	   photo.[ThumbnailPhotoFileName],
	   photo.[LargePhotoFileName],
	   subCat.[Name] as [Subcategory],
	   cat.[Name] as [Category]
  FROM [Production].[Product] as product
  LEFT JOIN [Production].[ProductModel] as pm ON product.[ProductModelID] = pm.[ProductModelID]
  LEFT JOIN [Production].[ProductModelProductDescriptionCulture] pmx ON pm.[ProductModelID] = pmx.[ProductModelID]
  LEFT JOIN [Production].[ProductDescription] pd ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID]
  LEFT JOIN [Production].[ProductProductPhoto] as ppp ON product.[ProductID] = ppp.[ProductID]
  LEFT JOIN [Production].[ProductPhoto] as photo ON ppp.[ProductPhotoID] = photo.[ProductPhotoID]
  LEFT JOIN [Production].[ProductSubcategory] as subCat on product.[ProductSubcategoryID] = subCat.[ProductSubcategoryID]
  LEFT JOIN [Production].[ProductCategory] as cat on subCat.[ProductCategoryID] = cat.[ProductCategoryID]
  WHERE pmx.[CultureID] = 'en' OR pmx.[CultureID] IS NULL

GO


