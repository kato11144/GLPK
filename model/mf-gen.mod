/* mf-gen.mod */

/* Given parameters */
param N integer, > 0;           /* ノードの総数を表すパラメータ */
param p integer, > 0;           /* 発ノードを表すパラメータ */
param q integer, > 0;           /* 着ノードを表すパラメータ */

set V := 1..N;                  /* ノードの集合(1からNまでの整数) */

param capa{V,V};                /* リンク容量を表すパラメータ (ノードの組を添字とする2次元配列) */

/* Decision variables */
var v >= 0;                     /* 発ノードから着ノードまで流れるトラヒック量 */
var x{V,V} >= 0;                /* リンクを流れるトラヒック量 (ノードの組を添字とする2次元配列) */

/* Objective function */
maximize FLOW: v;

/* Constraints */
s.t. SOURCE{i in V: i = p}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = v;

s.t. INTERNAL{i in V: i != p && i != q}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = 0;

s.t. CAPACITY{(i,j) in {V,V}}: x[i,j] <= capa[i,j];

end;
