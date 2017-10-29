data=load('dist.mat');
data=data.dist;
for i=1:44
    gt=data(:,:,i);
    filename=strcat('Ganglia',num2str(i));
    save(filename,'gt');
    
end