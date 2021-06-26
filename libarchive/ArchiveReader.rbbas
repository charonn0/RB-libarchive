#tag Class
Protected Class ArchiveReader
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
		  If mIsOpen Then mLastError = archive_read_close(mArchive)
		  mIsOpen = False
		  mBuffer = Nil
		  mCurrentEntry = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(ArchiveType As libarchive.ArchiveType, CompressionType As libarchive.CompressionType)
		  If Not libarchive.IsAvailable() Then Raise New PlatformNotSupportedException
		  mArchive = archive_read_new()
		  If mArchive = Nil Then Raise New ArchiveException(Me)
		  Select Case ArchiveType
		  Case libarchive.ArchiveType.SevenZip
		    mLastError = archive_read_support_format_7zip(mArchive)
		  Case libarchive.ArchiveType.Ar
		    mLastError = archive_read_support_format_ar(mArchive)
		  Case libarchive.ArchiveType.Cabinet
		    mLastError = archive_read_support_format_cab(mArchive)
		  Case libarchive.ArchiveType.CPIO
		    mLastError = archive_read_support_format_cpio(mArchive)
		  Case libarchive.ArchiveType.ISO9660
		    mLastError = archive_read_support_format_iso9660(mArchive)
		  Case libarchive.ArchiveType.LHA
		    mLastError = archive_read_support_format_lha(mArchive)
		  Case libarchive.ArchiveType.MTree
		    mLastError = archive_read_support_format_mtree(mArchive)
		  Case libarchive.ArchiveType.RAR
		    mLastError = archive_read_support_format_rar(mArchive)
		  Case libarchive.ArchiveType.TAR
		    mLastError = archive_read_support_format_tar(mArchive)
		  Case libarchive.ArchiveType.XAR
		    mLastError = archive_read_support_format_xar(mArchive)
		  Case libarchive.ArchiveType.Zip
		    mLastError = archive_read_support_format_zip(mArchive)
		  Case libarchive.ArchiveType.All
		    mLastError = archive_read_support_format_all(mArchive)
		  Else
		    Raise New ArchiveException(Me)
		  End Select
		  
		  Select Case CompressionType
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
		  Case libarchive.CompressionType.LZMA
		    mLastError = archive_read_support_filter_lzma(mArchive)
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
		  
		  If Archives = Nil Then Archives = New Dictionary
		  Archives.Value(mArchive) = New WeakRef(Me)
		  mLastError = archive_read_set_passphrase_callback(mArchive, mArchive, AddressOf archive_passphrase_callback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mArchive <> Nil Then
		    mLastError = archive_read_free(mArchive) ' free() calls close()
		    If Archives <> Nil And Archives.HasKey(mArchive) Then Archives.Remove(mArchive)
		    If Archives.Count = 0 Then Archives = Nil
		  End If
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetPassword(ByRef ArchivePassword As String) As Boolean
		  Return RaiseEvent GetPassword(ArchivePassword)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext(WriteTo As Writeable) As Boolean
		  Return ReadFileData(WriteTo) And ReadHeader()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub OpenFile(File As FolderItem, BlockSize As UInt32)
		  mLastError = archive_read_open_filename_w(mArchive, File.AbsolutePath, BlockSize)
		  If mLastError <> ARCHIVE_OK Or Not ReadHeader() Then Raise New ArchiveException(Me)
		  mIsOpen = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub OpenMemory(Buffer As MemoryBlock)
		  mLastError = archive_read_open_memory(mArchive, Buffer, Buffer.Size)
		  If mLastError <> ARCHIVE_OK Or Not ReadHeader() Then Raise New ArchiveException(Me)
		  mBuffer = Buffer
		  mIsOpen = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadFileData(WriteTo As Writeable) As Boolean
		  If WriteTo = Nil Then
		    mLastError = archive_read_data_skip(mArchive)
		    Return mLastError = ARCHIVE_OK
		  End If
		  
		  Do Until mLastError <> ARCHIVE_OK
		    Dim buffer As Ptr
		    Dim size As UInt32
		    Dim offset As UInt64
		    mLastError = archive_read_data_block(mArchive, buffer, size, offset)
		    If buffer <> Nil Then
		      Dim mb As MemoryBlock = buffer
		      WriteTo.Write(mb.StringValue(0, size))
		    End If
		  Loop
		  
		  Return mLastError = ARCHIVE_EOF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadHeader() As Boolean
		  Dim entry As Ptr
		  mLastError = archive_read_next_header(mArchive, entry)
		  If mLastError <> ARCHIVE_OK Then Return False
		  mCurrentEntry = New ArchiveEntryPtr(Me, entry)
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetPassword(ByRef ArchivePassword As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared Archives As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCurrentEntry
			End Get
		#tag EndGetter
		CurrentEntry As libarchive.ArchiveEntry
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Const ARCHIVE_FORMAT_CPIO = &h10000
			  Const ARCHIVE_FORMAT_SHAR = &h20000
			  Const ARCHIVE_FORMAT_TAR = &h30000
			  Const ARCHIVE_FORMAT_ISO9660 = &h40000
			  Const ARCHIVE_FORMAT_ZIP = &h50000
			  Const ARCHIVE_FORMAT_EMPTY = &h60000
			  Const ARCHIVE_FORMAT_AR = &h70000
			  Const ARCHIVE_FORMAT_MTREE = &h80000
			  Const ARCHIVE_FORMAT_RAW = &h90000
			  Const ARCHIVE_FORMAT_XAR = &hA0000
			  Const ARCHIVE_FORMAT_LHA = &hB0000
			  Const ARCHIVE_FORMAT_CAB = &hC0000
			  Const ARCHIVE_FORMAT_RAR = &hD0000
			  Const ARCHIVE_FORMAT_7ZIP = &hE0000
			  Const ARCHIVE_FORMAT_WARC = &hF0000
			  Const ARCHIVE_FORMAT_RAR_V5 = &h100000
			  
			  If mArchive = Nil Then Return ArchiveType.All
			  If mFormat = 0 Then mFormat = archive_format(mArchive)
			  
			  Select Case True
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_CPIO) = ARCHIVE_FORMAT_CPIO
			    Return ArchiveType.CPIO
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_CAB) = ARCHIVE_FORMAT_CAB
			    Return ArchiveType.Cabinet
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_ISO9660) = ARCHIVE_FORMAT_ISO9660
			    Return ArchiveType.ISO9660
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_LHA) = ARCHIVE_FORMAT_LHA
			    Return ArchiveType.LHA
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_MTREE) = ARCHIVE_FORMAT_MTREE
			    Return ArchiveType.MTree
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_RAR) = ARCHIVE_FORMAT_RAR, BitAnd(mFormat, ARCHIVE_FORMAT_RAR_V5) = ARCHIVE_FORMAT_RAR_V5
			    Return ArchiveType.RAR
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_TAR) = ARCHIVE_FORMAT_TAR
			    Return ArchiveType.TAR
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_XAR) = ARCHIVE_FORMAT_XAR
			    Return ArchiveType.XAR
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_7ZIP) = ARCHIVE_FORMAT_7ZIP
			    Return ArchiveType.SevenZip
			  Case BitAnd(mFormat, ARCHIVE_FORMAT_ZIP) = ARCHIVE_FORMAT_ZIP
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
		Private mCurrentEntry As libarchive.ArchiveEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFormat As Int32
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
