#tag Class
Private Class RawReaderPtr
Inherits libarchive.Readers.RawReader
	#tag Method, Flags = &h0
		Sub Close()
		  mArchive = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(TrueReader As libarchive.ArchiveReader)
		  ' This class allows any kind of ArchiveReader to be seen as a RawReader object
		  ' representing the current entry in the archive. 
		  
		  mArchive = TrueReader.Handle
		  mIsOpen = TrueReader.mIsOpen
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Open()
		  If IsOpen Then
		    mLastError = ERR_TOO_LATE
		    Raise New ArchiveException(Me)
		  End If
		  
		  mIsOpen = True
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
