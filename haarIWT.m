% Haar transform------------------------

% clc; close all; clear all;
% a=[ 20 20 30 40 20 20 22 15
%     20 20 30 40 20 20 22 15
%     21 21 31 41 21 21 22 16
%     21 21 31 41 21 21 22 16
%     20 20 30 40 20 20 22 15
%     20 20 30 40 20 20 22 15
%     21 21 31 41 21 21 22 16
%     21 21 31 41 21 21 22 16];

% a=reshape(1:64,8,8)';

     a=imread('cameraman.tif');

%function [final,ll,lh,hl,hh]=haar_tr(a);

a=double(a);
[m n]=size(a);

for j=1:n
    if mod(j,2)==0
        ev(:,j/2)=a(:,j);
    else
        odd(:,ceil(j/2))=a(:,j);
    end
end

fhigh=odd-ev;
flow=ev+floor(fhigh/2);

% Taking odd rows
temp=1;
for i=1:2:m
    leven(temp,:)=flow(i,:);
    heven(temp,:)=fhigh(i,:);
    temp=temp+1;
end

% Taking even rows
temp=1;
for i=2:2:m
    lodd(temp,:)=flow(i,:);
    hodd(temp,:)=fhigh(i,:);
    temp=temp+1;
end
% leven
% heven
% lodd
% hodd

% hh=lodd-leven;
% hl=leven+floor(hh/2);
% lh=hodd-heven;
% ll=heven+floor(lh/2);

lh=lodd-leven;
ll=leven+floor(lh/2);
hh=hodd-heven;
hl=heven-floor(hh);

final=[ll,lh;hl,hh];
final=[ll,lh;hl,hh]
%final=uint8(final);    Use for display
% final=cat(1,cat(2,leven,lodd),cat(2,heven,hodd));
% final=uint8(final);
 imshow(final);
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Inverse Transform
 aa=final
 [m n]=size(aa);
rll=aa(1:m/2,1:n/2);
rlh=aa(1:m/2,n/2+1:n);
rhl=aa(m/2+1:m,1:n/2);
rhh=aa(m/2+1:m,n/2+1:n);

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
 final2=uint8(final2);
 figure, imshow(final2);
