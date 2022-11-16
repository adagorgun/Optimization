function y = f_segmentation(vector, p)

dim = length(vector)/2;

t = vector(1:dim);

s = vector(dim + 1:end);

s = sort(s); 

s = unique(s);

t = sort(t);

t = unique(t);

if dim ~= length(t) || dim ~= length(s)

    y = 0;

else

    H = zeros(dim,1);

    for ind = 1:dim

        w = 0;

        if ind == 1

            start_point_1 = 1;
            start_point_2 = 1;
            end_point_1 = t(ind);
            end_point_2 = s(ind);

        else

            start_point_1 = t(ind - 1) ;
            start_point_2 = s(ind - 1) ;

            if ind == dim

                end_point_1 = 256; end_point_2 = 256;

            else

                end_point_1 = t(ind); end_point_2 = s(ind);

            end

        end

        for i = start_point_1:end_point_1

            for j = start_point_2:end_point_2

                w = w + p(i,j);

            end
        end

        for i = start_point_1:end_point_1

            for j = start_point_2:end_point_2

                val = (p(i,j)/w)*log(p(i,j)/w);
                if isnan(val)
                    val = 0;
                end
                H(ind) = H(ind) - val;

            end
        end

    end

    H(isnan(H)) = 0;

    y = sum(H);
end

end
