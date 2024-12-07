/* ex1.mod */

param N integer, > 0 ;
param M integer, > 0 ;
param MaxDegree integer, > 0 ;

set V := 1..N ;
set VV := 1..M ;

param PPcapacity{V} ;
param PPdemand{VV} ;
param BWcapacity{V,V} ;
param BWdemand{VV,VV} ;
param isPNactive{V} ;
param isPLactive{V,V} ;

param match{VV,V} binary ;

var f{V,V,V,V} >= 0 ;
var x{V,VV} binary ;
var LD{V,V} >= 0 ;
var z{V,V,VV,VV} binary ;
var rho{V,V} binary ;
var alrha{V} binary ;

minimize ACTIVE_EQUIPMENTS: sum{i in V: isPNactive[i] = 0} (alrha[i]) + sum{i in V} (sum{j in V: isPLactive[i,j] = 0} (rho[i,j])) ;

s.t. TrafficDemandConservation{i in V, j in V}:
       sum{k in VV, l in VV} (BWdemand[k,l] * z[i,j,k,l]) = LD[i,j];

s.t. FlowConservationSource{i in V, j in V}:
       sum{h in V} (f[i,h,i,j]) - sum{h in V} (f[h,i,i,j]) = LD[i,j];

s.t. FlowConservationInternal{i in V, j in V, l in V: l != i and l != j}:
       sum{k in V} (f[k,l,i,j]) = sum{k in V} (f[l,k,i,j]);

s.t. FlowConservationDestination{i in V, j in V}:
       sum{h in V} (f[h,j,i,j]) - sum{h in V} (f[j,h,i,j]) = LD[i,j];

s.t. LinearizationInbound{s in VV, d in VV, j in V}:
       sum{i in V} (z[i,j,s,d]) = x[j,d];

s.t. LinearizationOutbound{s in VV, d in VV, i in V}:
       sum{j in V} (z[i,j,s,d]) = x[i,s];

s.t. LinearizationConsistency{s in VV, d in VV, i in V, j in V}:
       x[i,s] + x[j,d] - z[i,j,s,d] <= 1;

s.t. LinkCapacity{i in V, j in V}:
       sum{s in V, d in V} (f[i,j,s,d]) <= BWcapacity[i,j] * rho[i,j];

s.t. NodeCapacity{l in V}:
       sum{s in VV} (x[l,s] * PPdemand[s]) <= PPcapacity[l];

s.t. UniqueMapping{s in VV}:
       sum{i in V} (x[i,s]) = 1;

s.t. FeasibleMapping{s in VV, i in V: match[s,i] = 0}:
       x[i,s] = 0;

s.t. NodeActivationConsistency{i in V}:
       sum{j in V} (rho[i,j]) + sum{j in V} (rho[j,i]) >= alrha[i];

s.t. NodeDegreeLimit{i in V}:
       sum{j in V} (rho[i,j]) + sum{j in V} (rho[j,i]) <= alrha[i] * MaxDegree;

end ;
