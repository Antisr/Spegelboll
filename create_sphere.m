function P = create_sphere(N, radius)
  P = [];
  d = 2 / N; # Distance between points on y axis
  inc = pi * (3 - sqrt(5)); # Angle difference between points.
  
  for i = 0:N
    y = radius * ((i * d) - 1);
    
    r = sqrt(radius^2 - y^2);
    phi = ((i + 1) * inc); 
    
    x = cos(phi) * r;
    z = sin(phi) * r;
    
    P = [P; x y z];
  endfor
endfunction