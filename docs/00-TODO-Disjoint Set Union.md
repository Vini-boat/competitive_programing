---
title: Disjoint Set Union (Union-Find)
author: Vinicius de Ávila Bezerra
---

> **CPH:** 15.2 Union-find structure, p. 145–147 (**tem o código em C++**)

> **IUSACO:** 10.6 Disjoint-Set Data Structure, p. 49–52

> **USACO Guide:** <https://usaco.guide/gold/dsu?lang=cpp>

> **Relacionado:** CPH 15.1 Kruskal's algorithm p. 142 (MST usa DSU por dentro)

**Gatilho:** juntar grupos e perguntar "esses dois estão no mesmo grupo?"; componentes conexas
quando as arestas vão chegando aos poucos (em vez de BFS/DFS do zero a cada vez).

<!-- corpo: escrever com as minhas palavras -->
