function p = reflection(v, n)
  # Projection v on n
  proj = n .* (dot(v, n)/dot(n, n));
  p = v - proj .* 2;
endfunction
