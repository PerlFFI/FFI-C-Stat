#include <sys/stat.h>
#include <stdlib.h>

struct stat *
stat___stat(const char *filename)
{
  struct stat *self;
  self = calloc(1, sizeof(struct stat));
  if(stat(filename, self) == -1)
  {
    free(self);
    return NULL;
  }
  return self;
}

struct stat *
stat___lstat(const char *filename)
{
  struct stat *self;
  self = calloc(1, sizeof(struct stat));
#if !defined(_WIN32) || defined(__CYGWIN__)
  if(lstat(filename, self) == -1)
#else
  if(stat(filename, self) == -1)
#endif
  {
    free(self);
    return NULL;
  }
  return self;
}

struct stat *
stat___fstat(int fd)
{
  struct stat *self;
  self = calloc(1, sizeof(struct stat));
  if(fstat(fd, self) == -1)
  {
    free(self);
    return NULL;
  }
  return self;
}

off_t
stat__size(struct stat *self)
{
  return self->st_size;
}

void
stat__DESTROY(struct stat *self)
{
  free(self);
}
