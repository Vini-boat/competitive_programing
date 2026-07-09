```cpp
// Define a margem de erro (Epsilon). 1e-9 é o padrão ouro para maratonas.
const double EPS = 1e-9; 

// Retorna true se 'a' for igual a 'b'
#define eq(a, b) (std::abs((a) - (b)) <= EPS)

// Retorna true se 'a' for estritamente menor que 'b'
#define ls(a, b) ((a) + EPS < (b))

// Retorna true se 'a' for menor ou igual a 'b'
#define lseq(a, b) ((a) - EPS <= (b))

// Retorna true se 'a' for estritamente maior que 'b'
#define gr(a, b) ((a) > (b) + EPS)

// Retorna true se 'a' for maior ou igual a 'b'
#define greq(a, b) ((a) + EPS >= (b))
```