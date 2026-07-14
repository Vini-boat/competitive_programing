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
    
    int p =0;
    for(int i=N;i>=0;i--){
        int v; cin >> v;
        if(v) p |= (1<<i);
    }

    int ans =0;
    while(p!=1){
        if(p & 1){
            p ^= ((p<<1)+1);
        }else{
            p = p>>1;
        }
        ans++;
    }


   cout << ans << endl; 
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