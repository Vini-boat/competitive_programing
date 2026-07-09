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
    int n; cin >> n;
    vi buckets(1000, 0);
    for(int i =0; i<n;i++){
        int s,t,b; cin >> s >> t >> b;
        for(int j=s;j<=t;j++){
            buckets[j]+=b;
        }
    }

    int m = 0;
    for(int i : buckets){
        m = max(m,i);
    }
    cout << m << endl;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("blist.in", "r", stdin);
	freopen("blist.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}