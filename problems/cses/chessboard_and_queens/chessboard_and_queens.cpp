#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using pii = pair<int, int>;
using vi = vector<int>;
using vvi = vector<vector<int>>;

const int INF = 1e9;
const ll LLINF = 4e18;
const double EPS = 1e-9;


#define pb push_back
#define all(x) x.begin(), x.end()
#define sz(x) (int)(x).size()

int N = 8;
vector<string> board(N);
int tot = 0;

vi column(N,0);
vi diag1(N+N-1,0);
vi diag2(N+N-1,0);

void search(int y){
    if(y == N){
        tot++;
        return;
    }

    for(int x = 0; x < N; x++){
        if(
            board[y][x] == '*' ||
            column[x] ||
            diag1[x+y] ||
            diag2[x-y+N-1]
        ) continue;

        column[x] = diag1[x+y] = diag2[x-y+N-1] = 1;
        search(y+1);
        column[x] = diag1[x+y] = diag2[x-y+N-1] = 0;
    }
}

void solve() {
    for(string& s : board) cin >> s;
    
    search(0);
    cout << tot << endl;
    
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    // freopen("template.in", "r", stdin);
	// freopen("template.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}