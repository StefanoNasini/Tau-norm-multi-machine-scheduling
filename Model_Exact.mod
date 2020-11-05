reset;

#-----------------------------------------------------------------------
# MIN CTV IN BILEVEL SCHEDULING
#-----------------------------------------------------------------------

param N;					# number of jobs
param M;					# number of machines
param T;					# number of machines
param tau;

param NM {1..M};			# number of jobs per machine
param ell {1..T};			# number of PWL nodes

param p {1..N}; 			# processing time of jobs

param LB_mean_bound default 0;

var y {h in 1..N, i in 1..M, k in 1..NM[i]} binary;
var x {i in 1..M, k in 1..NM[i]} >= 0;
var C {i in 1..M, k in 1..NM[i]} >= 0;
var phi {i in 1..M} >= 0;
var Phi >= 0;

#-----------------------------------------------------------------------

minimize MinNorme: sum{i in 1..M} phi[i];

minimize MinMax: Phi;

subject to Norme {i in 1..M, t in 1..T}:
	phi[i] >= (ell[t])^(tau) + (tau*(ell[t])^(tau-1))*(( 	
	(sum{k in 1..NM[i]}(C[i,k] - (sum{kk in 1..NM[i]} C[i,kk])/NM[i] )^2)/NM[i]
	) - ell[t]);
	
subject to Norme_MinMax {i in 1..M}:
	Phi >= ((sum{k in 1..NM[i]}(C[i,k] - (sum{kk in 1..NM[i]} C[i,kk])/NM[i] )^2)/NM[i]);
	
subject to Y_to_X{i in 1..M, k in 1..NM[i]}: 
	x[i,k] = sum{h in 1..N}  p[h]*y[h,i,k];

subject to Y0 {i in 1..M, k in 1..NM[i]}:
	sum{h in 1..N} y[h,i,k] = 1;
	
subject to Y3 {h in 1..N}:
	sum{i in 1..M,k in 1..NM[i]} y[h,i,k] = 1;	

#-----------------------------------------------------------------------

subject to Completion_times {i in 1..M, k in 1..NM[i]}:
	C[i,k] = sum{j in 1..k} x[i,j];

	
#-----------------------------------------------------------------------

subject to Set_VI_2 {i in 2..M}:
	sum{j in 1..NM[i]} x[i,j] <= sum{j in 1..NM[i-1]} x[i-1,j];
