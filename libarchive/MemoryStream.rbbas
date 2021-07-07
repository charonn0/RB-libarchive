#tag Class
Private Class MemoryStream
	#tag Method, Flags = &h21
		Private Function CB_Close() As Int32
		  mSource = Nil
		  mDestination = Nil
		  mIsOpen = False
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_Free() As Int32
		  If Instances = Nil Or Not Instances.HasKey(mArchive.Handle) Then Return -1
		  Instances.Remove(mArchive.Handle)
		  If Instances.Count = 0 Then Instances = Nil
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_Read(ByRef Buffer As Ptr) As UInt32
		  If mSource.EOF Then Return ARCHIVE_EOF
		  mCurrentBuffer = mSource.Read(CHUNK_SIZE)
		  Buffer = mCurrentBuffer
		  mUsed = mUsed + mCurrentBuffer.Size
		  Return mCurrentBuffer.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_ReadOpen() As Int32
		  If mSource = Nil Then Return -1
		  mIsOpen = True
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_Seek(Offset As Int64, Whence As Int32) As Int64
		  If Not mSource IsA BinaryStream Then Return ARCHIVE_FATAL
		  Dim stream As BinaryStream = BinaryStream(mSource)
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

	#tag Method, Flags = &h21
		Private Function CB_Skip(Request As Int64) As Int64
		  If Not mSource IsA BinaryStream Then Return 0
		  Dim stream As BinaryStream = BinaryStream(mSource)
		  Dim pos As UInt64 = stream.Position
		  stream.Position = Request
		  mUsed = Request
		  Return mUsed - pos
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_Switch(Opaque2 As Ptr) As Int32
		  Dim w As WeakRef = Instances.Lookup(Opaque2, Nil)
		  If w = Nil Or Not w.Value IsA MemoryStream Then Return -1
		  Dim nxt As MemoryStream = MemoryStream(w.Value)
		  If nxt = Nil Then Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_Write(Buffer As Ptr, Length As UInt32) As UInt32
		  Dim data As MemoryBlock = Buffer
		  Dim mb As MemoryBlock = data.StringValue(0, Length)
		  mDestination.Write(mb)
		  mUsed = mUsed + Length
		  Return Length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CB_WriteOpen() As Int32
		  If mDestination = Nil Then Return -1
		  mIsOpen = True
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CloseCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Close()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Owner As libarchive.ArchiveReader, ReadFrom As Readable)
		  mArchive = Owner
		  
		  mLastError = archive_read_set_open_callback(mArchive.Handle, AddressOf ReadOpenCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_read_callback(mArchive.Handle, AddressOf ReadCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_seek_callback(mArchive.Handle, AddressOf SeekCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_skip_callback(mArchive.Handle, AddressOf SkipCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_close_callback(mArchive.Handle, AddressOf CloseCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_switch_callback(mArchive.Handle, AddressOf SwitchCallback)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  mLastError = archive_read_set_callback_data(mArchive.Handle, mArchive.Handle)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  mSource = ReadFrom
		  
		  If Instances = Nil Then Instances = New Dictionary
		  Instances.Value(mArchive.Handle) = New WeakRef(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Owner As libarchive.ArchiveWriter, WriteTo As Writeable)
		  mArchive = Owner
		  If Instances = Nil Then Instances = New Dictionary
		  Instances.Value(mArchive.Handle) = New WeakRef(Me)
		  mDestination = WriteTo
		  
		  mLastError = archive_write_set_bytes_in_last_block(mArchive.Handle, 1)
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		  If Not USE_BUFFERING Then
		    mLastError = archive_write_set_bytes_per_block(mArchive.Handle, 0)
		    If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  End If
		  
		  mLastError = archive_write_open2(mArchive.Handle, mArchive.Handle, _
		  AddressOf WriteOpenCallback, _
		  AddressOf WriteCallback, _
		  AddressOf CloseCallback, _
		  AddressOf FreeCallback)
		  
		  If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Call CB_Close()
		  Call CB_Free()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FreeCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Free()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadCallback(Archive As Ptr, Opaque As Ptr, ByRef Buffer As Ptr) As UInt32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Read(Buffer)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadOpenCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_ReadOpen()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SeekCallback(Archive As Ptr, Opaque As Ptr, Offset As Int64, Whence As Int32) As Int64
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Seek(Offset, Whence)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SkipCallback(Archive As Ptr, Opaque As Ptr, Request As Int64) As Int64
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Skip(Request)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SwitchCallback(Archive As Ptr, Opaque1 As Ptr, Opaque2 As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque1 = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque1, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Switch(Opaque2)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function WriteCallback(Archive As Ptr, Opaque As Ptr, Buffer As Ptr, Length As UInt32) As UInt32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_Write(Buffer, Length)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function WriteOpenCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value).CB_WriteOpen()
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared Instances As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mIsOpen
			End Get
		#tag EndGetter
		IsOpen As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLastError
			End Get
		#tag EndGetter
		LastError As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mArchive As libarchive.Archive
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestination As Writeable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Readable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsed As UInt64
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUsed
			End Get
		#tag EndGetter
		Used As UInt64
	#tag EndComputedProperty


	#tag Constant, Name = USE_BUFFERING, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant


End Class
#tag EndClass
