#tag Class
Protected Class ArchiveReader
Inherits libarchive.Archive
	#tag Method, Flags = &h21
		Private Shared Function archive_passphrase_callback(Archive As Ptr, Opaque As Ptr) As CString
		  #pragma Unused Archive
		  If Opaque = Nil Or Archives = Nil Then Return Nil
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA ArchiveReader Then
		    Dim newpass As String
		    If Not ArchiveReader(w.Value).GetPassword(newpass) Then Return Nil
		    Return newpass
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  ' Close the archive and free system resources.
		  ' 
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.Close
		  
		  If mIsOpen Then mLastError = archive_read_close(mArchive)
		  mCurrentEntry = Nil
		  Super.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  ' Constructs a generic ArchiveReader. Format-specific subclasses call this Constructor.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From Archive
		  Super.Constructor()
		  
		  mArchive = archive_read_new()
		  If mArchive = Nil Then Raise New ArchiveException(Me)
		  
		  If Archives = Nil Then Archives = New Dictionary
		  Archives.Value(mArchive) = New WeakRef(Me)
		  mLastError = archive_read_set_passphrase_callback(mArchive, mArchive, AddressOf archive_passphrase_callback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Free all resources.
		  
		  Me.Close()
		  If mArchive <> Nil Then
		    mLastError = archive_read_free(mArchive)
		    If Archives <> Nil And Archives.HasKey(mArchive) Then Archives.Remove(mArchive)
		    If Archives.Count = 0 Then Archives = Nil
		  End If
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetPassword(ByRef ArchivePassword As String) As Boolean
		  If Me.Password <> "" Then
		    ArchivePassword = Me.Password
		    Return True
		  Else
		    Return RaiseEvent GetPassword(ArchivePassword)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext(WriteTo As Int32) As Boolean
		  ' Reads the currently selected entry into the specified file descriptor and then
		  ' advances the selection to the next item in the archive, if any.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.MoveNext
		  
		  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return False
		  
		  Return ReadEntryData(WriteTo) And ReadEntryHeader()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext(WriteTo As Writeable) As Boolean
		  ' Reads the currently selected entry into the WriteTo parameter and then advances the
		  ' selection to the next item in the archive, if any.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.MoveNext
		  
		  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return False
		  
		  Return ReadEntryData(WriteTo) And ReadEntryHeader()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Open()
		  ' Opens the ArchiveReader for reading. Format-specific subclasses call this after
		  ' setting options and features for the archive.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.Open
		  
		  If mLastError = ARCHIVE_FATAL Then Raise New ArchiveException(Me)
		  
		  If IsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  
		  Select Case True
		  Case mSourceBuffer <> Nil
		    OpenMemory(mSourceBuffer)
		  Case mSourceFile <> Nil
		    OpenFile(mSourceFile)
		  Case mSourceStream <> Nil
		    OpenStream(mSourceStream)
		  Else
		    mLastError = ERR_TOO_EARLY
		    Raise New ArchiveException(Me)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenFile(File As FolderItem)
		  ' Opens the specified file as an archive.
		  
		  mLastError = archive_read_open_filename_w(mArchive, File.AbsolutePath_, CHUNK_SIZE)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mSourceFile = File
		  mIsOpen = True
		  If Not ReadEntryHeader() Then Raise New ArchiveException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenMemory(Buffer As MemoryBlock)
		  ' Opens the specified MemoryBlock as an archive.
		  
		  mSourceBuffer = Buffer
		  Dim stream As New BinaryStream(mSourceBuffer)
		  OpenStream(stream)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OpenStream(ReadFrom As Readable)
		  ' Opens the specified Readable object as an archive.
		  ' libarchive will invoke the callbacks of this class when reading from the
		  ' archive, which in turn will read from the ReadFrom parameter until EOF.
		  
		  If Archives = Nil Then Archives = New Dictionary
		  Archives.Value(mArchive) = New WeakRef(Me)
		  mSourceStream = ReadFrom
		  
		  mLastError = archive_read_set_open_callback(mArchive, AddressOf ReadOpenCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_read_callback(mArchive, AddressOf ReadCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_seek_callback(mArchive, AddressOf SeekCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_skip_callback(mArchive, AddressOf SkipCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_close_callback(mArchive, AddressOf CloseCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_switch_callback(mArchive, AddressOf SwitchCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_callback_data(mArchive, mArchive)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_open1(mArchive)
		  If mLastError <> ARCHIVE_OK Or Not mIsOpen Or Not ReadEntryHeader() Then Raise New ArchiveException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryData(WriteTo As Int32) As Boolean
		  ' Reads bytes from the archive and writes them to the specified file descriptor.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.ReadEntryData
		  
		  If Not mIsOpen Then Open()
		  If WriteTo = 0 Then Return SkipEntryData()
		  mLastError = archive_read_data_into_fd(mArchive, WriteTo)
		  Return mLastError = ARCHIVE_EOF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryData(WriteTo As Writeable) As Boolean
		  ' Reads bytes from the archive and writes them to the specified Writeable stream.
		  ' This method will raise the Progress() event.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.ReadEntryData
		  
		  If Not mIsOpen Then Open()
		  If WriteTo = Nil Then Return SkipEntryData()
		  
		  mLastError = ARCHIVE_OK
		  Dim pos As Int64
		  Do Until mLastError <> ARCHIVE_OK
		    Dim buffer As MemoryBlock
		    Dim offset As UInt64
		    Dim size As UInt32 = ReadEntryDataBlock(buffer, offset)
		    If size > 0 Then
		      WriteTo.Write(buffer.StringValue(0, size))
		      pos = pos + size
		      If RaiseEvent Progress(CurrentEntry, pos) Then
		        Call SkipEntryData()
		        Exit Do
		      End If
		    End If
		  Loop
		  
		  Return (mLastError = ARCHIVE_EOF Or mLastError = ARCHIVE_OK)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryDataBlock(ByRef Block As MemoryBlock, ByRef Offset As UInt64) As UInt32
		  ' Reads bytes from the archive and updates the Block parameter to point to the buffer containing
		  ' the resulting data. This awkward arrangement minimizes the need to copy the potentially large
		  ' buffer. This method will not raise the Progress() event.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.ReadEntryDataBlock
		  
		  If Not mIsOpen Then Open()
		  
		  Dim size As UInt32
		  Dim buffer As Ptr
		  mLastError = archive_read_data_block(mArchive, buffer, size, Offset)
		  If buffer <> Nil Then Block = buffer
		  Return size
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryDataBlock(Count As UInt32) As MemoryBlock
		  ' Reads the requested number of bytes from the archive and copies them into a new MemoryBlock,
		  ' which is then returned. This method will not raise the Progress() event.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.ReadEntryDataBlock
		  
		  If Not mIsOpen Then Open()
		  
		  Dim buffer As New MemoryBlock(Count)
		  mLastError = archive_read_data(mArchive, buffer, Buffer.Size)
		  If mLastError >= 0 Then
		    buffer.Size = mLastError
		    Return buffer
		  End If
		  Raise New ArchiveException(Me)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryHeader() As Boolean
		  ' Reads the metadata of the next item in the archive.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.ReadEntryHeader
		  
		  If Not mIsOpen Then Open()
		  Dim entry As Ptr
		  mLastError = archive_read_next_header(mArchive, entry)
		  If mLastError <> ARCHIVE_OK Then Return False
		  mCurrentEntry = New ArchiveEntryPtr(Me, entry)
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFilter(Compressor As libarchive.CompressionType)
		  ' Sets the compression type. Must be called before the archive is opened.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SetFilter
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  
		  SetFilterName(Compressor)
		  Select Case Compressor
		  Case libarchive.CompressionType.BZip2
		    mLastError = archive_read_support_filter_bzip2(mArchive)
		  Case libarchive.CompressionType.Compress
		    mLastError = archive_read_support_filter_compress(mArchive)
		  Case libarchive.CompressionType.GRZip
		    mLastError = archive_read_support_filter_grzip(mArchive)
		  Case libarchive.CompressionType.GZip
		    mLastError = archive_read_support_filter_gzip(mArchive)
		  Case libarchive.CompressionType.LRZip
		    mLastError = archive_read_support_filter_lrzip(mArchive)
		  Case libarchive.CompressionType.LZ4
		    mLastError = archive_read_support_filter_lz4(mArchive)
		  Case libarchive.CompressionType.LZip
		    mLastError = archive_read_support_filter_lzip(mArchive)
		  Case libarchive.CompressionType.LZMA
		    mLastError = archive_read_support_filter_lzma(mArchive)
		  Case libarchive.CompressionType.LZOP
		    mLastError = archive_read_support_filter_lzop(mArchive)
		  Case libarchive.CompressionType.None
		    mLastError = archive_read_support_filter_none(mArchive)
		  Case libarchive.CompressionType.RPM
		    mLastError = archive_read_support_filter_rpm(mArchive)
		  Case libarchive.CompressionType.UUEncoded
		    mLastError = archive_read_support_filter_uu(mArchive)
		  Case libarchive.CompressionType.XZ
		    mLastError = archive_read_support_filter_xz(mArchive)
		  Case libarchive.CompressionType.ZStd
		    mLastError = archive_read_support_filter_zstd(mArchive)
		  Case libarchive.CompressionType.All
		    mLastError = archive_read_support_filter_all(mArchive)
		  Else
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
		  ' Sets an option for the specified compression filter. Must be called before the archive is opened.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SetFilterOption
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  
		  mLastError = archive_read_set_filter_option(mArchive, FilterModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFormat(ArchiveType As libarchive.ArchiveType)
		  ' Sets the archive format. Must be called before the archive is opened.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SetFormat
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  
		  SetFormatName(ArchiveType)
		  Select Case ArchiveType
		  Case libarchive.ArchiveType.All
		    mLastError = archive_read_support_format_all(mArchive)
		  Case libarchive.ArchiveType.SevenZip
		    mLastError = archive_read_support_format_7zip(mArchive)
		  Case libarchive.ArchiveType.Ar
		    mLastError = archive_read_support_format_ar(mArchive)
		  Case libarchive.ArchiveType.Cabinet
		    mLastError = archive_read_support_format_cab(mArchive)
		  Case libarchive.ArchiveType.CPIO
		    mLastError = archive_read_support_format_cpio(mArchive)
		  Case libarchive.ArchiveType.Empty
		    mLastError = archive_read_support_format_empty(mArchive)
		  Case libarchive.ArchiveType.ISO9660
		    mLastError = archive_read_support_format_iso9660(mArchive)
		  Case libarchive.ArchiveType.LHA
		    mLastError = archive_read_support_format_lha(mArchive)
		  Case libarchive.ArchiveType.MTree
		    mLastError = archive_read_support_format_mtree(mArchive)
		  Case libarchive.ArchiveType.RAR
		    mLastError = archive_read_support_format_rar(mArchive)
		  Case libarchive.ArchiveType.RAR5
		    mLastError = archive_read_support_format_rar5(mArchive)
		  Case libarchive.ArchiveType.Raw
		    mLastError = archive_read_support_format_raw(mArchive)
		  Case libarchive.ArchiveType.TAR
		    mLastError = archive_read_support_format_tar(mArchive)
		  Case libarchive.ArchiveType.WArc
		    mLastError = archive_read_support_format_warc(mArchive)
		  Case libarchive.ArchiveType.XAR
		    mLastError = archive_read_support_format_xar(mArchive)
		  Case libarchive.ArchiveType.Zip
		    mLastError = archive_read_support_format_zip(mArchive)
		  Case libarchive.ArchiveType.ZipStreamable
		    mLastError = archive_read_support_format_zip_streamable(mArchive)
		  Case libarchive.ArchiveType.ZipSeekable
		    mLastError = archive_read_support_format_zip_seekable(mArchive)
		  Else
		    mLastError = ERR_WRITE_ONLY_FORMAT
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
		  ' Sets an option for the specified archive format. Must be called before the archive is opened.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SetFormatOption
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  
		  mLastError = archive_read_set_format_option(mArchive, FormatModule, OptionName, OptionValue)
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
		  ' Sets an option for the specified compression filter or archive format. Must be
		  ' called before the archive is opened.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SetOption
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  
		  mLastError = archive_read_set_option(mArchive, FilterOrFormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptions(Options() As String) As Boolean
		  ' Sets several compression and/or archive options at once. Must be called before
		  ' the archive is opened.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SetOptions
		  
		  If mIsOpen Then
		    mLastError = ERR_TOO_LATE
		    Return False
		  End If
		  
		  Dim opts As String = Join(Options, ",")
		  mLastError = archive_read_set_options(mArchive, opts)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SkipEntryData() As Boolean
		  ' Skips the entire entry without reading it.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.SkipEntryData
		  
		  If Not mIsOpen Then
		    mLastError = ERR_TOO_EARLY
		    Return False
		  End If
		  
		  mLastError = archive_read_data_skip(mArchive)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetPassword(ByRef ArchivePassword As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Progress(Entry As libarchive.ArchiveEntry, Position As Int64) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the True if libarchive can decrypt this archive.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.CanDecryptData
			  
			  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return False
			  
			  If mArchive <> Nil Then
			    mLastError = archive_read_format_capabilities(mArchive)
			    Return BitAnd(mLastError, ARCHIVE_READ_FORMAT_CAPS_ENCRYPT_DATA) = ARCHIVE_READ_FORMAT_CAPS_ENCRYPT_DATA
			  End If
			End Get
		#tag EndGetter
		CanDecryptData As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the True if libarchive can decrypt this archive.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.CanDecryptMetaData
			  
			  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return False
			  
			  If mArchive <> Nil Then
			    mLastError = archive_read_format_capabilities(mArchive)
			    Return BitAnd(mLastError, ARCHIVE_READ_FORMAT_CAPS_ENCRYPT_METADATA) = ARCHIVE_READ_FORMAT_CAPS_ENCRYPT_METADATA
			  End If
			End Get
		#tag EndGetter
		CanDecryptMetadata As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the currently selected entry in the archive. If no entry has been selected
			  ' yet then the first entry is selected automatically.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.CurrentEntry
			  
			  If mCurrentEntry = Nil And Not IsOpen And mLastError <> ARCHIVE_FATAL Then Open()
			  return mCurrentEntry
			End Get
		#tag EndGetter
		CurrentEntry As libarchive.ArchiveEntry
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return 0
			  If mArchive <> Nil Then Return archive_read_header_position(mArchive)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mArchive <> Nil Then Call archive_seek_data(mArchive, value)
			End Set
		#tag EndSetter
		Protected FileDataPosition As UInt64
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
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.FilenameEncoding
			  
			  If SetFormatOption(mFormatName, FORMAT_OPT_HDRCHARSET, value.internetName) Then
			    mFilenameEncoding = value
			  End If
			  
			End Set
		#tag EndSetter
		FilenameEncoding As TextEncoding
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the format of the archive.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.Format
			  
			  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return ArchiveType.All
			  
			  Dim frmat As Int32 = archive_format(mArchive)
			  frmat = frmat And &hFFFFF00
			  Select Case frmat
			  Case ARCHIVE_FORMAT_CPIO
			    Return ArchiveType.CPIO
			  Case ARCHIVE_FORMAT_CAB
			    Return ArchiveType.Cabinet
			  Case ARCHIVE_FORMAT_ISO9660
			    Return ArchiveType.ISO9660
			  Case ARCHIVE_FORMAT_LHA
			    Return ArchiveType.LHA
			  Case ARCHIVE_FORMAT_MTREE
			    Return ArchiveType.MTree
			  Case ARCHIVE_FORMAT_RAR, ARCHIVE_FORMAT_RAR_V5
			    Return ArchiveType.RAR
			  Case ARCHIVE_FORMAT_TAR
			    Return ArchiveType.TAR
			  Case ARCHIVE_FORMAT_XAR
			    Return ArchiveType.XAR
			  Case ARCHIVE_FORMAT_7ZIP
			    Return ArchiveType.SevenZip
			  Case ARCHIVE_FORMAT_ZIP
			    Return ArchiveType.Zip
			  Else
			    Return ArchiveType.All
			  End Select
			End Get
		#tag EndGetter
		Format As libarchive.ArchiveType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the format subtype or variant of the archive entry.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.FormatVariant
			  
			  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return 0
			  Return archive_format(mArchive)
			End Get
		#tag EndGetter
		FormatVariant As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the True if libarchive has detected at least one encrypted entry so far.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.HasEncryptedEntries
			  
			  If mArchive = Nil Or mLastError = ARCHIVE_FATAL Or Not mIsOpen Then Return False
			  
			  mLastError = archive_read_has_encrypted_entries(mArchive)
			  Select Case mLastError
			  Case 0 ' decryption supported but no encrypted entries detected
			    Return False
			  Case Is > 0 ' decryption supported and encrypted entries detected
			    Return True
			  Else
			    ' either decryption is not supported or we don't know (yet) whether there are encrypted entries
			    Return False
			  End Select
			  
			End Get
		#tag EndGetter
		HasEncryptedEntries As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentEntry As libarchive.ArchiveEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the password to be used in decrypting encrypted entries. Must be set before
			  ' the archive is opened.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader.Password
			  
			  If Not IsOpen And mArchive <> Nil Then
			    Dim mb As MemoryBlock = value + Chr(0)
			    mLastError = archive_read_add_passphrase(mArchive, mb)
			    If mLastError = ARCHIVE_OK Then mPassword = value
			  End If
			  
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty


	#tag Constant, Name = ARCHIVE_READ_FORMAT_CAPS_ENCRYPT_DATA, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_READ_FORMAT_CAPS_ENCRYPT_METADATA, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_READ_FORMAT_CAPS_NONE, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_READ_FORMAT_ENCRYPTION_DONT_KNOW, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_READ_FORMAT_ENCRYPTION_UNSUPPORTED, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="CanDecryptData"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanDecryptMetadata"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasEncryptedEntries"
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
