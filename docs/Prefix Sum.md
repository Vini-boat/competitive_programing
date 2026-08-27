---
title: Prefix Sum
author: Vinicius de Ávila Bezerra
---

> **CPH:** 9.1 Static array queries, p. 84–85 (1D e 2D)
> **IUSACO:** cap. 11 Prefix Sums, p. 55–58 — 11.2 Two Dimensional Prefix Sums p. 56.
> Explica melhor que o CPH a convenção 1-indexada, que é onde dá ruim.
> **USACO Guide:** <https://usaco.guide/silver/prefix-sums?lang=cpp> ·
> <https://usaco.guide/silver/more-prefix-sums?lang=cpp>
> **Relacionado:** CPH 9.2 Binary indexed tree p. 86 (quando o array **muda** entre as queries)

**Gatilho:** muitas queries de soma em intervalo num array que não muda; soma de subretângulo.
Cuidado com overflow: prefixo de 1e5 valores de 1e9 estoura `int`.

<!-- corpo: escrever com as minhas palavras -->

Time Complexity: O(N+Q)

In C++ we can use std::partial_sum, although it doesn't shorten the code by much.

```cpp
#include <bits/stdc++.h>
using namespace std;

vector<long long> psum(const vector<int> &arr) {
	vector<long long> psums(arr.size() + 1);
	for (int i = 0; i < arr.size(); i++) { psums[i + 1] = psums[i] + arr[i]; }
	// or partial_sum(begin(a), end(a), begin(psums) + 1);
	return psums;
}

int main() {
	int N, Q;
	cin >> N >> Q;
	vector<int> nums(N);
	for (int i = 0; i < N; i++) { cin >> nums[i]; }
	vector<long long> prefix_arr = psum(nums);
	for (int i = 0; i < Q; ++i) {
		int l, r;
		cin >> l >> r;
		cout << prefix_arr[r] - prefix_arr[l] << "\n";
	}
}
```