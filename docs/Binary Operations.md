# Operadores Binários

São diferentes dos booleanos (tipo `||` e `&&`)

O peram em cada bit de um inteiro.

```cpp
n & x;  // AND
n | x;  // OR
n ^ x;  // XOR
~n;     // NOT
n << i; // Left Shif
n >> i; // Right Shift

```

## Versões compostas

```cpp
n &= x;   // equivale a n = n & x
n |= x;   // equivale a n = n | x
n ^= x;   // equivale a n = n ^ x
n <<= i;  // equivale a n = n << i
n >>= i;  // equivale a n = n >> i
```

## Para mascaras de bits

```cpp
int mask = 0;

mask |= (1 << i);        // liga o bit i

if (mask & (1 << i))     // testa se o bit i está ligado

mask &= ~(1 << i);       // desliga o bit i

mask ^= (1 << i);        // inverte o bit i

```

## XOR

`x ^ x = 0`
`x ^ 0 = x`

