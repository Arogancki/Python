function [x,val] = DeJongF2(x,options)
    % bez ograniczenia
    
    % funkcja Goldsteina-Prica
    %val = 1+ (x(1)+x(2)+1).^2 * (19-14*x(1) + 3*x(1).^2 - 14*x(2) + 6*x(1)*x(2)+3*x(2).^2)* (30+(2*x(2)-3*x(2)).^2*(18-32*x(1)+12*x(1).^2+48*x(2)-36*x(1)*x(2)+27*x(2).^2));
    
    % f2
    %val = (100*(x(1)*x(1) - x(2))^2 + (1 - x(1)*x(1))^2);
    
    % f3
   %val = 0.5 + ((sin(sqrt(x(1).^2+x(2).^2)-0.5).^2)/(1.0+0.001*(x(1).^2+x(2).^2)).^2);
    
    % ograniczenia
    wspolczynik_kary = 12;
    %{
    % f1
    val = 100* (x(2) - (x(1)).^2 ).^2 + (1-x(1)).^2;
   
    g1 = x(1) + x(2).^2;
    g2 = x(1).^2 + x(2);
    
    f1 = abs(min(g1,0));
    f2 = abs(min(g2,0));
    % f2
    val = - x(1) - x(2);
    
    g1 = 2*(x(1).^4) - 8*(x(1).^3) + 8*(x(1).^2) + 2 - x(2);
    g2 = 4*(x(1).^4) - 32*(x(1).^3) + 88*(x(1).^2) - 96*x(1) + 36 - x(2);
    
    f1 = abs(min(g1,0));
    f2 = abs(min(g2,0));
%}
    % f3
    val = (x(1) - 10).^3 + (x(2) - 20).^3;
    
    g1 = (x(1)-5).^2 + (x(2)-5).^2 - 100;
    g2 = -((x(1)-6).^2) - ((x(2)-5).^2) + 82.81;
    
    f1 = abs(min(g1,0));
    f2 = abs(min(g2,0)); 
    
    
    val = val + (f1+f2)*wspolczynik_kary;
    
    val = -val;
end