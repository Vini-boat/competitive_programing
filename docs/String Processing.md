# String Processing em C++ — Notebook de Competitive Programming

Gerado pelo Claude

Snippets enxutos de recursos da linguagem/STL para manipular strings. Sem algoritmos de string (KMP, Z-function, etc.) — só ferramentas de C++ que facilitam parsing, formatação e manipulação no dia da prova.

```cpp
#include <bits/stdc++.h>
using namespace std;
```

---

## 1. Conversões string <-> número

`stoi/stol/stoll/stoull/stod` — O(n). Lançam `invalid_argument`/`out_of_range` se inválido.
`to_string` — O(n).

```cpp
int x = stoi("123");
long long y = stoll("123456789012");
double d = stod("3.14");
string s = to_string(42); // "42"
```

---

## 2. Leitura de entrada

`cin >> s` lê um token (sem espaços). `getline(cin, s)` lê a linha inteira (incluindo espaços).
Cuidado: `getline` depois de `cin >>` pega o `\n` restante — precisa de `cin.ignore()`.

```cpp
string s;
cin >> s;              // lê 1 token
cin.ignore();           // descarta '\n' pendente
getline(cin, s);        // lê linha inteira

// ler N linhas
int n; cin >> n; cin.ignore();
vector<string> lines(n);
for (auto &l : lines) getline(cin, l);
```

---

## 3. stringstream para parsing

`istringstream` — tokeniza uma linha quando não se sabe quantos valores ela tem. O(n) no total.
`ostringstream` — "string builder", evita concatenar strings com `+` repetidamente.

```cpp
// parsing de quantidade desconhecida de inteiros numa linha
string line = "3 7 42 100";
istringstream iss(line);
vector<int> v; int val;
while (iss >> val) v.push_back(val);

// misturar tipos na mesma linha
istringstream iss2("Alice 25 3.5");
string name; int age; double gpa;
iss2 >> name >> age >> gpa;

// string builder eficiente
ostringstream oss;
for (int i = 0; i < 5; i++) oss << i << ",";
string result = oss.str(); // "0,1,2,3,4,"
```

---

## 4. Split por delimitador

```cpp
// split por delimitador de 1 char (usa getline com stringstream)
vector<string> split(const string &s, char delim) {
    vector<string> tokens;
    stringstream ss(s);
    string item;
    while (getline(ss, item, delim)) tokens.push_back(item);
    return tokens;
}
// split("a,b,,c", ',') -> {"a","b","","c"}

// split por espaços (whitespace) usando >>
vector<string> splitWS(const string &s) {
    istringstream iss(s);
    return vector<string>{istream_iterator<string>(iss), istream_iterator<string>()};
}
```

---

## 5. Join

```cpp
string join(const vector<string> &v, const string &sep) {
    ostringstream oss;
    for (size_t i = 0; i < v.size(); i++) {
        if (i) oss << sep;
        oss << v[i];
    }
    return oss.str();
}
```

---

## 6. Trim (espaços nas pontas) — O(n)

```cpp
string trim(const string &s) {
    size_t a = s.find_first_not_of(" \t\n\r");
    if (a == string::npos) return "";
    size_t b = s.find_last_not_of(" \t\n\r");
    return s.substr(a, b - a + 1);
}
```

---

## 7. Maiúsculas / minúsculas — O(n)

```cpp
transform(s.begin(), s.end(), s.begin(), ::tolower);
transform(s.begin(), s.end(), s.begin(), ::toupper);

// cuidado com char sinalizado: para chars fora do ASCII básico,
// prefira: ::tolower((unsigned char)c)
```

---

## 8. Reverse / Sort — O(n) e O(n log n)

```cpp
reverse(s.begin(), s.end());
sort(s.begin(), s.end());              // ordena caracteres
sort(s.rbegin(), s.rend());            // ordem decrescente
```

---

## 9. Substrings e busca

`substr(pos, len)` — O(len). `find/rfind/find_first_of/find_last_of` — O(n·m) no pior caso (implementação simples, não KMP).

```cpp
string s = "hello world";
string sub = s.substr(6, 5);           // "world"
size_t p = s.find("world");            // posição, ou string::npos se não achar
size_t p2 = s.rfind("o");              // última ocorrência
size_t p3 = s.find_first_of("aeiou");  // primeira vogal
size_t p4 = s.find_last_of("aeiou");   // última vogal
if (p != string::npos) { /* achou */ }
```

---

## 10. Remover caracteres (erase-remove idiom) — O(n)

```cpp
// remover todos os espaços
s.erase(remove(s.begin(), s.end(), ' '), s.end());

// remover caracteres que satisfazem um predicado (ex: tudo que não é dígito)
s.erase(remove_if(s.begin(), s.end(), [](char c){ return !isdigit((unsigned char)c); }), s.end());
```

---

## 11. Replace

```cpp
// substituir 1 ocorrência
size_t pos = s.find("foo");
if (pos != string::npos) s.replace(pos, 3, "bar"); // (pos, len, novo)

// substituir TODAS as ocorrências de uma substring
string replaceAll(string s, const string &from, const string &to) {
    size_t pos = 0;
    while ((pos = s.find(from, pos)) != string::npos) {
        s.replace(pos, from.size(), to);
        pos += to.size();
    }
    return s;
}
```

---

## 12. Comparação lexicográfica

```cpp
string a = "abc", b = "abd";
a < b;                 // true, compara lexicograficamente (operator< já sobrecarregado)
a.compare(b);           // <0, 0, >0

// para ordenar por critério customizado (ex: por tamanho, depois lexicográfico)
sort(v.begin(), v.end(), [](const string &x, const string &y){
    if (x.size() != y.size()) return x.size() < y.size();
    return x < y;
});
```

---

## 13. `<cctype>` — classificação de char (O(1) cada)

```cpp
isalpha(c); isdigit(c); isalnum(c);
isupper(c); islower(c); isspace(c); ispunct(c);
// sempre castar pra unsigned char pra evitar UB com char negativo:
isalpha((unsigned char)c);
```

---

## 14. Frequência de caracteres — O(n)

```cpp
// alfabeto minúsculo conhecido -> array é mais rápido que map
int freq[26] = {};
for (char c : s) freq[c - 'a']++;

// alfabeto arbitrário / unicode simplificado -> map
unordered_map<char,int> freqMap;
for (char c : s) freqMap[c]++;
```

---

## 15. Concatenação eficiente

`+=` amortizado O(1) por char (realoca geometricamente). Evitar `s = s + c` em loop (cria string nova a cada vez). Para tamanho conhecido, `reserve` evita realocações.

```cpp
string s;
s.reserve(1000000);       // evita realocações se o tamanho final é conhecido
for (int i = 0; i < n; i++) s += c; // O(1) amortizado
```

---

## 16. string <-> vector<char> / char array

```cpp
string s = "hello";
vector<char> v(s.begin(), s.end());
string s2(v.begin(), v.end());

char buf[100];
strcpy(buf, s.c_str());    // string -> char*
string s3(buf);            // char* -> string

const char* cs = s.c_str(); // ponteiro só-leitura, válido até s mudar
```

---

## 17. Formatação / padding de números

```cpp
// leading zeros / largura fixa
ostringstream oss;
oss << setw(5) << setfill('0') << 42;
string padded = oss.str();   // "00042"

// casas decimais fixas
ostringstream oss2;
oss2 << fixed << setprecision(2) << 3.14159;
string s = oss2.str();       // "3.14"

// printf-style (cuidado com buffer)
char buf[64];
snprintf(buf, sizeof(buf), "%05d", 42);
string s2(buf);
```

---

## 18. Truque útil: checar rotação de string — O(n)

`s` é rotação de `t` se `t` é substring de `s+s` (mesmo tamanho). Usa só `find`, sem algoritmo extra.

```cpp
bool isRotation(const string &s, const string &t) {
    return s.size() == t.size() && (s + s).find(t) != string::npos;
}
```

---

## 19. Compressão / indexação de strings

```cpp
// mapear strings distintas para inteiros (útil pra reduzir strings a IDs)
unordered_map<string,int> id;
vector<string> names;
int getId(const string &s) {
    auto it = id.find(s);
    if (it != id.end()) return it->second;
    id[s] = names.size();
    names.push_back(s);
    return id[s];
}
```

---

## 20. I/O rápido (importante quando há muita string)

```cpp
ios_base::sync_with_stdio(false);
cin.tie(nullptr);
// evita misturar com scanf/printf depois disso
```

---

## 21. `<regex>` (usar com moderação — pode ser lento)

```cpp
#include <regex>
regex re(R"(\d+)");                 // raw string evita escapar \\
smatch m;
string s = "abc123def456";
while (regex_search(s, m, re)) {
    cout << m[0] << "\n";
    s = m.suffix();
}

// checar se casa inteiro
bool ok = regex_match("12345", regex(R"(\d+)"));
```

---

## 22. bitset <-> string — O(n)

```cpp
bitset<8> b(string("10110010"));
string s = b.to_string();
```