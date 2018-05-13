%Hybrid authentication and tamper protection

wim=imread('D:\mypic.jpg'); %watermark image
wim=imresize(wim,[128,128]);
wim=rgb2gray(wim);  
cim=imread('D:\lena1.jpg');%cover image
[parity,bitmap,secretData]=btc(wim);
%s2=reshape(secretData,[4096,2]);
[parity1,bitmap1,secretData1]=btc(cim);
[final,ll,lh,hl,hh]=my_iwt(cim);
cnt=1;
%% LSB embedding of secret data of watermark in LH/HL of cover  based on parity
ll_lsb(128,128)=0;
lsb_embed(128,128)
if (parity1==1)
    for i=1:128
        for j=1:128
            tmp1=de2bi(lh,8);
            if(tmp1(1,7)==1 && lh(1,7)==1)
                tmp1(i,7)=0;
            end
            if(tmp1(1,7)==1 && lh(1,7)==0)
                tmp1(i,7)=1;
            end
            if(tmp1(1,7)==0 && lh(1,7)==1)
                tmp1(i,7)=1;
            end
            if(tmp1(1,7)==0 && lh(1,7)==0)
                tmp1(i,7)=0;
            end
            
            
            if(tmp1(1,8)==1 && lh(1,8)==1)
                tmp1(i,8)=0;
            end
            if(tmp1(1,8)==1 && lh(1,8)==0)
                tmp1(i,8)=1;
            end
            if(tmp1(1,8)==0 && lh(1,8)==1)
                tmp1(i,7)=1;
            end
            if(tmp1(1,8)==0 && lh(1,8)==0)
                tmp1(i,8)=0;
            end
            
            lh(i,j)=bi2de(tmp1(i,j),8);
        end
    end
    
end

if (parity1==0)
    for i=1:128
        for j=1:128
            tmp1=de2bi(hl,8);
            if(tmp1(1,7)==1 && hl(1,7)==1)
                tmp1(i,7)=0;
            end
            if(tmp1(1,7)==1 && hl(1,7)==0)
                tmp1(i,7)=1;
            end
            if(tmp1(1,7)==0 && hl(1,7)==1)
                tmp1(i,7)=1;
            end
            if(tmp1(1,7)==0 && hl(1,7)==0)
                tmp1(i,7)=0;
            end
            
            
            if(tmp1(1,8)==1 && hl(1,8)==1)
                tmp1(i,8)=0;
            end
            if(tmp1(1,8)==1 && hl(1,8)==0)
                tmp1(i,8)=1;
            end
            if(tmp1(1,8)==0 && hl(1,8)==1)
                tmp1(i,7)=1;
            end
            if(tmp1(1,8)==0 && hl(1,8)==0)
                tmp1(i,8)=0;
            end
            
            hl(i,j)=bi2de(tmp1(i,j),8);
        end
    end
end

%%construct the watermark with secret data
[watermarkedImage]=my_iiwt(final,ll,lh,hl,hh);
