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
    freopen("mixmilk.in", "r", stdin);
	freopen("mixmilk.out", "w", stdout);

    array<int,3> capacity;
    array<int,3> amount;

    for(int i =0; i< 3; i++){
        cin >> capacity[i];
        cin >> amount[i];
    }

    int from = 0;
    int to = 1;
    for(int i = 0; i < 100; i++){
        int space = capacity[to] - amount[to];
        if(amount[from] > space){
            amount[from] -= space;
            amount[to] += space;
        } else {
            amount[to] += amount[from];
            amount[from] = 0;
        }


        from = (from +1) % 3;
        to = (to +1) % 3;
    }

    cout << amount[0] << '\n' << amount[1] << '\n' << amount[2] << '\n';

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