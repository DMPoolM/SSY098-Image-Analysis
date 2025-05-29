function [U, nbr_inliers] = ransac_triangulation(Ps, us, threshold)

    N = numel(Ps);
    max_iterations = 1000;
    best_U = [];
    best_inliers = 0;

    for iter = 1:max_iterations
        % Randomly sample two indices for minimal solver
        idx = randperm(N, 2);
        Ps_sampled = Ps;
        us_sampled = us(:, idx);

        U = minimal_triangulation(Ps_sampled, us_sampled);

        inliers = 0;
        for i = 1:N
            errors = reprojection_errors({Ps{i}}, us(:, i), U);
            if errors <= threshold
                inliers = inliers + 1;
            end
        end

        if inliers > best_inliers
            best_inliers = inliers;
            best_U = U;
        end
    end

    U = best_U;
    nbr_inliers = best_inliers;
end
