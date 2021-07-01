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
			  return mAllowVersionNumber
			End Get
		#tag EndGetter
		#tag Setter
			Set
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
			  ' The specified filename will be identified in the ISO9660 metadata as holding the application identifier for this volume. Default: none. 
			  
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
			  ' The specified filename will be identified in the ISO9660 metadata as holding the bibliography for this volume. Default: none. 
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "biblio-file", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!biblio-file", "")
			  End If
			  If ok Then mBiblioFile = value
			End Set
		#tag EndSetter
		BiblioFile As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBootCatalogFilename
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The name that will be used for the El Torito boot catalog. Default: boot.catalog
			  
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
			  ' The boot image file provided by the BootFileName option will be edited with appropriate
			  ' boot information in bytes 8 through 64. Default: disabled
			  
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
			  ' itself). This should not be needed unless you are trying to support systems with very old BIOSes. This
			  ' defaults to the full size of the image. 
			  
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
			  return mCompressed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The zisofs extensions permit each file to be independently compressed using a
			  ' gzip-compatible compression. This can provide significant size savings, but
			  ' requires the reading system to have support for these extensions. These extensions
			  ' are disabled by default. For best results, libarchive tests each file and will
			  ' store the file uncompressed if the compression does not actually save any space.
			  ' In particular, files under 2KB will never be compressed. Note that boot image
			  ' files are never compressed. 
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "zisofs", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!zisofs", "")
			  End If
			  If ok Then mCompressed = value
			End Set
		#tag EndSetter
		Compressed As Boolean
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
			  ' filenames of up to 255 characters. Default: enabled. 
			  
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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mLongFileNames
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "joliet", "long")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "!joliet", "")
			    If ok And mJoliet Then ok = Me.SetFormatOption(FORMAT_MODULE_ISO9660, "joliet", "")
			  End If
			  If ok Then mLongFileNames = value
			End Set
		#tag EndSetter
		LongFileNames As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAbstractFile As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowVersionNumber As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAppID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBiblioFile As Boolean
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
		Private mCompressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJoliet As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLongFileNames As Boolean
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
			  ' also support symbolic links and other POSIX file types. Default: enabled. 
			  
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbstractFile"
			Group="Behavior"
			Type="Boolean"
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
