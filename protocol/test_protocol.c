#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>

int run_length_encode(char *data, int n, char **buf);
int run_length_decode(char *enc, int n, char **data_ptr);

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

void test_encode() {
  char *data = NULL;
  char *buf;
  int encoded_length;
  encoded_length = run_length_encode(data, 0, &buf);
  assert(encoded_length == 0);
  data = "abcd";
  encoded_length = run_length_encode(data, strlen(data), &buf);
  char expect1[] = {1, 'a', 1, 'b', 1, 'c', 1, 'd'};
  assert(array_eq(buf, encoded_length, expect1, 8));
  data = (char *) malloc(255+30);
  int i;
  for (i = 0; i < 255+30; i++) {
    data[i] = '\x42';
  }
  encoded_length = run_length_encode(data, 255+30, &buf);

  // 0xFF is 255 in decimal
  char expect2[] = {'\xFF', '\x42', 30, '\x42'};
  assert(array_eq(buf, encoded_length, expect2, 4));
}

void test_decode() {
  char *enc = NULL;
  char *data;
  int decoded_length;
  decoded_length = run_length_decode(enc, 0, &data);
  assert(decoded_length == 0);
  assert(data == NULL);

  char enc1[] = {3, 'b', 1, 'c', 4, 'd'};
  decoded_length = run_length_decode(enc1, sizeof(enc1), &data);
  assert(array_eq(data, decoded_length, "bbbcdddd", 8));
  char enc2[] = {5, '\x3C', 0, 'f', 2, '\x12'};
  decoded_length = run_length_decode(enc2, sizeof(enc2), &data);
  assert(array_eq(data, decoded_length, "\x3C\x3C\x3C\x3C\x3C\x12\x12", 7));
}

int main() {
  test_encode();
  test_decode();
}
