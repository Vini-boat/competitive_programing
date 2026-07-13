# C++

## Datatypes

(O tamanho pode mudar dependendo da arquitetura e do compilador)

| Type        | Description            | Size (bytes) | Range                   |                                     |
| ----------- | ---------------------- | ------------ | ----------------------- | ----------------------------------- |
| `int`       | 32-bit integer         | 4            | $-2^{31}$ to $2^{31}-1$ | $\approx -2*10^9$ to $2*10^9$       |
| `long long` | 64-bit integer         | 8            | $−2^{63}$ to $2^{63}-1$ | $\approx -9*10^{18}$ to $9*10^{18}$ |
| `double`    | Double-precision float | 8            |                         |                                     |
| `bool`      | True/False value       | 1            | 0 or 1                  |                                     |
| `char`      | 8-bit character        | 1            | $−2^7$ to $2^7-1$       | -256 to 256                         |


## Tuplas

da pra fazer pra ter elementos com mais de um tipo de dados
como se fosse um strunct anonimo;

```cpp

vector<
    tuple<size_t,string,int>
> cows(N);


for(auto& [id, name, weight] : cows){
    cin >> id >> name >> weight;
}


for(auto& [id, name, weight] : cows){
    cout << id << " " << name "" << weight << endl;
}
```

nesse caso tbm poderia ser usado uma struct