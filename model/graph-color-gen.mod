/* graph-color-gen.mod */

/* Given parameters */
param N integer, > 0;                    /* ノードの総数を表すパラメータ */

set V := 1..N;                           /* ノードの集合(要素は1からNまでのN個の整数) */
set W := 1..N;                           /* 色(波長)の集合(必要な数は最大でもN色) */
set W1 := 1..N-1;                        /* 最後の制約条件で用いる色の集合(識別子が最大の色を除く) */

param AM{V, V};                          /* 彩色グラフにおけるノード間のリンクの有無を表す行列ノードi, j間にリンクがあればAM[i,j]=1, そうでなければAM[i,j]=0 */

/* Decision variables */
var y{W}, binary;                        /* i番目の色が割り当てられるかどうか */
var x{V, W}, binary;                     /* i番目の色がj番目のノードに割り当てられるかどうか */

/* Objective function */
minimize NUM_COLOR: sum {i in W} y[i];   /* 割り当てられる色の数の最小化 */

/* Constraints */
s.t. UNIQUE_COLOR {j in V}:
    sum {i in W} x[j, i] = 1;            /* いずれのノードに対しても1つの色が割り当てられなければならない */

s.t. DIFFERENT_COLOR {j1 in V, j2 in V, i in W: AM[j1, j2] = 1}:
    x[j1, i] + x[j2, i] <= y[i];         /* 隣り合うノードに同じ色を割り当ててはいけない */

s.t. FIRST_FIT {i in W1}:
    y[i] >= y[i + 1];                    /* 識別子の小さい色から優先して割り当てなければならない */

end;
