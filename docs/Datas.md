# Datas em C++ — Notebook de Competitive Programming (ad-hoc)

Gerado pelo Claude

Snippets pra converter, comparar, somar/subtrair e consultar datas do calendário gregoriano. Foco em soluções O(1)/O(n) sem depender de bibliotecas externas (só `<chrono>` do C++20, que nem todo judge aceita — por isso o núcleo é manual).

```cpp
#include <bits/stdc++.h>
using namespace std;
```

---

## 1. Ano bissexto — O(1)

```cpp
bool isLeap(int y) {
    return (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
}
```

---

## 2. Dias no mês — O(1)

```cpp
int daysInMonth(int y, int m) {
    static int d[] = {31,28,31,30,31,30,31,31,30,31,30,31};
    if (m == 2 && isLeap(y)) return 29;
    return d[m-1]; // m em 1..12
}
```

---

## 3. Data <-> número de dias (dias desde uma época fixa) — O(1)

O truque central de quase todo problema de data: converter (y,m,d) para um inteiro absoluto de dias e vice-versa. Assim, diferença de datas, soma/subtração e comparação viram aritmética de inteiro. Algoritmo de Howard Hinnant, funciona para datas proléticas (inclusive antes de 1970 e anos negativos).

```cpp
// dias desde 1970-01-01 (pode ser negativo para datas anteriores)
long long daysFromCivil(int y, unsigned m, unsigned d) {
    y -= m <= 2;
    long long era = (y >= 0 ? y : y - 399) / 400;
    unsigned yoe = (unsigned)(y - era * 400);                // 0..399
    unsigned doy = (153 * (m + (m > 2 ? -3 : 9)) + 2) / 5 + d - 1; // 0..365
    unsigned doe = yoe * 365 + yoe/4 - yoe/100 + doy;          // 0..146096
    return era * 146097 + (long long)doe - 719468;
}

// inverso: número de dias (desde 1970-01-01) -> (ano, mes, dia)
void civilFromDays(long long z, int &y, unsigned &m, unsigned &d) {
    z += 719468;
    long long era = (z >= 0 ? z : z - 146096) / 146097;
    unsigned doe = (unsigned)(z - era * 146097);               // 0..146096
    unsigned yoe = (doe - doe/1460 + doe/36524 - doe/146096) / 365; // 0..399
    y = (int)(yoe) + (int)(era * 400);
    unsigned doy = doe - (365*yoe + yoe/4 - yoe/100);           // 0..365
    unsigned mp = (5*doy + 2)/153;                              // 0..11
    d = doy - (153*mp+2)/5 + 1;                                 // 1..31
    m = mp + (mp < 10 ? 3 : -9);                                // 1..12
    y += (m <= 2);
}
```

---

## 4. Struct simples de data + comparação — O(1)

```cpp
struct Date {
    int y; unsigned m, d;
    long long toDays() const { return daysFromCivil(y, m, d); }
    bool operator<(const Date &o) const { return toDays() < o.toDays(); }
    bool operator==(const Date &o) const { return y==o.y && m==o.m && d==o.d; }
};
```

---

## 5. Diferença entre duas datas (em dias) — O(1)

```cpp
long long diffDays(int y1, int m1, int d1, int y2, int m2, int d2) {
    return daysFromCivil(y2, m2, d2) - daysFromCivil(y1, m1, d1);
}
```

---

## 6. Somar/subtrair dias de uma data — O(1)

```cpp
void addDays(int y, unsigned m, unsigned d, long long delta, int &ry, unsigned &rm, unsigned &rd) {
    long long z = daysFromCivil(y, m, d) + delta;
    civilFromDays(z, ry, rm, rd);
}
```

---

## 7. Dia da semana — O(1)

`daysFromCivil` conta a partir de 1970-01-01, que foi **quinta-feira**. Então `(dias % 7 + 7) % 7` dá o deslocamento a partir de quinta.

```cpp
// 0=domingo, 1=segunda, ..., 6=sabado
int weekday(int y, unsigned m, unsigned d) {
    long long z = daysFromCivil(y, m, d);
    return (int)(((z % 7) + 7 + 4) % 7); // +4 porque 1970-01-01 é dia 4 (quinta)
}
const string WD[] = {"domingo","segunda","terca","quarta","quinta","sexta","sabado"};
```

Alternativa clássica sem precisar de `daysFromCivil` — **congruência de Zeller**:

```cpp
// 0=sabado, 1=domingo, ..., 6=sexta (cuidado com a convenção diferente)
int zeller(int y, int m, int d) {
    if (m < 3) { m += 12; y--; }
    int k = y % 100, j = y / 100;
    return (d + 13*(m+1)/5 + k + k/4 + j/4 + 5*j) % 7;
}
```

---

## 8. Validar data — O(1)

```cpp
bool isValidDate(int y, int m, int d) {
    if (m < 1 || m > 12) return false;
    if (d < 1 || d > daysInMonth(y, m)) return false;
    return true;
}
```

---

## 9. Quantidade de dias bissextos / dias entre anos — O(1)

```cpp
// quantidade de anos bissextos em [1, y]
long long leapsUpTo(int y) {
    if (y <= 0) return 0;
    return y/4 - y/100 + y/400;
}
// quantidade de anos bissextos no intervalo [y1, y2]
long long leapsInRange(int y1, int y2) {
    return leapsUpTo(y2) - leapsUpTo(y1 - 1);
}
```

---

## 10. Dia do ano (1..365/366) — O(1)

```cpp
int dayOfYear(int y, int m, int d) {
    return (int)(daysFromCivil(y,m,d) - daysFromCivil(y,1,1)) + 1;
}
```

---

## 11. Parsing de data a partir de string — O(n)

```cpp
// formato "YYYY-MM-DD"
Date parseDate(const string &s) {
    int y, m, d;
    sscanf(s.c_str(), "%d-%d-%d", &y, &m, &d);
    return {y, (unsigned)m, (unsigned)d};
}

// formato "DD/MM/YYYY"
Date parseDateBR(const string &s) {
    int d, m, y;
    sscanf(s.c_str(), "%d/%d/%d", &d, &m, &y);
    return {y, (unsigned)m, (unsigned)d};
}
```

---

## 12. Formatando data pra output — O(1)

```cpp
string formatDate(int y, unsigned m, unsigned d) {
    char buf[16];
    snprintf(buf, sizeof(buf), "%04d-%02u-%02u", y, m, d);
    return string(buf);
}
```

---

## 13. `<chrono>` (C++20) — alternativa pronta, se o judge suportar

Cheque suporte antes da prova (Codeforces/CSES aceitam C++20; alguns judges não). Vantagem: já vem com aritmética de calendário, dia da semana, validação, etc. `sys_days` é o análogo do "número de dias" acima.

```cpp
#include <chrono>
using namespace std::chrono;

year_month_day ymd{year{2024}/month{3}/day{15}};
sys_days sd = sys_days(ymd);                 // converte para dias desde epoch
sys_days sd2 = sd + days{10};                // soma 10 dias
year_month_day ymd2 = sd2;                   // volta pra y/m/d

weekday wd = weekday(sd);                    // dia da semana (0=domingo)
bool valid = ymd.ok();                       // valida data
long long diff = (sd2 - sd).count();         // diferença em dias
bool leap = ymd.year().is_leap();
```

---

## 14. Tabela de referência rápida

| Operação | Snippet |
|---|---|
| dias entre A e B | `daysFromCivil(B) - daysFromCivil(A)` |
| somar N dias | `civilFromDays(daysFromCivil(date) + N)` |
| dia da semana | `weekday()` ou `zeller()` |
| validar | `isValidDate()` |
| bissexto | `isLeap()` |
| comparar datas | converter ambas com `daysFromCivil` e comparar inteiros |