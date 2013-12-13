clear all;
[image_set,array] = get_imageSet(5,10);

scores{10} = [];

for x = 1 : numel(image_set)
    current_scores = scores{array(x)};
    sim = proj3(image_set{x},20);
    current_scores(end+1,:) = sim;
    scores{array(x)} = current_scores;
end

%% Genuine scores
genuine = [];
impostor = [];
for x = 1 : 10
    curr = scores{x};
    genuine(end+1) = sum( (curr(1,:)-curr(2,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(1,:)-curr(3,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(1,:)-curr(4,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(1,:)-curr(5,:)).^2).^0.5;
    
    genuine(end+1) = sum( (curr(2,:)-curr(1,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(2,:)-curr(3,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(2,:)-curr(4,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(2,:)-curr(5,:)).^2).^0.5;
    
    genuine(end+1) = sum( (curr(3,:)-curr(1,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(3,:)-curr(2,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(3,:)-curr(4,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(3,:)-curr(5,:)).^2).^0.5;
    
    genuine(end+1) = sum( (curr(4,:)-curr(1,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(4,:)-curr(2,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(4,:)-curr(3,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(4,:)-curr(5,:)).^2).^0.5;
    
    genuine(end+1) = sum( (curr(5,:)-curr(1,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(5,:)-curr(2,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(5,:)-curr(3,:)).^2).^0.5;
    genuine(end+1) = sum( (curr(5,:)-curr(4,:)).^2).^0.5;
end

for x = 1 : 10
    xScores = scores{x};
    for y = x+1 : 10
        yScores = scores{y};
        for z = 1 : 5
            for w = 1 : 5
                impostor(end+1) = sum( (xScores(z,:)-yScores(w,:)).^2).^0.5;
            end
        end
    end
end

roc(genuine,impostor, 'd');

return;