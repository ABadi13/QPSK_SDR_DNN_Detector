function delay = find_delay(M, MRx, start, shift)

% original bitstream
M = M.';
Mstream = M(:);     

% received bitstream
MRx = qpsk_shift(MRx,shift);
MRx = MRx.';
MRxstream = MRx(:);

% number of bits to search with
size = 1000;

for i = 1:100000000
    
    % if all (size) bits are equal 
    if all( Mstream(start*2-i+2-size:start*2-i+1) ==...
            MRxstream(start*2+1-size:start*2) )
        
        delay = ( i-1 )/2;
        return
    end
end

disp('Delay not found!')
