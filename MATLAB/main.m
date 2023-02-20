
%% extract data from binary files by gnu radio

path = './GNU Radio/';
append = '15__4'
path = [path, append]

mu = 2;
osps = 1;

[d1_sorted, d2_sorted, d3_sorted] = extract_data(path,mu,osps);

%% find pilots and determine phase shift

start = 2000000;
frame_size = 4;

[shift, p_loc] = find_shift(d2_sorted, start, frame_size)
%% find delay

delay = find_delay(d1_sorted, d2_sorted, start, shift)

fprintf('d2_sorted[%i]==d1_sorted[%i]\n',start,start-delay)


%% save data for python tensorflow

% pilots always at start of block
start = start + p_loc;

epoch_size = 4*100000;
val_size = 4*70000;
test_size = 4*1000000;

M   = d1_sorted(start-delay:start-delay+epoch_size-1,:);
MRx = d2_sorted(start:start+epoch_size-1,:);
Rx  = d3_sorted(start:start+epoch_size-1,:);

val_start = start+epoch_size;
M_val   = d1_sorted(val_start-delay : val_start-delay+val_size-1,:);
MRx_val = d2_sorted(val_start : val_start+val_size-1,:);
Rx_val  = d3_sorted(val_start : val_start+val_size-1,:);

test_start = start+epoch_size+val_size;
M_test   = d1_sorted(test_start-delay : test_start-delay+test_size-1,:);
MRx_test = d2_sorted(test_start : test_start+test_size-1,:);
Rx_test  = d3_sorted(test_start : test_start+test_size-1,:);

save(['sdr_data', append ,'.mat'],...
    'M','MRx','Rx','epoch_size',...
    'M_val','MRx_val','Rx_val','val_size',...
    'M_test','MRx_test','Rx_test','test_size',...
    'delay','shift','start','append')

%% find ber

[ber, err] = find_ber(M_test, MRx_test, frame_size, shift)

