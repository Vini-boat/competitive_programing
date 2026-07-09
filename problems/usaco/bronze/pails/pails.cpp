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
    int x,y,m; cin >> x >> y >> m;

    int ma = 0;

    for(int i =0; i < 1000; i++){
        for(int j =0; j < 1000; j++){
            int tot = i*x+j*y;
            if(tot <= m){
                ma = max(ma, i*x+j*y);
            }
        }
    }
    cout << ma << endl;
    
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("pails.in", "r", stdin);
	freopen("pails.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}