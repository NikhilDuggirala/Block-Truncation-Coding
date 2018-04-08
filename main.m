%Hybrid authentication and tamper protection

wim=imread('D:\mypic.jpg'); %watermark image
wim=imresize(wim,[128,128]);
wim=rgb2gray(wim);  
cim=imread('D:\lena1.jpg');%cover image
[parity,bitmap,secretData]=btc(wim);
%s2=reshape(secretData,[4096,2]);
