param (
    [string] 
    $serviceName = $(throw "-serviceName is required."),
    
    [string]
    $serviceKey = $(throw "-serviceKey is required."),

    [string] 
    $indexName = $(throw "-indexName is required."),

    [string] 
    $connectionString = $(throw "-connectionString is required.")
 )
 
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Credentials.psm1") -DisableNameChecking
 Import-Module (Join-Path (Join-Path $PSScriptRoot "lib") "Document.psm1") -DisableNameChecking
 
 function Get-Albums
{
	$query = "SELECT AlbumId
                    ,genres.Name as Genre
                    ,artists.Name as Artist
                    ,Title
                    ,Price
                    ,AlbumArtUrl
                FROM Albums albums
                JOIN Artists artists ON albums.ArtistId = artists.ArtistId
                JOIN Genres genres ON albums.GenreId = genres.GenreId"

    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString

    $connection.Open()

    $command = $connection.CreateCommand()
    $command.CommandText = $query
    
    $reader = $command.ExecuteReader()

    [System.Collections.ArrayList]$albums = @()

	while ($reader.read()) {
        $album = @{ "AlbumId" = ([int]$reader.GetValue(0)).ToString()
                    "Genre" = $reader.GetValue(1)
                    "Artist" = $reader.GetValue(2)
                    "Title" = $reader.GetValue(3)
                    "Price" = ([decimal]$reader.GetValue(4)).ToString()
                    "AlbumArtUrl" = $reader.GetValue(5)
                   }
        $albums.Add($album) | Out-Null
    }

    $reader.close()
    $connection.close()

	return $albums
}

 $ErrorActionPreference = "Stop"

 Set-Credentials $serviceName $serviceKey
   
 $albums = Get-Albums
 $albums | % { $_["@search.action"] = "mergeOrUpload" }

 $documents = @{ "value" = $albums }
 Index-Documents $indexName $documents