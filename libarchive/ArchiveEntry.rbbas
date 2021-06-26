#tag Class
Protected Class ArchiveEntry
	#tag Method, Flags = &h1
		Protected Sub Constructor(Owner As libarchive.ArchiveReader, Entry As Ptr)
		  mEntry = Entry
		  mOwner = Owner
		  
		  Dim path As MemoryBlock = archive_entry_pathname_w(mEntry)
		  If path <> Nil Then mPathName = path.WString(0)
		  
		  If archive_entry_atime_is_set(mEntry) = 1 Then
		    Dim count As UInt32 = archive_entry_atime(mEntry)
		    mAccessTime = time_t(count)
		  End If
		  
		  If archive_entry_mtime_is_set(mEntry) = 1 Then
		    Dim count As UInt32 = archive_entry_mtime(mEntry)
		    mModificationTime = time_t(count)
		  End If
		  
		  If archive_entry_size_is_set(mEntry) = 1 Then
		    mLength = archive_entry_size(mEntry)
		  End If
		  
		  mIsEncrypted = (archive_entry_is_data_encrypted(mEntry) = 1)
		  
		  Dim p As Int32 = archive_entry_mode(mEntry)
		  If p <> 0 Then mMode = New Permissions(p)
		  
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mAccessTime
			End Get
		#tag EndGetter
		AccessTime As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mEntry
			End Get
		#tag EndGetter
		Handle As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mIsEncrypted
			End Get
		#tag EndGetter
		IsEncrypted As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLastError
			End Get
		#tag EndGetter
		LastError As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mLength
			End Get
		#tag EndGetter
		Length As Int64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAccessTime As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEntry As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsEncrypted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLength As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Permissions
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModificationTime As Date
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mMode
			End Get
		#tag EndGetter
		Mode As Permissions
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mModificationTime
			End Get
		#tag EndGetter
		ModificationTime As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOwner As libarchive.ArchiveReader
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPathName As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPathName
			End Get
		#tag EndGetter
		PathName As String
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
			Name="IsEncrypted"
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
			Name="PathName"
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
