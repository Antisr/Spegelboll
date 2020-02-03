function asd123s = spegelboll(I_P, I_S, r, N)

if nargin < 4
  N = 150;
endif
if nargin < 3
  r = 1;
endif
if nargin < 2
  I_S = [0, 0, 0];
endif
if nargin == 0
  I_P = [2, 2, 2];
endif

# I_P = [5 2 1];    # Light-source coords
# I_S = [2 9 1];     # Sphere, Center coords
# N = 150;            # Number of points on sphere
# r = 2;             # Sphere, Radius

close all

P = I_P - I_S;    # Light-source coords

s_points = fib_sphere(N, r);

# Riktningsvektor för linje från ljuskälla till l
# V
lv = [];

for i= 1:size(s_points,1)
  ilv = s_points(i,:) - P; # Riktningsvektor på linje
  
  lv = [lv; ilv];
endfor

# Drawing lines and creating mirrored vector.
hold on

L = 10^10;  # One LARGE number.

adder = [I_S(1), I_S(1); I_S(2), I_S(2); I_S(3), I_S(3)];


for i = 1:size(s_points,1)
  p_i = s_points(i, :);
  
  if dot(lv(i, :), p_i) < 0      
    # Draws line between point on sphere and light source
    a = [P(1), p_i(1)] + adder(1, :);
    b = [P(2), p_i(2)] + adder(2, :);
    c = [P(3), p_i(3)] + adder(3, :);
    plot3(a, b, c, 'y')
    
    # Spegling kring en normal ges av R = V - 2proj_n(V)
    # Normalvektor --> p_i eftersom det är en sfär med centrum i origo.
    ref = reflection(lv(i, :), p_i);
    
    a2 = [p_i(1), L * ref(1) + p_i(1)] + adder(1, :);
    b2 = [p_i(2), L * ref(2) + p_i(2)] + adder(2, :);
    c2 = [p_i(3), L * ref(3) + p_i(3)] + adder(3, :);
    
    beta = (-1) * dot(lv(i,:),p_i)/(norm(lv(i,:)) * norm(p_i));
    color = [1 - beta, 0.3, beta];
    
    # spectrum = jet(100);
    # color = spectrum(round(100 * beta + 0.5), :);
    
    plot3(a, b, c, 'color', color)
    plot3(a2, b2, c2, 'color', color, 'LineWidth', 2)
  endif
endfor

# Distance between lightsource and sphere center
d = norm(P);
a = [I_S(1) - d, I_S(1) + d, I_S(2) - d, I_S(2) + d, I_S(3) - d, I_S(3) + d];

axis(a)

# plot3(s_points(:, 1) + I_S(1), s_points(:, 2) + I_S(2), s_points(:, 3) + I_S(3), 'g*')

[x, y, z] = sphere;

surf(r*x + I_S(1), r*y + I_S(2), r*z + I_S(3), 'edgecolor', 'none', 'facecolor', [0.8,0.8,0.8]);

hold off


# spegelboll([-12, 2, 51], [12, 20, 30], 10, 200)