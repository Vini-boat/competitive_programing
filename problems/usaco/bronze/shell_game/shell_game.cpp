#include <bits/stdc++.h>
using namespace std;

// --- ATALHOS (Typedefs) ---
using ll = long long;        // Para não ter que digitar long long toda hora
using pii = pair<int, int>;  // Par de inteiros (muito usado em grafos/grids)
using vi = vector<int>;      // Vetor de inteiros
using vvi = vector<vector<int>>;

// --- CONSTANTES ---
const int INF = 1e9;         // Infinito para int (1 bilhão)
const ll LLINF = 4e18;       // Infinito para long long
const double EPS = 1e-9;     // Para comparações de float/double

// --- MACROS (Opcional, mas muito usado) ---
#define pb push_back
#define all(x) x.begin(), x.end()  // Agiliza sort(all(v))
#define sz(x) (int)(x).size()

#define dbg cerr << "[DBG]:" << __LINE__ << ": "

void solve() {
    freopen("shell.in", "r", stdin);
	freopen("shell.out", "w", stdout);
    int n; cin >> n;

    int tot1 = 0, tot2 = 0, tot3 = 0;
    int p1 = 1, p2 = 2, p3 = 3;
    for(int i = 0;i<n;i++){
        int a,b,g; cin >> a >> b >> g;
        if(a==p1) {
            p1 = b;
        } else if(b==p1){
            p1 = a;
        }
        if(g==p1) tot1++;
        if(a==p2) {
            p2 = b;
        } else if(b==p2){
            p2 = a;
        }
        if(g==p2) tot2++;
        if(a==p3) {
            p3 = b;
        } else if(b==p3){
            p3 = a;
        }
        if(g==p3) tot3++;
    }

    cout << max(tot1,max(tot2,tot3)) << "\n";
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}