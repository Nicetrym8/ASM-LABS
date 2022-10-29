#include <iostream>

extern "C" float *sinus(float *arr, float *sin, int len);

int main()
{
    float arr[10] = {2.5, 3.5, 1.7, 7.5, 43.5, 64.5, 75.2, 21.8, 32.2, 74.4};
    float *sin = new float[10];
    sinus(arr, sin, 10);
    for (int i = 0; i < 10; i++)
        std::cout << "sin(" << arr[i] << ") = " << sin[i] << '\n';
    delete[] sin;
    return 0;
}