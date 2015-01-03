function T = interpolation2D(n)
%
%	Dirichlet (zero) boundary conditions, so boundary terms are omitted

T = interpolation1D(n);
T = kron(T,T);
