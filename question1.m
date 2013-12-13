function [ Top25_Eigenfaces ] = question1( images_per_subject, number_of_subjects )
if(nargin < 2) % We are just running question 1
    images_per_subject = 3;
    number_of_subjects = 10;
end

%% Step One: get the first three images from each person (30 total)
image_set = get_imageSet( images_per_subject,number_of_subjects );

%% Step Two: Read each image

S=[];
% figure;

for i = 1 : numel(image_set)
    img = imread(image_set{i});
%     subplot(ceil(sqrt(numel(image_set))),ceil(sqrt(numel(image_set))),i);
%     imshow(img);
%     if i==3
%         title('Training set','fontsize',18)
%     end
    drawnow;
    [irow, icol]=size(img);    % get the number of rows (N1) and columns (N2)
    temp=reshape(img',irow*icol,1);    % creates a (N1*N2)x1 vector
    S=[S temp];    % S is a N1*N2xM matrix after finishing the sequence
end

A = [];  
m = mean(S,2); % The average face
for i = 1 : size(S,2)
    temp = double(S(:,i)) - m; % Computing the difference image for each image in the training set Ai = Ti - m
    A = [A temp]; % Merging all centered images
end

L = A'*A; % L is the surrogate of covariance matrix C=A*A'.
[V, Eigenvalues] = eig(L); % Diagonal elements of D are the eigenvalues for both L=A'*A and C=A*A'.

L_eig_vec = [];
for i = 1 : size(V,2) 
    if( Eigenvalues(i,i)>1 )
        L_eig_vec = [L_eig_vec V(:,i)];
    else
        disp( 'Eigenvalue is less than one' );
    end
end

Eigenfaces = A * L_eig_vec; % A: centered image vectors

Top25_Eigenfaces = Eigenfaces(:,end-24:end);


figure;
for x = 1 : numel( Top25_Eigenfaces(2,:) )
    img=reshape(Top25_Eigenfaces(:,x),icol,irow);
    img = img';
    img=histeq(img,255);
    subplot(ceil(sqrt(numel(image_set))),ceil(sqrt(numel(image_set))),x)
    imshow(img)
    drawnow;
    
    if x==3
        title('Top 25 Eigenfaces','fontsize',18)
    end
end

end