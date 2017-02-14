function particles= init_distribution( regions,p,initFeature)
n=1;%
np = p / n;%
k = 1;
for i = 1:n%
      width = regions(3);%particle width
      height = regions(4);%particle height
      x = regions(1) + floor(width / 2);%partcle center location:x
      y = regions(2) + floor(height / 2);%partcle center location:y
      for j = 1:np
          particles(k).x = x;%current x-axis for partcle k,at time step t.
          particles(k).xp =x;%x-axis for partcle k,at time step t-1.
          particles(k).xp2 =x;%x-axis for partcle k,at time step t-2.
          particles(k).x0= x;%%initial x-axis for partcle k.
          
          particles(k).y = y;%current y-axis for partcle k,at time step t.
          particles(k).yp =y;%y-axis for partcle k,at time step t-1.
          particles(k).yp2 =y;%y-axis for partcle k,at time step t-2.
          particles(k).y0= y;%%initial y-axis for partcle k.
          
          particles(k).s = 1.0;%current scale for partcle k,at time step t.
          particles(k).sp =1.0;%scale for partcle k,at time step t-1.
          particles(k).sp2 =1.0;%scale for partcle k,at time step t-2.
          particles(k).s0 =1.0;%%%initial scale for partcle k.
          
          particles(k).width = width;%initial width for partcle k.
          particles(k).height = height;%initial height for partcle k.
          
          particles(k).v50 = initFeature;%current feature for partcle k.
          
          particles(k).w = 0;%current weight for partcle k.
          k=k+1;
      end
end