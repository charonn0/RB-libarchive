#tag Class
Private Class MemoryStream
	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_close_callback(Archive As Ptr, Opaque As Ptr) As Int32
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_free_callback(Archive As Ptr, Opaque As Ptr) As Int32
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_open_callback(Archive As Ptr, Opaque As Ptr) As Int32
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_passphrase_callback(Archive As Ptr, Opaque As Ptr) As CString
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_read_callback(Archive As Ptr, Opaque As Ptr, ByRef Buffer As Ptr) As UInt32
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_seek_callback(Archive As Ptr, Opaque As Ptr, Offset As Int64, Whence As Int32) As Int64
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_skip_callback(Archive As Ptr, Opaque As Ptr, Request As Int64) As Int64
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_switch_callback(Archive As Ptr, Opaque1 As Ptr, Opaque2 As Ptr) As Int32
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function archive_write_callback(Archive As Ptr, Opaque As Ptr, Buffer As Ptr, Length As UInt32) As UInt32
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Shared Function CloseCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Close()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Owner As libarchive.ArchiveReader, ReadFrom As Readable)
		  mArchive = Owner
		  
		  mLastError = archive_read_set_open_callback(mArchive.Handle, AddressOf OpenCallback)
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
		Sub Constructor(Owner As libarchive.ArchiveWriter)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FreeCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Free()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function OpenCallback(Archive As Ptr, Opaque As Ptr) As Int32
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Open()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadCallback(Archive As Ptr, Opaque As Ptr, ByRef Buffer As Ptr) As UInt32
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Read(Buffer)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SeekCallback(Archive As Ptr, Opaque As Ptr, Offset As Int64, Whence As Int32) As Int64
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Seek(Offset, Whence)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SkipCallback(Archive As Ptr, Opaque As Ptr, Request As Int64) As Int64
		  #pragma Unused Archive
		  If Opaque = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Skip(Request)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SwitchCallback(Archive As Ptr, Opaque1 As Ptr, Opaque2 As Ptr) As Int32
		  #pragma Unused Archive
		  If Opaque1 = Nil Or Instances = Nil Then Return -1
		  Dim w As WeakRef = Instances.Lookup(Opaque1, Nil)
		  If w <> Nil And w.Value IsA MemoryStream Then
		    Return MemoryStream(w.Value)._Switch(Opaque2)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Close() As Int32
		  mSource = Nil
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Free() As Int32
		  If Instances = Nil Or Not Instances.HasKey(mArchive.Handle) Then Return -1
		  Instances.Remove(mArchive.Handle)
		  If Instances.Count = 0 Then Instances = Nil
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Open() As Int32
		  If mSource = Nil Then Return -1
		  mIsOpen = True
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Read(ByRef Buffer As Ptr) As UInt32
		  If mSource.EOF Then Return ARCHIVE_EOF
		  Dim data As MemoryBlock = mSource.Read(CHUNK_SIZE)
		  Buffer = data
		  Return data.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Seek(Offset As Int64, Whence As Int32) As Int64
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
		  Return stream.Position
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Skip(Request As Int64) As Int64
		  If Not mSource IsA BinaryStream Then Return 0
		  Dim stream As BinaryStream = BinaryStream(mSource)
		  Dim pos As UInt64 = stream.Position
		  stream.Position = Request
		  Return stream.Position - pos
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _Switch(Opaque2 As Ptr) As Int32
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetPassword(ByRef ArchivePassword As String) As Boolean
	#tag EndHook


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
		Private mIsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Readable
	#tag EndProperty


End Class
#tag EndClass
