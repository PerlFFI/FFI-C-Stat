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

## size

```perl
my $size = $stat->size;
```

Returns the size of the file in bytes.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
