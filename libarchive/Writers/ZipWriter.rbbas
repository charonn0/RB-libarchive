#tag Class
Protected Class ZipWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(File As FolderItem, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.Zip, Compressor)
		  mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  CreateFile(File)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Buffer As MemoryBlock, Compressor As libarchive.CompressionType)
		  // Calling the overridden superclass constructor.
		  // Constructor(ArchiveType As libarchive.ArchiveType, Compressor As libarchive.CompressionType) -- from ArchiveWriter
		  Super.Constructor(ArchiveType.Zip, Compressor)
		  mLastError = archive_write_zip_set_compression_deflate(mArchive)
		  CreateMemory(Buffer)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCompressed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables compression on subsequently added entries.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "compression", "deflate")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "compression", "")
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
			  ' The compression level used by the deflate compressor. Ranges from 0 (least effort) to 9 (most effort). Default: 6 
			  
			  If Me.SetFormatOption(FORMAT_MODULE_ZIP, "compression-level", Str(value)) Then mCompressionLevel = value
			End Set
		#tag EndSetter
		CompressionLevel As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mEncryption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables encryption on subsequently added entries.
			  
			  Dim ok As Boolean
			  Select Case value
			  Case EncryptionType.None
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "encryption", "")
			  Case EncryptionType.ZipCrypt
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "encryption", "zipcrypt")
			  Case EncryptionType.AES128
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "encryption", "aes128")
			  Case EncryptionType.AES256
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "encryption", "aes256")
			  End Select
			  If ok Then mEncryption = value
			End Set
		#tag EndSetter
		Encryption As libarchive.Writers.ZipWriter.EncryptionType
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCompressed As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompressionLevel As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryption As libarchive.Writers.ZipWriter.EncryptionType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVerifyChecksums As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mZip64 As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mVerifyChecksums
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables CRC32 verification on subsequently added entries.
			  
			  Dim ok As Boolean
			  If value Then
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "!fakecrc32", "")
			  Else
			    ok = Me.SetFormatOption(FORMAT_MODULE_ZIP, "fakecrc32", "")
			  End If
			  If ok Then mVerifyChecksums = value
			End Set
		#tag EndSetter
		VerifyChecksums As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mZip64
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables or disables Zip64 extensions on subsequently added entries. These extensions
			  ' provide additional file size information for entries larger than 4 GiB. They also
			  ' provide extended file offset and archive size information when archives exceed 4 GiB.
			  ' By default, the Zip writer selectively enables these extensions only as needed. In
			  ' particular, if the file size is unknown, the Zip writer will include Zip64 extensions
			  ' to guard against the possibility that the file might be larger than 4 GiB.
			  ' 
			  ' Setting this option to True will force the writer to use the Zip64 extensions even
			  ' for small files that would not otherwise require them. Setting this option to False
			  ' will force the Zip writer to avoid Zip64 extensions: It will reject files with size
			  ' greater than 4 GiB, it will reject any new entries once the total archive size reaches
			  ' 4 GiB, and it will not use Zip64 extensions for files with unknown size. 
			  
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


	#tag Enum, Name = EncryptionType, Type = Integer, Flags = &h0
		None
		  ZipCrypt
		  AES128
		AES256
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
	#tag EndViewBehavior
End Class
#tag EndClass
