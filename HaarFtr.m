function [px,py,pw,ph,pwt] = HaarFtr(clfparams,ftrparams,M)%modified
width = clfparams.width;
height = clfparams.height;

px = zeros(M,ftrparams.maxNumRect);
py = zeros(M,ftrparams.maxNumRect);
pw = zeros(M,ftrparams.maxNumRect);
ph = zeros(M,ftrparams.maxNumRect);
pwt= zeros(M,ftrparams.maxNumRect);

for i=1:M
     numrects = ftrparams.minNumRect + randi(ftrparams.maxNumRect-ftrparams.minNumRect+1)-1;
     for j = 1:numrects
        px(i,j) = randi(width-3);
        py(i,j) = randi(height-3);
        pw(i,j) = randi(width-px(i,j)-2);
        ph(i,j) = randi(height-py(i,j)-2);        

        pwt(i,j)= (-1)^(randi(2));
        pwt(i,j)=pwt(i,j)/sqrt(numrects);
     end      
end