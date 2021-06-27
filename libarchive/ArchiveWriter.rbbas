#tag Class
Protected Class ArchiveWriter
Inherits libarchive.Archive
	#tag Method, Flags = &h0
		Sub Close()
		  If mIsOpen Then mLastError = archive_write_close(mArchive)
		  mIsOpen = False
		  mBuffer = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType)
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
		  Case libarchive.ArchiveType.Shar
		    mLastError = archive_write_set_format_shar(mArchive)
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
		  
		  Select Case Compressor
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
		    
		  Case libarchive.CompressionType.All
		  Else
		    mLastError = ERR_UNSUPPORTED_COMPRESSION
		    Raise New ArchiveException(Me)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateFile(File As FolderItem)
		  mLastError = archive_write_open_filename_w(mArchive, File.AbsolutePath_)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateMemory(Buffer As MemoryBlock)
		  mLastError = archive_write_open_memory(mArchive, Buffer, Buffer.Size, mUsed)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mBuffer = Buffer
		  mIsOpen = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mArchive <> Nil Then mLastError = archive_write_free(mArchive) ' free() calls close()
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetFilterOption(FilterModule As String, OptionName As String, OptionValue As String) As Boolean
		  mLastError = archive_write_set_filter_option(mArchive, FilterModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetFormatOption(FormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  mLastError = archive_write_set_format_option(mArchive, FormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(FilterOrFormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  mLastError = archive_write_set_option(mArchive, FilterOrFormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptions(Options() As String) As Boolean
		  Dim opts As String = Join(Options, ",")
		  mLastError = archive_write_set_options(mArchive, opts)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntry(Entry As libarchive.ArchiveEntry, Source As Readable)
		  Try
		    mLastError = archive_write_header(mArchive, Entry.Handle)
		    If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		    
		    Do Until Source.EOF
		      Dim block As MemoryBlock = Source.Read(CHUNK_SIZE)
		      If block = Nil Or block.Size = 0 Then Continue
		      mLastError = archive_write_data(mArchive, block, block.Size)
		      If mLastError < 0 Then Raise New ArchiveException(Me)
		    Loop
		    
		  Finally
		    mLastError = archive_write_finish_entry(mArchive)
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsed As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If IsOpen And mArchive <> Nil Then
			    mLastError = archive_write_set_passphrase(mArchive, value)
			    If mLastError = ARCHIVE_OK Then mPassword = value
			  End If
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty


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
