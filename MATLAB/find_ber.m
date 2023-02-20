function [ber err] = find_ber(M, MRx, frame_size, shift)

MRx = qpsk_shift(MRx,shift);

ind = ones(1,length(M))==1;
ind(1:frame_size:end) = false;      % false at pilots only

M_no_p = M(ind,:);        % no pilots for original bitstream

MRx_no_p = MRx(ind,:);    % no pilots for received bitstream

ber = 1 - ...
    sum( all( M_no_p(:) == MRx_no_p(:) ,2 ))...
    /length(M_no_p)/2;

err = ber*length(M_no_p)*2;       % number of errors