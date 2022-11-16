
function [FoodFitness,FoodPosition,Convergence_curve] = SSA_segmentation(N,Max_FE,lb,ub,dim,fobj,p)

if size(ub,1)==1
    ub=ones(1, dim)*ub;
    lb=ones(1, dim)*lb;
end

Convergence_curve = zeros(1,Max_FE);

%Initialize the positions of salps
SalpPositions=initialization(N,dim,ub,lb);

SalpPositions = fix(SalpPositions);


FoodPosition=zeros(1,dim);
FoodFitness=inf;

%calculate the fitness of initial salps

for i=1:size(SalpPositions,1)
    SalpFitness(1,i)=fobj(SalpPositions(i,:),p);
end

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
    
    SalpPositions = fix(SalpPositions);
    
    for i=1:N
        
        Tp=SalpPositions(i,:)>ub;Tm=SalpPositions(i,:)<lb;SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
        
        SalpFitness = fobj(SalpPositions(i,:), p);
        
        if SalpFitness>FoodFitness
            
            FoodPosition = SalpPositions(i,:);
            FoodFitness = SalpFitness;
            
        end
    end
    
    Convergence_curve(FE) = FoodFitness;
    FE = FE + 1;
end



