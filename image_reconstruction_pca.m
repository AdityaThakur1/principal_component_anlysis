load('teapots.mat')
image_dat = teapotImages;
%Get the mean of the data (for all 100 images in dataset)
mu = mean(image_dat);
figure(1);
imagesc(reshape(mu,38,50));
colormap  gray;
title('Mean image data');

x = image_dat - mu;
Covarience_mat = cov(x);
%eig(C) returns diagonal matrix D of eigenvalues and matrix V whose columns are the corresponding right eigenvectors, so that A*V = V*D.
[V, D] = eig(Covarience_mat);
%Taking top 3 eigen values and eigen vectors by sorting
[evalue, evector] = sort(diag(D),'descend');

e_val = evalue(1:3,:);
e_vec = V(:,evector(1:3));
e_vec1 = e_vec';

%top 3 eigenvectors of data covarience as images
figure(2);
a1 = num2str(evalue(1)); b1 = 'Eigen Value = '; legend = [b1 a1];
colormap gray;
subplot(1,3,1);
imagesc(reshape(e_vec1(1,:),38,50));
title(legend);
axis image;
a1 = num2str(evalue(2)); b1 = 'Eigen Value = '; legend = [b1 a1];
subplot(1,3,2)
imagesc(reshape(e_vec1(2,:),38,50));
title(legend);
axis image;
a1 = num2str(evalue(3)); b1 = 'Eigen Value = '; legend = [b1 a1];
subplot(1,3,3)
imagesc(reshape(e_vec1(3,:),38,50));
title(legend);
axis image;

%coefficient matrix
c = x*e_vec;
x_hat = mu+c*e_vec';

for j = 1:10
    figure(j+2);
    k = j*10; 
    subplot(1,2,1);
    imagesc(reshape(image_dat(k,:),38,50));
    colormap gray;
    title('Before reconstruction');
    axis image;
    subplot(1,2,2)
    imagesc(reshape(x_hat(k,:),38,50));
    colormap gray;
    title('After reconstruction (PCA)');
    axis image;
end
