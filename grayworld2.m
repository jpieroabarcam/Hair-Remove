function out = GrayWorld2(in,para)%
%%%% copyright: ofalling %%%%
if( nargin < 2 )
para = 0;
end
out = zeros(size(in));
inDouble = double(in)/255;
% % gamma correction
gamma = 1/2.2;
inDouble = inDouble.^(gamma);
if ( para == 0)% 最原始的gray world算法
for i = 1:3
a(i) = mean(mean(inDouble(:,:,i)));
f = 2;% f = 2/E(G),assume E(G)=1
out(:,:,i) = inDouble(:,:,i)/(f*a(i));
end
elseif( para == 1)% 先使用直方图分割为1000块再计算光源强度
inR = inDouble(:,:,1);
inG = inDouble(:,:,2);
inB = inDouble(:,:,3);
nb = 0;
for r = 1:10
for g = 1:10
for b = 1:10
bucket = find((inR>0.1*(r-1))&(inR<0.1*r)&(inG>0.1*(g-1))&...
(inG<0.1*g)&(inB>0.1*(b-1))&(inB<0.1*b));
if (size(bucket)~=0 )
nb = nb+1;
bucketC(nb,:) = [0.1*r-0.05 0.1*g-0.05 0.1*b-0.05];
end
end
end
end
for i =1:3
a(i) = mean(bucketC(:,i));
f = 2;% f = 2/E(G),assume E(G)=1
out(:,:,i) = inDouble(:,:,i)/(f*a(i));
end
end