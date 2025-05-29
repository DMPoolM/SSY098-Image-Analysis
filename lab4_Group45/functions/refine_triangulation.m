function U = refine_triangulation(Ps, us, Uhat)


n_iter = 5;

for i = 1:n_iter

    r = compute_residuals(Ps, us, Uhat);
    J = compute_jacobian(Ps, Uhat);
    Uhat = Uhat - ((J' * J) \ J') * r;

end

U = Uhat;

end