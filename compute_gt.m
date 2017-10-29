%% find the maximum volumn

for i=1:groupCount
    disp('------------------------------------------');
    neuron_no=input('please input the number of neurons:');
    
    gt(i).point_num=0;
    
    for j=1:neuron_no
        disp(['neuron ',num2str(j)]);
        pos_no=input('please input the number of points to represent the neuron:');
        pos_ind=1;
        point=zeros(pos_no,3);
        for a=1:groupSize
            imagesc(group(:,:,a,i))
            colormap(jet)
            
            point_no=input('please input the number of points(zoom in):');
            for k=1:point_no
                [locx,locy]=ginput(1);
                locx=floor(locx);
                locy=floor(locy);
                [~,z]=max(group(locy,locx,:,i));
                point(pos_ind,:)=[locy,locx,z];
                
                pos_ind=pos_ind+1;
            end
            
        end
         
        neuron(j).points=point;  %Use points to represent a neuron.
        neuron(j).mask=get_line(point,r,c,groupSize);
        neuron(j).pos_no=pos_no;
        gt(i).point_num=gt(i).point_num+pos_no;
    end
    
    gt(i).neurons=neuron;
    gt(i).neuron_no=neuron_no;
   
    
end
for i=1:groupCount
    for j=1:gt(i).neuron_no
        D=bwdist(gt(i).neurons(j).mask);
        gt(i).neurons(j).dist_transform=D;
    end
end
save('groundtruth_Ganglia','gt');
