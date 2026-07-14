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


void solve() {
    int N,M; cin >> N >> M;

    vvi a(N,vi(M));

    for(vi& row : a){
        for(int& i : row){
            cin >> i;
        }
    }
    
    int tot =0;
    for(int i=0;i<M;i++){
        int m = 0;
        for(int j=0;j<N;j++){
            m = max(m,a[j][i]);
        }
        tot+=m;
    }
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