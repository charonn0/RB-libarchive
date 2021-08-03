#tag Class
Protected Class ArchiveWriter
Inherits libarchive.Archive
	#tag Method, Flags = &h0
		Sub Close()
		  ' Close the archive and free system resources.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.Close
		  
		  If mIsOpen Then mLastError = archive_write_close(mArchive)
		  If mSourceBuffer <> Nil Then mSourceBuffer.Size = mUsed
		  Super.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  ' Constructs a generic ArchiveWriter. Format-specific subclasses call this Constructor.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From Archive
		  Super.Constructor()
		  
		  mArchive = archive_write_new()
		  If mArchive = Nil Then Raise New ArchiveException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Create()
		  ' Creates the ArchiveWriter for writing. Format-specific subclasses call this after
		  ' setting options and features for the archive.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.Create
		  
		  If IsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  
		  Select Case True
		  Case Not (mSourceBuffer Is Nil)
		    CreateMemory(mSourceBuffer)
		  Case mSourceFile <> Nil
		    CreateFile(mSourceFile)
		  Case mDestinationStream <> Nil
		    CreateStream(mDestinationStream)
		  Else
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateFile(File As FolderItem)
		  ' Creates an archive in the specified file.
		  mLastError = archive_write_open_filename_w(mArchive, File.AbsolutePath_)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mSourceFile = File
		  mIsOpen = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateMemory(Buffer As MemoryBlock)
		  ' Creates an archive in the specified MemoryBlock.
		  
		  mSourceBuffer = Buffer
		  Dim stream As New BinaryStream(mSourceBuffer)
		  CreateStream(stream)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateStream(Stream As Writeable)
		  ' Creates an archive in the specified Writeable object.
		  ' libarchive will invoke the callbacks of this class when writing to the
		  ' Owner archive, which in turn will write to the WriteTo object. The WriteTo
		  ' object must continue to exist at least until after Owner.Close() returns.
		  
		  mLastError = archive_write_set_bytes_in_last_block(mArchive, 1)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  If Not USE_BUFFERING Then
		    mLastError = archive_write_set_bytes_per_block(mArchive, 0)
		    If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  End If
		  
		  If Archives = Nil Then Archives = New Dictionary
		  Archives.Value(mArchive) = New WeakRef(Me)
		  mDestinationStream = Stream
		  
		  mLastError = archive_write_open2(mArchive, mArchive, _
		  AddressOf WriteOpenCallback, _
		  AddressOf WriteCallback, _
		  AddressOf CloseCallback, _
		  AddressOf FreeCallback)
		  
		  If mLastError <> ARCHIVE_OK Or Not mIsOpen Then Raise New ArchiveException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		  If mArchive <> Nil Then mLastError = archive_write_free(mArchive)
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFilter(Compressor As libarchive.CompressionType)
		  ' Sets the compression type. Must be called before the archive is created.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.SetFilter
		  
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

	#tag Method, Flags = &h0
		Function SetFilterOption(OptionName As String, OptionValue As String) As Boolean
		  Return SetFilterOption("", OptionName, OptionValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetFilterOption(FilterModule As String, OptionName As String, OptionValue As String) As Boolean
		  ' Sets an option for the specified compression filter. Must be called before the archive
		  ' is created.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.SetFilterOption
		  
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
		  ' Sets the archive format. Must be called before the archive is created.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.SetFormat
		  
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
		  Case libarchive.ArchiveType.Zip, libarchive.ArchiveType.ZipSeekable, libarchive.ArchiveType.ZipStreamable
		    mLastError = archive_write_set_format_zip(mArchive)
		  Else
		    mLastError = ERR_READ_ONLY_FORMAT
		    Raise New ArchiveException(Me)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetFormatOption(OptionName As String, OptionValue As String) As Boolean
		  Return SetFormatOption("", OptionName, OptionValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetFormatOption(FormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  ' Sets an option for the specified archive format. Must be called before the archive is created.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.SetFormatOption
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  mLastError = archive_write_set_format_option(mArchive, FormatModule, OptionName, OptionValue)
		  If mLastError = ARCHIVE_FAILED Then Raise New ArchiveException(Me) ' no such module!
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionName As String, OptionValue As String) As Boolean
		  Return SetOption("", OptionName, OptionValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetOption(FilterOrFormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  ' Sets an option for the specified compression filter or archive format. Must be called
		  ' before the archive is created.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.SetOption
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  mLastError = archive_write_set_option(mArchive, FilterOrFormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptions(Options() As String) As Boolean
		  ' Sets several compression and/or archive options at once. Must be called before the
		  ' archive is created.
		  '
		  ' Individual options have one of the following forms:
		  '   "option=value"
		  '     The option/value pair will be provided to every module. Modules that do not
		  '     accept an option with this name will ignore it.
		  '
		  '   "option"
		  '     The option will be provided to every module with a value of “1”.
		  '
		  '   "!option"
		  '      The option will be provided to every module with a NULL value.
		  '
		  '   "module:option=value", "module:option", "module:!option"
		  '      As above, but the corresponding option and value will be provided
		  '      only to modules whose name matches module.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.SetOptions
		  
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
		Sub WriteEntry(Entry As libarchive.ArchiveEntry, Contents As MemoryBlock)
		  ' Writes the Contents to the archive using the metadata of the Entry. The Progress()
		  ' event will be raised one or more times.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.WriteEntry
		  
		  If Not mIsOpen Then Create()
		  If mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End If
		  
		  If RaiseEvent Progress(Entry, 0) Then Return
		  Try
		    WriteEntryHeader(Entry)
		    If Contents <> Nil Then WriteEntryDataBlock(Contents)
		  Finally
		    WriteEntryFinished()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntry(Entry As libarchive.ArchiveEntry, Source As Readable)
		  ' Writes the Source stream (until Source.EOF=True) to the archive using metadata of
		  ' the Entry. The Progress() event will be raised one or more times if data is read
		  ' from the Source parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.WriteEntry
		  
		  If Not mIsOpen Then Create()
		  If mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End If
		  
		  Try
		    WriteEntryHeader(Entry)
		    If Source <> Nil Then
		      Dim position As Int64
		      Do Until Source.EOF
		        If RaiseEvent Progress(Entry, position) Then Exit Do
		        Dim block As MemoryBlock = Source.Read(CHUNK_SIZE)
		        WriteEntryDataBlock(block)
		        position = position + block.Size
		      Loop
		    End If
		    
		  Finally
		    WriteEntryFinished()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteEntryDataBlock(Block As MemoryBlock)
		  ' Writes bytes to the archive entry. The entry header must have already been written and the
		  ' entry data cannot have yet been marked as finished.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.WriteEntryDataBlock
		  
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
		  ' Finishes the archive entry.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.WriteEntryFinished
		  
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
		  ' Writes an archive header for the entry. Any previous entry must already be finished. After
		  ' this method returns you may write to the entry using WriteEntryDataBlock() and then finish
		  ' the entry by calling WriteEntryFinished().
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.WriteEntryHeader
		  
		  If Not mIsOpen Then Create()
		  If mHeaderWritten Then
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End If
		  
		  mLastError = archive_write_header(mArchive, Entry.Handle)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mHeaderWritten = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub _SetCompressed(b As Boolean)
		  #pragma Unused b
		  Return
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Progress(Entry As libarchive.ArchiveEntry, Position As Int64) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables format-specific compression in the archive. This
			  ' is different from the compression filter, which compresses the archive
			  ' as a whole.
			  
			  _SetCompressed(value)
			End Set
		#tag EndSetter
		Compressed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressionLevel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the compression level for the archive. This may or may not be meaningful depending
			  ' on the archive format.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.CompressionLevel
			  
			  If SetOption("", FORMAT_OPT_COMPRESSIONLEVEL, Str(value)) Then
			    ' If  SetOption(mFormatName, FORMAT_OPT_COMPRESSIONLEVEL, Str(value)) Or _
			    ' SetOption(mFilterName, FORMAT_OPT_COMPRESSIONLEVEL, Str(value)) Or _
			    ' SetOption("", FORMAT_OPT_COMPRESSIONLEVEL, Str(value)) _
			    ' Then
			    mCompressionLevel = value
			  End If
			End Set
		#tag EndSetter
		CompressionLevel As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mEncryption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the encryption format for the archive. This may or may not be meaningful depending
			  ' on the archive format. Must be called before the archive is created.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.Encryption
			  
			  If mIsOpen Then
			    mLastError = ERR_TOO_LATE
			    Raise New ArchiveException(Me)
			  End If
			  
			  Dim cipher As String
			  Select Case value
			  Case EncryptionType.ZipCrypt
			    cipher = CIPHER_ZIPCRYPT
			  Case EncryptionType.AES128
			    cipher = CIPHER_AES128
			  Case EncryptionType.AES256
			    cipher = CIPHER_AES256
			  End Select
			  If Not SetOption(mFormatName, FORMAT_OPT_ENCRYPTION, cipher) Then Raise New ArchiveException(Me)
			  mEncryption = value
			End Set
		#tag EndSetter
		Encryption As libarchive.EncryptionType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mFilenameEncoding = Nil Then mFilenameEncoding = Encodings.UTF8
			  return mFilenameEncoding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the character encoding for file names stored in the archive. This may or may not
			  ' be meaningful depending on the archive format.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.FilenameEncoding
			  
			  If SetOption(mFormatName, FORMAT_OPT_HDRCHARSET, value.internetName) Then
			    mFilenameEncoding = value
			  End If
			  
			End Set
		#tag EndSetter
		FilenameEncoding As TextEncoding
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mCompressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompressionLevel As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryption As libarchive.EncryptionType
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHeaderWritten As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Gets and sets the password to be used in encrypting encrypted entries. Must be
			  ' set before the archive is created. This may or may not be meaningful depending
			  ' on the archive format.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter.Password
			  
			  If Not IsOpen And mArchive <> Nil Then
			    mLastError = archive_write_set_passphrase(mArchive, value)
			    If mLastError = ARCHIVE_OK Then mPassword = value
			  End If
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty


	#tag Constant, Name = CIPHER_AES128, Type = String, Dynamic = False, Default = \"aes128", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CIPHER_AES256, Type = String, Dynamic = False, Default = \"aes256", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CIPHER_ZIPCRYPT, Type = String, Dynamic = False, Default = \"zipcrypt", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_BUFFERING, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Compressed"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
