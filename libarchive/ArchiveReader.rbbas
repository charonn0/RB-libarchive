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
		  
		  If mIsOpen Then mLastError = archive_read_close(mArchive)
		  mCurrentEntry = Nil
		  Super.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  ' Constructs a generic ArchiveReader. Format-specific subclasses call this Constructor.
		  
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
		  
		  If mArchive <> Nil Then
		    Super.Close()
		    mLastError = archive_read_free(mArchive) ' free() calls close()
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
		Function MoveNext(WriteTo As Writeable) As Boolean
		  Return ReadEntryData(WriteTo) And ReadEntryHeader()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub OpenFile(File As FolderItem, BlockSize As UInt32)
		  mLastError = archive_read_open_filename_w(mArchive, File.AbsolutePath_, BlockSize)
		  If mLastError <> ARCHIVE_OK Or Not ReadEntryHeader() Then Raise New ArchiveException(Me)
		  mIsOpen = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub OpenMemory(Buffer As MemoryBlock)
		  mLastError = archive_read_open_memory(mArchive, Buffer, Buffer.Size)
		  If mLastError <> ARCHIVE_OK Or Not ReadEntryHeader() Then Raise New ArchiveException(Me)
		  mBuffer = Buffer
		  mIsOpen = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryData(WriteTo As Int32) As Boolean
		  If WriteTo = 0 Then Return SkipEntryData()
		  
		  mLastError = archive_read_data_into_fd(mArchive, WriteTo)
		  Return mLastError = ARCHIVE_EOF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryData(WriteTo As Writeable) As Boolean
		  If WriteTo = Nil Then Return SkipEntryData()
		  mLastError = 0
		  
		  Do Until mLastError <> ARCHIVE_OK
		    Dim buffer As MemoryBlock
		    Dim offset As UInt64
		    Dim size As UInt32 = ReadEntryDataBlock(buffer, offset)
		    If size > 0 Then
		      WriteTo.Write(buffer.StringValue(0, size))
		      If RaiseEvent ExtractProgress(CurrentEntry, Me.FileDataPosition) Then Exit Do
		    End If
		  Loop
		  
		  Return mLastError = ARCHIVE_EOF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryDataBlock(ByRef Block As MemoryBlock, ByRef Offset As UInt64) As UInt32
		  Dim size As UInt32
		  Dim buffer As Ptr
		  mLastError = archive_read_data_block(mArchive, buffer, size, Offset)
		  If buffer <> Nil Then Block = buffer
		  Return size
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadEntryDataBlock(Count As UInt32) As MemoryBlock
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
		  Dim entry As Ptr
		  mLastError = archive_read_next_header(mArchive, entry)
		  If mLastError <> ARCHIVE_OK Then Return False
		  mCurrentEntry = New ArchiveEntryPtr(Me, entry)
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFilter(Compressor As libarchive.CompressionType)
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

	#tag Method, Flags = &h1
		Protected Function SetFilterOption(FilterModule As String, OptionName As String, OptionValue As String) As Boolean
		  mLastError = archive_read_set_filter_option(mArchive, FilterModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFormat(ArchiveType As libarchive.ArchiveType)
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

	#tag Method, Flags = &h1
		Protected Function SetFormatOption(FormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  mLastError = archive_read_set_format_option(mArchive, FormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetOption(FilterOrFormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  mLastError = archive_read_set_option(mArchive, FilterOrFormatModule, OptionName, OptionValue)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetOptions(Options() As String) As Boolean
		  Dim opts As String = Join(Options, ",")
		  mLastError = archive_read_set_options(mArchive, opts)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SkipEntryData() As Boolean
		  mLastError = archive_read_data_skip(mArchive)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ExtractProgress(Item As libarchive.ArchiveEntry, Position As Int64) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetPassword(ByRef ArchivePassword As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared Archives As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
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
			  return mCurrentEntry
			End Get
		#tag EndGetter
		CurrentEntry As libarchive.ArchiveEntry
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
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
			  Const ARCHIVE_FORMAT_CPIO = &h
			  Const ARCHIVE_FORMAT_SHAR = &h2
			  Const ARCHIVE_FORMAT_TAR = &h3
			  Const ARCHIVE_FORMAT_ISO9660 = &h4
			  Const ARCHIVE_FORMAT_ZIP = &h5
			  Const ARCHIVE_FORMAT_EMPTY = &h6
			  Const ARCHIVE_FORMAT_AR = &h7
			  Const ARCHIVE_FORMAT_MTREE = &h8
			  Const ARCHIVE_FORMAT_RAW = &h9
			  Const ARCHIVE_FORMAT_XAR = &hA
			  Const ARCHIVE_FORMAT_LHA = &hB
			  Const ARCHIVE_FORMAT_CAB = &hC
			  Const ARCHIVE_FORMAT_RAR = &hD
			  Const ARCHIVE_FORMAT_7ZIP = &hE
			  Const ARCHIVE_FORMAT_WARC = &hF
			  Const ARCHIVE_FORMAT_RAR_V5 = &h10
			  
			  If mArchive = Nil Then Return ArchiveType.All
			  If mFormatFamily = ArchiveType.All Then
			    Dim frmat As Int32 = archive_format(mArchive)
			    Select Case ShiftRight(frmat, 16)
			    Case ARCHIVE_FORMAT_CPIO
			      mFormatFamily = ArchiveType.CPIO
			    Case ARCHIVE_FORMAT_CAB
			      mFormatFamily = ArchiveType.Cabinet
			    Case ARCHIVE_FORMAT_ISO9660
			      mFormatFamily = ArchiveType.ISO9660
			    Case ARCHIVE_FORMAT_LHA
			      mFormatFamily = ArchiveType.LHA
			    Case ARCHIVE_FORMAT_MTREE
			      mFormatFamily = ArchiveType.MTree
			    Case ARCHIVE_FORMAT_RAR, ARCHIVE_FORMAT_RAR_V5
			      mFormatFamily = ArchiveType.RAR
			    Case ARCHIVE_FORMAT_TAR
			      mFormatFamily = ArchiveType.TAR
			    Case ARCHIVE_FORMAT_XAR
			      mFormatFamily = ArchiveType.XAR
			    Case ARCHIVE_FORMAT_7ZIP
			      mFormatFamily = ArchiveType.SevenZip
			    Case ARCHIVE_FORMAT_ZIP
			      mFormatFamily = ArchiveType.Zip
			    Else
			      mFormatFamily = ArchiveType.All
			    End Select
			  End If
			  
			  Return mFormatFamily
			End Get
		#tag EndGetter
		Format As libarchive.ArchiveType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mArchive = Nil Then Return 0
			  If mFormatVariant = 0 Then
			    Dim frmat As Int32 = archive_format(mArchive)
			    mFormatVariant = ShiftLeft(frmat, 16)
			  End If
			  
			  Return mFormatVariant
			End Get
		#tag EndGetter
		FormatVariant As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mArchive = Nil Then Return False
			  
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
		Private mFormatFamily As libarchive.ArchiveType = ArchiveType.All
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFormatVariant As Int32
	#tag EndProperty

	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty


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
