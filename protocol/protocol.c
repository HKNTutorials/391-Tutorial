/*
vim: tw=80:ts=4:sw=4:et
*/

#include <stdlib.h>

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
  char last_byte = data[0];
  int i;
  for (i = 0; i < n; i++) {
    if (data[i] != last_byte) {
      // Record length of the last run.
      encoded_length += 2;
      // Starting a new run.
      last_byte = data[i];
    }
  }
  // record the final run
  encoded_length += 2;

  char *buf = malloc(encoded_length);
  *buf_ptr = buf;
  /*
   * Note that we use a char to track this length -- we can't use more than one
   * byte to report the length, so there is a hard limit of 255 on any
   * individual length.
   */
  char current_length = 0;
  int buf_idx = 0;
  last_byte = data[0];
  for (i = 0; i < n; i++) {
    if (data[i] == last_byte) {
      current_length++;
    } else {
      buf[buf_idx++] = current_length;
      buf[buf_idx++] = last_byte;
      last_byte = data[i];
    }
  }
  buf[buf_idx++] = current_length;
  buf[buf_idx++] = last_byte;
  return encoded_length;
}
