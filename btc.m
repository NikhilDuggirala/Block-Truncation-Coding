function[parity,bitmap,secretData]=btc(image)
[m1,n1]=size(image); 
blk=4; %block size
var_arr(1,1024)=0; %array to store variance of all the blocks
mean_arr(1,1024)=0; %array to store mean of all the blocks
r(128,128)=0; %binary allocation matrix
r1(128,128)=0; %secret data
count=1;
%%for each block,calc mean,variance and binary alloc matrix
for i = 1 : blk : m1 
for j = 1 : blk : n1 
        y = image( i : i + (blk-1), j : j + (blk-1) ) ;
        m = mean( mean ( y ) );
        mean_arr(1,count)=m;
        sig=std2(y);
        var_arr(1,count)=sig;
        count=count+1;
        bi_m=de2bi(uint8(m),8);
        bi_v=de2bi(uint8(sig),8);
         b = y > m ; %the binary block
         r ( i : i + (blk-1), j : j + (blk-1) )=b;
         bi_b=reshape(r ( i : i + (blk-1), j : j + (blk-1) ),[1,16]);
         bi_arr=0;
         for k=1:8
              bi_arr(k,1)=bi_b(1,k);
              bi_arr(k,2)=bi_m(1,k);
         end
         for k=9:16
             bi_arr(k,1)=bi_b(1,k);
             bi_arr(k,2)=bi_m(1,k-8);
         end
         cbl=1;
         dec_arr=bi2de(bi_arr);
         for yy=i:i+(blk-1)
             for zz=j:j+(blk-1)
                 r1(yy,zz)=dec_arr(cbl,1);
                 cbl=cbl+1;
             end
         end
   end
end
bitmap=r;
%%Form the secret data
mean_arr=de2bi(uint8(mean_arr),8);
var_arr=de2bi(uint8(var_arr),8);
secretData=r1;
%%Calculate the parity for the image
count_one=0;
for i=1:128
    for j=1:128
        if (r(i,j)==1)
            count_one=count_one+1;
        end
    end
end
if(rem(count_one,2)==1)
    parity=1;
end
 if (rem(count_one,2)==0)
    parity=0;
end