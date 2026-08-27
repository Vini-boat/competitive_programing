---
title: TODO
author: Vinicius de Ávila Bezerra
---

# 00-TODO-Algoritmo de Euclides


> **CPH:** 21.1 Euclid's algorithm, p. 200 · 21.3 Diophantine equations (Euclides estendido), p. 204

> **IUSACO:** 13.2 GCD and LCM, p. 64

> **USACO Guide:** <https://usaco.guide/gold/divisibility?lang=cpp>

> **Relacionado:** `MDC e MMC.md` (o `std::gcd`/`std::lcm` já resolvem o caso simples),

> `00-TODO-Chinese Remeider Theorem.md`

**Gatilho:** gcd/lcm; resolver `ax + by = c` em inteiros; inverso modular quando o módulo
**não** é primo (quando é primo, dá pra usar o `fast_exp` do `Módulo.md`).

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Chinese Remeider Theorem


> **CPH:** 21.3 Chinese remainder theorem, p. 205 — só a matemática, sem código, e **exige módulos coprimos**

> **cp-algorithms:** <https://cp-algorithms.com/algebra/chinese-remainder-theorem.html>
> tem a `chinese_remainder_theorem()` em C++ e cobre o caso de módulos **não** coprimos

> **USACO Guide:** <https://usaco.guide/gold/modular?lang=cpp>

> **Relacionado:** `00-TODO-Grafos Funcionais.md`, `00-TODO-Algoritmo de Euclides.md`,
> `Módulo.md` (`fast_exp` pro inverso quando o módulo é primo)

**Gatilho:** ciclos de tamanhos **diferentes** e você quer saber quando eles se alinham.

⚠️ Antes de ir pro CRT: cheque se o problema resolve com `K % tamanho_do_ciclo` em cada ciclo
separado (ver `00-TODO-Grafos Funcionais.md`). Foi o que faltou na B da SBC ICPC 2025 — o CRT
parecia necessário e não era.

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Containers


> **CPH:** cap. 4 Data structures, p. 35–46 — 4.1 Dynamic arrays p. 35, 4.2 Set p. 37,
> 4.3 Map p. 38, 4.4 Iterators and ranges p. 39, 4.5 bitset/deque/stack/queue/priority_queue p. 41–43,
> 4.6 Comparison to sorting p. 44

> **IUSACO:** cap. 4 Built-in Data Structures, p. 10–17

> **USACO Guide:** <https://usaco.guide/bronze/intro-ds?lang=cpp> ·
> <https://usaco.guide/silver/priority-queues?lang=cpp>

> **Relacionado:** `Set.md`, `BitSet.md`

**Gatilho:** "acessar o maior/menor atual" → `priority_queue`; "esse elemento existe?" → `set`/`map`;
"insere e remove nas duas pontas" → `deque`.

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Disjoint Set Union


> **CPH:** 15.2 Union-find structure, p. 145–147 (**tem o código em C++**)

> **IUSACO:** 10.6 Disjoint-Set Data Structure, p. 49–52

> **USACO Guide:** <https://usaco.guide/gold/dsu?lang=cpp>

> **Relacionado:** CPH 15.1 Kruskal's algorithm p. 142 (MST usa DSU por dentro)

**Gatilho:** juntar grupos e perguntar "esses dois estão no mesmo grupo?"; componentes conexas
quando as arestas vão chegando aos poucos (em vez de BFS/DFS do zero a cada vez).

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Dynamic Programing


> **CPH:** cap. 7, p. 65–76 — 7.1 Coin problem p. 65, 7.2 Longest increasing subsequence p. 70,
> 7.3 Paths in a grid p. 71, 7.4 Knapsack problems p. 72, 7.5 Edit distance p. 74.
> Também 10.5 Bitmask DP p. 102 e 16.2 DP em DAG p. 151.

> **IUSACO:** não cobre DP (o livro para no Silver)

> **USACO Guide:** <https://usaco.guide/gold/intro-dp?lang=cpp> ·
> <https://usaco.guide/gold/knapsack?lang=cpp> · <https://usaco.guide/gold/lis?lang=cpp> ·
> <https://usaco.guide/gold/paths-grids?lang=cpp> · <https://usaco.guide/gold/dp-bitmasks?lang=cpp>

**Gatilho:** "de quantas formas", "menor/maior custo pra chegar em", e a decisão atual depende
só de um estado pequeno — não de todo o histórico.

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Grafos Funcionais


> **CPH:** 16.3 Successor paths, p. 154 (binary lifting pro k-ésimo sucessor) ·
> 16.4 Cycle detection, p. 155–156 (**Floyd com código em C++**)

> **USACO Guide:** <https://usaco.guide/silver/func-graphs?lang=cpp>

> **Relacionado:** `00-TODO-Simulation.md`, `00-TODO-Chinese Remeider Theorem.md`

**Gatilho:** cada elemento tem **exatamente um** sucessor — permutação, embaralhamento,
"cada vaca aponta pra uma vaca" — e/ou o K é grande demais pra simular passo a passo.

Ideia central: decompor em ciclos e usar `K % tamanho_do_ciclo`. Só precisa de CRT quando for
**alinhar ciclos de tamanhos diferentes**.

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Simulation


> **CPH:** — (não tem capítulo sobre isso)
> **IUSACO:** cap. 5 Simulation, p. 19–21
> **USACO Guide:** <https://usaco.guide/bronze/simulation?lang=cpp>
> **Relacionado:** `00-TODO-Grafos Funcionais.md`

**Gatilho:** o enunciado descreve um processo passo a passo e o número de passos cabe no tempo.

⚠️ Se o número de passos for gigante (1e9, 1e18), **não é simulação** — é grafo funcional /
ciclo. Ver `00-TODO-Grafos Funcionais.md`.

<!-- corpo: escrever com as minhas palavras -->

# 00-TODO-Two Pointers


> **CPH:** 8.1 Two pointers method, p. 77–79

> **IUSACO:** 14.1 Two Pointers, p. 66

> **USACO Guide:** <https://usaco.guide/silver/two-pointers?lang=cpp>

> **Relacionado:** CPH 8.2 Nearest smaller elements p. 79 (→ `Monotonic Stack.md`),
> CPH 8.3 Sliding window minimum p. 81 (→ `Sliding Window.md`)

**Gatilho:** subarray contíguo com condição monotônica; par que soma X em array ordenado.

<!-- corpo: escrever com as minhas palavras -->

