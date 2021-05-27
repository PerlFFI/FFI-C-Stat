# FFI::C::Stat ![linux](https://github.com/uperl/FFI-C-Stat/workflows/linux/badge.svg) ![windows](https://github.com/uperl/FFI-C-Stat/workflows/windows/badge.svg) ![macos](https://github.com/uperl/FFI-C-Stat/workflows/macos/badge.svg) ![cygwin](https://github.com/uperl/FFI-C-Stat/workflows/cygwin/badge.svg) ![msys2-mingw](https://github.com/uperl/FFI-C-Stat/workflows/msys2-mingw/badge.svg)

Object-oriented FFI interface to native stat and lstat

# SYNOPSIS

# DESCRIPTION

# CONSTRUCTOR

## new

```perl
my $stat = FFI::C::Stat->new(*HANDLE);
my $stat = FFI::C::Stat->new($filename);
```

You can create a new instance of this class by calling the new method and passing in
either a file or directory handle, or by passing in the filename path.

# PROPERTIES

## dev

```perl
my $id = $stat->dev;
```

The ID of device containing file.

## ino

```perl
my $inode = $stat->ino;
```

The inode number.

## mode

```perl
my $mode = $stat->mode;
```

The file type and mode.

## nlink

```perl
my $n = $stat->nlink;
```

The number of hard links.

## uid

```perl
my $uid = $stat->uid;
```

The User ID owner.

## gid

```perl
my $gid = $stat->gid;
```

The Group ID owner.

## rdev

```perl
my $id = $stat->rdev;
```

The ID of device (if special file)

## size

```perl
my $size = $stat->size;
```

Returns the size of the file in bytes.

## atime

```perl
my $time = $stat->atime;
```

The time of last access.

## mtime

```perl
my $time = $stat->mtime;
```

The time of last modification.

## ctime

```perl
my $time = $stat->ctime;
```

The time of last status change.

## blksize

```perl
my $size = $stat->blksize;
```

The filesystem-specific  preferred I/O block size.

## blocks

```perl
my $count = $stat->blocks;
```

Number of blocks allocated.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
