USAR A STDERR PARA DEBUGAR (não é identificado pelo CJ) (MENTIRA)

Macro para debug

```cpp
#define dbg cerr << "[DBG]:" << __LINE__ << ": "

dbg << "x: " << x;

```

Escrever e ler de arquivos como se fosse stdout

```cpp
#include <cstdio>
using namespace std;

int main() {
	freopen("template.in", "r", stdin);
	freopen("template.out", "w", stdout);
}
```


Capturar valor até não ser bem sucedido

```cpp
int a,b;

while(std::cin >> a >> b){
	...
}
```

ou com o `scanf()`

```c
int a,b;

// o scanf retorna o numero de leituras bem sucedidas
while(scanf("%d %d", &a,&b) == 2){
	...
}

```

----

## Velocidade de I/O

```cpp
// LENTO (Pode dar Time Limit Exceeded em saídas gigantes)
cout << resposta << endl;

// RÁPIDO
cout << resposta << "\n";
```

## Formatação de saída \<iomanip\>

| **Função**        | **O que faz**                   | **Persistência**       |
| ----------------- | ------------------------------- | ---------------------- |
| `setprecision(n)` | Define precisão numérica        | **Permanente**         |
| `fixed`           | Força formato decimal (sem 1e9) | **Permanente**         |
| `setw(n)`         | Define largura mínima do campo  | **Só o próximo valor** |
| `setfill(c)`      | Caractere de preenchimento      | **Permanente**         |
| `left` / `right`  | Alinha texto à esq/dir          | **Permanente**         |

### Precisão decimal 

- `fixed` força a notação decimal
- `setprecision(n)` define as casas DEPOIS da vírgula

```cpp
double pi = 3.1415926535;

cout << fixed << setprecision(2) << pi << "\n"; // Saída: 3.14 
cout << fixed << setprecision(9) << pi << "\n"; // Saída: 3.141592654 (arredonda)
```


### Zeros à Esquerda

- `setw(n)` define a largura do próximo campo.
- `setfill(c)` define o caractere que preenche o espaço vazio.

```cpp
int horas = 9;
int minutos = 5;

// Sem formatação: 9:5
cout << horas << ":" << minutos << "\n"; 

// Com formatação: 09:05
cout << setfill('0') << setw(2) << horas << ":";
cout << setfill('0') << setw(2) << minutos << "\n";
```

Printar ----
```cpp
cout << string(50, '-') << '\n';
```

Ver espaços

```shell
cat out.txt | tr ' ' '.'
```

Ver fim de linha e tab

```shell
cat -A out.txt
```

----

`cin.ignore()` e `cin.peek()` se se sabe que sobrou exatamente um `\n`
```cpp
if (cin.peek() == '\n') cin.ignore();
```

Usar entre `cin >> n` e `getline(cin,s)`
```cpp
void ignoreLine() {
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
}
```

ex:

```cpp
void main(){
	int n; cin >> n;
	cin.ignore(numeric_limits<streamsize>::max(), '\n');
	string s; getline(cin,s);
}
```

`getline()` com `stringstream` pra `.split()`
pegar um `vector<vector<int>>` sem saber o tamanho de cada linha
```cpp
int n = 4; // quantidade de linhas
vector<vector<int>> vec(n);
for(int i=0;i<n;i++){
	string s; getline(cin,s);
	stringstream ss(s);
	for(int t; ss >> t;) vec[i].pb(t);
}
```
printar sem trailing space `.join()`
```cpp
for(int i=0;i<n;i++) cout << vec[i] << (i==n-1 ? "" : " ");
cout << endl;
```
