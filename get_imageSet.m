function [ image_set,some_array ] = get_imageSet( images_per_subject, number_of_subjects )
% images_per_subject = 3;
% number_of_subjects = 10;
image_set = {};
some_array = [];
count=1;
listings = dir( fullfile('./','images') );

for i = 1 : images_per_subject
    for j = 1 : number_of_subjects
        
        some_array(count) = j;
        count = count + 1;
        
        if(j<10)
            img_pt1 = horzcat( 'user0',num2str(j),'_' );
        else
            img_pt1 = horzcat( 'user',num2str(j),'_' );
        end
        
        if(i<10)
            img_pt2 = horzcat( '0',num2str(i),'.bmp' );
        else
            img_pt2 = horzcat(num2str(i),'.bmp');
        end
        
        image_location = fullfile( './','images',horzcat(img_pt1,img_pt2) );
        image_set{end+1}=image_location;
        
    end
end


end
