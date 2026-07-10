---
  title: Conversão de Base de números 
  author: Vinicius de Ávila Bezerra
---

# String para Int

## Usar a Função `stoi()`

```cpp
int stoi(const string& str, size_t* pos = nullptr, int base = 10);
```

o `pos` é a posição da string que ele parou de ler. Normalmente não é necessário, mas da pra fazer coisas tipo:
o `stoi()` aceita bases de 2 a 36 (digitos + alfabeto)

também existem similares `stol()`, `stoll()` e `stof()`

```cpp
string s = "123,456";

size_t pos;
int a = stoi(s, &pos);        // 123
int b = stoi(s.substr(pos+1)); // 456
```

Exemplo de bases diferentes: 

```cpp
stoi("1010", nullptr, 2);   // 10
stoi("17",   nullptr, 8);   // 15
stoi("FF",   nullptr, 16);  // 255
stoi("Z",    nullptr, 36);  // 35
stoi("10",   nullptr, 36);  // 36
```


# Decimal para qualquer base

## Usando o `<iomanip>`

ALTERA ATÉ SER MUDADO NOVAMENTE

Funciona somente para essas bases:

```cpp
cout << dec << 255 << '\n';          // 255
cout << hex << 255 << '\n';          // ff
cout << uppercase << hex << 255;     // FF
cout << oct << 255 << '\n';          // 377
cout << bitset<8>(255) << '\n';      // 11111111
```



## Para uma base arbitrária:

```cpp
string toBase(long long x, int base) {
    const string digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    string ans;

    do {
        ans += digits[x % base];
        x /= base;
    } while (x);

    reverse(ans.begin(), ans.end());
    return ans;
}
```

