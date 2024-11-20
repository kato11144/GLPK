/* mcf-gen.mod */

/* Given parameters */
param N integer, > 0;                        /* ノードの総数を表すパラメータ */
param p integer, > 0;                        /* 発ノードを表すパラメータ */
param q integer, > 0;                        /* 着ノードを表すパラメータ */
param v >= 0;                                /* 発ノードから着ノードまで流れるトラヒック量 */

set V := 1..N;                               /* ノードの集合 (要素は1からNまでのN個の整数) */

param cost{V, V};                            /* リンクの距離を表すパラメータ */
param capa{V, V};                            /* リンクの容量を表すパラメータ */

/* Decision variables */
var x{V, V} >= 0;                            /* リンクを流れるトラヒック量 */

/* Objective function */
minimize PATH_COST: sum {i in V} (sum {j in V} (cost[i, j] * x[i, j]));

/* Constraints */
s.t. SOURCE {i in V : i = p}:
    sum {j in V} (x[i, j]) - sum {j in V} (x[j, i]) = v;     /* 発ノードにおけるフロー保存 */

s.t. INTERNAL {i in V : i != p && i != q}:
    sum {j in V} (x[i, j]) - sum {j in V} (x[j, i]) = 0;     /* 中継ノードにおけるフロー保存 */

/* 着ノードに関する条件は省略 */
s.t. CAPACITY {(i, j) in {V, V}}:
    x[i, j] <= capa[i, j];                                   /* 各リンクの容量制約 */

end;
