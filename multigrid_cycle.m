function u = multigrid_cycle(n,gamma,u,Lop,f,nu1,nu2,varargin)
%
%	Reference:
%		Ulrich Trottenberg, Cornelius W. Oosterlee, Anton Schuller.
%		Multigrid, Academic Press (2001)

if mod(n,2)~=0
	error('n must be a power of 2.');
end

L = Lop(n);

% process options
options = processopts(struct('SmoothingMethod','GaussSeidel'),varargin{:});

% smoothing method
switch options.SmoothingMethod
	case 'GaussSeidel'
		% set omega = 1
		smooth = @(L,u,f) relaxGaussSeidel(L,u,f,1);
	case 'Jacobi'
		% for smoothing of Poisson equation, omega = 4/5 is optimal
		smooth = @(L,u,f) relaxJacobi(L,u,f,4/5);
	otherwise
		error('Unknown smoothing method');
end


%% pre-smoothing

for j=1:nu1
	u = smooth(L,u,f);
end


%% coarse grid correction

% compute the defect
d = f - L*u;

% restrict the defect
d = restrictionFW2D(n)*d;

% compute an (approximate) solution v^tilde_{n-1} of the defect equation on Omega_{n/2}
if n==2
	v = Lop(n/2)\d;
else
	v = zeros((n/2-1)^2,1);	% start with zero
	for j=1:gamma
		v = multigrid_cycle(n/2,gamma,v,Lop,d,nu1,nu2,'SmoothingMethod',options.SmoothingMethod);
	end
end

% interpolate the correction
v = interpolation2D(n/2)*v;

% compute the corrected approximation on Omega_n
u = u + v;


%% post-smoothing

for j=1:nu2
	u = smooth(L,u,f);
end
