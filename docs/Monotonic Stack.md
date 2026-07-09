(Pilha Ordenada)

Sempre vai estar ordenado. Isso acontece pela lógica de inserção e remoção.

Genérico:

```cpp
vector<int> values;
int n = values.size();

vector<int> ans(n,0); // nesse caso 0 é o valor padrão caso não tenha um valor seguinte que satisfaça a condição

// caso o valor padrão seja outro, o vetor tem que ser inicializado com eles antes

stack<int> pilha; 

for(int i=0; i<n;i++){
	while(!pilha.empty() && values[pilha.top()] /*comparação*/ values[i]){
		ans[pilha.top()] = // atribui o valor 
		// tira do topo da pilha
		pilha.pop();
	}
	// adiciona o valor atual para validação
	pilha.push(i);
}

return ans;
```

----

# Achar a distância do valor atual até o próximo valor que seja maior

```cpp
vector<int> values;
int n = values.size();
// cria o vector com os valores base caso não tenha um indece que satisfaça
vector<int> ans(n,0);

stack<int> pilha; // armazena os indices que ainda precisam de uma temperatura

for(int i=0; i<n;i++){
	// enquanto tiver algum valor na pilha que seja menor que o atual
	while(!pilha.empty() && values[pilha.top()] < values[i]){
		// a distancia é a diferença do index atual pro do valor menor
		ans[pilha.top()] = i - pilha.top();
		// tira do topo da pilha
		pilha.pop();
	}
	// adiciona o valor atual para validação
	pilha.push(i);
}

return ans;
```