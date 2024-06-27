%% This function takes in pos_cut7_pk.mat matrix and transate it into lvt.mat
% Input: cut7_pos_pk for the two cut7 spots, timeStep and PixelSize from image data
% Output: a single spindle length vs. time matrix, 
% where time in seconds and spindle length in microns.

function lvt_matrix = translateLvT(pos_cut7_pk, time_step, pixel_size)

    cut7pk_vector = squeeze(pos_cut7_pk(1,:,:) - pos_cut7_pk(2,:,:));
    cut7pk_vector_micron = cut7pk_vector .* [pixel_size(1); pixel_size(2)];
    % Unused: p2p distance in pixels
    % p2p_len_pix = sqrt(sum((cut7pk_vector.^2), 1));           % p2p distance in pixels
    p2p_len_micron = sqrt(sum((cut7pk_vector_micron.^2), 1));   % p2p distance in microns

    % Construct the lvt matrix, an nx2 matrix of the form [t(min),length(μm)]: 
    lvt_matrix = zeros(length(p2p_len_micron), 2);
    lvt_matrix(:,1) = (1:length(p2p_len_micron))*time_step/60;
    lvt_matrix(:,2) = p2p_len_micron';

end