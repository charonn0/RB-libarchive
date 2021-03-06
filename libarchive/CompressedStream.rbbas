#tag Class
Protected Class CompressedStream
Implements Readable,Writeable
	#tag Method, Flags = &h0
		Sub Close()
		  If mCompressor <> Nil Then mCompressor.Close()
		  mCompressor = Nil
		  If mDecompressor <> Nil Then mDecompressor.Close()
		  mDecompressor = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As BinaryStream, Compressor As libarchive.CompressionType, CompressionLevel As Integer = 6)
		  ' Constructs a CompressedStream from the Source BinaryStream. If the Source's current position is equal
		  ' to its length then compressed output will be appended, otherwise the Source will be used as
		  ' input to be decompressed.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Constructor
		  
		  If Source.Length = Source.Position Then 'compress into Source
		    If Compressor = CompressionType.All Then Compressor = CompressionType.GZip
		    Me.Constructor(New libarchive.Writers.RawWriter(Source, Compressor, CompressionLevel))
		    
		  Else ' decompress from Source
		    Me.Constructor(New libarchive.Readers.RawReader(Source, Compressor))
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Engine As libarchive.Readers.RawReader)
		  ' Construct a decompression stream
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Constructor
		  
		  mDecompressor = Engine
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Engine As libarchive.Writers.RawWriter)
		  ' Construct a compression stream
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Constructor
		  
		  mCompressor = Engine
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As MemoryBlock, Compressor As libarchive.CompressionType, CompressionLevel As Integer = 6)
		  ' Constructs a CompressedStream from the Source MemoryBlock. If the Source's size is zero then
		  ' compressed output will be appended, otherwise the Source will be used as input
		  ' to be decompressed.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Constructor
		  
		  If Source.Size = 0 Then 'compress into Source
		    If Compressor = CompressionType.All Then Compressor = CompressionType.GZip
		    Me.Constructor(New libarchive.Writers.RawWriter(Source, Compressor, CompressionLevel))
		    
		  Else ' decompress from Source
		    Me.Constructor(New libarchive.Readers.RawReader(Source, Compressor))
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Output As FolderItem, Compressor As libarchive.CompressionType, CompressionLevel As UInt32 = 6) As libarchive.CompressedStream
		  ' Creates a new compressed stream for writing. Compressed data will be written to the Output file.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Create
		  
		  If Compressor = CompressionType.All Then Compressor = GuessCompressionType(Output.Name)
		  Dim writer As New libarchive.Writers.RawWriter(Output, Compressor, CompressionLevel)
		  Return New CompressedStream(writer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Output As Writeable, Compressor As libarchive.CompressionType, CompressionLevel As UInt32 = 6) As libarchive.CompressedStream
		  ' Creates a new compressed stream for writing. Compressed data will be written to the Output stream.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Create
		  
		  
		  Dim writer As New libarchive.Writers.RawWriter(Output, Compressor, CompressionLevel)
		  Return New CompressedStream(writer)
		End Function
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
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.EOF
		  
		  Return mDecompressor <> Nil And mDecompressor.EOF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush()
		  // Part of the Writeable interface.
		  // Not implemented.
		  ' Flushing is not supported by libarchive. Call CompressedStream.Close() instead.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Flush
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(Input As FolderItem, Compressor As libarchive.CompressionType) As libarchive.CompressedStream
		  ' Opens an existing compressed file for decompression.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Open
		  
		  
		  If Compressor = CompressionType.All Then Compressor = GuessCompressionType(Input.Name)
		  Dim reader As New libarchive.Readers.RawReader(Input, Compressor)
		  Return New CompressedStream(reader)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(Input As Readable, Compressor As libarchive.CompressionType) As libarchive.CompressedStream
		  ' Opens an existing compressed stream for decompression.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Open
		  
		  Dim reader As New libarchive.Readers.RawReader(Input, Compressor)
		  Return New CompressedStream(reader)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer, encoding As TextEncoding = Nil) As String
		  // Part of the Readable interface.
		  ' Reads compressed bytes from the stream and returns at most Count decompressed bytes.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Read
		  
		  If mDecompressor = Nil Then Raise New IOException
		  Dim data As String = mDecompressor.Read(Count)
		  Return DefineEncoding(data, encoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadError() As Boolean
		  // Part of the Readable interface.
		  ' Returns True if libarchive reports an error, whether recoverable or not.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.ReadError
		  
		  If IsReadable Then Return mDecompressor <> Nil And mDecompressor.LastError <> ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Data As String)
		  // Part of the Writeable interface.
		  ' Write Data to the compressed stream.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.Write
		  
		  If mCompressor = Nil Then Raise New IOException
		  mCompressor.WriteEntryDataBlock(data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteError() As Boolean
		  // Part of the Writeable interface.
		  ' Returns True if libarchive reports an error, whether recoverable or not.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.WriteError
		  
		  If IsWriteable Then Return mCompressor <> Nil And mCompressor.LastError <> 0
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the stream is in decompression mode
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.IsReadable
			  
			  Return mDecompressor <> Nil
			End Get
		#tag EndGetter
		IsReadable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns True if the stream is in compression mode
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.IsWriteable
			  
			  Return mCompressor <> Nil
			End Get
		#tag EndGetter
		IsWriteable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the most recent error code for this instance of CompressedStream.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream.LastError
			  
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
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWriteable"
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
