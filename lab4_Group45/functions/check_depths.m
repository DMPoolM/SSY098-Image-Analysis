function positive = check_depths(Ps, U)

    n_cameras = length(Ps);
    positive = [];
    for i = 1:n_cameras

        x = Ps{i} * [U; 1];
    
        if x(3) < 0
            positive = [positive, false];
    
        else
            positive = [positive, true];
        end
    end
end