function y = system1(x)

bl = trojkat(x, -180, -180, -90);
l  = trojkat(x, -180, 0, -30);
ok = trojkat(x, -30, 0, 30);
r  = trojkat(x, 0, 60, 120);
br = trojkat(x, 90, 180, 180);

suma = sl + bl + l + ok + r + br + sr;

if suma==0
   y = 0;
else 
   y = (sl*-20 + bl*-15 + l*-8 + ok*0 + r*8 + br*15 + sr*20)/suma;
end
