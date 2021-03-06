#tag Class
Protected Class ArchiveEntry
	#tag Method, Flags = &h0
		Sub Constructor(FromFile As FolderItem, Optional RelativeRoot As FolderItem)
		  ' Create a new ArchiveEntry and copy the metadata of the FromFile FolderItem
		  ' into the entry. RelativeRoot is the root of the directory tree being archived;
		  ' the PathName property will be the relative path between the root and the entry.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.Constructor
		  
		  Me.Constructor() // Constructor(Optional Owner As libarchive.Archive)
		  Me.SetMetadata(FromFile, RelativeRoot)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Optional Owner As libarchive.Archive)
		  ' Create a new empty ArchiveEntry.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.Constructor
		  
		  If Not libarchive.IsAvailable() Then Raise New PlatformNotSupportedException
		  If Owner = Nil Then
		    mEntry = archive_entry_new()
		  Else
		    mEntry = archive_entry_new2(Owner.Handle)
		    mOwner = Owner
		  End If
		  If mEntry = Nil Then
		    mLastError = ERR_INIT_FAILED
		    Raise New ArchiveException(Me)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Owner As libarchive.Archive, Entry As Ptr)
		  ' Used to construct instances of ArchiveEntry from raw ptrs to entry structs.
		  
		  mEntry = Entry
		  mOwner = Owner
		  GetMetadata()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CloneFrom As libarchive.ArchiveEntry)
		  ' Create a new ArchiveEntry by duplicating the CloneFrom instance.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.Constructor
		  
		  Dim e As Ptr = archive_entry_clone(CloneFrom.Handle)
		  If e = Nil Then
		    mLastError = ERR_INIT_FAILED
		    Raise New ArchiveException(Me)
		  End If
		  Me.Constructor(CloneFrom.mOwner, e) // Constructor(Owner As libarchive.Archive, Entry As Ptr)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CloneFrom As libarchive.ArchiveEntry, RelativeRoot As FolderItem)
		  ' Clone the CloneFrom entry and modify the pathname according to RelativeRoot
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.Constructor
		  
		  Me.Constructor(CloneFrom) // Constructor(CloneFrom As libarchive.ArchiveEntry)
		  Me.PathName = GetRelativePath(RelativeRoot, New FolderItem(PathName))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mEntry <> Nil And mFreeable Then archive_entry_free(mEntry)
		  mEntry = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Extract(Output As FolderItem, Optional Flags As Int32) As Boolean
		  ' Extract the entry into the specified FolderItem.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.Extract
		  
		  Dim disk As New libarchive.Writers.DiskWriter(Output, Flags)
		  mLastError = archive_read_extract2(mOwner.Handle, Me.Handle, disk.Handle)
		  disk.Close()
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtractPath(RelativeRoot As FolderItem, CreateMissingDirectories As Boolean) As FolderItem
		  ' Generates a FolderItem by concatenating the RelativeRoot path and the PathName property.
		  ' If CreateMissingDirectories is True then subdirectories are created as needed within
		  ' RelativeRoot; otherwise a missing subdirectory will cause the operation to fail (return 
		  ' Nil.) Only parent directories are created; the final name in the path (i.e. the file that
		  ' will be extracted into) is not created.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.ExtractPath
		  
		  If RelativeRoot = Nil Or Not RelativeRoot.Directory Then Return Nil
		  Dim s() As String = Split(Me.PathName, "/")
		  Dim bound As Integer = UBound(s)
		  
		  For i As Integer = 0 To bound - 1
		    Dim name As String = s(i)
		    If name = "" Or name = "." Or name = ".." Then Continue
		    RelativeRoot = RelativeRoot.TrueChild(name)
		    If RelativeRoot.Exists Then
		      If Not RelativeRoot.Directory Then Return Nil
		    ElseIf CreateMissingDirectories Then
		      RelativeRoot.CreateAsFolder()
		    Else
		      Return Nil
		    End If
		  Next
		  
		  Dim name As String = s(bound)
		  If name <> "" Then RelativeRoot = RelativeRoot.Child(name)
		  
		  Return RelativeRoot
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub GetMetadata()
		  ' Call this method to populate the various metadata properties (AccessTime, etc.) by
		  ' querying libarchive.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.GetMetaData
		  
		  Dim path As MemoryBlock = archive_entry_pathname_w(mEntry)
		  If path <> Nil Then mPathName = path.WString(0)
		  
		  If archive_entry_atime_is_set(mEntry) = 1 Then
		    Dim count As UInt32 = archive_entry_atime(mEntry)
		    mAccessTime = time_t(count)
		    
		    Dim countn As Int64 = archive_entry_atime_nsec(mEntry)
		    mAccessTimeNS = time_tn(countn)
		  End If
		  
		  If archive_entry_mtime_is_set(mEntry) = 1 Then
		    Dim count As UInt32 = archive_entry_mtime(mEntry)
		    mModificationTime = time_t(count)
		  End If
		  
		  If archive_entry_birthtime_is_set(mEntry) = 1 Then
		    Dim count As UInt32 = archive_entry_birthtime(mEntry)
		    mBirthTime = time_t(count)
		    
		    Dim countn As Int64 = archive_entry_birthtime_nsec(mEntry)
		    mBirthTimeNS = time_tn(countn)
		  End If
		  
		  If archive_entry_ctime_is_set(mEntry) = 1 Then
		    Dim count As UInt32 = archive_entry_ctime(mEntry)
		    mChangeTime = time_t(count)
		    
		    Dim countn As Int64 = archive_entry_ctime_nsec(mEntry)
		    mChangeTime = time_tn(countn)
		  End If
		  
		  If archive_entry_size_is_set(mEntry) = 1 Then
		    mLength = archive_entry_size(mEntry)
		  End If
		  
		  mLinkCount = archive_entry_nlink(mEntry)
		  mUID = archive_entry_uid(mEntry)
		  mGID = archive_entry_gid(mEntry)
		  
		  Dim mb As MemoryBlock = archive_entry_sourcepath_w(mEntry)
		  If mb <> Nil Then mSourcePath = mb.WString(0)
		  
		  mIsEncrypted = (archive_entry_is_data_encrypted(mEntry) = 1)
		  
		  mb = archive_entry_uname_w(mEntry)
		  If mb <> Nil Then mUser = mb.WString(0)
		  
		  mb = archive_entry_gname_w(mEntry)
		  If mb <> Nil Then mGroup = mb.WString(0)
		  
		  Dim p As Int32 = archive_entry_mode(mEntry)
		  If p <> 0 Then mMode = New Permissions(p)
		  
		  mType = archive_entry_filetype(mEntry)
		  mLinkType = archive_entry_symlink_type(mEntry)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetRelativePath(Root As FolderItem, Item As FolderItem) As String
		  If Root = Nil Or Root.AbsolutePath_ = Item.AbsolutePath_ Then Return Item.Name
		  Dim s() As String
		  Do Until Item.AbsolutePath_ = Root.AbsolutePath_
		    s.Insert(0, Item.Name)
		    Item = Item.Parent
		  Loop Until Item = Nil
		  If Item = Nil Then Return s.Pop ' not relative
		  Return Join(s, "/")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function PermissionsToMode(p As Permissions) As UInt32
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

	#tag Method, Flags = &h0
		Sub Reset(Optional FromFile As FolderItem, Optional RelativeRoot As FolderItem)
		  ' Resets the metadata of the entry, optionally re-populating it with the FromFile
		  ' and RelativeRoot parameters.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.Reset
		  
		  If mEntry <> Nil Then
		    mEntry = archive_entry_clear(mEntry)
		    Me.GetMetadata()
		    If FromFile <> Nil Then Me.SetMetadata(FromFile, RelativeRoot)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetMetadata(FromFile As FolderItem, RelativeRoot As FolderItem)
		  ' Call this method to populate the various metadata properties (AccessTime, etc.) by
		  ' copying the values of FromFile. If RelativeRoot is not Nil then the PathName property
		  ' will be populated with a relative path, otherwise the PathName will set to FromFile.Name
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry.SetMetaData
		  
		  If RelativeRoot <> Nil Then
		    Me.PathName = GetRelativePath(RelativeRoot, FromFile)
		  Else
		    Me.PathName = FromFile.Name
		  End If
		  Me.Length = FromFile.Length
		  Me.Mode = New Permissions(FromFile.Permissions)
		  If FromFile.Directory Then
		    Me.Type = libarchive.EntryType.Directory
		  ElseIf FromFile.Exists Then
		    Me.Type = libarchive.EntryType.File
		  End If
		  Me.ModificationTime = FromFile.ModificationDate
		  Me.BirthTime = FromFile.CreationDate
		  Me.IsADirectory = FromFile.Directory
		  Me.User = FromFile.Owner
		  Me.Group = FromFile.Group
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function time_t(d As Date) As Integer
		  Static epoch As Double = time_t(0).TotalSeconds
		  Return d.TotalSeconds - epoch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function time_t(Count As Integer) As Date
		  Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		  d.TotalSeconds = d.TotalSeconds + Count
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function time_tn(Count As Int64) As Date
		  Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		  Count = Count / 1000000000
		  d.TotalSeconds = d.TotalSeconds + Count
		  Return d
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the last access time of the entry, or Nil if not available.
			  
			  Return mAccessTime
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the last access time of the entry. Set this to Nil to remove the access time.
			  
			  If mEntry = Nil Then Return
			  If value = Nil Then
			    archive_entry_unset_atime(mEntry)
			    mAccessTime = Nil
			  Else
			    Dim count As UInt32 = time_t(value)
			    archive_entry_set_atime(mEntry, count, 0)
			    mAccessTime = value
			  End If
			End Set
		#tag EndSetter
		AccessTime As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the last access time of the entry, or Nil if not available.
			  
			  Return mAccessTimeNS
			End Get
		#tag EndGetter
		AccessTimeNS As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the birth time of the entry, or Nil if not available.
			  
			  Return mBirthTime
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the birth time of the entry. Set this to Nil to remove the access time.
			  
			  If mEntry = Nil Then Return
			  If value = Nil Then
			    archive_entry_unset_birthtime(mEntry)
			    mBirthTime = Nil
			  Else
			    Dim count As UInt32 = time_t(value)
			    archive_entry_set_birthtime(mEntry, count, 0)
			    mBirthTime = value
			  End If
			End Set
		#tag EndSetter
		BirthTime As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the birth time of the entry, or Nil if not available.
			  
			  Return mBirthTimeNS
			End Get
		#tag EndGetter
		BirthTimeNS As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the metadata changed time of the entry, or Nil if not available.
			  
			  Return mChangeTime
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the metadata changed time of the entry. Set this to Nil to remove the change time.
			  
			  If mEntry = Nil Then Return
			  If value = Nil Then
			    archive_entry_unset_ctime(mEntry)
			    mChangeTime = Nil
			  Else
			    Dim count As UInt32 = time_t(value)
			    archive_entry_set_ctime(mEntry, count, 0)
			    mChangeTime = value
			  End If
			End Set
		#tag EndSetter
		ChangeTime As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mGID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mEntry = Nil Then Return
			  archive_entry_set_gid(mEntry, value)
			  mGID = value
			End Set
		#tag EndSetter
		GID As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mGroup
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mEntry = Nil Then Return
			  If value <> "" Then
			    archive_entry_copy_gname_w(mEntry, value)
			    mGroup = value
			  End If
			End Set
		#tag EndSetter
		Group As String
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
			  ' Gets whether the entry is a directory or directory link.
			  
			  Return Me.Type = EntryType.Directory Or Me.Type = EntryType.DirectoryLink
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether the entry is a directory.
			  
			  Dim link As Boolean = IsALink
			  Select Case True
			  Case value And link
			    Me.Type = EntryType.DirectoryLink
			  Case value And Not link
			    Me.Type = EntryType.Directory
			  Case Not value And link
			    Me.Type = EntryType.FileLink
			  Case Not value And Not link
			    Me.Type = EntryType.File
			  End Select
			End Set
		#tag EndSetter
		IsADirectory As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets whether the entry is a symlink.
			  
			  Return Me.Type = EntryType.FileLink Or Me.Type = EntryType.DirectoryLink
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether the entry is a symlink.
			  
			  Dim dir As Boolean = IsADirectory
			  Select Case True
			  Case value And dir
			    Me.Type = EntryType.DirectoryLink
			  Case value And Not dir
			    Me.Type = EntryType.FileLink
			  Case Not value And dir
			    Me.Type = EntryType.Directory
			  Case Not value And Not dir
			    Me.Type = EntryType.File
			  End Select
			End Set
		#tag EndSetter
		IsALink As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the entry is encrypted, if that information is available.
			  
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
			  ' Get the uncompressed size of the entry, if available.
			  
			  Return mLength
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the uncompressed size of the entry. Set this to a value <0 to clear the size.
			  
			  If mEntry = Nil Then Return
			  If value < 0 Then
			    archive_entry_unset_size(mEntry)
			    mLength = 0
			  Else
			    archive_entry_set_size(mEntry, value)
			    mLength = value
			  End If
			End Set
		#tag EndSetter
		Length As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the number of links to this entry, if available.
			  
			  Return mLinkCount
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the number of links to the entry. Set this to a value 0 to clear the link count.
			  
			  If mEntry = Nil Then Return
			  archive_entry_set_nlink(mEntry, value)
			  mLinkCount = value
			  
			End Set
		#tag EndSetter
		LinkCount As UInt32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAccessTime As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAccessTimeNS As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBirthTime As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBirthTimeNS As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChangeTime As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChangeTimeNS As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEntry As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mFreeable As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGID As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGroup As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsEncrypted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLength As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLinkCount As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLinkType As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Permissions
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModificationTime As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModificationTimeNS As Date
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the Unix-style permissions of the entry, if available.
			  
			  Return mMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the Unix-style permissions of the entry.
			  
			  If mEntry = Nil Or value = Nil Then Return
			  Dim p As Int32 = PermissionsToMode(value)
			  archive_entry_set_mode(mEntry, p)
			  mMode = value
			  
			End Set
		#tag EndSetter
		Mode As Permissions
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the last-modified time of the entry, if available.
			  
			  Return mModificationTime
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the last-modified time of the entry. Set this to Nil to remove the last-modified time.
			  
			  If mEntry = Nil Then Return
			  If value = Nil Then
			    archive_entry_unset_mtime(mEntry)
			    mModificationTime = Nil
			  Else
			    Dim count As UInt32 = time_t(value)
			    archive_entry_set_mtime(mEntry, count, 0)
			    mModificationTime = value
			  End If
			End Set
		#tag EndSetter
		ModificationTime As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the last-modified time of the entry, or Nil if not available.
			  
			  Return mModificationTimeNS
			End Get
		#tag EndGetter
		ModificationTimeNS As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOwner As libarchive.Archive
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPathName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourcePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUID As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUser As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the relative path and filename of the entry, if available.
			  
			  Return mPathName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the relative path and filename of the entry.
			  
			  If mEntry = Nil Then Return
			  If value <> "" Then
			    archive_entry_copy_pathname_w(mEntry, value)
			    mPathName = value
			  End If
			End Set
		#tag EndSetter
		PathName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  Return mSourcePath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mEntry = Nil Then Return
			  If value <> "" Then
			    archive_entry_copy_sourcepath_w(mEntry, value)
			    mPathName = value
			  End If
			End Set
		#tag EndSetter
		SourcePath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the EntryType of the entry, if available.
			  
			  Select Case mType
			  Case AE_IFBLK
			    Return EntryType.BlockSpecial
			    
			  Case AE_IFCHR
			    Return EntryType.CharacterSpecial
			    
			  Case AE_IFDIR
			    Return EntryType.Directory
			    
			  Case AE_IFIFO
			    Return EntryType.FIFO
			    
			  Case AE_IFREG
			    Return EntryType.File
			    
			  Case AE_IFLINK
			    Select Case mLinkType
			    Case AE_SYMLINK_TYPE_DIRECTORY
			      Return EntryType.DirectoryLink
			    Case AE_SYMLINK_TYPE_FILE
			      Return EntryType.FileLink
			    Case AE_SYMLINK_TYPE_UNDEFINED
			      Return EntryType.UndefinedLink
			    End Select
			    
			  Case AE_IFSOCK
			    Return EntryType.Socket
			    
			  Else
			    Return EntryType.Unknown
			  End Select
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the EntryType of the entry.
			  
			  If mEntry = Nil Then Return
			  Dim t As UInt32
			  Select Case value
			  Case EntryType.BlockSpecial
			    t = AE_IFBLK
			    
			  Case EntryType.CharacterSpecial
			    t = AE_IFCHR
			    
			  Case EntryType.Directory
			    t = AE_IFDIR
			    
			  Case EntryType.FIFO
			    t = AE_IFIFO
			    
			  Case EntryType.File
			    t = AE_IFREG
			    
			  Case EntryType.DirectoryLink, EntryType.FileLink, EntryType.UndefinedLink
			    t = AE_IFLINK
			    
			  Case EntryType.Socket
			    t = AE_IFSOCK
			    
			  Else
			    Return
			  End Select
			  
			  archive_entry_set_filetype(mEntry, t)
			  mType = t
			End Set
		#tag EndSetter
		Type As libarchive.EntryType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mEntry = Nil Then Return
			  archive_entry_set_uid(mEntry, value)
			  mUID = value
			End Set
		#tag EndSetter
		UID As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUser
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mEntry = Nil Then Return
			  If value <> "" Then
			    archive_entry_copy_uname_w(mEntry, value)
			    mUser = value
			  End If
			End Set
		#tag EndSetter
		User As String
	#tag EndComputedProperty


	#tag Constant, Name = AE_IFBLK, Type = Double, Dynamic = False, Default = \"&o0060000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFCHR, Type = Double, Dynamic = False, Default = \"&o0020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFDIR, Type = Double, Dynamic = False, Default = \"&o0040000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFIFO, Type = Double, Dynamic = False, Default = \"&o0010000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFLINK, Type = Double, Dynamic = False, Default = \"&o0120000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFMT, Type = Double, Dynamic = False, Default = \"&o0170000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFREG, Type = Double, Dynamic = False, Default = \"&o0100000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_IFSOCK, Type = Double, Dynamic = False, Default = \"&o0140000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_SYMLINK_TYPE_DIRECTORY, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_SYMLINK_TYPE_FILE, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AE_SYMLINK_TYPE_UNDEFINED, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Group"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsADirectory"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsALink"
			Group="Behavior"
			Type="Boolean"
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
			Name="SourcePath"
			Group="Behavior"
			Type="String"
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
		#tag ViewProperty
			Name="User"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
