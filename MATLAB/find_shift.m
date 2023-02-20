function [shift, p_loc] = find_shift(MRx, start, frame_size)

size = 7;        % amount of frames to check for

for i = 0:frame_size-1
    
    % if symbol repeated (size) times
    if all([ ~xor( MRx(start+i:frame_size:start+frame_size*size,1),...
                    MRx(start+i,1)) ,...
             ~xor( MRx(start+i:frame_size:start+frame_size*size,2),...
                    MRx(start+i,2)) ])
        
        p_loc = i;          % pilot location
        
        % mapping
        if all(MRx(start+i,:)==[ 0 0 ])
            shift = 0;
            return
        elseif all(MRx(start+i,:)==[ 1 1 ])
            shift = 180;
            return
        elseif all(MRx(start+i,:)==[ 0 1 ])
            shift = 90;
            return
        elseif all(MRx(start+i,:)==[ 1 0 ])
            shift = 270;
            return
        end
        
    end
end

disp('Shift  not found!')