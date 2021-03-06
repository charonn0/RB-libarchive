#tag Module
Protected Module libarchive
	#tag Method, Flags = &h21
		Private Function AbsolutePath_(Extends f As FolderItem) As String
		  #If RBVersion > 2019 Then
		    Return f.NativePath
		  #Else
		    Return f.AbsolutePath
		  #endif
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_bzlib_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_atime Lib libpath (ArchiveEntry As Ptr) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_atime_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_atime_nsec Lib libpath (ArchiveEntry As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_birthtime Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_birthtime_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_birthtime_nsec Lib libpath (ArchiveEntry As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_clear Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_clone Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_copy_gname_w Lib libpath (ArchiveEntry As Ptr, GName As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_copy_pathname_w Lib libpath (ArchiveEntry As Ptr, Pathname As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_copy_sourcepath_w Lib libpath (ArchiveEntry As Ptr, Pathname As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_copy_uname_w Lib libpath (ArchiveEntry As Ptr, UName As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_ctime Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_ctime_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_ctime_nsec Lib libpath (ArchiveEntry As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_dev Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_devmajor Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_devminor Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_dev_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_fflags Lib libpath (ArchiveEntry As Ptr, IsSet As Int32, IsClear As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_filetype Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_free Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_gid Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_gname Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_gname_utf8 Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_gname_w Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_hardlink Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_hardlink_utf8 Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_hardlink_w Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_ino Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_ino64 Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_ino_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_is_data_encrypted Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_is_encrypted Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_is_metadata_encrypted Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mode Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mtime Lib libpath (ArchiveEntry As Ptr) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mtime_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_mtime_nsec Lib libpath (ArchiveEntry As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_new2 Lib libpath (Archive As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_nlink Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_pathname Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_pathname_utf8 Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_pathname_w Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_perm Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_rdev Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_rdevmajor Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_rdevminor Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_atime Lib libpath (ArchiveEntry As Ptr, UnixTime As UInt32, NanoSeconds As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_birthtime Lib libpath (ArchiveEntry As Ptr, UnixTime As UInt32, NanoSeconds As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_ctime Lib libpath (ArchiveEntry As Ptr, UnixTime As UInt32, NanoSeconds As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_filetype Lib libpath (ArchiveEntry As Ptr, Type As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_gid Lib libpath (ArchiveEntry As Ptr, gid As Int64)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_gname_utf8 Lib libpath (ArchiveEntry As Ptr, GName As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_mode Lib libpath (ArchiveEntry As Ptr, Perms As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_mtime Lib libpath (ArchiveEntry As Ptr, UnixTime As UInt32, NanoSeconds As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_nlink Lib libpath (ArchiveEntry As Ptr, Count As UInt32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_size Lib libpath (ArchiveEntry As Ptr, Size As Int64)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_uid Lib libpath (ArchiveEntry As Ptr, uid As Int64)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_set_uname_utf8 Lib libpath (ArchiveEntry As Ptr, UName As WString)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_size Lib libpath (ArchiveEntry As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_size_is_set Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_sourcepath Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_sourcepath_w Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_strmode Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_symlink Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_symlink_type Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_symlink_utf8 Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_symlink_w Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_uid Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_uname Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_uname_utf8 Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_entry_uname_w Lib libpath (ArchiveEntry As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_atime Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_birthtime Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_ctime Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_mtime Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub archive_entry_unset_size Lib libpath (ArchiveEntry As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_errno Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_error_string Lib libpath (Archive As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_format Lib libpath (ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_liblz4_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_liblzma_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_libzstd_version Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_add_callback_data Lib libpath (Archive As Ptr, Opaque As Ptr, Index As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_add_passphrase Lib libpath (Archive As Ptr, Password As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_append_callback_data Lib libpath (Archive As Ptr, Opaque As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_close Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data Lib libpath (Archive As Ptr, Buffer As Ptr, Size As UInt32) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data_block Lib libpath (Archive As Ptr, ByRef Buffer As Ptr, ByRef Size As UInt32, ByRef Offset As UInt64) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data_into_fd Lib libpath (Archive As Ptr, Descriptor As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_data_skip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_extract Lib libpath (Archive As Ptr, Entry As Ptr, Flags As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_extract2 Lib libpath (Archive As Ptr, Entry As Ptr, Destination As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_finish Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_format_capabilities Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_free Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_has_encrypted_entries Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_header_position Lib libpath (Archive As Ptr) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_next_header Lib libpath (Archive As Ptr, ByRef ArchiveEntry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open Lib libpath (Archive As Ptr, Opaque As Ptr, OpenCallback As Ptr, ReadCallback As Ptr, CloseCallback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open1 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open2 Lib libpath (Archive As Ptr, Opaque As Ptr, OpenCallback As Ptr, ReadCallback As Ptr, SkipCallback As Ptr, CloseCallback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open_filename Lib libpath (Archive As Ptr, FileName As CString, BlockSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open_filename_w Lib libpath (Archive As Ptr, FileName As WString, BlockSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_open_memory Lib libpath (Archive As Ptr, Buffer As Ptr, BufferSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_prepend_callback_data Lib libpath (Archive As Ptr, Opaque As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_callback_data Lib libpath (Archive As Ptr, Opaque As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_callback_data2 Lib libpath (Archive As Ptr, Opaque As Ptr, Index As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_close_callback Lib libpath (Archive As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_filter_option Lib libpath (Archive As Ptr, FilterModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_format Lib libpath (Archive As Ptr, Format As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_format_option Lib libpath (Archive As Ptr, FilterOrReaderModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_open_callback Lib libpath (Archive As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_option Lib libpath (Archive As Ptr, FilterOrReaderModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_options Lib libpath (Archive As Ptr, Options As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_passphrase_callback Lib libpath (Archive As Ptr, Opaque As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_read_callback Lib libpath (Archive As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_seek_callback Lib libpath (Archive As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_skip_callback Lib libpath (Archive As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_set_switch_callback Lib libpath (Archive As Ptr, Callback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_all Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_bzip2 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_compress Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_grzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_gzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lrzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lz4 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lzma Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_lzop Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_none Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_rpm Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_uu Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_xz Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_filter_zstd Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_7zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_all Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_ar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_by_code Lib libpath (Archive As Ptr, Code As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_cab Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_cpio Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_empty Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_gnutar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_iso9660 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_lha Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_mtree Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_rar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_rar5 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_raw Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_tar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_warc Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_xar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_zip_seekable Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_read_support_format_zip_streamable Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_seek_data Lib libpath (Archive As Ptr, Offset As Int64) As Int64
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_version_details Lib libpath () As WString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_version_number Lib libpath () As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_version_string Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_bzip2 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_compress Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_grzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_gzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lrzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lz4 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lzip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lzma Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_lzop Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_none Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_uuencode Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_xz Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_add_filter_zstd Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_close Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_data Lib libpath (Archive As Ptr, Buffer As Ptr, BufferSize As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_disk_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_disk_set_options Lib libpath (Archive As Ptr, Flags As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_finish_entry Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_free Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_header Lib libpath (Archive As Ptr, Entry As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_new Lib libpath () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_open2 Lib libpath (Archive As Ptr, Opaque As Ptr, OpenCallback As Ptr, WriteCallback As Ptr, CloseCallback As Ptr, FreeCallback As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_open_filename_w Lib libpath (Archive As Ptr, Path As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_open_memory Lib libpath (Archive As Ptr, Buffer As Ptr, BufferSize As UInt32, ByRef Used As UInt32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_bytes_in_last_block Lib libpath (Archive As Ptr, BytesInLastBlock As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_bytes_per_block Lib libpath (Archive As Ptr, BytesInLastBlock As Int32) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_filter_option Lib libpath (Archive As Ptr, FilterModule As WString, Option As WString, Value As WString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_7zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_ar_bsd Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_cpio Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_iso9660 Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_mtree Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_option Lib libpath (Archive As Ptr, FormatModule As CString, Option As CString, Value As CString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_raw Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_shar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_ustar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_xar Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_format_zip Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_option Lib libpath (Archive As Ptr, FilterOrFilterModule As CString, Option As CString, Value As CString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_options Lib libpath (Archive As Ptr, Options As CString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_set_passphrase Lib libpath (Archive As Ptr, Password As CString) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_zip_set_compression_deflate Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_write_zip_set_compression_store Lib libpath (Archive As Ptr) As Int32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function archive_zlib_version Lib libpath () As WString
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function CreateArchive(WriteTo As FolderItem, Archivist As libarchive.ArchiveType, Optional Compressor As libarchive.CompressionType) As libarchive.ArchiveWriter
		  ' Create a new archive of the specified archive and compression types in the specified FolderItem.
		  ' Returns an instance of ArchiveWriter to which archive entries may be written.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CreateArchive
		  
		  If Archivist = ArchiveType.All Then Archivist = GuessArchiveType(WriteTo.Name)
		  If Compressor = CompressionType.All Then Compressor = GuessCompressionType(WriteTo.Name)
		  Select Case Archivist
		  Case ArchiveType.All ' unknown file extension
		    Return Nil
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Writers.ARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Writers.CPIOWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Writers.ISO9660Writer(WriteTo, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Writers.MTreeWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Raw
		    Return New libarchive.Writers.RawWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Writers.SevenZipWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Shar
		    Return New libarchive.Writers.SharWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Writers.TARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Writers.XARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Zip, ArchiveType.ZipSeekable, ArchiveType.ZipStreamable
		    Dim z As New libarchive.Writers.ZipWriter(WriteTo, Compressor)
		    If Compressor = CompressionType.None Then z.Compressed = False
		    Return z
		    
		  Else
		    Raise New ArchiveException(ERR_READ_ONLY_FORMAT)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateArchive(WriteTo As MemoryBlock, Archivist As libarchive.ArchiveType, Optional Compressor As libarchive.CompressionType) As libarchive.ArchiveWriter
		  ' Create a new archive of the specified archive and compression types and write
		  ' the output to the specified empty memoryblock. The memoryblock will be enlarged
		  ' automatically as needed. Returns an instance of ArchiveWriter to which archive
		  ' entries may be written.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CreateArchive
		  
		  Select Case Archivist
		  Case ArchiveType.Ar
		    Return New libarchive.Writers.ARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Writers.CPIOWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Writers.ISO9660Writer(WriteTo, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Writers.MTreeWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Raw
		    Return New libarchive.Writers.RawWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Writers.SevenZipWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Shar
		    Return New libarchive.Writers.SharWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Writers.TARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Writers.XARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Zip, ArchiveType.ZipSeekable, ArchiveType.ZipStreamable
		    Dim z As New libarchive.Writers.ZipWriter(WriteTo, Compressor)
		    If Compressor = CompressionType.None Then z.Compressed = False
		    Return z
		    
		  Else
		    Raise New ArchiveException(ERR_READ_ONLY_FORMAT)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateArchive(WriteTo As Writeable, Archivist As libarchive.ArchiveType, Optional Compressor As libarchive.CompressionType) As libarchive.ArchiveWriter
		  ' Create a new archive of the specified archive and compression types and write the
		  ' output to the specified Writeable object. Returns an instance of ArchiveWriter to
		  ' which archive entries may be written.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CreateArchive
		  
		  
		  Select Case Archivist
		  Case ArchiveType.Ar
		    Return New libarchive.Writers.ARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Writers.CPIOWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Writers.ISO9660Writer(WriteTo, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Writers.MTreeWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Raw
		    Return New libarchive.Writers.RawWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Writers.SevenZipWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Shar
		    Return New libarchive.Writers.SharWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Writers.TARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Writers.XARWriter(WriteTo, Compressor)
		    
		  Case ArchiveType.Zip, ArchiveType.ZipSeekable, ArchiveType.ZipStreamable
		    Dim z As New libarchive.Writers.ZipWriter(WriteTo, Compressor)
		    If Compressor = CompressionType.None Then z.Compressed = False
		    Return z
		    
		  Else
		    Raise New ArchiveException(ERR_READ_ONLY_FORMAT)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateAsArchive(Extends Archive As FolderItem, Archivist As libarchive.ArchiveType = libarchive.ArchiveType.All) As libarchive.ArchiveWriter
		  ' Create a new archive of the specified archive type and write the output to
		  ' the specified Writeable object. Returns an instance of ArchiveWriter to which
		  ' archive entries may be written.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.CreateAsArchive
		  
		  Return CreateArchive(Archive, Archivist, CompressionType.All)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GuessArchiveType(Name As String) As libarchive.ArchiveType
		  Dim ext As String = NthField(Name, ".", CountFields(Name, "."))
		  Select Case ext
		  Case "a", "lib", "ar", "deb"
		    Return ArchiveType.Ar
		    
		  Case "cab"
		    Return ArchiveType.Cabinet
		    
		  Case "cpio"
		    Return ArchiveType.Cpio
		    
		  Case "iso"
		    Return ArchiveType.ISO9660
		    
		  Case "lzh", "lha"
		    Return ArchiveType.LHA
		    
		  Case "rar", "rev"
		    Return ArchiveType.Rar
		    
		  Case "7z"
		    Return ArchiveType.SevenZip
		    
		  Case "shar"
		    Return ArchiveType.Shar
		    
		  Case "tar", "tgz", "tbz"
		    Return ArchiveType.TAR
		    
		  Case "xar", "pkg", "xip"
		    Return ArchiveType.Xar
		    
		  Case "zip", "xpi", "odt", "fodt", "ods", "fods", "odp", "fodp", "odg", "fodg", "odf", "3mf", "dwfx", _
		    "cddx", "familyx", "fdix", "appv", "semblio", "vsix", "vsdx", "appx", "appxbundle", "cspkg", "xps", _
		    "mmzx", "nupkg", "docx", "pptx", "xlsx", "oxps", "aasx", "jtx", "slx", "smpk", "scdoc", "jar"
		    Return ArchiveType.Zip
		    
		  Case "gz", "xz", "lz", "uu"
		    Return GuessArchiveType(Left(Name, Name.Len - 3))
		  Case "bz2", "lz4", "uue", "zst"
		    Return GuessArchiveType(Left(Name, Name.Len - 4))
		  Case "lzma", "lzop", "gzip", "zstd"
		    Return GuessArchiveType(Left(Name, Name.Len - 5))
		  Else
		    Return ArchiveType.All
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GuessCompressionType(Name As String) As libarchive.CompressionType
		  Dim ext As String = NthField(Name, ".", CountFields(Name, "."))
		  Select Case ext
		  Case "bz2"
		    Return CompressionType.BZip2
		  Case "Z"
		    Return CompressionType.Compress
		  Case "grz"
		    Return CompressionType.GRZip
		  Case "gz", "gzip", "tgz"
		    Return CompressionType.GZip
		  Case "lrz"
		    Return CompressionType.LRZip
		  Case "lz4"
		    Return CompressionType.LZ4
		  Case "lzip"
		    Return CompressionType.LZip
		  Case "lzma"
		    Return CompressionType.LZMA
		  Case "lzop"
		    Return CompressionType.LZOP
		  Case "rpm"
		    Return CompressionType.RPM
		  Case "uue", "uu"
		    Return CompressionType.UUEncoded
		  Case "xz"
		    Return CompressionType.XZ
		  Case "zstd", "zst"
		    Return CompressionType.ZStd
		  Else
		    Return CompressionType.All
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  Static avail As Boolean
		  If Not avail Then avail = System.IsFunctionAvailable("archive_read_new", libpath)
		  Return avail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OpenArchive(Archive As FolderItem, Archivist As libarchive.ArchiveType, Optional Compressor As libarchive.CompressionType) As libarchive.ArchiveReader
		  ' Open the specified FolderItem as an archive using the specified archive and
		  ' compression types.
		  ' Returns an instance of ArchiveReader from which archive entries may be extracted.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.OpenArchive
		  
		  Select Case Archivist
		  Case ArchiveType.All ' detect.
		    Return New ArchiveReaderPtr(Archive)
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Readers.ARReader(Archive, Compressor)
		    
		  Case ArchiveType.Cabinet
		    Return New libarchive.Readers.CabinetReader(Archive, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Readers.CPIOReader(Archive, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Readers.ISO9660Reader(Archive, Compressor)
		    
		  Case ArchiveType.LHA
		    Return New libarchive.Readers.LHAReader(Archive, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Readers.MTreeReader(Archive, Compressor)
		    
		  Case ArchiveType.RAR
		    Return New libarchive.Readers.RARReader(Archive, Compressor)
		    
		  Case ArchiveType.RAR5
		    Return New libarchive.Readers.RAR5Reader(Archive, Compressor)
		    
		  Case ArchiveType.Raw
		    Return New libarchive.Readers.RawReader(Archive, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Readers.SevenZipReader(Archive, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Readers.TARReader(Archive, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Readers.XARReader(Archive, Compressor)
		    
		  Case ArchiveType.Zip
		    Return New libarchive.Readers.ZipReader(Archive, Compressor)
		    
		  Else
		    Raise New ArchiveException(ERR_WRITE_ONLY_FORMAT)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OpenArchive(Archive As MemoryBlock, Archivist As libarchive.ArchiveType, Optional Compressor As libarchive.CompressionType) As libarchive.ArchiveReader
		  ' Open the specified MemoryBlock as an archive using the specified archive and
		  ' compression types.
		  ' Returns an instance of ArchiveReader from which archive entries may be extracted.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.OpenArchive
		  
		  Select Case Archivist
		  Case ArchiveType.All ' detect.
		    Return New ArchiveReaderPtr(Archive)
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Readers.ARReader(Archive, Compressor)
		    
		  Case ArchiveType.Cabinet
		    Return New libarchive.Readers.CabinetReader(Archive, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Readers.CPIOReader(Archive, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Readers.ISO9660Reader(Archive, Compressor)
		    
		  Case ArchiveType.LHA
		    Return New libarchive.Readers.LHAReader(Archive, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Readers.MTreeReader(Archive, Compressor)
		    
		  Case ArchiveType.RAR
		    Return New libarchive.Readers.RARReader(Archive, Compressor)
		    
		  Case ArchiveType.RAR5
		    Return New libarchive.Readers.RAR5Reader(Archive, Compressor)
		    
		  Case ArchiveType.Raw
		    Return New libarchive.Readers.RawReader(Archive, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Readers.SevenZipReader(Archive, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Readers.TARReader(Archive, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Readers.XARReader(Archive, Compressor)
		    
		  Case ArchiveType.Zip
		    Return New libarchive.Readers.ZipReader(Archive, Compressor)
		    
		  Else
		    Raise New ArchiveException(ERR_WRITE_ONLY_FORMAT)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OpenArchive(Archive As Readable, Archivist As libarchive.ArchiveType, Optional Compressor As libarchive.CompressionType) As libarchive.ArchiveReader
		  ' Open the specified Readable object as an archive using the specified archive and
		  ' compression types.
		  ' Returns an instance of ArchiveReader from which archive entries may be extracted.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.OpenArchive
		  
		  Select Case Archivist
		  Case ArchiveType.All ' detect.
		    Return New ArchiveReaderPtr(Archive)
		    
		  Case ArchiveType.Ar
		    Return New libarchive.Readers.ARReader(Archive, Compressor)
		    
		  Case ArchiveType.Cabinet
		    Return New libarchive.Readers.CabinetReader(Archive, Compressor)
		    
		  Case ArchiveType.CPIO
		    Return New libarchive.Readers.CPIOReader(Archive, Compressor)
		    
		  Case ArchiveType.ISO9660
		    Return New libarchive.Readers.ISO9660Reader(Archive, Compressor)
		    
		  Case ArchiveType.LHA
		    Return New libarchive.Readers.LHAReader(Archive, Compressor)
		    
		  Case ArchiveType.MTree
		    Return New libarchive.Readers.MTreeReader(Archive, Compressor)
		    
		  Case ArchiveType.RAR
		    Return New libarchive.Readers.RARReader(Archive, Compressor)
		    
		  Case ArchiveType.RAR5
		    Return New libarchive.Readers.RAR5Reader(Archive, Compressor)
		    
		  Case ArchiveType.Raw
		    Return New libarchive.Readers.RawReader(Archive, Compressor)
		    
		  Case ArchiveType.SevenZip
		    Return New libarchive.Readers.SevenZipReader(Archive, Compressor)
		    
		  Case ArchiveType.TAR
		    Return New libarchive.Readers.TARReader(Archive, Compressor)
		    
		  Case ArchiveType.XAR
		    Return New libarchive.Readers.XARReader(Archive, Compressor)
		    
		  Case ArchiveType.Zip
		    Return New libarchive.Readers.ZipReader(Archive, Compressor)
		    
		  Else
		    Raise New ArchiveException(ERR_WRITE_ONLY_FORMAT)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OpenAsArchive(Extends Archive As FolderItem) As libarchive.ArchiveReader
		  ' Attempts to open the specified file as an archive by guessing the ArchiveType and
		  ' CompressionType. This may fail even on valid archives if libarchive guesses incorrectly.
		  ' Returns an instance of ArchiveReader from which archive entries may be extracted.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.OpenAsArchive
		  
		  
		  Return OpenArchive(Archive, ArchiveType.All, CompressionType.All)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadArchive(ArchiveFile As FolderItem, ExtractTo As FolderItem) As libarchive.ArchiveEntry()
		  ' Extracts the ArchiveFile into the ExtractTo directory.
		  ' Returns an array of zero or more ArchiveEntry objects representing the
		  ' extracted files/directories.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ReadArchive
		  
		  Dim arc As ArchiveReader = ArchiveFile.OpenAsArchive()
		  Return ReadArchive(arc, ExtractTo)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadArchive(Archive As libarchive.ArchiveReader, ExtractTo As FolderItem) As libarchive.ArchiveEntry()
		  ' Extracts an already opened ArchiveReader into the ExtractTo directory.
		  ' Returns an array of zero or more ArchiveEntry objects representing the
		  ' extracted files/directories.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.ReadArchive
		  
		  Dim list() As libarchive.ArchiveEntry
		  If USE_FAST_EXTRACT Then
		    ' This method extracts the Archive using libarchive's DiskWriter API
		    ' This can be significantly faster than using Xojo FolderItems to
		    ' generate directory trees, however it involves changing the app's
		    ' working directory which is a) a global variable which we don't exclusively
		    ' control; and b) only changeable in Xojo by using platform-specific
		    ' declares.
		    ' Set USE_FAST_EXTRACT to False to fall back on a slower but more portable
		    ' pure Xojo extraction routine.
		    
		    Dim writer As New libarchive.Writers.DiskWriter(ExtractTo)
		    Do Until Archive.LastError <> 0
		      Dim entry As libarchive.ArchiveEntry = Archive.CurrentEntry
		      writer.WriteEntry(entry, Archive)
		      list.Append(entry)
		    Loop Until writer.LastError <> 0
		    Archive.Close()
		    writer.Close()
		    
		  Else
		    If ExtractTo.Exists And Not ExtractTo.Directory Then Raise New IOException
		    ExtractTo.CreateAsFolder()
		    Dim outstream As BinaryStream
		    Do
		      If outstream <> Nil Then outstream.Close()
		      Dim entry As ArchiveEntry = Archive.CurrentEntry
		      Dim output As FolderItem = entry.ExtractPath(ExtractTo, True)
		      If entry.IsADirectory Then
		        output.CreateAsFolder()
		        outstream = Nil
		      Else
		        outstream = BinaryStream.Create(output, True)
		      End If
		      list.Append(entry)
		    Loop Until Not Archive.MoveNext(outstream)
		    If outstream <> Nil Then outstream.Close()
		    Archive.Close()
		  End If
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VersionNumber() As Int32
		  If Not IsAvailable Then Return 0
		  Return archive_version_number()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VersionString(LongForm As Boolean = False) As String
		  If Not IsAvailable Then Return ""
		  Dim w As MemoryBlock
		  If Not LongForm Then
		    w = archive_version_string()
		  Else
		    w = archive_version_details()
		  End If
		  If w <> Nil Then Return w.CString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteArchive(Archive As libarchive.ArchiveWriter, ToArchive() As FolderItem, RelativeRoot As FolderItem)
		  ' Adds the files in the ToArchive() parameter to an existing ArchiveWriter
		  ' with paths relative to the RelativeRoot parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.WriteArchive
		  
		  Dim c As Integer = UBound(ToArchive)
		  
		  For i As Integer = 0 To c
		    Dim item As FolderItem = ToArchive(i)
		    Dim entry As New ArchiveEntry(item, RelativeRoot)
		    Dim bs As BinaryStream
		    If Not item.Directory Then bs = BinaryStream.Open(item)
		    Archive.WriteEntry(entry, bs)
		  Next
		  Archive.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteArchive(Archive As libarchive.ArchiveWriter, TargetDirectory As FolderItem)
		  ' Creates an archive of the specified type and then recursively archives
		  ' the TargetDirectory parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libarchive/wiki/libarchive.WriteArchive
		  
		  If Not TargetDirectory.Exists Then Raise New ArchiveException(ERR_NOT_FOUND)
		  Dim folders() As FolderItem = Array(TargetDirectory)
		  
		  Do Until UBound(folders) < 0
		    Dim dir As FolderItem = folders.Pop
		    Dim c As Integer = dir.Count
		    For i As Integer = 1 To c
		      Dim item As FolderItem = dir.TrueItem(i)
		      Dim entry As New libarchive.ArchiveEntry(item, TargetDirectory)
		      Dim bs As BinaryStream
		      If item.Directory Then
		        folders.Insert(0, item)
		      Else
		        bs = BinaryStream.Open(item)
		      End If
		      Try
		        Archive.WriteEntry(entry, bs)
		      Finally
		        If bs <> Nil Then bs.Close()
		      End Try
		    Next
		  Loop
		  Archive.Close()
		End Sub
	#tag EndMethod


	#tag Constant, Name = ARCHIVE_EOF, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FAILED, Type = Double, Dynamic = False, Default = \"-25", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FATAL, Type = Double, Dynamic = False, Default = \"-30", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_7ZIP, Type = Double, Dynamic = False, Default = \"&h000E0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_AR, Type = Double, Dynamic = False, Default = \"&h00070000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_AR_BSD, Type = Double, Dynamic = False, Default = \"&h00070002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_AR_GNU, Type = Double, Dynamic = False, Default = \"&h00070001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CAB, Type = Double, Dynamic = False, Default = \"&h000C0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO, Type = Double, Dynamic = False, Default = \"&h0010000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO_AFIO_LARGE, Type = Double, Dynamic = False, Default = \"&h0010006", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO_BIN_BE, Type = Double, Dynamic = False, Default = \"&h0010003", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO_BIN_LE, Type = Double, Dynamic = False, Default = \"&h0010002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO_POSIX, Type = Double, Dynamic = False, Default = \"&h0010001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO_SVR4_CRC, Type = Double, Dynamic = False, Default = \"&h0010005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_CPIO_SVR4_NOCRC, Type = Double, Dynamic = False, Default = \"&h0010004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_EMPTY, Type = Double, Dynamic = False, Default = \"&h0060000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_ISO9660, Type = Double, Dynamic = False, Default = \"&h0040000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_ISO9660_ROCKRIDGE, Type = Double, Dynamic = False, Default = \"&h0040001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_LHA, Type = Double, Dynamic = False, Default = \"&h00B0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_MTREE, Type = Double, Dynamic = False, Default = \"&h0080000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_RAR, Type = Double, Dynamic = False, Default = \"&h00D0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_RAR_V5, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_RAW, Type = Double, Dynamic = False, Default = \"&h0090000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_SHAR, Type = Double, Dynamic = False, Default = \"&h0020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_SHAR_BASE, Type = Double, Dynamic = False, Default = \"&h0020001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_SHAR_DUMP, Type = Double, Dynamic = False, Default = \"&h0020002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_TAR, Type = Double, Dynamic = False, Default = \"&h0030000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_TAR_GNUTAR, Type = Double, Dynamic = False, Default = \"&h0030004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_TAR_PAX_INTERCHANGE, Type = Double, Dynamic = False, Default = \"&h0030002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_TAR_PAX_RESTRICTED, Type = Double, Dynamic = False, Default = \"&h0030003", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_TAR_USTAR, Type = Double, Dynamic = False, Default = \"&h0030001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_WARC, Type = Double, Dynamic = False, Default = \"&h00F0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_XAR, Type = Double, Dynamic = False, Default = \"&h00A0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_FORMAT_ZIP, Type = Double, Dynamic = False, Default = \"&h0050000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_RETRY, Type = Double, Dynamic = False, Default = \"-10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ARCHIVE_WARN, Type = Double, Dynamic = False, Default = \"-20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CHUNK_SIZE, Type = Double, Dynamic = False, Default = \"16777216", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ERR_INCONCEIVABLE, Type = Double, Dynamic = False, Default = \"-108", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_INIT_FAILED, Type = Double, Dynamic = False, Default = \"-102", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_INVALID_OPERATION, Type = Double, Dynamic = False, Default = \"-106", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_NOT_FOUND, Type = Double, Dynamic = False, Default = \"-109", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_READ_ONLY_FORMAT, Type = Double, Dynamic = False, Default = \"-101", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_SIZE_REQUIRED, Type = Double, Dynamic = False, Default = \"-105", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOO_EARLY, Type = Double, Dynamic = False, Default = \"-104", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_TOO_LATE, Type = Double, Dynamic = False, Default = \"-103", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_UNSUPPORTED_COMPRESSION, Type = Double, Dynamic = False, Default = \"-100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERR_WRITE_ONLY_FORMAT, Type = Double, Dynamic = False, Default = \"-107", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_BASE64, Type = String, Dynamic = False, Default = \"b64encode", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_BZIP2, Type = String, Dynamic = False, Default = \"bzip2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_COMPRESS, Type = String, Dynamic = False, Default = \"compress", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_GRZIP, Type = String, Dynamic = False, Default = \"grzip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_GZIP, Type = String, Dynamic = False, Default = \"gzip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_LRZIP, Type = String, Dynamic = False, Default = \"lrzip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_LZ4, Type = String, Dynamic = False, Default = \"lz4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_LZMA, Type = String, Dynamic = False, Default = \"lzma", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_LZOP, Type = String, Dynamic = False, Default = \"lzop", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_NONE, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_RPM, Type = String, Dynamic = False, Default = \"rpm", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_UUENCODE, Type = String, Dynamic = False, Default = \"uuencode", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_XZ, Type = String, Dynamic = False, Default = \"xz", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILTER_MODULE_ZSTD, Type = String, Dynamic = False, Default = \"zstd", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_7ZIP, Type = String, Dynamic = False, Default = \"7zip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_AR, Type = String, Dynamic = False, Default = \"ar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_CAB, Type = String, Dynamic = False, Default = \"cabinet", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_CPIO, Type = String, Dynamic = False, Default = \"cpio", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_EMPTY, Type = String, Dynamic = False, Default = \"empty", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_GNUTAR, Type = String, Dynamic = False, Default = \"gnutar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_ISO9660, Type = String, Dynamic = False, Default = \"iso9660", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_LHA, Type = String, Dynamic = False, Default = \"lha", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_MTREE, Type = String, Dynamic = False, Default = \"mtree", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_PAX, Type = String, Dynamic = False, Default = \"pax", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_RAR, Type = String, Dynamic = False, Default = \"rar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_RAR5, Type = String, Dynamic = False, Default = \"rar5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_RAW, Type = String, Dynamic = False, Default = \"raw", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_SHAR, Type = String, Dynamic = False, Default = \"shar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_USTAR, Type = String, Dynamic = False, Default = \"ustar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_V7TAR, Type = String, Dynamic = False, Default = \"v7tar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_WARC, Type = String, Dynamic = False, Default = \"warc", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_XAR, Type = String, Dynamic = False, Default = \"xar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_MODULE_ZIP, Type = String, Dynamic = False, Default = \"zip", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_CHECKFS, Type = String, Dynamic = False, Default = \"checkfs", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_COMPAT2X, Type = String, Dynamic = False, Default = \"compat-2x", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_COMPRESSION, Type = String, Dynamic = False, Default = \"compression", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_COMPRESSIONLEVEL, Type = String, Dynamic = False, Default = \"compression-level", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_ENCRYPTION, Type = String, Dynamic = False, Default = \"encryption", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_HDRCHARSET, Type = String, Dynamic = False, Default = \"hdrcharset", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_JOLIET, Type = String, Dynamic = False, Default = \"joliet", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_MACEXT, Type = String, Dynamic = False, Default = \"mac-ext", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_READCONCATENATED, Type = String, Dynamic = False, Default = \"read_concatenated_archives", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FORMAT_OPT_ROCKRIDGE, Type = String, Dynamic = False, Default = \"rockridge", Scope = Private
	#tag EndConstant

	#tag Constant, Name = libpath, Type = String, Dynamic = False, Default = \"libarchive.so.13", Scope = Private
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"libarchive-13.dll"
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"/usr/local/lib/libarchive.13.dylib"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"libarchive.so.13"
	#tag EndConstant

	#tag Constant, Name = USE_FAST_EXTRACT, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ArchiveType, Type = Integer, Flags = &h1
		All=0
		  Ar=&h00070000
		  Cabinet=&h000C0000
		  CPIO=&h0010000
		  Empty=&h0060000
		  ISO9660=&h0040000
		  LHA=&h00B0000
		  MTree=&h0080000
		  RAR=&h00D0000
		  RAR5=&h00100000
		  Raw=&h0090000
		  SevenZip=&h000E0000
		  Shar=&h0020000
		  TAR=&h0030000
		  WArc=&h00F0000
		  XAR=&h00A0000
		  Zip=&h0050000
		  ZipStreamable=&h0050001
		ZipSeekable=&h0050002
	#tag EndEnum

	#tag Enum, Name = CompressionType, Type = Integer, Flags = &h1
		All
		  BZip2
		  Compress
		  GRZip
		  GZip
		  LRZip
		  LZ4
		  LZip
		  LZMA
		  LZOP
		  None
		  RPM
		  UUEncoded
		  XZ
		ZStd
	#tag EndEnum

	#tag Enum, Name = EncryptionType, Type = Integer, Flags = &h1
		None
		  ZipCrypt
		  AES128
		AES256
	#tag EndEnum

	#tag Enum, Name = EntryType, Type = Integer, Flags = &h1
		File
		  Directory
		  FileLink
		  DirectoryLink
		  Socket
		  CharacterSpecial
		  BlockSpecial
		  FIFO
		  UndefinedLink
		Unknown
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
End Module
#tag EndModule
