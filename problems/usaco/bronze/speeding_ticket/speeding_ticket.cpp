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

#define dbg cerr << "[DBG]:" << __LINE__ << ": "

void solve() {
    freopen("speeding.in", "r", stdin);
	freopen("speeding.out", "w", stdout);
    int n,m; cin >> n >> m;

    array<int,100> limit;
    array<int,100> speed;

    auto begin = limit.begin();
    for(int i = 0; i < n;i++){
        int l,s; cin >> l >> s;
        fill(begin, begin + l ,s);
        begin = begin + l;
    }
    begin = speed.begin();
    for(int i = 0; i < m;i++){
        int l,s; cin >> l >> s;
        fill(begin, begin + l ,s);
        begin = begin + l;
    }

    int agg = 0;
    for(int i = 0; i< 100; i++){
        agg = max(agg,speed[i] - limit[i]);
    }
    cout << agg << "\n";

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