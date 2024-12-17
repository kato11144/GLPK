/* ex3.mod */

param N integer, > 0 ;
param K integer, > 0 ;

set V := 1..N;
set VV := 1..K;

param w{V, V};

var S{VV, V, V} binary;
var y{V, V} binary;

maximize OFFLOADING: sum{i in V, j in V} w[i,j] * y[i,j];

s.t. CELL_COVERAGE_CONSTRAINT{k in VV}:
       sum{i in V} (sum{j in V} (S[k,i,j])) = 1;

s.t. CELL_PAIR_COVERAGE{i in V, j in V}:
       y[i,j] = sum{k in VV} (S[k,i,j]);

end ;
