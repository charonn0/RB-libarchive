#tag Class
Protected Class ArchiveException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(ErrorCode As Integer)
		  Me.ErrorNumber = ErrorCode
		  Me.Message = ErrorName(ErrorCode) + ": " + ErrorDescription(ErrorCode)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Archive As libarchive.Archive)
		  If Archive <> Nil Then
		    Me.Constructor(Archive.LastError)
		    If Archive.Handle <> Nil Then
		      Dim mb As MemoryBlock = archive_error_string(Archive.Handle)
		      If mb <> Nil Then Me.Message = Me.Message + " " + mb.CString(0) + "."
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Entry As libarchive.ArchiveEntry)
		  If Entry <> Nil Then Me.Constructor(Entry.LastError)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function ErrorDescription(ErrorCode As Int32) As String
		  Select Case ErrorCode
		  Case ERR_INIT_FAILED
		    Return "Unknown error while initializing libarchive."
		  Case ERR_UNSUPPORTED_COMPRESSION
		    Return "Unknown or unsupported compressor."
		  Case ERR_READ_ONLY_FORMAT
		    Return "Creating an archive of this type is not supported."
		  Case ERR_WRITE_ONLY_FORMAT
		    Return "Extracting an archive of this type is not supported."
		  Case ERR_TOO_LATE
		    Return "It is too late in the process to perform the requested operation."
		  Case ERR_TOO_EARLY
		    Return "It is too early in the process to perform the requested operation."
		  Case ERR_SIZE_REQUIRED
		    Return "The requested operation cannot be performed on an unbounded memory block."
		  Case ERR_INVALID_OPERATION
		    Return "The requested operation is invalid in the current context."
		  Case ERR_INCONCEIVABLE
		    Return "A pure virtual function was called."
		  Case ARCHIVE_OK
		    Return "Operation succeeded."
		  Case ARCHIVE_EOF
		    Return "No further data to read."
		  Case ARCHIVE_FAILED
		    Return "The operation failed but it may be possible to continue."
		  Case ARCHIVE_FATAL
		    Return "The operation failed and it is not possible to continue."
		  Case ARCHIVE_RETRY
		    Return "The operation failed but it may succeed if retried."
		  Case ARCHIVE_WARN
		    Return "The operation was partially successful."
		  Else
		    Return "Unknown error number: " + Str(ErrorCode, "-000")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function ErrorName(ErrorCode As Int32) As String
		  Select Case ErrorCode
		  Case ERR_INIT_FAILED
		    Return "ERR_INIT_FAILED"
		  Case ERR_UNSUPPORTED_COMPRESSION
		    Return "ERR_UNSUPPORTED_COMPRESSION"
		  Case ERR_READ_ONLY_FORMAT
		    Return "ERR_READ_ONLY_FORMAT"
		  Case ERR_WRITE_ONLY_FORMAT
		    Return "ERR_WRITE_ONLY_FORMAT"
		  Case ERR_TOO_LATE
		    Return "ERR_TOO_LATE"
		  Case ERR_TOO_EARLY
		    Return "ERR_TOO_EARLY"
		  Case ERR_SIZE_REQUIRED
		    Return "ERR_SIZE_REQUIRED"
		  Case ERR_INVALID_OPERATION
		    Return "ERR_INVALID_OPERATION"
		  Case ERR_INCONCEIVABLE
		    Return "ERR_INCONCEIVABLE"
		  Case ARCHIVE_OK
		    Return "ARCHIVE_OK"
		  Case ARCHIVE_EOF
		    Return "ARCHIVE_EOF"
		  Case ARCHIVE_FAILED
		    Return "ARCHIVE_FAILED"
		  Case ARCHIVE_FATAL
		    Return "ARCHIVE_FATAL"
		  Case ARCHIVE_RETRY
		    Return "ARCHIVE_RETRY"
		  Case ARCHIVE_WARN
		    Return "ARCHIVE_WARN"
		  Else
		    Return Str(ErrorCode, "-000")
		  End Select
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
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
