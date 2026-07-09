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
    freopen("cowsignal.in", "r", stdin);
	freopen("cowsignal.out", "w", stdout);
    int m,n,k; cin >> m >> n >> k;

    vvi picture(m,vi(n,0));

    for(vi& line : picture){
        for(int& cell : line){
            char c; cin >> c;
            if(c == 'X') cell = 1;
        }
    }
    

    for(vi line : picture){
        for(int j =0; j<k;j++){
            for(int cell : line){
                for(int i = 0; i<k;i++){
                    if(cell == 1){
                        cout << "X";
                    } else {
                        cout << ".";
                    }
                }
            }
            cout << "\n";
        }
    }

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