/*
vim: tw=80:ts=2:sw=2:et
*/

#include <stdlib.h>
#include <unistd.h>
#include <assert.h>

/**
 * Run-length encodes data up to length n and stores the result into buf. The
 * return value is the length of the encoded buffer. The function allocates a
 * buffer, which the caller is responsible for free'ing.
 *
 * Conceptually, the run-length encoding of, for example, aaabbcdddd is
 * 3a2b1c4d. Note that the run-length encoding of an array may be longer than
 * the original; for this reason, the function first calculates the length of
 * the encoded buffer.
 */
int run_length_encode(char *data, int n, char **buf_ptr) {
  if (n == 0) {
    *buf_ptr = NULL;
    return 0;
  }
  int encoded_length = 0;
  /*
   * Note that we use an int to track this length, but eventually use it as a
   * character to store into the encoded buffer. It therefore must be
   * constrained to be in [0,256) or we will get an overflow with undefined
   * behavior. Thus a run longer than 255 will get broken into chunks of at most
   * 255. For simplicity, we do not make use of the 0-length run, though in a
   * practical implementation it would be used to represent a run of 256 for
   * greater efficiency.
   *
   * One alternative to an int would be to use a char. Unfortunately in C a char
   * is a _signed_ 8-bit value, so a comparison with the maximum value would
   * require comparing to the constant '\xFF', which is a less readable
   * solution. In addition, any bug that resulted in overflow would result in
   * some subtle bugs. The "savings" are probably not realized since the machine
   * is likely to use a full machine word anyway (though this completely
   * implementation dependent; the C standard doesn't say what must happen).
   */
  int current_length = 0;
  char last_byte = data[0];
  int i;
  for (i = 0; i < n; i++) {
    if (data[i] == last_byte && current_length < 255) {
        current_length++;
    } else {
      // Record length of the last run.
      encoded_length += 2;
      // Starting a new run.
      last_byte = data[i];
      current_length = 1;
    }
  }
  // record the final run
  encoded_length += 2;

  char *buf = malloc(encoded_length);
  *buf_ptr = buf;
  current_length = 0;
  int buf_idx = 0;
  last_byte = data[0];
  for (i = 0; i < n; i++) {
    if (data[i] == last_byte && current_length < 255) {
      current_length++;
    } else {
      assert(current_length <= 255);
      buf[buf_idx++] = (char) current_length;
      buf[buf_idx++] = last_byte;
      last_byte = data[i];
      current_length = 1;
    }
  }
  buf[buf_idx++] = current_length;
  buf[buf_idx++] = last_byte;
  return encoded_length;
}
