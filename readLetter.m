function [image] = readLetter(image_path, letter, n)
    
    image_path = image_path + "Baza" + letter;
    
    if n < 100
        image_path = image_path + "0";
    end
    if n < 10
        image_path = image_path + "0";
    end 
    
    image = imread(image_path + num2str(n) + ".bmp");
    
    % Prebacivanje u double
    image = im2double(image);
    
end