function initstate=getRect(p)
    w=round(p.width*p.s);%real width
    h=round(p.height*p.s);%real height
    x=p.x-floor(w/2);
    y=p.y-floor(h/2);
    initstate=[x,y,w,h];