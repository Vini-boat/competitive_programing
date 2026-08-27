---
title: Algoritmo de Euclides
author: Vinicius de Ávila Bezerra
---

> **CPH:** 21.1 Euclid's algorithm, p. 200 · 21.3 Diophantine equations (Euclides estendido), p. 204

> **IUSACO:** 13.2 GCD and LCM, p. 64

> **USACO Guide:** <https://usaco.guide/gold/divisibility?lang=cpp>

> **Relacionado:** `MDC e MMC.md` (o `std::gcd`/`std::lcm` já resolvem o caso simples),

> `00-TODO-Chinese Remeider Theorem.md`

**Gatilho:** gcd/lcm; resolver `ax + by = c` em inteiros; inverso modular quando o módulo
**não** é primo (quando é primo, dá pra usar o `fast_exp` do `Módulo.md`).

<!-- corpo: escrever com as minhas palavras -->
