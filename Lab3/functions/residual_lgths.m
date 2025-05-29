function res = residual_lgths(A, t, pts, pts_tilde)
    pts_trans = A * pts + t;
    
    M = pts_trans - pts_tilde;
    res = sum(M.^2, 1);
end