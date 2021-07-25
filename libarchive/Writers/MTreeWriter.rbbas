#tag Class
Protected Class MTreeWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.MTree)
		  SetFilter(Compressor)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.MTree)
		  SetFilter(Compressor)
		  mSourceBuffer = Buffer
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(WriteTo As Writeable, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.MTree)
		  SetFilter(Compressor)
		  mDestinationStream = WriteTo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetAll()
		  Cksum = True
		  ' Contents = True
		  Device = True
		  Flags = True
		  Gid = True
		  GName = True
		  GName = True
		  ' Ignore = True
		  INode = True
		  IsOptional = True
		  Link = True
		  MD5 = True
		  Mode = True
		  NoChange = True
		  NumLinks = True
		  ResDevice = True
		  Ripemd160 = True
		  SHA1 = True
		  SHA256 = True
		  SHA384 = True
		  SHA512 = True
		  Size = True
		  Type = True
		  Uid = True
		  UName = True
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCksum
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the cksum field. 
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "cksum", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!cksum", "")
			  End If
			  If ok Then mCksum = value
			End Set
		#tag EndSetter
		Cksum As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mContents
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the contents field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "contents", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!contents", "")
			  End If
			  If ok Then mContents = value
			End Set
		#tag EndSetter
		Contents As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mDevice
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the device field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "device", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!device", "")
			  End If
			  If ok Then mDevice = value
			End Set
		#tag EndSetter
		Device As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mFlags
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the flags field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "device", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!device", "")
			  End If
			  If ok Then mFlags = value
			End Set
		#tag EndSetter
		Flags As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mGid
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the GID field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "gid", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!gid", "")
			  End If
			  If ok Then mGid = value
			End Set
		#tag EndSetter
		Gid As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mGName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the gname field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "gname", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!gname", "")
			  End If
			  If ok Then mGName = value
			End Set
		#tag EndSetter
		GName As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mIgnore
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the ignore field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "ignore", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!ignore", "")
			  End If
			  If ok Then mIgnore = value
			End Set
		#tag EndSetter
		Ignore As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mINode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the inode field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "inode", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!inode", "")
			  End If
			  If ok Then mINode = value
			End Set
		#tag EndSetter
		INode As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		IsOptional As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLink
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the link field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "link", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!link", "")
			  End If
			  If ok Then mLink = value
			End Set
		#tag EndSetter
		Link As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCksum As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContents As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMD5
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the md5 field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "md5", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!md5", "")
			  End If
			  If ok Then mMD5 = value
			End Set
		#tag EndSetter
		MD5 As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDevice As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGid As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGName As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIgnore As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mINode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLink As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMD5 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumLinks As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the mode field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "mode", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!mode", "")
			  End If
			  If ok Then mMode = value
			End Set
		#tag EndSetter
		Mode As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mRipemd160 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSHA1 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSHA256 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSHA384 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSHA512 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSize As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTime As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUid As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUName As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseSet As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		NoChange As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mNumLinks
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the "number of links" field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "nlink", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!nlink", "")
			  End If
			  If ok Then mNumLinks = value
			End Set
		#tag EndSetter
		NumLinks As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ResDevice As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mRipemd160
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the Ripemd160 field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "ripemd160digest", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!ripemd160digest", "")
			  End If
			  If ok Then mRipemd160 = value
			End Set
		#tag EndSetter
		Ripemd160 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSHA1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the SHA1 field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "sha1", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!sha1", "")
			  End If
			  If ok Then mSHA1 = value
			End Set
		#tag EndSetter
		SHA1 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSHA256
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the SHA256 field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "sha256", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!sha256", "")
			  End If
			  If ok Then mSHA256 = value
			End Set
		#tag EndSetter
		SHA256 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSHA384
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the SHA384 field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "sha384", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!sha384", "")
			  End If
			  If ok Then mSHA384 = value
			End Set
		#tag EndSetter
		SHA384 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSHA512
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the SHA512 field.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "sha512", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!sha512", "")
			  End If
			  If ok Then mSHA512 = value
			End Set
		#tag EndSetter
		SHA512 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the size field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "size", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!size", "")
			  End If
			  If ok Then mSize = value
			End Set
		#tag EndSetter
		Size As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mTime
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the last modified field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "time", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!time", "")
			  End If
			  If ok Then mTime = value
			End Set
		#tag EndSetter
		Time As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the type field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "type", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!type", "")
			  End If
			  If ok Then mType = value
			End Set
		#tag EndSetter
		Type As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUid
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the UID field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "uid", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!uid", "")
			  End If
			  If ok Then mUid = value
			End Set
		#tag EndSetter
		Uid As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the uname field.
			  '
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "uid", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!uid", "")
			  End If
			  If ok Then mUName = value
			End Set
		#tag EndSetter
		UName As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUseSet
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables the use of /set lines.
			  '
			  ' Default: Disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "use-set", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_MTREE, "!use-set", "")
			  End If
			  If ok Then mUseSet = value
			End Set
		#tag EndSetter
		UseSet As Boolean
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Compressed"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.ArchiveWriter"
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
			InheritedFrom="libarchive.ArchiveWriter"
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
