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
    int n;
    cin >> n;
    vector<string> lado_a(n);
    vector<string> lado_b(n);

    for(int i=0;i<n;i++){
        cin >> lado_a[i] >> lado_b[i];
    }

    vi letras(26,0); // total necessário de cada letra

    for(char letra = 'a'; letra <= 'z'; letra++){
        for(int j =0; j<n;j++){
            int c_a =0; 
            int c_b = 0;

            for(auto l : lado_a[j]){
                if(l == letra) c_a++;
            }
            for(auto l : lado_b[j]){
                if(l == letra) c_b++;
            }
            letras[letra -'a'] += max(c_a,c_b);
        }

    }



    for(int l =0; l<26;l++) cout << letras[l] << endl;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("blocks.in", "r", stdin);
	freopen("blocks.out", "w", stdout);

    int t = 1;
    // cin >> t;
    while (t--) {
        solve();
    }

    return 0;
}