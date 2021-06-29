#tag Class
Protected Class XARWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.XAR, Compressor)
		  CreateFile(File)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.XAR, Compressor)
		  CreateMemory(Buffer)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables compression on subsequently added entries.
			  
			  Dim ok As Boolean
			  Select Case value
			  Case AlgorithmType.None
			    ok = Me.SetFormatOption(FORMAT_MODULE_XAR, "compression", "store")
			  Case AlgorithmType.BZip2
			    ok = Me.SetFormatOption(FORMAT_MODULE_XAR, "compression", "bzip2")
			  Case AlgorithmType.GZip
			    ok = Me.SetFormatOption(FORMAT_MODULE_XAR, "compression", "gzip")
			  End Select
			  If ok Then mCompressor = value
			End Set
		#tag EndSetter
		CompressionAlgorithm As libarchive.Writers.XARWriter.AlgorithmType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressionLevel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The compression level used by the deflate compressor. Ranges from 0 (least effort) to 9 (most effort). Default: 6 
			  
			  If Me.SetFormatOption(FORMAT_MODULE_XAR, "compression-level", Str(value)) Then mCompressionLevel = value
			End Set
		#tag EndSetter
		CompressionLevel As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCompressionLevel As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompressor As libarchive.Writers.XARWriter.AlgorithmType
	#tag EndProperty


	#tag Enum, Name = AlgorithmType, Flags = &h0
		None
		  BZip2
		GZip
	#tag EndEnum


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
