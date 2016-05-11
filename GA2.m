%% Start of Instructions
global I

% Function to read image from Local Drive
[file,path] = uigetfile('*.jpg','Pick an Image File'); 
% Open standard dialog box for retrieving files
% To browse the file from the coding folder 

if isequal(file,0) || isequal(path,0)      
    % If you not selecting file or click the cancel button 
    warndlg('You should Have to Select a person First'); 
    % Open warning dialog box with some message
    % Means it display the dialog box
else
    % Else
    a = imread(file);          
end
% Close the if loop

SelectedPerson=a;
I=SelectedPerson;
%%
% Open warning dialog box
warndlg('Please visit Command window to see iterations count for Genetic algorithm')


%%
%% Create genetic algorithm options structure
optpar = gaoptimset('Generations',20,'Display','iter'); 
% displays a complete list of parameters with their valid values

 
%% Find minimum of function using genetic algorithm
OptimumValue= ga(@fitness3, 1, [], [], [], [], 5,20, [], optpar );   
OptimumValue=round(OptimumValue);
I2=I;

%% Create a Virtual Structure of same size
final_image = zeros(size(I,1), size(I,2));
if(size(I, 3) > 1)
    
    %% Pixel wise looping
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            
            %% Separating R, G and B
            R = I(i,j,1);
            G = I(i,j,2);
            B = I(i,j,3);
           
            if(R > 100 && G > 55 && B > 42)
                v = [R,G,B];
                if((max(v) - min(v)) > 15)
                    
                
                    if(abs(R-G) > 22 && R > G && R > B)
                    if(abs(R-B) > OptimumValue && R > G && R > B)
                    if(abs((B+G)-R) > OptimumValue )
                    
                  
                      
                        final_image(i,j) = 1;
                    end
                    end
                    end
                end
            end
        end
    end

end
   
update_image(i,j) = final_image(i,j);
   
     
 %% Binary image
BW=im2bw(final_image);
%figure,imshow(BW);
%title('Binary image');

%% Connected Components-Detection of face

L = bwlabel(BW,4);
%BWLABEL Label==>connected components in 2-D binary image
BB = regionprops(L, 'BoundingBox');
%Measure properties of image regions (blob analysis)
BB1 =struct2cell(BB);
%struct2cell==>Convert structure array to cell array
BB2 = cell2mat(BB1);
%cell2mat==>Convert a cell array into a single matrix.
[s1 s2]=size(BB2);
%sizing BB2 in matrix format
mx=0;
for k=3:4:s2-1
    p=BB2(1,k)*BB2(1,k+1);
    if p>mx && (BB2(1,k)/BB2(1,k+1))<1.8
        mx=p;
        j=k;
    end
end
%% rgb to gray scale conversion


% Crop image
croppedImage = imcrop(I2, [BB2(1,j-2) BB2(1,j-1) BB2(1,j) BB2(1,j+1)]);
figure;  

imshow(croppedImage)


im=I;

figure;
imshow(im);
hold on;
%plot the rctangular box on face
rectangle('Position',[BB2(1,j-2),BB2(1,j-1),BB2(1,j),BB2(1,j+1)],'EdgeColor','r' , 'LineWidth', 4)
% Create 2-D rectangle object

% Create and open help dialog box
helpdlg('Skin Detection Process Completed on selected image');  

