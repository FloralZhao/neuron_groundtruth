for i=1:groupCount
    neu_no=gt(i).neuron_no;
    pos_no=gt(i).point_num;
    neg_no=30*groupSize;
    pos_sample=zeros(pos_no,6); %[loc,2 smallest offset,score]
    neg_sample=zeros(330,6);
    pos_sample(:,6)=1;
    neg_sample(:,6)=0;
  %positive samples
    for j=1:neu_no
        start_ind=(j-1)*100+1;
        end_ind=j*100;
        pos_sample(start_ind:end_ind,1:3)=gt(i).neuron(j).points;
    end
    for j=1:pos_no
        dist=zeros(1,neu_no);
        for k=1:neu_no
            D=gt(i).neuron(k).dist_transform;
            dist(k)=D(pos_sample(j,1),pos_sample(j,2),pos_sample(j,3));
        end
        dist=sort(dist);
        pos_sample(j,4:5)=dist(1:2); %todo:2 smallest offsets
    end
    
  %negative samples
  for j=1:groupSize
      imagesc(group(:,:,j,i))
      colormap(jet);
      [locx,locy]=ginput(30);
      locx=floor(locx);
      locy=floor(locy);
      start_ind=(j-1)*30+1;
      end_ind=j*30;
      neg_sample(start_ind:end_ind,1:3)=[locy,locx,ones(30,1)*j];
  end
  for j=1:neg_no
        dist=zeros(1,neu_no);
        for k=1:neu_no
            D=gt(i).neuron(k).dist_transform;
            dist(k)=D(neg_sample(j,1),neg_sample(j,2),neg_sample(j,3));
        end
        dist=sort(dist);
        neg_sample(j,4:5)=dist(1:2); %TODO
  end
    
end

save('on_line_samples','pos_sample');
save('off_line_samples','neg_sample');
