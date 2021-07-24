#tag Class
Private Class CompressedStreamPtr
Inherits libarchive.CompressedStream
	#tag Method, Flags = &h1000
		Sub Constructor(Source As libarchive.ArchiveReader)
		  ' This Constructor allows any kind of ArchiveReader to be seen as a Readable object
		  ' representing the current entry in the archive.
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Engine As libarchive.Readers.RawReader) -- From CompressedStream
		  Super.Constructor(New RawReaderPtr(Source))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Destination As libarchive.ArchiveWriter)
		  ' This Constructor allows any kind of ArchiveWriter to be seen as a Writeable object
		  ' representing the current entry in the archive. 
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Engine As libarchive.Writers.RawWriter) -- From CompressedStream
		  Super.Constructor(New RawWriterPtr(Destination))
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsReadable"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.CompressedStream"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWriteable"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libarchive.CompressedStream"
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
