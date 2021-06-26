#tag Class
Protected Class ArchiveWriter
	#tag Method, Flags = &h0
		Sub Close()
		  If mIsOpen Then mLastError = archive_write_close(mArchive)
		  mIsOpen = False
		  mBuffer = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(ArchiveType As libarchive.ArchiveType, CompressionType As libarchive.CompressionType)
		  If Not libarchive.IsAvailable() Then Raise New PlatformNotSupportedException
		  mArchive = archive_write_new()
		  If mArchive = Nil Then Raise New ArchiveException(Me)
		  
		  Select Case ArchiveType
		  Case libarchive.ArchiveType.SevenZip
		    mLastError = archive_write_set_format_7zip(mArchive)
		  Case libarchive.ArchiveType.Ar
		    mLastError = archive_write_set_format_ar_bsd(mArchive)
		  Case libarchive.ArchiveType.CPIO
		    mLastError = archive_write_set_format_cpio(mArchive)
		  Case libarchive.ArchiveType.ISO9660
		    mLastError = archive_write_set_format_iso9660(mArchive)
		  Case libarchive.ArchiveType.MTree
		    mLastError = archive_write_set_format_mtree(mArchive)
		  Case libarchive.ArchiveType.TAR
		    mLastError = archive_write_set_format_ustar(mArchive)
		  Case libarchive.ArchiveType.XAR
		    mLastError = archive_write_set_format_xar(mArchive)
		  Case libarchive.ArchiveType.Zip
		    mLastError = archive_write_set_format_zip(mArchive)
		  Else
		    mLastError = ERR_READ_ONLY_FORMAT
		    Raise New ArchiveException(Me)
		  End Select
		  
		  Select Case CompressionType
		  Case libarchive.CompressionType.Compress
		    mLastError = archive_write_add_filter_compress(mArchive)
		  Case libarchive.CompressionType.GRZip
		    mLastError = archive_write_add_filter_grzip(mArchive)
		  Case libarchive.CompressionType.GZip
		    mLastError = archive_write_add_filter_gzip(mArchive)
		  Case libarchive.CompressionType.LRZip
		    mLastError = archive_write_add_filter_lrzip(mArchive)
		  Case libarchive.CompressionType.LZ4
		    mLastError = archive_write_add_filter_lz4(mArchive)
		  Case libarchive.CompressionType.LZMA
		    mLastError = archive_write_add_filter_lzma(mArchive)
		  Case libarchive.CompressionType.None
		    mLastError = archive_write_add_filter_none(mArchive)
		    Raise New ArchiveException(Me)
		  Case libarchive.CompressionType.UUEncoded
		    mLastError = archive_write_add_filter_uuencode(mArchive)
		  Case libarchive.CompressionType.XZ
		    mLastError = archive_write_add_filter_xz(mArchive)
		  Case libarchive.CompressionType.ZStd
		    mLastError = archive_write_add_filter_zstd(mArchive)
		  Else
		    mLastError = ERR_UNSUPPORTED_COMPRESSION
		    Raise New ArchiveException(Me)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateFile(File As FolderItem)
		  mLastError = archive_write_open_filename_w(mArchive, File.AbsolutePath)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mArchive <> Nil Then mLastError = archive_write_free(mArchive) ' free() calls close()
		  mArchive = Nil
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mArchive
			End Get
		#tag EndGetter
		Handle As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mIsOpen
			End Get
		#tag EndGetter
		IsOpen As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mArchive As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Int32
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsOpen"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
