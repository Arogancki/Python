function wzorce = paterns(drukuj)
wzorce(:,:,1) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

wzorce(:,:,2) = [
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
];

wzorce(:,:,3) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 0 0;
2 2 0 0 0 0;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

wzorce(:,:,4) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

wzorce(:,:,5) = [
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
];

wzorce(:,:,6) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 0 0;
2 2 0 0 0 0;
2 2 2 2 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

wzorce(:,:,7) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 0 0;
2 2 0 0 0 0;
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

wzorce(:,:,8) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
];

wzorce(:,:,9) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

wzorce(:,:,10) = [
2 2 2 2 2 2;
2 2 2 2 2 2;
2 2 0 0 2 2;
2 2 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
0 0 0 0 2 2;
0 0 0 0 2 2;
2 2 2 2 2 2;
2 2 2 2 2 2;
];

if drukuj
    for i=1:10
        subplot(2,5,i)
        imagesc(wzorce(:,:,i));
    end
end

wzorce = wzorce - 1;

end