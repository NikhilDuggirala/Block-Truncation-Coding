%Inverse Transform
function[final2]=my_iiwt(final,rll,rlh,rhl,rhh)
 aa=final;
 [m n]=size(aa);
% rll=aa(1:m/2,1:n/2);
% rlh=aa(1:m/2,n/2+1:n);
% rhl=aa(m/2+1:m,1:n/2);
% rhh=aa(m/2+1:m,n/2+1:n);

rleven=rll-floor(rlh/2);
rlodd=rleven+rlh;
rheven=rhl+rhh;
rhodd=rheven+rhh;

% Reconstructing flow
[m n]=size(rleven);
m=m*2; n=n*2;
temp=0;
for i=1:m 
    if temp==0
        rflow(i,:)=rleven(ceil(i/2),:);
    else
        rflow(i,:)=rlodd(i/2,:);
    end
    temp=~temp;
end

% Reconstructing fhigh
temp=0;
for i=1:m 
    if temp==0
       rfhigh(i,:)=rheven(ceil(i/2),:);
    else
        rfhigh(i,:)=rhodd(i/2,:);
    end
    temp=~temp;
end

% Reconstructing 'ev'
r_ev=rflow-floor(rfhigh/2);

% Reconstructing 'odd'
rodd=rfhigh+r_ev;

temp=0;
for j=1:n
    if temp==0
        final2(:,j)=rodd(:,ceil(j/2));
    else
        final2(:,j)=r_ev(:,j/2);
    end
    temp=~temp;
end
 final2=uint16(final2);
 figure, imshow(final2);
end