---
title: Grafos Funcionais (ciclos e K passos)
author: Vinicius de Ávila Bezerra
---

> **CPH:** 16.3 Successor paths, p. 154 (binary lifting pro k-ésimo sucessor) ·
> 16.4 Cycle detection, p. 155–156 (**Floyd com código em C++**)

> **USACO Guide:** <https://usaco.guide/silver/func-graphs?lang=cpp>

> **Relacionado:** `00-TODO-Simulation.md`, `00-TODO-Chinese Remeider Theorem.md`

**Gatilho:** cada elemento tem **exatamente um** sucessor — permutação, embaralhamento,
"cada vaca aponta pra uma vaca" — e/ou o K é grande demais pra simular passo a passo.

Ideia central: decompor em ciclos e usar `K % tamanho_do_ciclo`. Só precisa de CRT quando for
**alinhar ciclos de tamanhos diferentes**.

<!-- corpo: escrever com as minhas palavras -->
