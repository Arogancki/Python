function Yp =  spr(we, wagi)
    s=size(we);
    s(1)
    Yp = 0;
    for y=1:s(1)
        Yp = Yp + (we(y) * wagi(y));
    end
end