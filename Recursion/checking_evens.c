// Counting the even numbers in an array recursively because why not
#include <stdbool.h>
#include <stdio.h>
#define SIZE sizeof(arr) / sizeof(int)
bool isEven(int number) { return (number % 2 == 0) ? 1 : 0; }
int evenDriver(int start, int end, int array[]) {
    if (start == end) {
        return 0;
    }
    return (isEven(*array) + evenDriver(start + 1, end, array + 1));
}
int main() {
    int arr[] = {1, 2, 3, 4, 5, 6, 7};
    printf("%d\n", evenDriver(0, SIZE, arr));
    return 0;
}
