/* sp-gen.mod */

/* Given parameters */
param N integer, > 0;           /* ノードの総数を表すパラメータ */
param p integer, > 0;           /* 発ノードを表すパラメータ */
param q integer, > 0;           /* 着ノードを表すパラメータ */

set V := 1..N;                  /* ノードの集合(1からNまでの整数) */

param cost{V,V};                /* リンクの距離を表すパラメータ (ノードの組を添字とする2次元配列) */

/* Decision variables */
var x{V,V} <= 1, >= 0;          /* リンクを通過する変数 (ノードの組を添字とする2次元配列) */

/* Objective function */
minimize PATH_COST: sum{i in V} (sum{j in V} (cost[i,j] * x[i,j]));

/* Constraints */
s.t. SOURCE{i in V: i = p}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = 1;

s.t. INTERNAL{i in V: i != p && i != q}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = 0;

end;
