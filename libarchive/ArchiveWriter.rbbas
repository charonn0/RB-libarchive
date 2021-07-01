#tag Class
Protected Class ArchiveWriter
Inherits libarchive.Archive
	#tag Method, Flags = &h0
		Sub Close()
		  If mIsOpen Then mLastError = archive_write_close(mArchive)
		  If mSourceBuffer <> Nil Then mSourceBuffer.Size = mUsed
		  Super.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From Archive
		  Super.Constructor()
		  
		  mArchive = archive_write_new()
		  If mArchive = Nil Then Raise New ArchiveException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateFile(File As FolderItem)
		  mLastError = archive_write_open_filename_w(mArchive, File.AbsolutePath_)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mSourceFile = File
		  mIsOpen = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateMemory(Buffer As MemoryBlock)
		  mLastError = archive_write_open_memory(mArchive, Buffer, Buffer.Size, mUsed)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mSourceBuffer = Buffer
		  mIsOpen = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mArchive <> Nil Then mLastError = archive_write_free(mArchive) ' free() calls close()
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFilter(Compressor As libarchive.CompressionType)
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  SetFilterName(Compressor)
		  Select Case Compressor
		  Case libarchive.CompressionType.BZip2
		    mLastError = archive_write_add_filter_bzip2(mArchive)
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
		  Case libarchive.CompressionType.LZip
		    mLastError =archive_write_add_filter_lzip(mArchive)
		  Case libarchive.CompressionType.LZOP
		    mLastError =archive_write_add_filter_lzop(mArchive)
		  Case libarchive.CompressionType.LZMA
		    mLastError = archive_write_add_filter_lzma(mArchive)
		  Case libarchive.CompressionType.None
		    mLastError = archive_write_add_filter_none(mArchive)
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
		Protected Function SetFilterOption(FilterModule As String, OptionName As String, OptionValue As String) As Boolean
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  mLastError = archive_write_set_filter_option(mArchive, FilterModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFormat(ArchiveType As libarchive.ArchiveType)
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  SetFormatName(ArchiveType)
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
		  Case libarchive.ArchiveType.Raw
		    mLastError = archive_write_set_format_raw(mArchive)
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetFormatOption(FormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  mLastError = archive_write_set_format_option(mArchive, FormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetOption(FilterOrFormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  mLastError = archive_write_set_option(mArchive, FilterOrFormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetOptions(Options() As String) As Boolean
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  Dim opts As String = Join(Options, ",")
		  mLastError = archive_write_set_options(mArchive, opts)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntry(Entry As libarchive.ArchiveEntry, Source As Readable)
		  If Not mIsOpen Then
		    Select Case True
		    Case mSourceBuffer <> Nil
		      CreateMemory(mSourceBuffer)
		    Case mSourceFile <> Nil
		      CreateFile(mSourceFile)
		    Else
		      mLastError = ERR_TOO_EARLY
		      Raise New ArchiveException(Me)
		    End Select
		  End If
		  If mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End If
		  
		  Try
		    WriteEntryHeader(Entry)
		    If Source <> Nil Then
		      Do Until Source.EOF
		        Dim block As MemoryBlock = Source.Read(CHUNK_SIZE)
		        WriteEntryDataBlock(block)
		      Loop
		    End If
		    
		  Finally
		    WriteEntryFinished()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteEntryDataBlock(Block As MemoryBlock)
		  If Block = Nil Or Block.Size = 0 Then Return
		  If Not mIsOpen Or Not mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End If
		  
		  mLastError = archive_write_data(mArchive, Block, Block.Size)
		  If mLastError < 0 Then Raise New ArchiveException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteEntryFinished()
		  If Not mIsOpen Or Not mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Return
		  End If
		  mLastError = archive_write_finish_entry(mArchive)
		  mHeaderWritten = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteEntryHeader(Entry As libarchive.ArchiveEntry)
		  If Not mIsOpen Then
		    Select Case True
		    Case mSourceBuffer <> Nil
		      CreateMemory(mSourceBuffer)
		    Case mSourceFile <> Nil
		      CreateFile(mSourceFile)
		    Else
		      mLastError = ERR_TOO_EARLY
		      Raise New ArchiveException(Me)
		    End Select
		  End If
		  If mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End If
		  
		  mLastError = archive_write_header(mArchive, Entry.Handle)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mHeaderWritten = True
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressionLevel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If SetFilterOption(mFilterName, FORMAT_OPT_COMPRESSIONLEVEL, Str(value)) Then
			    mCompressionLevel = value
			  End If
			End Set
		#tag EndSetter
		CompressionLevel As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCompressionLevel As Int32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHeaderWritten As Boolean
	#tag EndProperty

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
			InheritedFrom="libarchive.Archive"
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
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
