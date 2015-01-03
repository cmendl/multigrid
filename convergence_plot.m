function convergence_plot(varargin)
%
%	Reference:
%		Ulrich Trottenberg, Cornelius W. Oosterlee, Anton Schuller.
%		Multigrid, Academic Press (2001)

% process options
options = processopts(struct('n',32,'SmoothingMethod','GaussSeidel'),varargin{:});

n = options.n;

%% setup

[X,Y] = meshgrid((1:(n-1))/n,(1:(n-1))/n);

% create right-hand side f
f = exp(-cos(4*X).^2 + exp(-sin(6*Y).^2)) - 3/2;

figure();
surf(X,Y,f)
title('right-hand side f');

%% exact solution

u_exact = poisson_stencil2D(n)\reshape(f,[],1);

figure();
surf(X,Y,reshape(u_exact,n-1,n-1));
title('exact solution u of -\Delta u = f');

%% multigrid solution

maxiter = 10;

nu1 = 1;
nu2 = 1;

err = cell(2,1);
for gamma=1:2
	fprintf('gamma = %g\n',gamma);

	errG = zeros(maxiter+1,1);

	% iterations of multigrid cycle
	u = zeros((n-1)^2,1);
	errG(1) = norm(u - u_exact);
	for j=1:maxiter
		fprintf('starting iteration %i...\n',j);
		u = multigrid_cycle(n,gamma,u,@poisson_stencil2D,reshape(f,[],1),nu1,nu2,'SmoothingMethod',options.SmoothingMethod);
		errG(j+1) = norm(u - u_exact);
	end
	
	% store error
	err{gamma} = errG;
end


%% convergence plot

figure();
semilogy(0:maxiter,err{1},'.-',0:maxiter,err{2},'.-');
legend('\gamma = 1','\gamma = 2');
xlabel('iteration');
ylabel('error');
title(sprintf('Multigrid convergence plot (Poisson equation)\nsmoothing method: %s, \\nu_1 = %g, \\nu_2 = %g',options.SmoothingMethod,nu1,nu2));
