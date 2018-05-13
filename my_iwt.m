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

%      a=imread('cameraman.tif');

function [final,ll,lh,hl,hh]=my_iwt(a)

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
final=[ll,lh;hl,hh];
%final=uint8(final);    Use for display
% final=cat(1,cat(2,leven,lodd),cat(2,heven,hodd));
 final=uint16(final);
 imshow(final);
end
 