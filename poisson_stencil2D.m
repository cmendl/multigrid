function A = poisson_stencil2D(n)
%
%	Reference:
%		Ulrich Trottenberg, Cornelius W. Oosterlee, Anton Schuller.
%		Multigrid, Academic Press (2001)
%
%	Dirichlet (zero) boundary conditions, so boundary terms are omitted

h = 1/n;

% example for n = 6:
%	0 1 0 0 0
%	1 0 1 0 0
%	0 1 0 1 0
%	0 0 1 0 1
%	0 0 0 1 0
e = ones(n-1,1);
nD = spdiags([e e],[-1,1],n-1,n-1);

% Kronecker product
nD = kron(speye(n-1),nD) + kron(nD,speye(n-1));

% (n-1)^2 x (n-1)^2 matrix
A = (4*speye((n-1)^2) - nD) / h^2;
