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
    vi p(n); for(int& i : p) cin >> i;

    int count =0;

    for(int i =0; i<n;i++){
        int tot =0;
        for(int j=i;j<n;j++){
            // calcular de avg flower
            tot += p[j]; // coloca flor na janela
            

            if(tot % (j-i+1) != 0) continue;
            int avg = tot / (j-i+1);
            // check if it is there


            for(int k=i;k<=j;k++){
                if(p[k] == avg){
                    count++;
                    break;
                }
            }
            
        }
    }


    cout << count << endl;
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