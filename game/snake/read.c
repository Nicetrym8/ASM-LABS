#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>
#include <termios.h>

char readInp()
{
    static struct termios oldt, newt;

    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;

    newt.c_lflag &= ~(ICANON);

    tcsetattr(STDIN_FILENO, TCSANOW, &newt);

    fd_set rfds;
    struct timeval tv;
    int retval;
    char kek;

    FD_ZERO(&rfds);
    FD_SET(0, &rfds);

    tv.tv_sec = 0;
    tv.tv_usec = 85000;
    // tv.tv_usec = 0;

    retval = select(1, &rfds, NULL, NULL, &tv);

    fflush(stdin);
    if (retval == -1)
        perror("select()");
    else if (retval)
    {
        kek = getchar();
        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
        return kek;
    }
    else
    {
        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
        return 0;
    }
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    return 0;
}

int gen_num()
{
    unsigned int num;
    FILE *fd = fopen("/dev/urandom", "r");
    fread(&num, sizeof(unsigned int), 1, fd);
    return num % 1342;
}