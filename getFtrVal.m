function samplesFtrVal = getFtrVal(iH,samples,ftr)
sx = samples.sx;
sy = samples.sy;
px = ftr.px;
py = ftr.py;
pw = ftr.pw;
ph = ftr.ph;
pwt= ftr.pwt;

samplesFtrVal = FtrVal(iH,sx,sy,px,py,pw,ph,pwt); %feature without preprocessing
