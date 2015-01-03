function R = restrictionFW2D(n)
%
%	Dirichlet (zero) boundary conditions, so boundary terms are omitted

R = restrictionFW1D(n);
R = kron(R,R);
