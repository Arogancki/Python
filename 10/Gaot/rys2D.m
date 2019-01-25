function rys2D(f,x,y)

s = size(x);
z(s(1),s(2)) = 0;

for p=1:s(1)
   for q=1:s(2)
      [aa z(p,q)]= feval(f,[x(p,q) y(p,q)],[]);
   end
end
mesh(x,y,z);
