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
    vector<vector<int>> adj(n);
    for(int i = 0; i< n-1;i++){
        int a,b; cin >> a >> b;
        adj[b-1].pb(a-1);
    }

    int ans =-1;
    for(int i = 0; i<n;i++){

        vector<bool> seen(n,false);
        queue<int> q;
        seen[i] = true;
        q.push(i);

        while(!q.empty()){
            int curr = q.front(); q.pop();
            for(int next : adj[curr]){
                if(seen[next]) continue;
                seen[next] = true;
                q.push(next);
            }
        }
        bool invalid = false;
        for(bool b : seen){
            invalid |= !b;
        }
        if(!invalid){
            ans = i+1;
            break;
        }
    }

    cout << ans << endl;
    
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("factory.in", "r", stdin);
	freopen("factory.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}