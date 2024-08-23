DigiPres Sandbox
=================

An interactive guide to format identification

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/digipresnet/guide-to-format-id/master)

```
jupyter-repo2docker -v .:/home/${USER} .
```

DigiPres Toolbox
----------------

This notebook lets you run files through various format identification tools and compare the results. The format tools are:

 - [Siegfried](https://www.itforarchivists.com/siegfried) (using the 'deluxe' format signatures which includes mutliple sources).
 - [Apache Tika](https://tika.apache.org/)
 - [File](https://www.darwinsys.com/file/)
 - [TrID](http://mark0.net/soft-trid-e.html)
 - [DROID](http://digital-preservation.github.io/droid/)
 - [Fido](https://github.com/openpreserve/fido)
 - [MediaInfo](https://github.com/MediaArea/MediaInfo)
 - [ffprobe](https://ffmpeg.org/ffprobe.html)
 - [GitHub Linguist](https://github.com/github/linguist)
 - [CLOC](https://github.com/AlDanial/cloc)

You can use one of the example files (taken from the [Open Preservation Foundation Format Corpus](https://github.com/openpreserve/format-corpus)), or (_TBA_) supply the URL of a public file, or upload your own file.

**NOTE** that while any files you upload to this cloud-hosted service _should_ remain private, this cannot be guarenteed.