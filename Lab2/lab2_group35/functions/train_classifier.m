function net = train_classifier(layers, imgs_train, labels_train, imgs_val, labels_val)

epochs = 25;
disp('Training the network')
options = trainingOptions('sgdm', 'MaxEpochs', epochs, 'Verbose', false);
net = trainNetwork(imgs_train, labels_train, layers, options);
tp = nnz(net.classify(imgs_val) == labels_val);
accuracy = tp / length(labels_val);
disp(['The network achieved an accuracy of: ', num2str((accuracy)*100), '%'])
end