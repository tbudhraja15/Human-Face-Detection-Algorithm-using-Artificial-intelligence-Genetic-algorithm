%% Fitness function

function OptVal= fitness3(in)
global I
Whitevalues=0;

final_image = zeros(size(I,1), size(I,2));
TotalValues=size(I,1)* size(I,2);
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            R = I(i,j,1);
            G = I(i,j,2);
            B = I(i,j,3);
           
            if(R > 100 && G > 55 && B > 42)
                  if(abs(R-B) > in)
                    if(abs((B+G)-R) > in )   
                        final_image(i,j) = 1;
                        Whitevalues=Whitevalues+1;
                    end
                    end
                end
            end
        end
       
     
     
 PercentageValue=(Whitevalues/TotalValues)*100;
 PercentageValue=ceil(PercentageValue);
if PercentageValue>=10 && PercentageValue<=15
     OptVal=PercentageValue+in; 
else
    OptVal=PercentageValue;
end
end 
 

%% End of Instructions
 
