function [F]=get_line(P0,r,c,z)
F=zeros(r,c,z);
P0=unique(P0,'rows');
D = [0; cumsum(sum(abs(diff(P0)),2))];  %distance between successive points
P(:,1) = interp1(D,P0(:,1),D(1):.5:D(end));  %interpolate intermediate locations every 0.5 pixels
P(:,2) = interp1(D,P0(:,2),D(1):.5:D(end));
P(:,3) = interp1(D,P0(:,3),D(1):.5:D(end));

P = unique(round(P),'rows');  %round everything back to the pixel grid
S = sub2ind([r,c,z],P(:,2),P(:,1),P(:,3)); %get the pixel indices that are under the curve
% set the curve pixels to be 1
F(S) = 1;
