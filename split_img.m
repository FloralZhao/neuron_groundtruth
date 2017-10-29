
%% 
data=bfopen('neurons/Ganglia.czi');
series=data{1,1};
planeCount=size(series,1);
[r,c]=size(series{1,1});


group=zeros(r,c,44);
for i=1:planeCount
    
        plane=im2double(series{i,1});
        group(:,:,i)=plane;     
    
end
