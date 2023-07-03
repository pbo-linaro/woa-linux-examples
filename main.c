#include <linux/fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main()
{
    int ret = execveat(AT_FDCWD, "/bin/ls", 0, 0, 0);
    printf("FAILED %d %d %s\n", ret, errno, strerror(errno));
}
