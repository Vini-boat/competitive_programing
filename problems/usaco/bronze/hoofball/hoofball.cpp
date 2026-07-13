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

    if(n<4){
        cout << 1 << endl;
        return;
    }

    vi xs(n); for(int& x : xs) cin >> x;
    vector<pair<int,int>> cows(n);
    for(int i =0; i<n;i++){
        cows[i] = {xs[i],i};
    }
    sort(all(cows));

    vi adj(n);

    for(int i =0;i<n;i++){
        auto [x, id] = cows[i];
        if(i==0){
            adj[id] = cows[i+1].second; 
            continue;
        }
        if(i==n-1){
            adj[id] = cows[i-1].second;
            continue;
        }
        auto [lx,lid] = cows[i-1];
        auto [rx,rid] = cows[i+1];

        int dl = abs(x-lx);
        int rl = abs(x-rx);

        if(rl < dl) swap(lid,rid);

        adj[id] = lid;
    }


    vi in_cycle(n,0);
    int curr_cycle = 1;
    for(int i =0; i<n;i++){
        if(in_cycle[i]) continue;
        if(adj[adj[i]] == i){ //eh ciclo
            in_cycle[i] = in_cycle[adj[i]] = curr_cycle++;
        }
    }

    vi cycle_degree(n,0);
    for(int i =0; i<n;i++){
        if(in_cycle[i]) continue;
        cycle_degree[in_cycle[adj[i]]]++;
    }


    for(int i = 1; i<curr_cycle; i++){
        if(!cycle_degree[i]) cycle_degree[i]++;
    }



    cout << accumulate(cycle_degree.begin() + 1, cycle_degree.end(),0) << '\n';
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("hoofball.in", "r", stdin);
	freopen("hoofball.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}