function [vy_init,yaw_init]=linear_regression(gamma,vy,yaw,i)
vy_init = zeros(size(vy(:,:,i)));
yaw_init= zeros(size(yaw(:,:,i)));

%% Data to Regress
g = vy(1,:,i);
[ind]=find(g==0);
 gin = linspace(1,length(g),length(g));

 m = mean(gin);
 ind= sort(ind,'descend');
 
 for k=1:length(ind)
     gin(ind(k))=[];
 end
maxx = max(gin);
minx = min(gin);
 

%% Regress and get matrix

[vy_init] = regress(vy_init,gamma,vy,minx,maxx,2,1,i);
[vy_init] = regress(vy_init,gamma,vy,minx,maxx,3,1,i);
[yaw_init] = regress(yaw_init,gamma,yaw,minx,maxx,2,0,i);
[yaw_init] = regress(yaw_init,gamma,yaw,minx,maxx,3,0,i);



    function [new_init] = regress(new_init,gamma,vy,min,max,color,VorY,i)
        x=[];
        y=[];
        
        if (VorY ==1 && color==2)
            [idx] = find(vy(color,:,i)>0);
            for j =1:length(idx)
            if idx(j)<max
                x(end+1) = gamma(idx(j));
                y(end+1)=vy(color,idx(j),i);
            end
            end
            b = reg(x,y);
            r_int = gamma(min:end);
            X2 = [ones(length(r_int),1), r_int];
            
            y_int = X2*b;
            new_init(color,min:end)=y_int;
            
        elseif VorY==1 && color==3
             [idx] = find(vy(color,:,i)<0);
            for j =1:length(idx)
            if idx(j)>min
                x(end+1) = gamma(idx(j));
                y(end+1)=vy(color,idx(j),i);
            end
            end
            b = reg(x,y);
            r_int = gamma(1:max);
            X2 = [ones(length(r_int),1), r_int];
            y_int = X2*b;
            new_init(color,1:max)=y_int;
        elseif (VorY==0 && color == 3)
              [idx] = find(vy(color,:,i)>0);
            for j =1:length(idx)
            if idx(j)>min
                x(end+1) = gamma(idx(j));
                y(end+1)=vy(color,idx(j),i);
            end
            end
            b = reg(x,y);
            r_int = gamma(1:max);
            X2 = [ones(length(r_int),1), r_int];
            y_int = X2*b;
            new_init(color,1:max)=y_int;
        else 
              [idx] = find(vy(color,:,i)<0);
            for j =1:length(idx)
            if idx(j)<max
                x(end+1) = gamma(idx(j));
                y(end+1)=vy(color,idx(j),i);
            end
            end
            b = reg(x,y);
            r_int = gamma(min:end);
            X2 = [ones(length(r_int),1), r_int];
            y_int = X2*b;
            new_init(color,min:end)=y_int;
            
        end
        
           
    end

    function [b]=reg(x,y)
        X = [ones(length(x),1) x'];
        b = X\y';
        b(2)=1*b(2);
    end
end
