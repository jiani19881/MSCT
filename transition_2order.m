function tranParticles=transition_2order(particles,w,h)
num_particles=size(particles,2);
%parameters:
TRANS_X_STD=5;
TRANS_Y_STD=2.5;
TRANS_S_STD=0.06;
A1=2;
A2=-1;
B0=1;
maxSscale=0.5;%
minS=0.5;%
for j = 1:num_particles
    p=particles(j);     %
    pn=p;               %
    %2-order transition for x,y,s
	x = A1 * ( p.x - p.x0 ) + A2 * ( p.xp - p.x0 )+B0 * normrnd(0,TRANS_X_STD) + p.x0;
    x=round(x);
	y = A1 * ( p.y - p.y0 ) + A2 * ( p.yp - p.y0 )+B0 * normrnd(0,TRANS_Y_STD ) + p.y0;
    y=round(y);
	s = A1 * ( p.s - 1.0 ) + A2 * ( p.sp - 1.0 )+B0 * normrnd( 0, TRANS_S_STD ) + 1.0;%
    s=min([maxSscale*w/p.width,maxSscale*h/p.height,max(minS,s)]);    
    %rectify of particle location
    new_w=round(p.width*s);
    new_h=round(p.height*s);%
    xlu=x-floor(new_w/2);
    ylu=y-floor(new_h/2);
    xrd=xlu+new_w-1;
    yrd=ylu+new_h-1;
    if xlu<=0
       x=1+floor(new_w/2);
    end
    if ylu<=0
       y=1+floor(new_h/2);
    end
    if xrd>=w+1
       x=w+floor(new_w/2)-new_w+1;
    end
    if yrd>=h+1
       y=h+floor(new_h/2)-new_h+1;
    end
    pn.x = x;
    pn.y = y;
    pn.s = s;

    pn.xp = p.x;
    pn.yp = p.y;
    pn.sp = p.s;

    pn.xp2 = p.xp;
    pn.yp2 = p.yp;
    pn.sp2 = p.sp;
    
    tranParticles(j)=pn;
end