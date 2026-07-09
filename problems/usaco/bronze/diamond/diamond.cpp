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
    int n,k; cin >> n >> k;
    vi d(n); for(int& i : d) cin >> i;
    sort(all(d));

    int m = 0;
    for(int i=0;i<n;i++){
        int tot =0;
        for(int j = i; j<n && d[j] - d[i] <= k;j++){
            tot++;
        }
        m = max(m,tot);
    }

    cout << m << endl;
    
}

// 1 1 3 4 6

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("diamond.in", "r", stdin);
	freopen("diamond.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}