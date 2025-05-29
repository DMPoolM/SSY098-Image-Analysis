function [A,t] = ransac_fit_affine(pts, pts_tilde, threshold)
    % Instantiate A and t
    A = zeros(2,2);
    t = zeros(2,1);
    
    % Number of points
    N = size(pts,2);

    % Determine number of samples for each iteration 
    % (3 seems to be fine for the majority of the assignment)
    N_samples = 3;          

    % RANSAC parameters
    N_inliers_best = 0;
    eta = 0.95;
    k_max = inf;
    k = 0;
    success = true;

    % While it will be beneficial to keep searching for better fit
    % keep searching...
    while k < k_max
        
        % increment the iteration counter
        k = k+1;

        % pick N_sample random points and use as sample
        i = randperm(N,N_samples);

        % Extract points and points_tilde
        sample_pts = pts(:,i);
        sample_pts_tilde = pts_tilde(:,i);
    
        % Estimate affine transformation given the sample points
        [A_sample, t_sample] = estimate_affine(sample_pts,sample_pts_tilde);
    
        % Calculate the residuals for ALL points
        res = residual_lgths(A_sample, t_sample, pts, pts_tilde);
    
        % Count number of inliers
        N_inliers = sum(res<threshold);
    
        % Check if this affine estimation has more number of inliers than
        % previous best
        if N_inliers > N_inliers_best
    
            % Update best number of inliers
            N_inliers_best = N_inliers;

            % Calculate inlier ratio epsilon
            eps = N_inliers/N;

            % Compute maximum number of iterations
            k_max = round( abs( log(1-eta) / log(1-(eps.^N_samples))));

            % Update A and t
            A = A_sample;
            t = t_sample;

            % Calculate the residual for this affine transform
            best_res = mean(residual_lgths(A, t, pts, pts_tilde),'all');
    
        end

        %If the RANSAC goes on for too long, break
        if k == 100000
            disp('RANSAC reached 100000 iterations, terminating search for better fit')
            success = false;
            break
        end
    end

    % When solution is found, print information
    if success
        fprintf('======================================\n')
        fprintf('RANSAC iterations done!\nIt took k=%.0f iterations to terminate...\nResidual: %.2f \n', k,best_res)
        fprintf('Number of inliers: %.0f \n',N_inliers_best)
        fprintf('======================================\n')
    end

end