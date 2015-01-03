function err = test_poisson_eig2D(n)
%
%	Poisson stencil eigenfunctions

A = poisson_stencil2D(n);

x = (1:n-1)'/n;

err = 0;
for k=1:n-1
	for l=1:n-1
		phi = (2/n)*kron(sin(k*pi*x),sin(l*pi*x));
		lambda = 2*(1-cos(k*pi/n)) + 2*(1-cos(l*pi/n));
		err = err + norm(A*phi - n^2*lambda*phi);
	end
end
