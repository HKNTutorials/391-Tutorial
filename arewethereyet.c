/**
 * This program is supposed to run until it receives SIG INT - i.e.
 * until you press CTRL+C.  But instead it segfaults.  What goes wrong?
 * Can you fix it?
 *
 * In gdb, you can emulate CTRL+C with the command
 *   signal SIGINT
 */

#include <signal.h>
#include <stdio.h>

volatile int there = 0;

void do_sigint()
{
    printf("Detected SIGINT\n");
    there = 1;
}

void playangrybirds()
{
    /* 
     * An interesting exercise here: If we want to break here when "there"
     * changes to 1, we can do it with either a watchpoint or a conditional
     * breakpoint.  Try it - which one is faster?
     */
    if (!there) {
        playangrybirds();
		}
}

int main()
{
    signal(SIGINT, do_sigint);

    if (!there) {
        playangrybirds();
		}

    return 0;
}
