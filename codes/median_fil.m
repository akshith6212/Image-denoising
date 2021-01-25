%median_filter function
function I = median_fil(I)
[r c] = size(I);
Rep = zeros(r + 2, c + 2);
for x = 2 : r + 1
    for y = 2 : c + 1
        Rep(x,y) = I(x - 1, y - 1);
    end
end
%B = zeros(r, c);
array=zeros(1,9);
for x = 1 : r
    for y = 1 : c
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;     w = y - 1;
                array((i - 1) * 3 + j) = Rep(i + q, j + w);
            end
        end
        val_array = sort(array(:));
        I(x, y) = val_array(5);
    end
end
end
