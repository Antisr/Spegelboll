function asd123s = spegelboll(r, N, rainbow)
 
I_P = input('Ljuskällans punkt: ');
I_S = input('Bollens mittpunkt: ');

if nargin < 3
  rainbow = 0; # Represent angles as a rainbow.
endif
if nargin < 2
  N = 150; # Number of points
endif
if nargin == 0
  r = 1; # Radius
endif

P = I_P - I_S;    # Translates coordinates so sphere has a center in origo.

s_points = create_sphere(N, r);

L = 10^6;  #Large number to create 'long enough' lines.

adder = [I_S(1), I_S(1); I_S(2), I_S(2); I_S(3), I_S(3)]; # Corrects the earlier translation.

hold on

for i = 1:size(s_points,1)
  p_i = s_points(i, :);
  rv = p_i - P; # Direction vector from ligthsource to point on sphere.
  
  if dot(rv, p_i) < 0      
    # 1x2 of point on sphere and light source point on respective axis'
    x1 = [P(1), p_i(1)] + adder(1, :);
    y1 = [P(2), p_i(2)] + adder(2, :);
    z1 = [P(3), p_i(3)] + adder(3, :);
    
    # Reflection around a normal is given by R = V -2proj_n(V)
    # Note that normal of a poin on a sphere is its point.
    proj = p_i .* (dot(rv, p_i)/dot(p_i, p_i));
    refl = rv - proj .* 2;
    
    # 1x2 of point on sphere and a point far away along reflection vector on respective axis'
    x2 = [p_i(1), L * refl(1) + p_i(1)] + adder(1, :);
    y2 = [p_i(2), L * refl(2) + p_i(2)] + adder(2, :);
    z2 = [p_i(3), L * refl(3) + p_i(3)] + adder(3, :);
    
    beta = (-1) * dot(rv, p_i)/(norm(rv * norm(p_i))); # Angle of reflection represented as a number [0 - 1]
    
    color = [1 - beta, 0.3, beta]; # Chooses color based on angle.
    
      if rainbow == 1 # Represents angle with a greater variety of color.
      spectrum = jet(100);
      color = spectrum(round(100 * beta + 0.5), :);
    endif
    
    plot3(x1, y1, z1, 'color', color)
    plot3(x2, y2, z2, 'color', color, 'LineWidth', 2)
  endif
endfor

# Chooses a nice window.
d = norm(P);
a = [I_S(1) - d, I_S(1) + d, I_S(2) - d, I_S(2) + d, I_S(3) - d, I_S(3) + d];
axis(a)

  # Show points:
# plot3(s_points(:, 1) + I_S(1), s_points(:, 2) + I_S(2), s_points(:, 3) + I_S(3), 'g*')

# Create sphere:
[x, y, z] = sphere;
surf(r*x + I_S(1), r*y + I_S(2), r*z + I_S(3), 'edgecolor', 'none', 'facecolor', [0.8,0.8,0.8]);

hold off