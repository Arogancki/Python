function y = system1(x)

mi_bm =  trapez(x, 15, 15, 18, 30);
mi_m = trojkat(x, 18, 30, 42);
mi_sr = trojkat(x, 30, 42, 54);
mi_s = trojkat(x, 42, 54, 64);
mi_bs =  trapez(x, 54, 64, 70, 70);

suma = mi_bm+mi_m+mi_sr+mi_s+mi_bs;

if suma==0
   y = 0;
else 
   y = (mi_bm*0 +mi_m*50 +mi_sr*100 +mi_s*75 +mi_bs*50 )/suma;
end
