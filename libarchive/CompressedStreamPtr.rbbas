#tag Class
Private Class CompressedStreamPtr
Inherits libarchive.CompressedStream
	#tag Method, Flags = &h1000
		Sub Constructor(Destination As libarchive.ArchiveWriter)
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
