function noisefiltsplens = filterSpindleNoise(lvt, stdthresh, numbins)
% Description: Filters noisy spindle data by binning the data in time and
%              removing bins that have standard deviations in spindle length
%              well beyond what is physically possible
% Inputs:
%         lvt: an nx2 matrix of the form [t(min),length(μm)] where n is the
%              number of points for a given curve
%         stdthresh (optional): a max "physically possible" standard
%                               deviation of lengths contained within a
%                               given bin. Defaults to 0.75 μm for
%                               numbins=30
%         numbins (optional): the number of bins to use for binning in
%                             time. Defaults to 30
% Output:
%         noisefiltsplens: an nx2 matrix of the form [t(min), length(μm) of
%                          coarse-filtered length vs time data, where n is
%                          the number of points for a given curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
% Optional Input %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
    numbins = 30;
end

if nargin < 2
    stdthresh = 0.75;
end

%%%%%%%%%%%%%
% Filtering %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initializing binned data:
be = linspace(min(lvt(:,1)),max(lvt(:,1)),numbins+1);
filtdat=zeros(length(lvt(:,1)),2);
counter = 1; % for assigning points to rows in filtdat

% Removing bins with unphysical standard deviations:
for bin = 1:numbins
    tfilt = lvt(lvt(:,1) >= be(bin) & lvt(:,1) < be(bin + 1),:);
    if std(tfilt(:,2)) <= stdthresh
        for ptgm = 1:length(tfilt(:,1))
            filtdat(counter,:) = tfilt(ptgm,:);
            counter = counter + 1;
        end
    end
end

noisefiltsplens = filtdat(1:counter-1,:);

end
