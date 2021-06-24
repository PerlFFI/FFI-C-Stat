# FFI::C::Stat ![static](https://github.com/PerlFFI/FFI-C-Stat/workflows/static/badge.svg) ![linux](https://github.com/PerlFFI/FFI-C-Stat/workflows/linux/badge.svg) ![windows](https://github.com/PerlFFI/FFI-C-Stat/workflows/windows/badge.svg) ![macos](https://github.com/PerlFFI/FFI-C-Stat/workflows/macos/badge.svg) ![cygwin](https://github.com/PerlFFI/FFI-C-Stat/workflows/cygwin/badge.svg) ![msys2-mingw](https://github.com/PerlFFI/FFI-C-Stat/workflows/msys2-mingw/badge.svg)

Object-oriented FFI interface to native stat and lstat

# SYNOPSIS

```perl
use FFI::C::Stat;

my $stat = FFI::C::Stat->new("foo.txt");
print "size = ", $stat->size;
```

# DESCRIPTION

Perl comes with perfectly good `stat`, `lstat` functions, however if you are writing
FFI bindings for a library that use the C `stat` structure, you are out of luck there.
This module provides an FFI friendly interface to the C `stat` function, which uses
an object similar to [File::stat](https://metacpan.org/pod/File::stat), except the internals are a real C `struct` that
you can pass into C APIs that need it.

Supposing you have a C function:

```perl
void
my_cfunction(struct stat *s)
{
  ...
}
```

You can bind `my_cfunction` like this:

```perl
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new( api => 1 );
$ffi->type('object(FFI::C::Stat)' => 'stat');
$ffi->attach( my_cfunction => ['stat'] => 'void' );
```

# CONSTRUCTORS

## new

```perl
my $stat = FFI::C::Stat->new(*HANDLE,   %options);
my $stat = FFI::C::Stat->new($filename, %options);
```

You can create a new instance of this class by calling the new method and passing in
either a file or directory handle, or by passing in the filename path.

Options:

- symlink

    Use `lstat` instead of `stat`, that is if the filename is a symlink, `stat` the
    symlink instead of the target.

## clone

```perl
my $stat = FFI::C::Stat->clone($other_stat);
```

Creates a clone of `$stat`.  The argument `$stat` can be either a [FFI::C::Stat](https://metacpan.org/pod/FFI::C::Stat) instance,
or an opaque pointer to a `stat` structure.  The latter case is helpful when writing bindings
to a method that returns a `stat` structure, since you won't be wanting to free the pointer
that belongs to the callee.

C:

```perl
struct stat *
my_cfunction()
{
  static struct stat stat;  /* definitely do not want to free static memory */
  ...
  return stat;
}
```

Perl:

```perl
$ffi->attach( my_cfunction => [] => 'opaque' => sub {
  my $xsub = shift;
  my $ptr = $xsub->();
  return FFI::C::Stat->clone($ptr);
});
```

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
