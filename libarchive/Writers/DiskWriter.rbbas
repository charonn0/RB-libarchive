#tag Class
Protected Class DiskWriter
Inherits libarchive.ArchiveWriter
	#tag Method, Flags = &h1000
		Sub Constructor(Output As FolderItem, Flags As Int32 = 0)
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From Archive
		  Super.Constructor()
		  mArchive = archive_write_disk_new()
		  If mArchive = Nil Then Raise New ArchiveException(ERR_INIT_FAILED)
		  If Flags = 0 Then
		    Flags = ARCHIVE_EXTRACT_TIME Or ARCHIVE_EXTRACT_PERM Or ARCHIVE_EXTRACT_ACL Or ARCHIVE_EXTRACT_FFLAGS
		  End If
		  If Not SetOptions(Flags) Then Raise New ArchiveException(Me)
		  CreateFile(Output)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetFilterOption(FilterModule As String, OptionName As String, OptionValue As String) As Boolean
		  #pragma Unused FilterModule
		  #pragma Unused OptionName
		  #pragma Unused OptionValue
		  Return False ' not supported for writing to disk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetFormatOption(FormatModule As String, OptionName As String, OptionValue As String) As Boolean
		  #pragma Unused FormatModule
		  #pragma Unused OptionName
		  #pragma Unused OptionValue
		  Return False ' not supported for writing to disk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptions(OptionMask As Int32) As Boolean
		  mLastError = archive_write_disk_set_options(mArchive, OptionMask)
		  Return mLastError = ARCHIVE_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetOptions(Options() As String) As Boolean
		  #pragma Unused Options
		  Return False ' not supported for writing to disk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteEntry(Entry As libarchive.ArchiveEntry)
		  Try
		    mLastError = archive_write_header(mArchive, Entry.Handle)
		    If mLastError <> ARCHIVE_OK Then Raise New ArchiveException(Me)
		    
		    Do
		      mLastError = archive_write_data(mArchive, Nil, 0)
		      If mLastError < 0 Then Raise New ArchiveException(Me)
		    Loop
		    
		  Finally
		    mLastError = archive_write_finish_entry(mArchive)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteEntry(Entry As libarchive.ArchiveEntry, Source As Readable)
		  #pragma Unused Source
		  WriteEntry(Entry)
		End Sub
	#tag EndMethod


	#tag Note, Name = About this class
		.
		writes to the disk instead of to an archive file,
	#tag EndNote


	#tag Constant, Name = ARCHIVE_EXTRACT_ACL, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_CLEAR_NOCHANGE_FFLAGS, Type = Double, Dynamic = False, Default = \"&h20000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_FFLAGS, Type = Double, Dynamic = False, Default = \"&h0040", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_HFS_COMPRESSION_FORCED, Type = Double, Dynamic = False, Default = \"&h8000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_MAC_METADATA, Type = Double, Dynamic = False, Default = \"&h2000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_NO_AUTODIR, Type = Double, Dynamic = False, Default = \"&h0400", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_NO_HFS_COMPRESSION, Type = Double, Dynamic = False, Default = \"&h4000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_NO_OVERWRITE, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_NO_OVERWRITE_NEWER, Type = Double, Dynamic = False, Default = \"&h0800", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_OWNER, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_PERM, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_SAFE_WRITES, Type = Double, Dynamic = False, Default = \"&h40000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_SECURE_NOABSOLUTEPATHS, Type = Double, Dynamic = False, Default = \"&h10000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_SECURE_NODOTDOT, Type = Double, Dynamic = False, Default = \"&h0200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_SECURE_SYMLINKS, Type = Double, Dynamic = False, Default = \"&h0100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_SPARSE, Type = Double, Dynamic = False, Default = \"&h1000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_TIME, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_UNLINK, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_EXTRACT_XATTR, Type = Double, Dynamic = False, Default = \"&h0080", Scope = Public
	#tag EndConstant


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
