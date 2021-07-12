#tag Class
Protected Class Archive
	#tag Method, Flags = &h0
		Sub Close()
		  ' Releases all locally held resources. 
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.Close
		  
		  mIsOpen = False
		  mSourceBuffer = Nil
		  mSourceFile = Nil
		  mSourceStream = Nil
		  mStream = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  ' Raises an exception if libarchive is not available at runtime. Subclasses should
		  ' call this Constructor before doing anything else.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.Constructor
		  
		  If Not libarchive.IsAvailable() Then Raise New PlatformNotSupportedException
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFilterName(Compressor As libarchive.CompressionType)
		  ' Sets the name of the compression filter. This name is used in subsequent calls to
		  ' SetFilterOption() (and similar methods) of subclasses.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.SetFilterName
		  
		  Select Case Compressor
		  Case libarchive.CompressionType.BZip2
		    mFilterName = FILTER_MODULE_BZIP2
		  Case libarchive.CompressionType.Compress
		    mFilterName = FILTER_MODULE_COMPRESS
		  Case libarchive.CompressionType.GRZip
		    mFilterName = FILTER_MODULE_GRZIP
		  Case libarchive.CompressionType.GZip
		    mFilterName = FILTER_MODULE_GZIP
		  Case libarchive.CompressionType.LRZip
		    mFilterName = FILTER_MODULE_LRZIP
		  Case libarchive.CompressionType.LZ4
		    mFilterName = FILTER_MODULE_LZ4
		  Case libarchive.CompressionType.LZMA
		    mFilterName = FILTER_MODULE_LZMA
		  Case libarchive.CompressionType.None
		    mFilterName = FILTER_MODULE_NONE
		  Case libarchive.CompressionType.UUEncoded
		    mFilterName = FILTER_MODULE_UUENCODE
		  Case libarchive.CompressionType.XZ
		    mFilterName = FILTER_MODULE_XZ
		  Case libarchive.CompressionType.ZStd
		    mFilterName = FILTER_MODULE_ZSTD
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFormatName(ArchiveType As libarchive.ArchiveType)
		  ' Sets the name of the archive format. This name is used in subsequent calls to 
		  ' SetFormatOption() (and similar methods) of subclasses.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.SetFormatName
		  
		  Select Case ArchiveType
		  Case libarchive.ArchiveType.SevenZip
		    mFormatName = FORMAT_MODULE_7ZIP
		  Case libarchive.ArchiveType.Ar
		    mFormatName = FORMAT_MODULE_AR
		  Case libarchive.ArchiveType.Cabinet
		    mFormatName = FORMAT_MODULE_CAB
		  Case libarchive.ArchiveType.CPIO
		    mFormatName = FORMAT_MODULE_CPIO
		  Case libarchive.ArchiveType.Empty
		    mFormatName = FORMAT_MODULE_EMPTY
		  Case libarchive.ArchiveType.ISO9660
		    mFormatName = FORMAT_MODULE_ISO9660
		  Case libarchive.ArchiveType.LHA
		    mFormatName = FORMAT_MODULE_LHA
		  Case libarchive.ArchiveType.MTree
		    mFormatName = FORMAT_MODULE_MTREE
		  Case libarchive.ArchiveType.RAR
		    mFormatName = FORMAT_MODULE_RAR
		  Case libarchive.ArchiveType.RAR5
		    mFormatName = FORMAT_MODULE_RAR5
		  Case libarchive.ArchiveType.Raw
		    mFormatName = FORMAT_MODULE_RAW
		  Case libarchive.ArchiveType.Shar
		    mFormatName = FORMAT_MODULE_SHAR
		  Case libarchive.ArchiveType.TAR
		    mFormatName = FORMAT_MODULE_USTAR
		  Case libarchive.ArchiveType.WArc
		    mFormatName = FORMAT_MODULE_WARC
		  Case libarchive.ArchiveType.XAR
		    mFormatName = FORMAT_MODULE_XAR
		  Case libarchive.ArchiveType.Zip
		    mFormatName = FORMAT_MODULE_ZIP
		  Case libarchive.ArchiveType.ZipStreamable
		    mFormatName = FORMAT_MODULE_ZIP
		  Case libarchive.ArchiveType.ZipSeekable
		    mFormatName = FORMAT_MODULE_ZIP
		  End Select
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The opaque handle of the archive.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.Handle
			  
			  
			  return mArchive
			End Get
		#tag EndGetter
		Handle As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the archive is currently open.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.IsOpen
			  
			  return mIsOpen
			End Get
		#tag EndGetter
		IsOpen As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the most recent error code for the archive.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.LastError
			  
			  return mLastError
			End Get
		#tag EndGetter
		LastError As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mArchive As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDestinationStream As Writeable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mFilterName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mFormatName As String = """raw"""
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Int32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSourceBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSourceFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSourceStream As Readable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStream As MemoryStream
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
