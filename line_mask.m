% show an image and have the user draw a curve
I = imread('/images/8p_1.jpg');
% initialize the mask to be all 0
F = zeros(size(I,1),size(I,2));

imshow(I);
num=2;
i=1;
while(i<=num)
clear P;
M = imfreehand(gca,'Closed',0); %closed 0->is an open freehand region

% get the point positions
P0 = M.getPosition();
D = [0; cumsum(sum(abs(diff(P0)),2))];  %distance between successive points
P(:,1) = interp1(D,P0(:,1),D(1):.5:D(end));  %interpolate intermediate locations every 0.5 pixels
P(:,2) = interp1(D,P0(:,2),D(1):.5:D(end));

P = unique(round(P),'rows');  %round everything back to the pixel grid
S = sub2ind(size(I),P(:,2),P(:,1)); %get the pixel indices that are under the curve
% set the curve pixels to be 1
F(S) = 1;

i=i+1;
end

%display result
figure;
imshow(F);
imwrite(F,'neurons_44_6gt.jpg')
  