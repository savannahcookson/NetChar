function NETDIST = getNetDist(PARCELNUM,NETGROUPS,INCLUDEDROIS)

% Returns the overlapping network distribution of a given parcel for the
% provided network assignment group file provided by SVINet.
%
% USAGE: NETDIST = getNetDist(PARCELNUM,NETGROUPS,INCLUDEDROIS)
%       NETDIST: output array with number of elements equal to the number
%       of networks in the provided SVI assignment; elements contain the
%       assignment probability value for each network for the parcel of
%       interest.
%       PARCELNUM: parcel ID number
%       NETGROUPS: variable containing the results of loading the SVINet
%       output group.txt file for the network assignment of interest
%       INCLUDEDROIS: list of parcel IDs included in the assignment of
%       interest

parcelIndex = find(INCLUDEDROIS == PARCELNUM);

if isempty(parcelIndex)
    sprintf('Parcel %d not included in assignment analysis',PARCELNUM)
    NETDIST = [];
else
    distRow = find(NETGROUPS(:,2) == parcelIndex);
    NETDIST = NETGROUPS(distRow,3:end);
end

end