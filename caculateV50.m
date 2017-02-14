function feature_particles=caculateV50(particles,iH,ftr)
num_particles=size(particles,2);
for j = 1:num_particles
    p=particles(j);
    
    new_w=round(p.width*p.s);%
    new_h=round(p.height*p.s);%
    xlu=p.x-floor(new_w/2);
    ylu=p.y-floor(new_h/2);
    
    samples.sx = xlu;samples.sy = ylu;samples.sw = new_w;samples.sh = new_h;
    p.v50=getFtrVal_includeScale(iH,samples,ftr,p.s,p.s);
    feature_particles(j)=p;
end