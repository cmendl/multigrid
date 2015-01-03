function T = interpolation1D(n)
%
%	Dirichlet (zero) boundary conditions, so boundary terms are omitted

e = ones(2*n-1,1);
T = spdiags([e/2 e e/2],-1:1,2*n-1,2*n-1);
T = T(:,2:2:end);
