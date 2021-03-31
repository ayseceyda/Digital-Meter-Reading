filePattern = fullfile('C:\Users\Analythinx\Documents\MATLAB\digital', '*.JPG');
files = dir(filePattern);

for i=1:length(files)
    filename = files(i);
    fname = filename.name;
    contr(fname);
end

function contr(filename)

    file = fullfile('digital', filename);
    img = imread(file);
    
    % Converting to grayscale
    I = rgb2gray(img);
    
    J = adapthisteq(I);
    
    % Adaptive threshold
    T = adaptthresh(J,0.4,'ForegroundPolarity','dark', 'Statistic', 'gaussian');
    BW = imbinarize(J,T);

    % Complement first
    Icomplement = imcomplement(BW);
    
    % Remove salt and pepper noise
    K = medfilt2(Icomplement, [4,4]);

    % Revert again to black on white background
    FinalComplement = imcomplement(K);
 
    imshow(FinalComplement);
          
    % Saving the new image in a new folder
    newname = fullfile('output', filename);
    imwrite(FinalComplement, newname)
        
end