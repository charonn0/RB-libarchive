#tag Class
Protected Class ZipWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.Zip)
		  SetFilter(Compressor)
		  mSourceFile = File
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.Zip)
		  SetFilter(Compressor)
		  mSourceBuffer = Buffer
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(WriteTo As Writeable, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- from ArchiveWriter
		  Super.Constructor()
		  SetFormat(ArchiveType.Zip)
		  SetFilter(Compressor)
		  If WriteTo IsA BinaryStream Then BinaryStream(WriteTo).LittleEndian = True
		  mDestinationStream = WriteTo
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub _SetCompressed(b As Boolean)
		  ' Enables or disables compression on the archive.
		  
		  If b Then
		    mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  Else
		    mLastError = archive_write_zip_set_compression_store(mArchive)
		  End If
		  
		  If mLastError = 0 Then mCompressed = b
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mIncludeChecksums
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables CRC calculations. When disabled, all CRC fields are set to zero.
			  ' This should not be used except for testing purposes.
			  ' 
			  ' Default: Enabled
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "!fakecrc32", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "fakecrc32", "")
			  End If
			  If ok Then mIncludeChecksums = value
			End Set
		#tag EndSetter
		IncludeChecksums As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIncludeChecksums As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mZip64 As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mZip64
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Forces or disables use of Zip64 extensions. These extensions provide additional file
			  ' size information for entries larger than 4 GiB. They also provide extended file offset
			  ' and archive size information when archives exceed 4 GiB.
			  '
			  ' Setting this option to True will force the use of Zip64 extensions even for small files
			  ' that would not otherwise require them. Setting this option to False will forbid the use
			  ' Zip64 extensions: It will reject files with size greater than 4 GiB, it will reject any
			  ' new entries once the total archive size reaches 4 GiB, and it will not use Zip64 extensions
			  ' for files with unknown size.
			  ' 
			  ' Default: Zip64 extensions are selectively used only as needed. In particular, if the file
			  ' size is unknown, Zip64 extensions are used to guard against the possibility that the file
			  ' might be larger than 4 GiB.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "zip64", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "!zip64", "")
			  End If
			  If ok Then mZip64 = value
			End Set
		#tag EndSetter
		Zip64 As Boolean
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="FakeCRC"
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
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="VerifyChecksums"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Zip64"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
