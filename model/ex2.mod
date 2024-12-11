/* ex2.mod */

param N integer, > 0 ;
param W integer, > 0 ;
param C integer, > 0 ;

param P_ZERO ;
param P ;

set V := 1..N ;
set VV := 1..W ;

param isLink{V,V} ;

param T{V,V} ;

var b{V,V} >= 0 ;
var bb{V,V,V,V} >= 0 ;
var c{V,V,V,V,VV} binary ;
var t{V,V,V,V} >= 0 ;

minimize POWER_CONSUMPTION: P_ZERO * sum{i in V, j in V} (b[i,j]) + P * sum{i in V, j in V, s in V, d in V} (t[i,j,s,d]) ;

s.t. B6{i in V, j in V, k in V: k != i and k != j}:
       sum{l in V: isLink[k,l] == 1} (bb[i,j,k,l]) - sum{l in V: isLink[l,k] == 1} (bb[i,j,l,k]) = 0;

s.t. B7{i in V, j in V}:
       sum{k in V: isLink[i,k] == 1} (bb[i,j,i,k]) = b[i,j];

s.t. B8{i in V, j in V}:
       sum{k in V: isLink[k,i] == 1} (bb[i,j,k,i]) = 0;

s.t. B9{i in V, j in V}:
       sum{k in V: isLink[j,k] == 1} (bb[i,j,j,k]) = 0;

s.t. B10{i in V, j in V}:
       sum{k in V: isLink[k,j] == 1} (bb[i,j,k,j]) = b[i,j];

s.t. C11{i in V, j in V, k in V, l in V: isLink[k,l] == 1}:
       sum{w in VV} (c[i,j,k,l,w]) = bb[i,j,k,l];

s.t. C12{w in VV, k in V, l in V: isLink[k,l] == 1}:
       sum{i in V, j in V} (c[i,j,k,l,w]) <= 1;

s.t. C13{w in VV, i in V, j in V, k in V: k != i and k != j}:
       sum{l in V: isLink[k,l] == 1} (c[i,j,k,l,w]) - sum{l in V: isLink[l,k] == 1} (c[i,j,l,k,w]) = 0;

s.t. C14{w in VV, i in V, j in V}:
       sum{k in V: isLink[i,k] == 1} (c[i,j,i,k,w]) <= b[i,j];

s.t. C15{w in VV, i in V, j in V}:
       sum{k in V: isLink[k,i] == 1} (c[i,j,k,i,w]) = 0;

s.t. C16{w in VV, i in V, j in V}:
       sum{k in V: isLink[j,k] == 1} (c[i,j,j,k,w]) = 0;

s.t. C17{w in VV, i in V, j in V}:
       sum{k in V: isLink[k,j] == 1} (c[i,j,k,j,w]) <= b[i,j];

s.t. T18{i in V, j in V}:
       sum{s in V, d in V} (t[i,j,s,d]) <= b[i,j] * C;

s.t. T19{i in V, j in V}:
       sum{s in V, d in V} (t[i,j,s,d]) >= (b[i,j] - 1) * C;

s.t. T20{s in V, d in V, i in V: i != s and i != d}:
       sum{j in V} (t[i,j,s,d]) - sum{j in V} (t[j,i,s,d]) = 0;

s.t. T21{s in V, d in V}:
       sum{j in V} (t[s,j,s,d]) = T[s,d];

s.t. T22{s in V, d in V}:
       sum{j in V} (t[j,s,s,d]) = 0;

s.t. T23{s in V, d in V}:
       sum{j in V} (t[d,j,s,d]) = 0;

s.t. T24{s in V, d in V}:
       sum{j in V} (t[j,d,s,d]) = T[s,d];

end ;
