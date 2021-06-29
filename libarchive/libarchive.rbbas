#tag Module
Protected Module libarchive
	#tag Method, Flags = &h21
		Private Function AbsolutePath_(Extends f As FolderItem) As String
		  #If RBVersion > 2019 Then
		    Return f.NativePath
		  #Else
		    Return f.AbsolutePath
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ArchiveTypeFromName(Name As String) As libarchive.ArchiveType
		  Dim ext As String = NthField(Name, ".", CountFields(Name, "."))
		  Select Case ext
		  Case "zip", "docx", "xlsx", "pptx", "jar"
		    Return ArchiveType.Zip
		  Case "gz", "bz2"
		    Return ArchiveTypeFromName(Right(Name, Name.Len - (ext.Len + 1)))
		  Case "tar"
		    Return ArchiveType.TAR
		  Case "rar"
		    Return ArchiveType.RAR
		  Case "iso"
		    Return ArchiveType.ISO9660
		    
		  Else
		    Return ArchiveType.All
		  End Select
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_bzlib_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_atime Lib libpath (ArchiveEntry As Ptr) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_atime_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_clone Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_copy_pathname_w Lib libpath (ArchiveEntry As Ptr, Pathname As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_filetype Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_free Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_is_data_encrypted Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mode Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mtime Lib libpath (ArchiveEntry As Ptr) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mtime_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_pathname Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_pathname_utf8 Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_pathname_w Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_atime Lib libpath (ArchiveEntry As Ptr, UnixTime As UInt32, NanoSeconds As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_filetype Lib libpath (ArchiveEntry As Ptr, Type As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_mode Lib libpath (ArchiveEntry As Ptr, Perms As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_mtime Lib libpath (ArchiveEntry As Ptr, UnixTime As UInt32, NanoSeconds As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_size Lib libpath (ArchiveEntry As Ptr, Size As Int64)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_size Lib libpath (ArchiveEntry As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_size_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_symlink_type Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_atime Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_mtime Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_size Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_errno Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_error_string Lib libpath (Archive As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_format Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_liblz4_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_liblzma_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_libzstd_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_close Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data_block Lib libpath (Archive As Ptr, ByRef Buffer As Ptr, ByRef Size As UInt32, ByRef Offset As UInt64) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data_into_fd Lib libpath (Archive As Ptr, Descriptor As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data_skip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_finish Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_format_capabilities Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_free Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_has_encrypted_entries Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_header_position Lib libpath (Archive As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_next_header Lib libpath (Archive As Ptr, ByRef ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open_filename Lib libpath (Archive As Ptr, FileName As CString, BlockSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open_filename_w Lib libpath (Archive As Ptr, FileName As WString, BlockSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open_memory Lib libpath (Archive As Ptr, Buffer As Ptr, BufferSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_filter_option Lib libpath (Archive As Ptr, FilterModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_format_option Lib libpath (Archive As Ptr, FilterOrReaderModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_option Lib libpath (Archive As Ptr, FilterOrReaderModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_options Lib libpath (Archive As Ptr, Options As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_passphrase_callback Lib libpath (Archive As Ptr, Opaque As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_all Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_bzip2 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_compress Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_grzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_gzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lrzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lz4 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lzma Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lzop Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_none Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_rpm Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_uu Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_xz Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_zstd Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_7zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_all Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_ar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_by_code Lib libpath (Archive As Ptr, Code As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_cab Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_cpio Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_empty Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_iso9660 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_lha Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_mtree Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_rar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_raw Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_tar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_xar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_seek_data Lib libpath (Archive As Ptr, Offset As Int64) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_compress Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_grzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_gzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lrzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lz4 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lzma Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_none Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_uuencode Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_xz Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_zstd Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_close Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_data Lib libpath (Archive As Ptr, Buffer As Ptr, BufferSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_finish_entry Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_free Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_header Lib libpath (Archive As Ptr, Entry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_open_filename_w Lib libpath (Archive As Ptr, Path As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_open_memory Lib libpath (Archive As Ptr, Buffer As Ptr, BufferSize As UInt32, ByRef Used As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_filter_option Lib libpath (Archive As Ptr, FilterModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_7zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_ar_bsd Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_cpio Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_iso9660 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_mtree Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_option Lib libpath (Archive As Ptr, FormatModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_shar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_ustar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_xar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_option Lib libpath (Archive As Ptr, FilterOrFilterModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_options Lib libpath (Archive As Ptr, Options As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_passphrase Lib libpath (Archive As Ptr, Password As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_zip_set_compression_deflate Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_zlib_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function CreateArchive(Archive As FolderItem, Type As libarchive.ArchiveType, Compressor As libarchive.CompressionType) As libarchive.ArchiveWriter
		  If Type = ArchiveType.All Then Type = ArchiveTypeFromName(Archive.Name)
		  
		  Select Case Type
		  Case ArchiveType.All ' unknown file extension
		    Return Nil
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Writers.ARWriter(Archive, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Writers.CPIOWriter(Archive, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Writers.ISO9660Writer(Archive, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Writers.MTreeWriter(Archive, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Writers.SevenZipWriter(Archive, Compressor)
		    
		  Case ArchiveType.Shar
		    Return New libarchive.Writers.SharWriter(Archive, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Writers.TARWriter(Archive, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Writers.XARWriter(Archive, Compressor)
		    
		  Case ArchiveType.Zip
		    Return New libarchive.Writers.ZipWriter(Archive, Compressor)
		    
		  Else
		    Raise New ArchiveException(ERR_READ_ONLY_FORMAT)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateAsArchive(Extends Archive As FolderItem, Type As libarchive.ArchiveType = libarchive.ArchiveType.All) As libarchive.ArchiveWriter
		  If Type = ArchiveType.All Then Type = ArchiveTypeFromName(Archive.Name)
		  
		  Select Case Type
		  Case ArchiveType.All ' unknown file extension
		    Return Nil
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Writers.ARWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Writers.CPIOWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Writers.ISO9660Writer(Archive, CompressionType.All)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Writers.MTreeWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Writers.SevenZipWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.Shar
		    Return New libarchive.Writers.SharWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Writers.TARWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Writers.XARWriter(Archive, CompressionType.All)
		    
		  Case ArchiveType.Zip
		    Return New libarchive.Writers.ZipWriter(Archive, CompressionType.All)
		    
		  Else
		    Raise New ArchiveException(ERR_READ_ONLY_FORMAT)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatError(ErrorCode As Int32) As String
		  Dim msg As String
		  Select Case ErrorCode
		  Case ERR_INIT_FAILED
		    msg = "Unknown error while initializing libarchive."
		  Case ERR_UNSUPPORTED_COMPRESSION
		    msg = "Unknown or unsupported compressor."
		  Case ERR_READ_ONLY_FORMAT
		    msg = "Creating an archive of this type is not supported."
		  Case ERR_WRITE_ONLY_FORMAT
		    msg = "Extracting an archive of this type is not supported."
		  Case ARCHIVE_OK
		    msg = "Operation succeeded."
		  Case ARCHIVE_EOF
		    msg = "No further data to read."
		  Case ARCHIVE_FAILED
		    msg = "The operation failed but it may be possible to continue."
		  Case ARCHIVE_FATAL
		    msg = "The operation failed and it is not possible to continue."
		  Case ARCHIVE_RETRY
		    msg = "The operation failed but it may succeed if retried."
		  Case ARCHIVE_WARN
		    msg = "The operation was partially successful."
		    
		  Else
		    msg = "Unknown error number: " + Str(ErrorCode, "-000")
		    
		  End Select
		  
		  Return msg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  Static avail As Boolean
		  If Not avail Then avail = System.IsFunctionAvailable("archive_read_new", libpath)
		  Return avail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OpenAsArchive(Extends Archive As FolderItem, Type As libarchive.ArchiveType = libarchive.ArchiveType.All) As libarchive.ArchiveReader
		  Select Case Type
		  Case ArchiveType.All ' detect
		    Return New ArchiveReaderPtr(Archive, ArchiveType.All, CompressionType.All)
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Readers.ARReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.Cabinet
		    Return New libarchive.Readers.CabinetReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Readers.CPIOReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Readers.ISO9660Reader(Archive, CompressionType.All)
		    
		  Case ArchiveType.LHA
		    Return New libarchive.Readers.LHAReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Readers.MTreeReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.RAR
		    Return New libarchive.Readers.RARReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Readers.SevenZipReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Readers.TARReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Readers.XARReader(Archive, CompressionType.All)
		    
		  Case ArchiveType.Zip
		    Return New libarchive.Readers.ZipReader(Archive, CompressionType.All)
		    
		  Else
		    Raise New ArchiveException(ERR_WRITE_ONLY_FORMAT)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PermissionsToMode(p As Permissions) As UInt32
		  Const TGEXEC = &o00010
		  Const TGREAD = &o00040
		  Const TGWRITE = &o00020
		  Const TOEXEC = &o00001
		  Const TOREAD = &o00004
		  Const TOWRITE = &o00002
		  Const TSGID = &o02000
		  Const TSUID = &o04000
		  Const TSVTX = &o01000
		  Const TUEXEC = &o00100
		  Const TUREAD = &o00400
		  Const TUWRITE = &o00200
		  
		  Dim mask As UInt32
		  If p.GroupExecute Then mask = mask Or TGEXEC
		  If p.GroupRead Then mask = mask Or TGREAD
		  If p.GroupWrite Then mask = mask Or TGWRITE
		  
		  If p.OwnerExecute Then mask = mask Or TUEXEC
		  If p.OwnerRead Then mask = mask Or TUREAD
		  If p.OwnerWrite Then mask = mask Or TUWRITE
		  
		  If p.OthersExecute Then mask = mask Or TOEXEC
		  If p.OthersRead Then mask = mask Or TOREAD
		  If p.OthersWrite Then mask = mask Or TOWRITE
		  
		  Return mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function time_t(d As Date) As Integer
		  Static epoch As Double = time_t(0).TotalSeconds
		  Return d.TotalSeconds - epoch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function time_t(Count As Integer) As Date
		  Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		  d.TotalSeconds = d.TotalSeconds + Count
		  Return d
		End Function
	#tag EndMethod


	#tag Constant, Name = ARCHIVE_EOF, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FAILED, Type = Double, Dynamic = False, Default = \"-25", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FATAL, Type = Double, Dynamic = False, Default = \"-30", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_RETRY, Type = Double, Dynamic = False, Default = \"-10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_WARN, Type = Double, Dynamic = False, Default = \"-20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CHUNK_SIZE, Type = Double, Dynamic = False, Default = \"16384", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ERR_INIT_FAILED, Type = Double, Dynamic = False, Default = \"-102", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_READ_ONLY_FORMAT, Type = Double, Dynamic = False, Default = \"-101", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UNSUPPORTED_COMPRESSION, Type = Double, Dynamic = False, Default = \"-100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_WRITE_ONLY_FORMAT, Type = Double, Dynamic = False, Default = \"-103", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_CHECKFS, Type = String, Dynamic = False, Default = \"checkfs", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_COMPAT2X, Type = String, Dynamic = False, Default = \"compat-2x", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_HDRCHARSET, Type = String, Dynamic = False, Default = \"hdrcharset", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_JOLIET, Type = String, Dynamic = False, Default = \"joliet", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_MACEXT, Type = String, Dynamic = False, Default = \"mac-ext", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_READCONCATENATED, Type = String, Dynamic = False, Default = \"read_concatenated_archives", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_ROCKRIDGE, Type = String, Dynamic = False, Default = \"rockridge", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = libpath, Type = String, Dynamic = False, Default = \"libarchive.dll", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ArchiveType, Type = Integer, Flags = &h1
		SevenZip
		  All
		  Ar
		  Cabinet
		  CPIO
		  Empty
		  ISO9660
		  LHA
		  MTree
		  RAR
		  Raw
		  Shar
		  TAR
		  XAR
		Zip
	#tag EndEnum

	#tag Enum, Name = CompressionType, Type = Integer, Flags = &h1
		All
		  Compress
		  Deflate
		  GRZip
		  GZip
		  LRZip
		  LZ4
		  LZMA
		  None
		  RPM
		  UUEncoded
		  XZ
		ZStd
	#tag EndEnum

	#tag Enum, Name = EntryType, Type = Integer, Flags = &h1
		File
		  Directory
		  FileLink
		  DirectoryLink
		  Socket
		  CharacterSpecial
		  BlockSpecial
		  FIFO
		  UndefinedLink
		Unknown
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
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
End Module
#tag EndModule
