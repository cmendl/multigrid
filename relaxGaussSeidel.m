function u = relaxGaussSeidel(L,u,f,omega)
%
%	Reference:
%		Ulrich Trottenberg, Cornelius W. Oosterlee, Anton Schuller.
%		Multigrid, Academic Press (2001)

if omega==1
	LL = tril(L);
	u = LL\(f - triu(L,1)*u);
else
	% for omega=1, this is equal to tril(L)
	LL = diag(diag(L)) + omega*tril(L,-1);
	u = LL\((1-omega)*diag(L).*u + omega*(f - triu(L,1)*u));
end
