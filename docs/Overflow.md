```cpp
int a = 1000000;
int b = 1000000;
long long c = a * b; // ERRADO! Overflow acontece na multiplicação int*int
long long d = (long long)a * b; // CORRETO
```