#tag Class
Protected Class ISO9660Writer
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.ISO9660)
		  SetFilter(Compressor)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.ISO9660)
		  SetFilter(Compressor)
		  mSourceBuffer = Buffer
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(WriteTo As Writeable, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.ISO9660)
		  SetFilter(Compressor)
		  mDestinationStream = WriteTo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub _SetCompressed(b As Boolean)
		  ' The zisofs extensions permit each file to be independently compressed using a
		  ' gzip-compatible compression. This can provide significant size savings, but
		  ' requires the reading system to have support for these extensions. These extensions
		  ' are disabled by default. For best results, libarchive tests each file and will
		  ' store the file uncompressed if the compression does not actually save any space.
		  ' In particular, files under 2KB will never be compressed. Note that boot image
		  ' files are never compressed.
		  
		  Dim ok As Boolean
		  If b Then
		    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "zisofs", "1")
		  Else
		    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!zisofs", "0")
		  End If
		  If ok Then mCompressed = b
		End Sub
	#tag EndMethod


	#tag Note, Name = Options
		https://github.com/libarchive/libarchive/wiki/FormatISO9660#supported-options
		
		https://nxmnpg.lemoda.net/3/archive_write_set_format_option
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAbstractFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The specified file name will be identified in the ISO9660 metadata as holding the abstract for this volume. Default: none.
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "abstract-file", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!abstract-file", "")
			  End If
			  If ok Then mAbstractFile = value
			End Set
		#tag EndSetter
		AbstractFile As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAllowLeadingDots
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If enabled, allows filenames to begin with a leading period. If disabled, filenames that
			  ' begin with a leading period will have that period replaced by an underscore character in
			  ' the standard ISO9660 namespace. This does not impact names stored in the Rockridge or Joliet
			  ' extension area.
			  ' 
			  ' Default: disabled.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "allow-ldots", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!allow-ldots", "")
			  End If
			  If ok Then mAllowLeadingDots = value
			End Set
		#tag EndSetter
		AllowLeadingDots As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAllowLowerCase
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If enabled, allows filenames to contain lowercase characters. If disabled, filenames will
			  ' be forced to uppercase. This does not impact names stored in the Rockridge or Joliet
			  ' extension area.
			  ' 
			  ' Default: disabled.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "allow-lowercase", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!allow-lowercase", "")
			  End If
			  If ok Then mAllowLowerCase = value
			End Set
		#tag EndSetter
		AllowLowerCase As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAllowMultiDot
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If enabled, allows filenames to contain multiple period characters, in violation
			  ' of the ISO9660 specification. If disabled, additional periods will be converted
			  ' to underscore characters. This does not impact names stored in the Rockridge or
			  ' Joliet extension area.
			  ' 
			  ' Default: disabled.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "allow-multidot", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!allow-multidot", "")
			  End If
			  If ok Then mAllowMultiDot = value
			End Set
		#tag EndSetter
		AllowMultiDot As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAllowVersionNumber
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If enabled, version numbers will be included with files. If disabled, version
			  ' numbers will be suppressed, in violation of the ISO9660 standard. This does not
			  ' impact names stored in the Rockridge or Joliet extension area.
			  ' 
			  ' Default: enabled.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "allow-vernum", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!allow-vernum", "")
			  End If
			  If ok Then mAllowVersionNumber = value
			End Set
		#tag EndSetter
		AllowVersionNumber As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAppID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The specified filename will be identified in the ISO9660 metadata as holding the
			  ' application identifier for this volume.
			  ' 
			  ' Default: "" (none)
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "application-id", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!application-id", "")
			  End If
			  If ok Then mAppID = value
			End Set
		#tag EndSetter
		AppID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBiblioFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The specified filename will be identified in the ISO9660 metadata as holding
			  ' the bibliography for this volume.
			  ' 
			  ' Default: none.
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "biblio-file", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!biblio-file", value)
			  End If
			  If ok Then mBiblioFile = value
			End Set
		#tag EndSetter
		BiblioFile As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBootCatalogFilename
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The name that will be used for the El Torito boot catalog.
			  ' 
			  ' Default: "boot.catalog"
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "boot-catalog", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!boot-catalog", "")
			  End If
			  If ok Then mBootCatalogFilename = value
			End Set
		#tag EndSetter
		BootCatalogFilename As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mBootFileName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The specified file name will be used as the El Torito boot image file.
			  ' 
			  ' Default: "" (none)
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "boot", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!boot", "")
			  End If
			  If ok Then mBootFileName = value
			  
			End Set
		#tag EndSetter
		BootFileName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBootInfoTable
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If enabled, the boot image file provided by the BootFileName option will be
			  ' edited with appropriate boot information in bytes 8 through 64.
			  ' 
			  ' Default: disabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "boot-info-table", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!boot-info-table", "")
			  End If
			  If ok Then mBootInfoTable = value
			End Set
		#tag EndSetter
		BootInfoTable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBootLoaderSegment
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The load segment for a no-emulation boot image.
			  ' 
			  ' Default: 0 (unspecified)
			  
			  If Me.SetFormatOption(FORMAT_MODULE_ISO9660, "boot-load-seg", "0x" + Hex(value)) Then mBootLoaderSegment = value
			End Set
		#tag EndSetter
		BootLoaderSegment As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBootLoaderSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The number of "virtual" 512-byte sectors to be loaded from a no-emulation boot image. Some very old
			  ' BIOSes can only load very small images, setting this value to 4 will often allow such BIOSes to load
			  ' the first part of the boot image (which will then need to be intelligent enough to load the rest of
			  ' itself). This should not be needed unless you are trying to support systems with very old BIOSes.
			  ' 
			  ' Default: 0 (Load the full size of the image.)
			  
			  If Me.SetFormatOption(FORMAT_MODULE_ISO9660, "boot-load-size", Str(value)) Then mBootLoaderSize = value
			End Set
		#tag EndSetter
		BootLoaderSize As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBootType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Specifies the boot semantics used by the El Torito boot image. If the value is "fd", then the
			  ' boot image is assumed to be a bootable floppy image. If the value is "hd", then the boot image
			  ' is assumed to be a bootable hard disk image. If the value is "no-emulation", the boot image is
			  ' used without floppy or hard disk emulation. If the boot image is exactly 1.2MB, 1.44MB, or 2.88MB,
			  ' then the default is "fd", otherwise the default is "no-emulation".
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "boot-type", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!boot-type", "")
			  End If
			  If ok Then mBootType = value
			End Set
		#tag EndSetter
		BootType As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompatibilityMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' This enables support for file size and file name extensions in the core ISO9660 area. The
			  ' name extensions specified here do not affect the names stored in the Rockridge or Joliet
			  ' extension areas.
			  ' 
			  ' ISOLevel.L1
			  '    The most compliant form of ISO9660 image. Filenames are limited to 8.3 uppercase format,
			  '    directory names are limited to 8 uppercase characters, files are limited to 4 GiB, the
			  '    complete ISO9660 image cannot exceed 4 GiB.
			  ' ISOLevel.L2
			  '    Filenames are limited to 30 uppercase characters with a 30-character extension, directory
			  '    names are limited to 30 characters, files are limited to 4 GiB.
			  ' ISOLevel.L3
			  '    As with L2, except that files may exceed 4 GiB.
			  ' ISOLevel.L4
			  '    As with L3, except that filenames may be up to 193 characters and may include arbitrary
			  '    8-bit characters.
			  ' 
			  ' Default: ISOLevel.L1
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.Writers.ISO9660Writer.CompatibilityMode
			  
			  If mIsOpen Then
			    mLastError = ERR_TOO_LATE
			    Raise New ArchiveException(Me)
			  End If
			  
			  Select Case value
			  Case ISOLevel.L1
			    If Not SetOption(mFormatName, "iso-level", "1") Then Raise New ArchiveException(Me)
			  Case ISOLevel.L2
			    If Not SetOption(mFormatName, "iso-level", "2") Then Raise New ArchiveException(Me)
			  Case ISOLevel.L3
			    If Not SetOption(mFormatName, "iso-level", "3") Then Raise New ArchiveException(Me)
			  Case ISOLevel.L4
			    If Not SetOption(mFormatName, "iso-level", "4") Then Raise New ArchiveException(Me)
			  End Select
			  mCompatibilityMode = value
			End Set
		#tag EndSetter
		CompatibilityMode As libarchive.Writers.ISO9660Writer.ISOLevel
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mJoliet
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Microsoft's Joliet extensions store a completely separate set of directory
			  ' information about each file. In particular, this information includes Unicode
			  ' filenames of up to 255 characters.
			  ' 
			  ' Default: enabled.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, FORMAT_OPT_JOLIET, "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!" + FORMAT_OPT_JOLIET, "")
			  End If
			  If ok Then mJoliet = value
			End Set
		#tag EndSetter
		Joliet As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAbstractFile As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowLeadingDots As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowLowerCase As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowMultiDot As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowVersionNumber As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAppID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBiblioFile As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBootCatalogFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBootFileName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBootInfoTable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBootLoaderSegment As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBootLoaderSize As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBootType As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompatibilityMode As libarchive.Writers.ISO9660Writer.ISOLevel
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJoliet As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRockRidge As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVolumeID As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mRockRidge
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The Rockridge extensions store an additional set of POSIX-style file
			  ' information with each file, including mtime, atime, ctime, permissions,
			  ' and long filenames with arbitrary 8-bit characters. These extensions
			  ' also support symbolic links and other POSIX file types.
			  ' 
			  ' Default: enabled.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, FORMAT_OPT_ROCKRIDGE, "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!" + FORMAT_OPT_ROCKRIDGE, "")
			  End If
			  If ok Then mRockRidge = value
			End Set
		#tag EndSetter
		RockRidge As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mVolumeID
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The specified string will be used as the Volume Identifier in
			  ' the ISO9660 metadata. It is limited to 32 bytes. Default: none.
			  
			  Dim ok As Boolean
			  If value <> "" Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "volume-id", value)
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!volume-id", "")
			  End If
			  If ok Then mVolumeID = value
			End Set
		#tag EndSetter
		VolumeID As String
	#tag EndComputedProperty


	#tag Enum, Name = ISOLevel, Type = Integer, Flags = &h0
		L1
		  L2
		  L3
		L4
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbstractFile"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowVersionNumber"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppID"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BiblioFile"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BootCatalogFilename"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BootFileName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BootInfoTable"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BootType"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Compressed"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Encryption"
			Group="Behavior"
			Type="String"
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
			Name="Joliet"
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
			Name="LongFileNames"
			Group="Behavior"
			Type="Boolean"
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
			Name="RockRidge"
			Group="Behavior"
			Type="Boolean"
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
			Name="VolumeID"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
