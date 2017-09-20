function [ f ] = myCegaHE(inImg)

I=imread(inImg);
%subplot(1,3,1);
%imshow(I);

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

rmat=uint8(zeros(size(R,1),size(R,2)));
gmat=uint8(zeros(size(G,1),size(G,2)));
bmat=uint8(zeros(size(B,1),size(B,2)));

probcf=zeros(256,1);
fqn=zeros(256,1);
cdf=zeros(256,1);
prob=zeros(256,1);


outr=zeros(256,1);
outg=zeros(256,1);
outb=zeros(256,1);

a=3;
b=3;
p=255;
[m,n]=size(R);

pnum=m*n;

for i=1:m
    for j=1:n
        mag=R(i,j);
        fqn(mag+1)=fqn(mag+1)+1;
        prob(mag+1)=(fqn(mag+1))/pnum;
    end
end

sum=0;
for i=1:size(prob)
    sum=sum+fqn(i);
    cdf(i)=sum;
    probcf(i)=cdf(i)/pnum;
    outr(i)=round(probcf(i)*p);
end

for i=1:size(outr)-1
    g=round((a*[(i/127)-1]*[(i/127)-1])+b);
    d=outr(i+1)-outr(i);
    if(d>g)
        outr(i+1)=outr(i+1)-(d-g);
    end
end
for i=1:m
    for j=1:n
      rmat(i,j)=outr(R(i,j)+1);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:m
    for j=1:n
        mag=G(i,j);
        fqn(mag+1)=fqn(mag+1)+1;
        prob(mag+1)=(fqn(mag+1))/pnum;
    end
end

sum=0;
for i=1:size(prob)
    sum=sum+fqn(i);
    cdf(i)=sum;
    probcf(i)=cdf(i)/pnum;
    outg(i)=round(probcf(i)*p);
end

for i=1:size(outg)-1
    g=round((a*[(i/127)-1]*[(i/127)-1])+b);
    d=outg(i+1)-outg(i);
    if(d>g)
        outg(i+1)=outg(i+1)-(d-g);
    end
end

for i=1:m
    for j=1:n
      gmat(i,j)=outg(G(i,j)+1);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:m
    for j=1:n
        mag=B(i,j);
        fqn(mag+1)=fqn(mag+1)+1;
        prob(mag+1)=(fqn(mag+1))/pnum;
    end
end

sum=0;
for i=1:size(prob)
    sum=sum+fqn(i);
    cdf(i)=sum;
    probcf(i)=cdf(i)/pnum;
    outb(i)=round(probcf(i)*p);
end

for i=1:size(outb)-1
    g=round((a*[(i/127)-1]*[(i/127)-1])+b);
    d=outb(i+1)-outb(i);
    if(d>g)
        outb(i+1)=outb(i+1)-(d-g);
    end
end

for i=1:m
    for j=1:n
      bmat(i,j)=outb(B(i,j)+1);
    end
end

subplot(2,3,4);

I=cat(3,rmat,gmat,bmat);
imshow(I);

title('GA - CegaHE image');

prev = 1;
curr = 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% R-COMP %%%%%%%%%%%%%%%%
while(curr<size(outr))
    while(curr<size(outr) && outr(curr)==outr(prev))
        curr = curr+1;
    end
    
    x = outr(prev);
    diff = outr(curr)-outr(prev);
    while(prev<curr)
       outr(prev) = x;
       if(x<diff)
           x=x+1;
       end
       prev=prev+1;
    end
    
end

%%%%%%%%%%% G - Comp %%%%%%%%%%%%%%

prev = 1;
curr = 1;
while(curr<size(outg))
    while(curr<size(outg) && outg(curr)==outg(prev))
        curr = curr+1;
    end
    
    x = outg(prev);
    diff = outg(curr)-outg(prev);
    while(prev<curr)
       outg(prev) = x;
       if(x<diff)
           x=x+1;
       end
       prev=prev+1;
    end
    
end

prev = 1;
curr = 1;
%%%%%%%%%%%%% B- comp %%%%%%%%%%%%%

while(curr<size(outb))
    while(curr<size(outb) && outb(curr)==outb(prev))
        curr = curr+1;
    end
    
    x = outb(prev);
    diff = outb(curr)-outb(prev);
    while(prev<curr)
       outb(prev) = x;
       if(x<diff)
           x=x+1;
       end
       prev=prev+1;
    end
    
end

for i=1:m
    for j=1:n
      rmat(i,j)=outr(R(i,j)+1);
    end
end

for i=1:m
    for j=1:n
      gmat(i,j)=outg(G(i,j)+1);
    end
end

for i=1:m
    for j=1:n
      bmat(i,j)=outb(B(i,j)+1);
    end
end

subplot(2,3,5);
gre = cat(3,rmat,gmat,bmat);
imshow(gre);
title('GVR - CegaHE image');

dre = gre;

%imshow(dre);
grad = zeros(256,1);
rfpr = 255 - outr(256);
rfpg = 255 - outg(256);
rfpb = 255 - outb(256);

pas = dre;

for k=1:3
    for i=2:m-1
        for j=2:n-1
            grad(dre(i,j,k)+1) = grad(dre(i,j,k)+1) + abs(dre(i-1,j,k)-dre(i+1,j,k)) + abs(dre(i,j-1,k)-dre(i,j+1,k));
        end
    end
end



sum=0;
mean=0;
for i=1:256
    sum=sum+grad(i);
    mean = mean + (i-1)*grad(i);
end

mean = mean/sum;

sumr=0;
sumg=0;
sumb=0;
dr = 0;
dg = 0;
db = 0;
for i=1:mean-1
    dr = dr+outr(i);
    dg = dg+outg(i);
    db = db+outb(i);
end

for i=1:256
    sumr=sumr+outr(i);
    sumg=sumg+outg(i);
    sumb=sumb+outb(i);
end

Rfpr = (dr/sumr) *rfpr;
Rfpg = (dg/sumg) *rfpg;
Rfpb = (db/sumb) *rfpb;

for k=1:3
    for i=1:m
        for j=1:n
            if(k==1)
                pas(i,j,k) = dre(i,j,k)*Rfpr;
            end
            if(k==2)
                pas(i,j,k) = dre(i,j,k)*Rfpg;
            end
            if(k==3)
                pas(i,j,k) = dre(i,j,k)*Rfpb;
            end
        end
    end
end

subplot(2,3,6);

%subplot(1,3,3);
imshow(dre);
title('DRE - CegaHE image');

end

