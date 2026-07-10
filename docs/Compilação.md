Comando básico

```shell
g++ main.cpp -o main
```

Completo

- `-std=c++17` define a versão
- `-O2` define o nível de otimização
- `-Wall -Wextra -Wshadow` Ativa avisos de tempo de compilação

```shell
g++ main.cpp -o main -std=c++17 -O2 -Wall -Wextra -Wshadow
```

Debug

- `-g` adiciona símbolos de debug DEIXA MAIS LENTO
- `-fsanitize=address` pega erros de acesso a vetor
- `-fsanitize=undefined` pega erros matemáticos

```shell
g++ main.cpp -o main -std=c++17 -g -fsanitize=address -fsanitize=undefined
```

Rodar

```shell
./main
```

Rodar com arquivo de input

```shell
./main < input.txt
```

FAZ O SCRIPT MOSTRAR O PWD DO ARQUIVO PRA NÃO COMPILAR O ERRADO PELO AMOR DE DEUS

---

Se o compilador for o GCC

Atalho para importar toda a Biblioteca padrão de uma vez só
```cpp
#include <bits/stdc++.h>
```

`main.cpp`

```cpp
#include <bits/stdc++.h>
using namespace std;

// --- ATALHOS (Typedefs) ---
using ll = long long;        // Para não ter que digitar long long toda hora
using pii = pair<int, int>;  // Par de inteiros (muito usado em grafos/grids)
using vi = vector<int>;      // Vetor de inteiros
using vvi = vector<vector<int>>;

// --- CONSTANTES ---
const int INF = 1e9;         // Infinito para int (1 bilhão)
const ll LLINF = 4e18;       // Infinito para long long
const double EPS = 1e-9;     // Para comparações de float/double

// --- MACROS (Opcional, mas muito usado) ---
#define pb push_back
#define all(x) x.begin(), x.end()  // Agiliza sort(all(v))
#define sz(x) (int)(x).size()

#define endl '\n'

#ifdef VINI_DEBUG
template<typename T>
void debug(const T& a) {cerr << a << '\n';}
template<typename T, typename... Args>
void debug(const T& a, Args... r) {cerr << a << " "; debug(r...);}
#define dbg(...) cerr << "[" << #__VA_ARGS__ << "] ", debug(__VA_ARGS__)
#else
#define dbg(...)
#endif

int main() {
    // --- OTIMIZAÇÃO DE I/O (ESSENCIAL) ---
    // Desliga a sincronia entre C e C++ (scanf vs cin) e o flush automático
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

}
```
