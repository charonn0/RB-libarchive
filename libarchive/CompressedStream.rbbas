#tag Class
Protected Class CompressedStream
Implements Readable,Writeable
	#tag Method, Flags = &h0
		Sub Close()
		  If mCompressor <> Nil Then
		    Try
		      Me.Flush()
		    Catch
		    End Try
		  End If
		  mSource = Nil
		  mDestination = Nil
		  mCompressor = Nil
		  mDecompressor = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engine As libarchive.Readers.RawReader, Source As Readable)
		  ' Construct a decompression stream using the Engine and Source parameters
		  mDecompressor = Engine
		  mSource = Source
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engine As libarchive.Writers.RawWriter, Destination As Writeable)
		  ' Construct a compression stream using the Engine and Destination parameters
		  mCompressor = Engine
		  mDestination = Destination
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EndOfFile() As Boolean
		  // Part of the Readable interface as of 2019r2
		  Return Me.EOF()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EOF() As Boolean
		  // Part of the Readable interface.
		  ' Returns True if there is no more output to read (decompression only)
		  Return mSource <> Nil And mSource.EOF And mDecompressor <> Nil And mDecompressor.EOF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer, encoding As TextEncoding = Nil) As String
		  // Part of the Readable interface.
		  
		  If mDecompressor = Nil Then Raise New IOException
		  Dim data As String = mDecompressor.Read(Count)
		  Return DefineEncoding(data, encoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadError() As Boolean
		  // Part of the Readable interface.
		  If mSource <> Nil Then Return mSource.ReadError Or (mDecompressor <> Nil And mDecompressor.LastError <> 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Data As String)
		  // Part of the Writeable interface.
		  ' Write Data to the compressed stream.
		  
		  If mCompressor = Nil Then Raise New IOException
		  mCompressor.WriteEntryDataBlock(data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteError() As Boolean
		  // Part of the Writeable interface.
		  If mDestination <> Nil Then Return mDestination.WriteError Or (mCompressor <> Nil And mCompressor.LastError <> 0)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the stream is in decompression mode
			  Return mDecompressor <> Nil
			End Get
		#tag EndGetter
		IsReadable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the stream is in compression mode
			  Return mCompressor <> Nil
			End Get
		#tag EndGetter
		IsWriteable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mDecompressor <> Nil Then
			    Return mDecompressor.LastError
			  ElseIf mCompressor <> Nil Then
			    Return mCompressor.LastError
			  End IF
			End Get
		#tag EndGetter
		LastError As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCompressor As libarchive.Writers.RawWriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecompressor As libarchive.Readers.RawReader
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestination As Writeable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Readable
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
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
