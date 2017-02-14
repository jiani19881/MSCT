function samplesFtrVal = getFtrVal_includeScale(iH,samples,ftr,xdirScale,ydirScale)
sx = samples.sx;
sy = samples.sy;
px = round(ftr.px*xdirScale);
py = round(ftr.py*ydirScale);
pw = round(ftr.pw*xdirScale);
ph = round(ftr.ph*ydirScale);
pwt= ftr.pwt;
samplesFtrVal = FtrVal(iH,sx,sy,px,py,pw,ph,pwt); %feature without preprocessing
%the code in C++ file have been changed for FtrVal.