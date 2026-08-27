---
title: Chinese Remainder Theorem
author: Vinicius de Ávila Bezerra
---

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
