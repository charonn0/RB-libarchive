#tag Class
Protected Class ZipWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.Zip, Compressor)
		  mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  CreateFile(File)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.Zip, Compressor)
		  mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  CreateMemory(Buffer)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
