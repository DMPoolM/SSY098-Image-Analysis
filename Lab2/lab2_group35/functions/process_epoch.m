function [w, w0] = process_epoch(w, w0, lrate, examples_train, labels_train)

idx = randperm(size(examples_train, 2));


    for i = idx
        [wgrad, w0grad] = partial_gradient(w, w0, cell2mat(examples_train(i)), labels_train(i));
    
        w = w - lrate * wgrad;
    
        w0 = w0 - lrate * w0grad;
    
    end
end