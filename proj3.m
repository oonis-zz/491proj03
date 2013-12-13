%% Loading the Images
clear all
% input_dir = ‘D:\MATLAB R2012a\work’;
% image_dims = [300, 238];
% 
% filenames = dir(fullfile(input_dir, ‘*.jpg’));
% num_images = numel(filenames);
% 
% images = zeros(prod(image_dims),num_images);
% 
% for n = 1:num_images
% filename = fullfile(input_dir, filenames(n).name);
% img = imread(filename);
% % img = rgb2gray(img); % I’ve done it manually before using IrfanView
% img = im2double(img); % Thanks to this line the best match is shown. Without it it was just a white space.
% img = imresize(img,image_dims);
% images(:, n) = img(:);
% end

image_set = get_imageSet( 5,10 );
num_images = numel(image_set);

%% Step Two: Read each image

images = [];
% figure;

for i = 1 : numel(image_set)
    img = imread(image_set{i});
    img = im2double(img);
%     subplot(ceil(sqrt(numel(image_set))),ceil(sqrt(numel(image_set))),i);
%     imshow(img);
%     if i==3
%         title('Training set','fontsize',18)
%     end
%     drawnow;
    [irow, icol]=size(img);    % get the number of rows (N1) and columns (N2)
    temp=reshape(img',irow*icol,1);    % creates a (N1*N2)x1 vector
    images=[images temp];    % S is a N1*N2xM matrix after finishing the sequence
end


%% Training
% steps 1 and 2: find the mean image and the mean-shifted input images
mean_face = mean(images, 2);
shifted_images = images - repmat(mean_face, 1, num_images);

% steps 3 and 4: calculate the ordered eigenvectors and eigenvalues
[evectors, score, evalues] = princomp(images', 'econ');

% step 5: only retain the top ‘num_eigenfaces’ eigenvectors (i.e. the principal components)
num_eigenfaces = 25;
evectors = evectors(:, 1:num_eigenfaces);
% evalues = evalues(1:num_eigenfaces); % Get the evalues for the top 25

% step 6: project the images into the subspace to generate the feature vectors
features = evectors'*shifted_images;


%% Question One: display the top 25 images
figure;
for x = 1 : numel( evectors(2,:) )
    img=reshape(evectors(:,x),icol,irow);
    img = img';
    img=histeq(img,255);
    subplot(ceil(sqrt(numel(image_set))),ceil(sqrt(numel(image_set))),x)
    imshow(img)
    drawnow;
    
    if x==3
        title('Top 25 Eigenfaces','fontsize',18)
    end
end


return;

%% Question Three: Compute the euclidean distance between everything
% calculate the similarity of the input to each training image
input_image = imread('PC044879_cr.jpg');
% input_image = rgb2gray(input_image);
input_image = imresize(input_image,image_dims);
input_image = im2double(input_image);
feature_vec = evectors' * (input_image(:) - mean_face);

similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

% find the image with the highest similarity
[match_score, match_ix] = min(similarity_score);

% % display the result
% figure, imshow([input_image reshape(images(:,match_ix), image_dims)]);
% colormap(gray);
% title(sprintf(‘matches %s, score %f’, filenames(match_ix).name, match_score));

% display the result
figure, imshow([input_image reshape(images(:,match_ix), image_dims)]);
% colormap(gray);
title(sprintf('matches %s, score %f', filenames(match_ix).name, match_score));

% display the eigenvectors
figure;
% for n = 1:num_eigenfaces
% subplot(2, ceil(num_eigenfaces/2), n);
% evector = reshape(evectors(:,n), image_dims);
% imshow(evector);
% end
for n = 1:num_eigenfaces
subplot(2, ceil(num_eigenfaces/2), n);
evector = reshape(evectors(:,n), image_dims);
imagesc(evector);
colormap(gray); % Thanks to this line I’ve got all the eigenfaces instead of getting black rectangles
end