## Warning: This project is in its early stages. Expect bugs, incomplete features, and API changes.

## Introduction
[libarchive](https://www.libarchive.org/) is a cross-platform multi-format archive and compression library. **RB-libarchive** is a libarchive [binding](http://en.wikipedia.org/wiki/Language_binding) for Realbasic and Xojo ("classic" framework) projects. Library binaries for various platforms are available, or can be built from source. 

The minimum supported libarchive version is x.y.z. The minimum supported Xojo version is RS2010R4.

## Example
This example extracts an archive into a folder. [**More examples**](https://github.com/charonn0/RB-libarchive/wiki#examples).
```xojo
  Dim src As FolderItem = GetOpenFolderItem("")
  Dim lst() As libarchive.ArchiveEntry = libarchive.ReadArchive(src, dst)
```

## Highlights
* Create and extract any archive format supported by libarchive<sup>1</sup>.
* Read and write encrypted archives.
* Read and write any compression format supported by libarchive<sup>1</sup>.

<sup>1</sup> Some formats are read-only; a few are write-only.

## Synopsis
An archive is represented by an instance of `ArchiveReader` or `ArchiveWriter`, or a format-specific subclass of these classes.

## How to incorporate libcarchive into your Realbasic/Xojo project
### Import the libarchive module
1. Download the RB-libarchive project either in [ZIP archive format](https://github.com/charonn0/RB-libarchive/archive/master.zip) or by cloning the repository with your Git client.
2. Open the RB-libarchive project in REALstudio or Xojo. Open your project in a separate window.
3. Copy the libarchive module into your project and save.

### Ensure the libarchive shared library is installed
libarchive is not installed by default on most operating systems, you will need to ship all the necessary DLLs/SOlibs/dylibs with your application. RB-libarchive will raise a PlatformNotSupportedException when used if all required DLLs/SOs/DyLibs are not available at runtime. 

## Examples
* [Generic extractor](https://github.com/charonn0/RB-libarchive/wiki/Extractor-Example)
* [Generic archiver](https://github.com/charonn0/RB-libarchive/wiki/Archiver-Example)
