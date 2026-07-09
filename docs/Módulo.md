Propriedades Fundamentais

A ideia principal é que você pode tirar o resto antes de realizar a operação, e o resultado final será o mesmo. Isso mantém os números pequenos durante todo o cálculo.

Soma: $$(a+b)(\mod m)=((a(\mod m))+(b(\mod m)))(\mod m)$$
Subtração: $$(a−b)(\mod m)=((a(\mod m))−(b(\mod m)))(\mod m)$$

Multiplicação: $$(a⋅b)(\mod m)=((a(\mod m))⋅(b(\mod m)))(\mod m )$$
Exponenciação (Propriedade Geral): $$a^b \pmod m = (a \pmod m)^b \pmod m$$

Exponenciação (Se $b$ é par): $$a^b \pmod m = (a^{b/2} \pmod m)^2 \pmod m$$

Exponenciação (Se $b$ é ímpar): $$a^b \pmod m = (a \cdot (a^{b-1} \pmod m)) \pmod m$$

⚠️ Cuidado: O Bug do Resto Negativo

Em C++, o operador % pode retornar um valor negativo se o dividendo for negativo (ex: -5 % 3 resulta em -2, mas na matemática queremos 1).

Para corrigir isso, sempre que fizer uma subtração modular, você deve garantir que o resultado seja positivo somando m antes de tirar o módulo final.
# Snippet de Código (Template)

Aqui está como implementar essas operações de forma segura em C++:
C++

```cpp
long long m = 1e9+7; // Ou o valor que o problema pedir

// Soma Segura
long long add(long long a, long long b) {
    return (a + b) % m;
}

// Multiplicação Segura (atenção ao overflow antes do mod)
long long mul(long long a, long long b) {
    return ((a % m) * (b % m)) % m;
}

// Subtração Segura (CRÍTICO: evita resultado negativo)
long long sub(long long a, long long b) {
    long long res = (a - b) % m;
    if (res < 0) res += m; 
    return res;
}

// Exponenciação Modular Rápida (O(log b))
// Calcula (base^exp) % m
long long fast_exp(long long base, long long exp) {
    long long res = 1;
    base = base % m; // Garante que a base inicial está dentro do módulo
    
    while (exp > 0) {
        // Se o expoente for ímpar (usando bitwise AND para checar o último bit)
        if (exp & 1) {
            res = (res * base) % m; // Equivalente a usar a sua função mul()
        }
        // Eleva a base ao quadrado para a próxima iteração
        base = (base * base) % m; 
        
        // Divide o expoente por 2 (usando bitwise Right Shift)
        exp >>= 1; 
    }
    
    return res;
}
```

Dica Prática: Em problemas de fatorial ou exponenciação, aplique o módulo em cada etapa do loop.
