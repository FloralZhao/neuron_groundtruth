%% split the stack into groups
data=bfopen('neurons/Ganglia.czi');
series=data{1,1};
planeCount=size(series,1);
[r,c]=size(series{1,1});
groupSize=11;
groupCount=(planeCount/groupSize)/3;
group=zeros(r,c,groupSize,groupCount);
for i=1:groupCount
    for j=1:groupSize
        ind=(j+(i-1)*groupSize)*3-2;
        plane=im2double(series{ind,1});
        group(:,:,j,i)=plane;     
    end
end
