---
    title: Complete Search With Recursion
    author: Vinicius de Ávila Bezerra
---

> **CPH:** 5.1 Generating subsets p. 47, 5.2 Generating permutations p. 49,
> 5.3 Backtracking p. 50, 5.4 Pruning the search p. 51


# Subsets

Percorrer todos os subsets é $O(2^N)$
Então o N não pode ser maior que uns 22

## Recursiva

```cpp
void search(int k) {
    if (k == n) {
        // process subset
    } else {
        search(k+1);
        subset.push_back(k);
        search(k+1);
        subset.pop_back();
    }
}
```

## Bitmask

```cpp
for(int subset =0; subset < (1<<N); subset++){
    for(int i = 0; i < N; i++){
        if(subset & (1<<i)){
            // do something if element in subset
        }
    }
}

```


# Permutations

Percorrer todos as permutações é $O(N!)$
Então o N não pode ser maior que uns 7

## Recursiva

não tem muito pq então vou só deixar aqui mas eu sempre uso a do STL

```cpp

```

## STL

Exemplo de string, mas funciona pra qqr container que tenha iterators

Precisa ser ordenado entes. Pois a `std::next_permutation()` retorna `false` quando chega na permutação em que todos os elementos estão ordenados. Então se não estiver ordenado, ele vai "ignorar" as permutações anteriores lexicograficamente. 

```cpp

string str = "abcdefghijk";

sort(all(str));

do {

    // process permutation
    cout << str << '\n';

} while(next_permutation(all(str)));


```

# Backtracking

Basicamente é fazer um bfs no solution space. Voltando quando uma possibilidade não da mais certo.
Normalmente envolve uma função recursiva `search()`
É um dos casos que ter variáveis globais de estado facilitam a vida.

A estrutura conceitual é mais ou menos essa:

```cpp

vector<int> state(N);

void search(int c){
    if(/* chegou no final*/) return;

    for(/* pra todas as possibilidades de "movimentos" */){
        state[i] = true;
        search(c+1);
        state[i] = false;
    }
}

```

A moral principal é saber como fazer o "pruning" que é saber quando um estado não vai poder gerar uma solução válida e pode ser ignorado.