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
    int N; cin >> N;
    vector<vector<string>> subgroups(N);
    for(int i=0;i<N;i++){
        int m; cin >> m;
        for(int j=0;j<m;j++){
            string s; cin >> s;
            subgroups[i].pb(s);
        }
    }
    
    for(auto& a : subgroups){
        for(string& s : a){
            cout << s << " ";
        }
        cout << endl;
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    // freopen("evolution.in", "r", stdin);
	// freopen("evolution.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}