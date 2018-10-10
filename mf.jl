#####################################
# this function gets array and returns
# sum of all elements' squares
###################################
function ad_Some_Of_Squares(arr)
    tot=0;
    for i=1:length(arr)
        tot+=arr[i]^2;
    end
    return tot;
end

############################################
#    this function will do the match filter
############################################
function  NormCorrClean(Data,Ref)
    corr="AA";
    StartIndx = length(Ref) ;
    StopIndx = length(Data) + length(Ref) -1 ;

    K =  ad_Some_Of_Squares(Ref);

    corr="$StartIndx -> $StopIndx -> $K" ;
     return corr;
end

print(NormCorrClean([2],[4,3,2]));
