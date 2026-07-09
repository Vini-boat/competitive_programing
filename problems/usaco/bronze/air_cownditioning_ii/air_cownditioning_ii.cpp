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
    int m,n;
    cin >> n >> m;
    vvi cows(n, vector<int>(3));
    vvi conds(m, vector<int>(4));
    for(vi& cow : cows) cin >> cow[0] >> cow[1] >> cow[2];
    for(vi& cond : conds) cin >> cond[0] >> cond[1] >> cond[2] >> cond[3];
    

    vi casinhas(100, 0);

    for(auto cow:cows) {
        for(int i=cow[0]-1; i <= cow[1]-1; i++) {
            casinhas[i] = cow[2];
        }
    }
    

    int ans = INF;
    for(int subset = 0; subset < (1 << m); subset++){
        int tot = 0;
        bool valido=true;

        for(int casinha =0; casinha < 100; casinha++) {
            int resf = 0;
            for(int i =0; i < m; i++){
                if(subset & (1 << i)){
                    vi cond = conds[i];
                    if(cond[0]-1 <= casinha && cond[1]-1 >= casinha) {
                        resf += cond[2];
                    }


                }
            }
            if(resf < casinhas[casinha]) {
                valido = false;
                break;
            }
        }
        for(int i =0; i < m; i++){
            if(subset & (1 << i)){
                vi cond = conds[i];
                tot += cond[3];
            }
        }

        if(valido){
            ans = min(tot, ans);
        }

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