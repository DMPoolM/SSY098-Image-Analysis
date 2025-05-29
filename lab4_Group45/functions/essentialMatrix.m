function E = essentialMatrix(P1, P2)
    % Extract the camera centers from projection matrices
    C1 = null(P1);
    C2 = null(P2);

    % Skew-symmetric matrix S from camera centers
    S = [0, -C1(3), C1(2); 
         C1(3), 0, -C1(1); 
         -C1(2), C1(1), 0];

    % Essential matrix E
    E = S * P2 * pinv(P1);

    % Normalize essential matrix to ensure det(E) = 0
    [U, ~, V] = svd(E);
    E = U * diag([1, 1, 0]) * V';
end
