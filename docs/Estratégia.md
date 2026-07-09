# Cheiros

| Fala sobre / Pede                                            | Provavelmente           |
| ------------------------------------------------------------ | ----------------------- |
| Próximo elemento maior/menor                                 | Monotonic Stack         |
| Procurar elemento específico                                 | Set/HashMap             |
| Menor distância em grafo/matriz                              | BFS                     |
| Validar estrutura aninhada                                   | Stack                   |
| Acessar o maior/menor elemento.<br>Inserir de forma ordenada | Heap                    |
| Escolha melhor atual é a melhor sempre                       | Greedy                  |
| N muito pequeno (<= 1000)                                    | Brute Force             |
| Menor distância em grafo com pesos                           | Dijkstra                |
| Segmentos Contiguos validos                                  | Sliding Window Variável |
| Maior soma de K itens contiguos                              | Sliding Window Fixo     |
# Complexidade vs Limite de Tempo

| **Tamanho de N** | **Complexidade Aceitável** | **Estratégia / Algoritmo**              | Entendo               |
| ---------------- | -------------------------- | --------------------------------------- | --------------------- |
| $N \le 11$       | $O(N!)$                    | Permutações (`std::next_permutation`)   | Sim                   |
| $N \le 20$       | $O(2^N)$                   | Força Bruta / Máscara de Bits (Bitmask) | Sim / Sim             |
| $N \le 500$      | $O(N^3)$                   | Floyd-Warshall / DP 3D                  | Não / Não             |
| $N \le 5000$     | $O(N^2)$                   | Loops duplos / DPs clássicas            | Sim / Sim             |
| $N \le 10^5$     | $O(N\log N)$               | Sort, Busca Binária, Map/Set, Dijkstra  | Sim / Sim / Sim / Não |
| $N \le 10^7$     | $O(N)$                     | Two Pointers, Prefix Sum, Greedy        | Sim / Sim / Sim       |

# Estratégias

- Ler todos os problemas primeiro
	- Caso a solução seja óbvia resolver para tirar da frente
- Começar pelos mais fáceis pra ir pensando sobre os difíceis
- SEMPRE resolver os casos na mão antes
- Tentar resolver uma versão mais simples do problema
	- Diminuir algum valor
	- Ordenar o vetor
- Só faz na força bruta
- Visualize o problema
	- Estrutura implícita
- Tenta resolver ao contrário / de trás pra frente