#include <iostream>

extern "C" void pow(int64_t, float *);

int main()
{
    float arr[16];
    int64_t x;
    std::cout << "Enter 16 float numbers: ";
    for (auto &c : arr)
        std::cin >> c;
    std::cout << "Enter pow of x: ";
    std::cin >> x;
    pow(x, arr);
    std::cout << "Result: ";
    for (const auto &c : arr)
        std::cout << c << ' ';
    std::exit(0);
}