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

int clamp(int n){
    // if(n < 0) return 0;
    // if(n >= 1000) return 999;
    return n;
}

void solve() {
    int x,y; cin >> x >> y;
    if(x==y){
        cout << 0 << endl;
        return;
    }
    bool na_direita = x < y;

    int curr_pos = x;
    int tot = 0;
    int dir = 1;
    bool found = false;
    for (int i = 1; !found; i*=2){
        int target = x + i* dir;  

        int limit = clamp(target);

        if(na_direita){
            if(dir == 1){ // indo pra direita
                if(y <= limit){
                    found = true;
                    tot += abs(curr_pos - y);
                } else {
                    tot += abs(curr_pos - limit);
                    curr_pos = limit;    
                }
            } else {
                tot += abs(curr_pos - limit);
                curr_pos = limit;
            }
        } else { // na esquerda
            if(dir == 1){
                tot += abs(curr_pos - limit);
                curr_pos = limit;
            } else {
                if(y >= limit){
                    found = true;
                    tot += abs(curr_pos - y);
                } else {
                    tot += abs(curr_pos - limit);
                    curr_pos = limit;    
                }
            }
        }

        // while(curr_pos != limit){
        //     curr_pos+=dir;
        //     tot++;
        //     if(curr_pos == y){
        //         found = true;
        //         break;
        //     }
        // }

        dir*=-1;
    }

    cout << tot << endl;


}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("lostcow.in", "r", stdin);
	freopen("lostcow.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}