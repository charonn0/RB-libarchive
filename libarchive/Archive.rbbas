#tag Class
Protected Class Archive
	#tag Method, Flags = &h1
		Protected Function CB_Close() As Int32
		  mSourceStream = Nil
		  mSourceFile = Nil
		  mSourceBuffer = Nil
		  mDestinationStream = Nil
		  mIsOpen = False
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_Read(ByRef Buffer As Ptr) As UInt32
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If mSourceStream.EOF Then Return ARCHIVE_EOF
		  mCurrentBuffer = mSourceStream.Read(CHUNK_SIZE)
		  Buffer = mCurrentBuffer
		  mUsed = mUsed + mCurrentBuffer.Size
		  Return mCurrentBuffer.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_ReadOpen() As Int32
		  If mSourceStream = Nil Then Return -1
		  mIsOpen = True
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_Seek(Offset As Int64, Whence As Int32) As Int64
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If Not mSourceStream IsA BinaryStream Then Return ARCHIVE_FATAL
		  Dim stream As BinaryStream = BinaryStream(mSourceStream)
		  Const SEEK_SET = 0
		  Const SEEK_CUR = 1
		  Const SEEK_END = 2
		  
		  Select Case Whence
		  Case SEEK_SET
		    Offset = Offset
		  Case SEEK_CUR
		    Offset = stream.Position + Offset
		  Case SEEK_END
		    Offset = stream.Length - Offset
		  Else
		    Return ARCHIVE_FATAL
		  End Select
		  
		  If Offset < 0 Or Offset > stream.Length Then Return ARCHIVE_FATAL
		  stream.Position = Offset
		  mUsed = Offset
		  Return mUsed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_Skip(Request As Int64) As Int64
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If Not mSourceStream IsA BinaryStream Then Return 0
		  Dim stream As BinaryStream = BinaryStream(mSourceStream)
		  Dim pos As UInt64 = stream.Position
		  stream.Position = Request
		  mUsed = Request
		  Return mUsed - pos
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_Switch(Opaque2 As Ptr) As Int32
		  Dim w As WeakRef = Archives.Lookup(Opaque2, Nil)
		  If w = Nil Or Not w.Value IsA Archive Then Return -1
		  Dim nxt As Archive = Archive(w.Value)
		  If nxt = Nil Then Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_Write(Buffer As Ptr, Length As UInt32) As UInt32
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  Dim data As MemoryBlock = Buffer
		  mDestinationStream.Write(data.StringValue(0, Length))
		  mUsed = mUsed + Length
		  Return Length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CB_WriteOpen() As Int32
		  If mDestinationStream = Nil Then Return -1
		  mIsOpen = True
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  ' Releases all locally held resources. 
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Archive.Close
		  
		  ' Call CB_Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CloseCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_Close()
		  End If
		End Function
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
		Protected Shared Function FreeCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Archives <> Nil And Archives.HasKey(Opaque) Then
		    Archives.Remove(Opaque)
		    If Archives.Count = 0 Then Archives = Nil
		    Return 0
		  End If
		  Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function ReadCallback(Archive As Ptr, Opaque As Ptr, ByRef Buffer As Ptr) As UInt32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_Read(Buffer)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function ReadOpenCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_ReadOpen()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SeekCallback(Archive As Ptr, Opaque As Ptr, Offset As Int64, Whence As Int32) As Int64
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_Seek(Offset, Whence)
		  End If
		End Function
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

	#tag Method, Flags = &h0
		Function SetFilterOption(OptionName As String, OptionValue As String) As Boolean
		  #pragma Unused OptionName
		  #pragma Unused OptionValue
		  Raise New ArchiveException(ERR_INCONCEIVABLE)
		End Function
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

	#tag Method, Flags = &h0
		Function SetFormatOption(OptionName As String, OptionValue As String) As Boolean
		  #pragma Unused OptionName
		  #pragma Unused OptionValue
		  Raise New ArchiveException(ERR_INCONCEIVABLE)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionName As String, OptionValue As String) As Boolean
		  #pragma Unused OptionName
		  #pragma Unused OptionValue
		  Raise New ArchiveException(ERR_INCONCEIVABLE)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptions(Options() As String) As Boolean
		  #pragma Unused Options
		  Raise New ArchiveException(ERR_INCONCEIVABLE)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SkipCallback(Archive As Ptr, Opaque As Ptr, Request As Int64) As Int64
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_Skip(Request)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SwitchCallback(Archive As Ptr, Opaque1 As Ptr, Opaque2 As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque1 = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque1, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_Switch(Opaque2)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function WriteCallback(Archive As Ptr, Opaque As Ptr, Buffer As Ptr, Length As UInt32) As UInt32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  #pragma StackOverflowChecking Off
		  #pragma BackgroundTasks Off
		  #pragma NilObjectChecking Off
		  
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_Write(Buffer, Length)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function WriteOpenCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Archives = Nil Then Return -1
		  Dim w As WeakRef = Archives.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA Archive Then
		    Return Archive(w.Value).CB_WriteOpen()
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Shared Archives As Dictionary
	#tag EndProperty

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

	#tag Property, Flags = &h21
		Private mCurrentBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDestinationStream As Writeable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mFilenameEncoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mFilterName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mFormatName As String
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
		Protected mUsed As UInt64
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
