function u_next = relaxJacobi(L,u,f,omega)
%
%	Reference:
%		Ulrich Trottenberg, Cornelius W. Oosterlee, Anton Schuller.
%		Multigrid, Academic Press (2001)

u_next = u + omega./diag(L).*(f - L*u);
