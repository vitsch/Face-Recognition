pt = 'yale_pic_sm/';
files = dir(pt);
files([1,2,3]) = [];
npic = 60; % pictures per subject
np = length(files); 

c = np/npic; % 38 classes (people)
target = repmat([1:c],npic,1); target = reshape(target,1,[]); % training targets

n = 32;
m = 32;
data = zeros(n*m, np);

 for i = 1:np
   I = imread([pt, files(i).name]);
   I = imresize(I, [n, m]);
   % imshow(I);
   Id = double(I);
   Id = reshape(Id,[],1);
   % Irestore = uint8(reshape(Id,size(I)));
   data(:,i) = Id;
 end

save Yale1 data target