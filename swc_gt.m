load Ganglia1-44.txt
data=Ganglia1_44(:,3:6); %[x,y,z,r]
data(:,1:3)=round(data(:,1:3)); %make data on grid
data(:,4)=floor(data(:,4));
% Seperate data with their z-axes
z_group=zeros(1,2,44);
z_ind=ones(1,44);
data_no=size(data,1);

for i =1:data_no
    z=data(i,3);
    if z==0
        z=1;
        data(i,3)=1;
    end
    z_group(z_ind(z),:,z)=data(i,1:2);
    z_ind(z)=z_ind(z)+1;
end

% Construct the groundtrurh
r=3288;
c=3288;
F=zeros(r,c,44);
P = unique(data,'rows');  %round everything back to the pixel grid
S = sub2ind([r,c,44],P(:,1),P(:,2),P(:,3)); %get the pixel indices that are under the curve
% set the curve pixels to be 1
F(S) = 1;

%Consider the radius information
for i =1:data_no
    r=data(i,4);
   
    for z=1:r
        temp=data(i,3)+z;
        if temp<45
            F(data(i,1),data(i,2),data(i,3)+z)=1;
        end
        temp=data(i,3)-z;
        if temp>0
            F(data(i,1),data(i,2),data(i,3)-z)=1;
        end
    end
    for x=1:r

        F(data(i,1)+x,data(i,2),data(i,3))=1;
        temp=data(i,1)-x;
        if temp>0
            F(data(i,1)-x,data(i,2),data(i,3))=1;
        end
    end
    for y=1:r
    
        F(data(i,1),data(i,2)+y,data(i,3))=1;
        temp=data(i,2)-y;
        if temp>0
            F(data(i,1),data(i,2)-y,data(i,3))=1;
        end
    end
end

%Compute the smallest offset
[dist,index]=bwdist(F);


save('dist.mat','dist'); %'dist' is the smallest offset
save('index.mat','index'); %'index' is the index of nearest pixel
save('F.mat','F','-v7.3'); %'F' is the groundtruth
