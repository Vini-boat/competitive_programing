# Janela tamanho fixo

Exemplo de achar o subarray de 4 elementos que tenha a maior soma 

```cpp
vector<int> arr = {1, 4, 2, 10, 2, 3, 1, 0, 20};
int k = 4; // tamanho maximo da janela
int n = arr.size();

// Se o array for menor que a janela, retorna 0 (ou um erro dependendo do problema)
// guard clause
if (n < k) return 0; 

int current_sum = 0;
int max_sum = 0;

// 1. Pré-processamento: Calcula a soma da PRIMEIRA janela (os primeiros K elementos)
for (int i = 0; i < k; i++) {
	current_sum += arr[i];
}

// Inicializa a soma máxima com a soma da primeira janela
max_sum = current_sum;

// 2. O Deslizamento da Janela
// Começamos a olhar o elemento logo após a primeira janela (índice k)
for (int i = k; i < n; i++) {
	// Adiciona o elemento atual que ENTRA na janela (arr[i])
	// Subtrai o elemento mais antigo que SAI da janela (arr[i - k])
	current_sum = current_sum + arr[i] - arr[i - k];

	// Atualiza a soma máxima se a janela atual for melhor
	max_sum = max(max_sum, current_sum);
}

cout << max_sum << '\n';
```
----

# Janela tamanho variável

Exemplo de achar o maior subarrei que não passe da soma S.

```cpp
vector<int> arr = {3, 1, 2, 7, 4, 2, 1, 1, 5};
int n = arr.size();
int S = 10; // soma que tem que ser menor

int current_sum = 0;    // Guarda o estado atual da janela
int max_len = 0;        // Guarda a nossa melhor resposta

int L = 0;              // Ponteiro esquerdo
// O ponteiro R (direito) avança a cada iteração, expandindo a janela
for (int R = 0; R < n; R++) {
	// 1. Adiciona o novo elemento à janela
	current_sum += arr[R];

	// 2. Se a janela ficou INVÁLIDA (soma maior que S), precisamos encolher!
	// O while garante que vamos tirar elementos da esquerda até voltar a ser válida
	while (current_sum > S && L <= R) { // garante que o L não passe do R
		current_sum -= arr[L]; // Remove o elemento que ficou para trás
		L++;                   // Encolhe a janela pela esquerda
	}
	// 3. Neste ponto, a janela [L...R] é garantidamente válida.
	
	// Calculamos o tamanho dela e atualizamos a resposta máxima.
	// O tamanho de um intervalo fechado [L, R] é sempre (R - L + 1)
	int len = R - L + 1;
	max_len = max(max_len, len);
}

cout << max_len << '\n';
```