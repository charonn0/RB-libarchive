## Introduction
[libarchive](https://www.libarchive.org/) is a cross-platform multi-format archive and compression library. **RB-libarchive** is a libarchive [binding](http://en.wikipedia.org/wiki/Language_binding) for Realbasic and Xojo ("classic" framework) projects. Library binaries for various platforms are available, or can be built from source. 

The minimum supported libarchive version is 3.3.3. The minimum supported Xojo version is RS2010R4.

## Example
This example extracts an archive into a folder. [**More examples**](https://github.com/charonn0/RB-libarchive/wiki#examples).
```xojo
  Dim src As FolderItem = GetOpenFolderItem("")
  Dim dst As FolderItem = SelectFolder()
  Dim lst() As libarchive.ArchiveEntry = libarchive.ReadArchive(src, dst)
```

## Highlights
* Create and extract any archive format supported by libarchive<sup>1</sup>.
* Read and write encrypted archives<sup>2</sup>.
* Read and write any compression format supported by libarchive<sup>1</sup>.
* 64-bit ready.

<sup>1</sup> Some formats are read-only; a few are write-only.<br /><sup>2</sup> Zip archives only.

## Synopsis
The libarchive API is abstracted over by several object classes:

|Object Class|Comment|
|------------|-------|
|[`ArchiveReader`](https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveReader)|An archive opened for extraction.| 
|[`ArchiveWriter`](https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveWriter)|An archive opened for archiving.| 
|[`ArchiveEntry`](https://github.com/charonn0/RB-libarchive/wiki/libarchive.ArchiveEntry)|The metadata of a single entry in an archive.| 
|[`CompressedStream`](https://github.com/charonn0/RB-libarchive/wiki/libarchive.CompressedStream)|A `BinaryStream` workalike for reading and writing compressed streams.| 

An archive is represented by an instance of `ArchiveReader` or `ArchiveWriter`, or a format-specific subclass of these classes. For most purposes you can use the [OpenArchive](https://github.com/charonn0/RB-libarchive/wiki/libarchive.OpenArchive), [OpenAsArchive](https://github.com/charonn0/RB-libarchive/wiki/libarchive.OpenAsArchive), and [ReadArchive](https://github.com/charonn0/RB-libarchive/wiki/libarchive.ReadArchive) convenience methods to extract an existing archive; and the [CreateArchive](https://github.com/charonn0/RB-libarchive/wiki/libarchive.CreateArchive), [CreateAsArchive](https://github.com/charonn0/RB-libarchive/wiki/libarchive.CreateAsArchive), and [WriteArchive](https://github.com/charonn0/RB-libarchive/wiki/libarchive.WriteArchive) convenience methods to generate a new archive.

## How to incorporate libcarchive into your Realbasic/Xojo project
### Import the libarchive module
1. Download the RB-libarchive project either in [ZIP archive format](https://github.com/charonn0/RB-libarchive/archive/master.zip) or by cloning the repository with your Git client.
2. Open the RB-libarchive project in REALstudio or Xojo. Open your project in a separate window.
3. Copy the libarchive module into your project and save.

### Ensure the libarchive shared library is installed
libarchive might be not installed by default on some operating systems, in which case you will need to either install the libarchive package from the OS vendor or ship the necessary files with your application. 

* Windows: [32-bit and 64-bit DLLs](https://www.boredomsoft.org/hosted/libarchiveDLLs.zip)
* macOS: [32-bit and 64-bit dylibs](https://jenkins.heirloomcomputing.com/downloads/MacOSX10.8.sdk/usr/lib/libarchive.dylib) (untested; *might* not be needed. Be sure to update the `libarchive.libpath` constant to point to this file.)
* Linux: Install the `libarchive-13` (or equivalent) package through the system package manager if it is not already installed.

RB-libarchive will raise a PlatformNotSupportedException when used if all required DLLs/SOs/DyLibs are not available at runtime. 

## Examples
* [Generic extractor](https://github.com/charonn0/RB-libarchive/wiki/Extractor-Example)
* [Generic archiver](https://github.com/charonn0/RB-libarchive/wiki/Archiver-Example)
* [Compressed streams](https://github.com/charonn0/RB-libarchive/wiki/Compressed-Stream-Examples)
