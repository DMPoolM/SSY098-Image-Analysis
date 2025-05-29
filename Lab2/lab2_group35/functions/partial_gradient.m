function [wgrad, w0grad] = partial_gradient(w, w0, example_train, label_train)

y = dot(example_train, w) + w0;

partial = exp(y) / (1 + exp(y));

    if label_train == 1
    
        wgrad = (partial - 1) * example_train;
        w0grad = (partial - 1);
    
    else
    
        wgrad = partial * example_train;
        w0grad = partial;
    
    end
end