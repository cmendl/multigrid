function R = restrictionFW1D(n)
%
%	Dirichlet (zero) boundary conditions, so boundary terms are omitted

if mod(n,2)~=0
	error('n must be even.');
end

% example for n = 6 (z is zero boundary):
%	z 1 2 1 0 0 z
%	z 0 0 1 2 1 z

e = ones(n-1,1);
R = spdiags([e 2*e e]/4,-1:1,n-1,n-1);
R = R(2:2:end,:);
