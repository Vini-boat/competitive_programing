## Adjacency List

```cpp
int n; // Numero de Arestas
vector<vector<int>> edges; // Lista de arestas [[0,1],[1,2],[2,0]]

vector<vector<int>> adj_list(n); // Lista de conexões de cada nó
// Nó 0 -> 1, 2
// Nó 1 -> 0, 2
// Nó 2 -> 0, 1

for(vector<int> edge : edges){
	adj_list[edge[0]].push_back(edge[1]);
	adj_list[edge[1]].push_back(edge[0]); // Somente no Bidirecional
}
```

## DFS

Busca por profundidade

```cpp
vector<vector<int>> adj_list;
vector<bool> seen(n, false);

void walk(vector<vector<int>>& adj_list, vector<bool>& seen, int node){
	if(seen[node])
		return;
	seen[node] = true;
	
	// Processar o nó atual
	
	for(int connected_node : adj_list[node]){
		walk(adj_list,seen,connected_node);
	}
}

```


## BFS

Busca por proximidade

Com lista de adjacência

```cpp
vector<vector<int>> adj_list;
vector<bool> seen(n, false);
queue<int> q;

int start_node = ;//

seen[start_node] = true;
q.push(start_node);

while(!q.empty()){
	int curr = q.front();
	q.pop();
	
	// Processar o nó atual
	
	for(int neighbor : adj_list[curr]){
		if(seen[neighbor]) continue;
		seen[neighbor] = true;
		q.push(neighbor);
	}
}

```

Em um Grid

```cpp

int ROWS; // quantidade de linhas
int COLS; // quantidade de colunas

pii b; // celula inicial 
vector<vi> dist(ROWS,vi(COLS,-1));
queue<pii> q;

// inicializa o estado
dist[b.second][b.first] = 0; 
q.push(b);

while(!q.empty()){
	pii curr = q.front();
	auto [curr_x, curr_y] = curr;
	q.pop();

	// processar célula
	
	int dx[] = { 1,-1, 0, 0};
	int dy[] = { 0, 0, 1,-1};

	for(int i = 0; i < 4; i++){
		int new_x = curr_x + dx[i];
		int new_y = curr_y + dy[i];

		// VALIDAÇÃO DOS INDICES TEM QUE SER FEITA ANTES DE ACESSAR
		if(new_x < 0 || COLS <= new_x || new_y < 0 || ROWS <= new_y) 
			continue; 

		// Outras validações de vizinhos (bloqueios e afins)
		
		if(dist[new_y][new_x] != -1) continue;
		
		dist[new_y][new_x] = dist[curr_y][curr_x] + 1;
		q.push({new_x,new_y});
	}
}

```


## Net Degree

Para problemas que dependem apenas da contagem de entradas e saídas do grafo

```cpp
vector<int> net(n,0);

for(vector<int> edge : trust){
	net[edge[0]-1]--;
	net[edge[1]-1]++;
}
```