considerando

```cpp
#define un_set unordered_set
#define all(x) x.begin(),x.end()

std::un_set<int> A = {1, 2, 3, 4, 5};
std::un_set<int> B = {3, 4, 5, 6, 7};
std::un_set<int> res; // Conjunto para armazenar o resultado
```

União

```cpp
res = A;
res.insert(all(B)); // [1,2,3,4,5,6,7]
```

Interseção

```cpp
for(int elem : A) if (B.count(elem)) res.insert(elem); // [3,4,5] 
```

Diferença

```cpp
res = A;
for(int elem : B) res.erase(elem); // [1,2]
```

Diferença Simétrica

```cpp
for(int elem : A) if(!B.count(elem)) res.insert(elem);
for(int elem : B) if(!A.count(elem)) res.insert(elem);
// [1,2,6,7]
```

Pegar Unico elemento

```cpp
int elem = A.size() == 1 ? *A.begin() : VALOR_PADRAO;
```