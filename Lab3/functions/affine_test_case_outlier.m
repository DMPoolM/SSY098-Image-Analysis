function [pts, pts_tilde, A_true, t_true] = affine_test_case_outlier(outlier_rate)
    N = randi([3, 200]);
    n_outliers = round(N*outlier_rate);
    A_true = randn(2, 2);
    t_true = randn(2, 1) * 100;
    pts = rand(2, N);
    pts_tilde = A_true * pts + t_true;
    outliers = N * randn(1, n_outliers);
    idx_outliers = randperm(N, n_outliers);
    pts_tilde(idx_outliers) = outliers;
end