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
    int n; cin >> n;
    vi xs(n); for (auto& x : xs) cin >> x;
    vi ys(n); for (auto& y : ys) cin >> y;

    ll m = 0;
    for(int i=0;i<n-1;i++){
        for(int j=i+1;j<n;j++){
            ll dx = xs[i]-xs[j];
            ll dy = ys[i]-ys[j];
            ll sd = (ll) dx*dx + dy*dy;
            m = max(m,sd);
        }
    }
    cout << m << endl;

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