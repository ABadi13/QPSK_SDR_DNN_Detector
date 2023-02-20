function [d1_sorted, d2_sorted, d3_sorted] = extract_data(path,mu,osps)

% extract original bitstream
f1 = fopen([ path , 'od' ]);
d1 = fread(f1);
fclose(f1);
d1_sorted = [d1(1:mu:end) d1(2:mu:end)];

% extract received bitstream
f2 = fopen([ path , 'sd' ]);
d2 = fread(f2);
fclose(f2);
d2_sorted = [d2(1:mu:end) d2(2:mu:end)];

% extract received synched symbols
f3 = fopen([path , 'RxSignalUnsynched' ]);
d3 = fread(f3,'float');
fclose(f3);
%d3_complex = [d3(1:2:end)+d3(2:2:end)*1j];
d3_sorted = [];
for i = 1:osps*2
    d3_sorted = [d3_sorted d3(i:osps*2:end)];
end

% extract received unsynched samples
% f4 = fopen([ path , 'rxunsynched.bin' ]);
% d4 = fread(f4);
% fclose(f4);
% d4_complex = [d3(1:2:end)+d3(2:2:end)*1j];
% d4_sorted = [];
% for i = 1:sps*2
%     d4_sorted = [d4_sorted d3(i:sps*2:end)];
% end