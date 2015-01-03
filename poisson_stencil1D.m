function T = poisson_stencil1D(n)
%
%	Dirichlet (zero) boundary conditions, so boundary terms are omitted

h = 1/n;

% (n-1) x (n-1) matrix
% example for n = 6:
%	 2 -1  0  0  0
%	-1  2 -1  0  0
%	 0 -1  2 -1  0
%	 0  0 -1  2 -1
%	 0  0  0 -1  2
e = ones(n-1,1);
T = spdiags([-e 2*e -e]/h,-1:1,n-1,n-1);
