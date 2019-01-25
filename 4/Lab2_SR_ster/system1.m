function y = system1(x)

bl = trapez(x, -180, -180, -40, -20);
l = trojkat(x, -40, -20, 0);
ok = trojkat(x, -20, 0, 20);
r  = trojkat(x, 0, 20, 40);
br = trojkat(x, 20, 40, 180);

suma = bl + l + ok + r + br;

if suma==0
   y = 0;
else 
   y = (bl*-20 + l*-12 + ok*0 + r*12 + br*20)/suma;
end
