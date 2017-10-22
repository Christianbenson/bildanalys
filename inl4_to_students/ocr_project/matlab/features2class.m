function y = features2class(x,classification_data)
%find nearest neighbour
    nearest_neighbour_distance = intmax;
    nearest_neighbour_class = 0;
    for i = 1:size(classification_data{1,1},2)
        distances = x - classification_data{1,1}(:,i);
        distance = sqrt(sum(distances.^2));
        if distance < nearest_neighbour_distance
            nearest_neighbour_distance = distance;
            nearest_neighbour_class = classification_data{2,1}(1,i);
        end
    end
    y = nearest_neighbour_class;
end