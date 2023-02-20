function d = qpsk_shift(d,shift)

if shift == 180
    d = (d-1)*-1;
elseif shift == 90 || shift ==  -270
    d_1 = d(:,1);
    d(:,1) = (d(:,2)-1)*-1;
    d(:,2) = d_1;
elseif shift == 270 || shift == -90
    d_1 = d(:,1);
    d(:,1) = d(:,2);
    d(:,2) = (d_1-1)*-1;
end
