#tag Class
Protected Class ISO9660Writer
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.ISO9660, Compressor)
		  CreateFile(File)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.ISO9660, Compressor)
		  CreateMemory(Buffer)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Options
		https://github.com/libarchive/libarchive/wiki/FormatISO9660#supported-options
		60
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAbstractFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption("iso9660", "abstract-file", "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!abstract-file", "")
			  End If
			  If ok Then mAbstractFile = value
			End Set
		#tag EndSetter
		AbstractFile As Boolean
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
			    ok = Me.SetFormatOption("iso9660", "allow-vernum", "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!allow-vernum", "")
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
			  If Me.SetFormatOption("iso9660", "application-id", value) Then mAppID = value
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
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption("iso9660", "biblio-file", "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!biblio-file", "")
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
			  If Me.SetFormatOption("iso9660", "boot-catalog", value) Then mBootCatalogFilename = value
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
			  If Me.SetFormatOption("iso9660", "boot", value) Then mBootFileName = value
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
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption("iso9660", "boot-info-table", "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!boot-info-table", "")
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
			  If Me.SetFormatOption("iso9660", "boot-load-seg", "0x" + Hex(value)) Then mBootLoaderSegment = value
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
			  If Me.SetFormatOption("iso9660", "boot-load-size", Str(value)) Then mBootLoaderSize = value
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
			  ' Legal values are "no-emulation", "fd", or "hard-disk" indicating the type of boot emulation that should be used
			  
			  If Me.SetFormatOption("iso9660", "boot-type", value) Then mBootType = value
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
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption("iso9660", "zisofs", "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!zisofs", "")
			  End If
			  If ok Then mCompressed = value
			End Set
		#tag EndSetter
		Compressed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressionLevel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Me.SetFormatOption("iso9660", "compression-level", Str(value)) Then mCompressionLevel = value
			End Set
		#tag EndSetter
		CompressionLevel As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mJoliet
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption("iso9660", FORMAT_OPT_JOLIET, "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!" + FORMAT_OPT_JOLIET, "")
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
			    ok = Me.SetFormatOption("iso9660", "joliet", "long")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!joliet", "")
			    If ok And mJoliet Then ok = Me.SetFormatOption("iso9660", "joliet", "")
			  End If
			  If ok Then mLongFileNames = value
			End Set
		#tag EndSetter
		LongFileNames As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAbstractFile As Boolean
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
		Private mCompressionLevel As Int32
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
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption("iso9660", FORMAT_OPT_ROCKRIDGE, "")
			  Else
			    ok = Me.SetFormatOption("iso9660", "!" + FORMAT_OPT_ROCKRIDGE, "")
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
			  If Me.SetFormatOption("iso9660", "volume-id", value) Then mVolumeID = value
			End Set
		#tag EndSetter
		VolumeID As String
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
