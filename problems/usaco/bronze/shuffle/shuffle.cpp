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
    vi shuffle(n); for(auto& i : shuffle) cin >> i;
    vi curr_pos(n); for(auto& i : curr_pos) cin >> i;
    vi s1(n);
    vi s2(n);
    vi s3(n);

    for(int i = 0; i< n; i++){
        s1[i] = curr_pos[shuffle[i]-1]; 
    }
    for(int i = 0; i< n; i++){
        s2[i] = s1[shuffle[i]-1]; 
    }
    for(int i = 0; i< n; i++){
        s3[i] = s2[shuffle[i]-1]; 
    }

    for(int i : s3) {
        cout << i << "\n";
    }


}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("shuffle.in", "r", stdin);
	freopen("shuffle.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}