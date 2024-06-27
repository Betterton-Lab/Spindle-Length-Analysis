function tasplens = timeAverage(lvt, nminsmth)
% Description: Employs a sliding average to smooth data over time.
% Inputs:
%         lvt: an nx2 matrix of the form [t(min),length(μm)] where n is 
%              the number of points for a given curve
%         nminsmth: the width (in min) of a sliding average box
% Output: 
%         tasplens: an nx3 matrix of the form [t(min), length(μm), stelen(μm] 
%                   of time-averaged length vs time data, where n is
%                   the number of points for a given curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tasplens = zeros(length(lvt(:,1)),3); % preallocating a matrix
tacount = 1; % for assigning data to rows in tasplens
for pt = 1:length(lvt(:,1))
    % Grab all points in a box that begins at the current time and ends at
    % the current time + nminsmth:
    tsplens = lvt(lvt(:,1)>=lvt(pt,1) & lvt(:,1)< lvt(pt,1)+nminsmth,:);

    % Averages + stdlen:
    avglen = mean(tsplens(:,2));
    stelen = std(tsplens(:,2))/sqrt(length(tsplens(:,2)));
    avgt = mean(tsplens(:,1));

    % Store data:
    tasplens(tacount,:) = [avgt,avglen,stelen];
    tacount = tacount + 1;
end
tasplens = tasplens(tasplens(:,1)~=0,:);

end
