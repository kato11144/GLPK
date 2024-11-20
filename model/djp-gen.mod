/* djp-gen.mod */

/* Given parameters */
param N integer, > 0;                           /* ノードの総数を表すパラメータ */
param p integer, > 0;                           /* 発ノードを表すパラメータ */
param q integer, > 0;                           /* 着ノードを表すパラメータ */
param K integer, > 0;                           /* リンク独立経路の総数 */

set V := 1..N;                                  /* ノードの集合 (要素は1からNまでのN個の整数) */
set M := 1..K;                                  /* リンク独立経路の集合 */

param cost{V, V};                               /* リンクの距離を表すパラメータ */

/* Decision variables */
var x{V, V, M} binary;                          /* k番目のリンク独立経路がリンク(i, j)を使うかどうか */

/* Objective function */
minimize PATH_COST: sum {k in M} (sum {i in V} (sum {j in V} (cost[i, j] * x[i, j, k])));

/* Constraints */
s.t. SOURCE {i in V, k in M : i = p}:
    sum {j in V} (x[i, j, k]) - sum {j in V} (x[j, i, k]) = 1;  /* 発ノードにおけるフロー保存 */

s.t. INTERNAL {i in V, k in M : i != p && i != q}:
    sum {j in V} (x[i, j, k]) - sum {j in V} (x[j, i, k]) = 0;  /* 中継ノードにおけるフロー保存 */

/* 着ノードに関する条件は省略 */
s.t. DISJOINT {i in V, j in V, k1 in M, k2 in M : k2 != k1}:
    x[i, j, k1] + x[i, j, k2] <= 1;                             /* リンク独立性を保つ制約 */

end;
