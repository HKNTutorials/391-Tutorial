#include <stdlib.h>
#include <string.h>
#include <assert.h>

int run_length_encode(char *data, int n, char **buf);

/**
 * Compares arr1 to arr2 up to n. Returns 1 if they are the same and 0 if they
 * differ. There is no way for this function to compare lengths; you must do
 * that yourself.
 */
int buf_eq(char *arr1, char* arr2, int n) {
  if ((arr1 == NULL && arr2 != NULL) || (arr1 != NULL && arr2 == NULL)) {
    return 0;
  }
  int i;
  for (i = 0; i < n; i++) {
    if (arr1[i] != arr2[i]) {
      return 0;
    }
  }
  return 1;
}

/**
 * Compares two arrays, specified as a combination of buffer and length. If the
 * provided lengths differ, returns false immediately.
 */
int array_eq(char *arr1, int n1, char *arr2, int n2) {
  if (n1 != n2) {
    return 0;
  }
  return buf_eq(arr1, arr2, n1);
}

int main() {
  char *data = NULL;
  char *buf;
  int encoded_length;
  encoded_length = run_length_encode(data, 0, &buf);
  assert(encoded_length == 0);
  data = "abcd";
  encoded_length = run_length_encode(data, strlen(data), &buf);
  assert(encoded_length == 8);
  assert(buf_eq(buf, "\001a\001b\001c\001d", encoded_length));
}
