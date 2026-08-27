> **CPH:** 21.2 Computer arithmetic p. 203 · 1.3 Working with numbers p. 6

```cpp
int a = 1000000;
int b = 1000000;
long long c = a * b; // ERRADO! Overflow acontece na multiplicação int*int
long long d = (long long)a * b; // CORRETO
```