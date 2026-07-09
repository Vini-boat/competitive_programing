Para computar os primos até uns $10^7$

```cpp
// Função para pré-computar primos até um limite N
vector<bool> sieve(int n) {
    // Inicializa o vetor assumindo que todos são primos (true)
    vector<bool> is_prime(n + 1, true);
    is_prime[0] = is_prime[1] = false; // 0 e 1 por definição não são primos

    // Só precisamos iterar até a raiz quadrada de n (p * p <= n)
    for (int p = 2; p * p <= n; p++) {
        // Se p continuar marcado como true, ele é primo
        if (is_prime[p]) {
            // Marca todos os múltiplos de p como falsos.
            // Otimização: podemos começar de p^2, pois múltiplos menores 
            // já foram marcados por primos anteriores.
            for (int i = p * p; i <= n; i += p) {
                is_prime[i] = false;
            }
        }
    }
    return is_prime;
}
```