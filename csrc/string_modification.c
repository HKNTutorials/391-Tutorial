#include <stdio.h>

int main(void)
{
    char a[] = "hello";
		char *p;
    a[0] = 'H';
    printf("%s\n", a);

    p = "world";
    p[0] = 'W';
    printf("%s\n", p);
    
    return 0;
}
