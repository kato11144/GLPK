/* min-cost-flow.mod */

/* Given parameters */
param N integer, > 0 ;                  /* ノードの総数 */
param p integer, > 0 ;                  /* 発ノード */
param q integer, > 0 ;                  /* 着ノード */
param v integer, > 0 ;                  /* 発ノードから着ノードに流すトラヒック量 */

set V := 1..N ;                         /* ノードの集合 */

param capa{V,V} ;                       /* 各リンクの容量 */
param cost{V,V} ;                       /* 各リンクの距離 (コスト) */

/* Decision variables */
var x{V,V} >= 0 ;                       /* リンクを流れるトラヒック量 */

/* Objective function */
minimize TOTAL_COST: sum{i in V, j in V} (cost[i,j] * x[i,j]) ;

/* Constraints */
s.t. SOURCE_FLOW{i in V: i = p}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = v ;

s.t. SINK_FLOW{i in V: i = q}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = -v ;

s.t. FLOW_BALANCE{i in V: i != p && i != q}:
    sum{j in V} (x[i,j]) - sum{j in V} (x[j,i]) = 0 ;

s.t. CAPACITY_CONSTRAINT{i in V, j in V}: x[i,j] <= capa[i,j] ;

end;
