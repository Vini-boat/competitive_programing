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
#define F first
#define S second

#define dbg cerr << "[DBG]:" << __LINE__ << ": "

void solve() {
    int n; cin >> n;
    
    vector<pair<string,pair<int,int>>> segments(n);
    for(auto& seg : segments){
        string s; cin >> s;
        int lo,hi; cin >> lo >> hi;
        seg.F = s;
        seg.S.F = lo;
        seg.S.S = hi;
    }
    
    bool highway_found = false;
    int i = 0;
    int m = 0;
    while(!highway_found){
        if(segments[i].first == "none"){
            highway_found = true;
        } else {
            i++;
            if(segments[i].first == "on"){
                m+=segments[i].S.F;
            } else {
                m-=segments[i].S.S;
            }
            
        }
    }

    pair<int,int> after {max(m,0),INF};

    for(;i<n;i++){
        auto& s = segments[i];
        auto& val = s.S;
        if(s.F == "none"){
           // lower bound

           if(val.F > after.F){
            after.F = val.F;
           }
           // upper bound
           if(val.S < after.S){
            after.S = val.S;
           }
        }

        if(s.F == "on"){
            after.F += val.F;
            after.S += val.S;
        }
        
        if(s.F == "off"){
            after.F -= val.S;
            after.S -= val.F;
            
            after.F = max(after.F,0);
            after.S = max(after.S,0);
        }
    }
    
    
    
    highway_found = false;
    i = n-1;
    m = 0;
    // ignora todas as rampas iniciais
    while(!highway_found){
        if(segments[i].first == "none"){
            highway_found = true;
        } else {
            i--;
            if(segments[i].first == "off"){
                m+=segments[i].S.F;
            } else {
                m-=segments[i].S.S;
            }
        }
    }
    
    pair<int,int> before {max(m,0),INF};
    
    for(;i>=0;i--){
        auto& s = segments[i];
        auto& val = s.S;
        if(s.F == "none"){
            // lower bound
            
            if(val.F > before.F){
                before.F = val.F;
            }
            // upper bound
            if(val.S < before.S){
                before.S = val.S;
            }
        }
        
        if(s.F == "off"){
            before.F += val.F;
            before.S += val.S;
        }
        
        if(s.F == "on"){
            before.F -= val.S;
            before.S -= val.F;
            before.F = max(before.F,0);
            before.S = max(before.S,0);
        }
    }
    
    cout << before.F << " " << before.S << "\n";
    cout << after.F << " " << after.S << "\n";
    
    

}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("traffic.in", "r", stdin);
	freopen("traffic.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}