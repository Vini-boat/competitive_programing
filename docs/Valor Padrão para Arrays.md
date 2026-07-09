Só funciona confiavelmente para 0 e -1, pois o `memset` escreve um int8. então vai ficar tudo 0, com o `memset 0`, ou tudo 1, com o `memset -1`.

```cpp
int dp[1005];
memset(dp, -1, sizeof(dp)); // Enche tudo com -1
memset(dp, 0, sizeof(dp));  // Enche tudo com 0
```

Ou da pra usar com vetores com

```cpp
int size = 1005;
vector<int> dp(size;0);
vector<int> dp(size;-1);
vector<int> dp(size;99);
```
