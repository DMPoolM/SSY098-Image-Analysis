function [w, w0] = process_epoch_sequential(w, w0, lrate, examples_train, labels_train)
    % Iterate over each training example sequentially
    for i = 1:numel(labels_train)
        % Choose the training example
        example = examples_train{i};
        label = labels_train(i);

        % Compute gradient of the partial loss for the chosen example
        [wgrad, w0grad] = partial_gradient(w, w0, {example}, label);

        % Update weights and bias term using the computed gradients
        w = w - lrate * wgrad;
        w0 = w0 - lrate * w0grad;
    end
end