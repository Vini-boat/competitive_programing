Pra quando se sabe o maior valor que será armazenado.

```cpp
const int MAX = 10; // pra guardar 0 a 9

bitset<MAX> A;
bitset<MAX> B;
bitset<MAX> res;

for(int i: {1,2,3,4}) A.set(i); // [1,2,3,4]
for(int i: {4,5,6,7}) B.set(i); // [3,4,5,6]
```

Operações

```cpp
A.set(x);   // insere x
A.set()     // insere tudo

A.reset(x); // tira x
A.reset();  // tira tudo

A.flip(x);  // inverte x
```

Operações de conjunto

```cpp
// 1. União (A U B) -> Resultado: {1, 2, 3, 4, 5, 6} 
res = A | B; 
// 2. Interseção (A ∩ B) -> Resultado: {3, 4} 
res = A & B; 
// 3. Diferença (A - B) -> Resultado: {1, 2} 
res = A &~B; 
// 4. Diferença Simétrica (A Δ B) -> Resultado: {1, 2, 5, 6}
res = A ^ B;
```

Ou pra transformar o A no resultado

```cpp
A|=B;
A&=B;
A&=~B;
A^=B;
```

Intersecção entre vários sets

```cpp
vector<bitset<MAX>> sets; // pegar de algum lugar
bitset<MAX> res = sets[0];

for(int i =1;i<n;i++) res &= sets[i];
```
