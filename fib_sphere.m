function P = fib_sphere(N, radius)
  P = [];
  d = 2 / N;
  inc = pi * (3 - sqrt(5));
  
  for i = 0:N
    y = radius * ((i * d) - 1);
    r = sqrt(radius^2 - y^2);
    
    phi = ((i + 1) * inc);
    
    x = cos(phi) * r;
    z = sin(phi) * r;
    
    P = [P; x y z];
  endfor
endfunction