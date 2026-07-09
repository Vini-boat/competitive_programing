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
    vector<ll> weights(n); for(ll& i : weights) cin >> i;

    ll m = LLINF;

    for(ll subset = 0; subset < (1 << n); subset++){
        ll sum1 = 0;
        ll sum2 = 0;
        for(int i =0; i < n; i++){
            if(subset & (1 << i)){
                sum1+=weights[i];
            }else {
                sum2+=weights[i];
            }
        }
        m = min(m,abs(sum1-sum2));
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