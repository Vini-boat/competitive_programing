Tendo os dados:

O vetor JÁ ESTÁ ordenado.
```cpp
std::vector<int> v = {10, 20, 30, 30, 30, 40, 50};
int alvo = 30;
```

Se não estivesse ordenado , usaríamos antes.
```cpp
std::sort(v.begin(),v.end());
```

Apenas verifica se o elemento existe no vetor ($O(log N)$).
```cpp
bool existe = std::binary_search(v.begin(), v.end(), alvo); 
```

Retorna um iterador para o PRIMEIRO elemento que seja `>=` alvo (Maior ou Igual).
```cpp
auto lower = std::lower_bound(v.begin(), v.end(), alvo);
int lower_idx = lower - v.begin(); 
```
Resultado: 2 (índice do primeiro '30')

Retorna um iterador para o PRIMEIRO elemento ESTRITAMENTE MAIOR que o alvo (> alvo).
```cpp
auto upper = std::upper_bound(v.begin(), v.end(), alvo);
int upper_idx = upper - v.begin(); 
```
Resultado: 5 (índice do '40')

Contar Frequência $O(log N)$
Para descobrir quantas vezes um número repete no vetor
```cpp
int frequencia = upper - lower; 
```
Resultado: 3 (pois o índice 5 menos o índice 2 = 3 ocorrências)