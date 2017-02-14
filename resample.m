function new_particles=resample(particles,n)
  k=1;flag=0;
  for i = 1: n
      np = round( particles(i).w * n );
      for j = 1: np
        new_particles(k) = particles(i);
        k=k+1;
        if k>n
            flag=1;
            break;
        end
      end
      if flag==1
        break;
      end
  end
  while k <= n
    new_particles(k) = particles(1);
    k=k+1;
  end