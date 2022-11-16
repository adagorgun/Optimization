
function [FoodPosition,FoodFitness,Convergence_curve] = EHSSA_CEC(N,Max_FE,lb,ub,dim,fobj,func_number)

if size(ub,1)==1
    ub=ones(1, dim)*ub;
    lb=ones(1, dim)*lb;
end

Convergence_curve = zeros(1,Max_FE);

%Initialize the positions of salps
SalpPositions=initialization(N,dim,ub,lb);


FoodPosition=zeros(1,dim);
FoodFitness=inf;

%calculate the fitness of initial salps

SalpFitness = feval(fobj, SalpPositions',func_number);

[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);

for newindex=1:N
    Sorted_salps(newindex,:)=SalpPositions(sorted_indexes(newindex),:);
end

FoodPosition=Sorted_salps(1,:);
FoodFitness=sorted_salps_fitness(1);

%Main loop
FE=1; 

while FE<Max_FE+1
    
    c1 = 2*exp(-(4*FE/Max_FE)^2); 
    
    for i=1:size(SalpPositions,1)
                
        if i<=N/2
            
            for j=1:dim
                
                r1 = rand();
                r2 = rand();
                
                if r2<0.5   
                    
                    SalpPositions(i, j) = FoodPosition(j) - c1*((ub(j) - lb(j))*r1 + lb(j));
                    
                else   
                    
                    SalpPositions(i, j) = FoodPosition(j) + c1*((ub(j) - lb(j))*r1 + lb(j));
                    
                end
                
            end
            
        elseif i>N/2 && i<N+1 
            
            SalpPositions(i,:) = (SalpPositions(i-1,:) + SalpPositions(i,:))/2; 
            
        end
        
        
    end
    
    SalpPositions_e = zeros(size(SalpPositions));
    
    for i = 1:N
        
        d = randperm(N); d(d == i) = [];
        
        if tan(pi*(rand() - 0.5)) < (1 - FE/Max_FE)
            
            phi = Levy(1.5); % Step-Size
            SalpPositions(i,:) = SalpPositions(d(3),:) + rand(1, dim) .* phi .* (SalpPositions(d(1),:) - SalpPositions(d(2),:));
            
        else
            
            c = rand(); R1 = rand(); R2 = rand();  R3 = rand();
            rand_index = floor(N*rand() + 1);  SalpPositions_r = SalpPositions(rand_index,:);
            
            if c < 0.5 
                
                SalpPositions_e(i,:) = SalpPositions_r - R1*abs(SalpPositions_r - 2*R2*SalpPositions(i,:));
                
            else
                
                SalpPositions_mean = mean(SalpPositions,1);
                SalpPositions_e(i,:) = (FoodPosition - SalpPositions_mean) - R1*((ub - lb)*R3 + lb);
                
            end
            % Do we need this ??
%             Tp=SalpPositions(i,:)>ub;Tm=SalpPositions(i,:)<lb;SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
%             Tp=SalpPositions_e(i,:)>ub;Tm=SalpPositions_e(i,:)<lb;SalpPositions_e(i,:)=(SalpPositions_e(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
%             
%             
            SalpFitness = feval(fobj, SalpPositions(i,:)',func_number);
            
            SalpFitness_e = feval(fobj, SalpPositions_e(i,:)',func_number);
            
            if SalpFitness_e < SalpFitness
                
                SalpPositions(i,:) = SalpPositions_e(i,:);
                SalpFitness = SalpFitness_e; 
                
            end
            
            if SalpFitness_e < FoodFitness
                
                FoodPosition = SalpPositions_e(i,:);
                
            end
                  
            
        end     
        
    end


    for i=1:N
        
        Tp=SalpPositions(i,:)>ub;Tm=SalpPositions(i,:)<lb;SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
    
        SalpFitness = feval(fobj, SalpPositions(i,:)',func_number);
                
        if SalpFitness<FoodFitness
            
            FoodPosition = SalpPositions(i,:);
            FoodFitness = SalpFitness;
            
        end
    end
    
    Convergence_curve(FE) = FoodFitness;
    FE = FE + 1;
    
end

end

function phi = Levy(beta)

upper_division = gamma(1+beta)*sin(pi*beta/2);
lower_division = gamma(((beta + 1)/2)*beta*(2^((beta-1)/2)));
phi = (upper_division / lower_division)^(1/beta);

end

