%% Ada Görgün
classdef Network < handle
    
    properties
        
        layers
        loss
        loss_prime 
        
    end
    
    methods  % init
        
        function obj = Network()
            
            obj.layers = {};
        end    
        
    end
    
    methods % functions
        
        function add(obj, layer)
            
            obj.layers{end+1} = layer;          
            
        end
        
        function result = predict(obj, input_data)
            
            samples = length(input_data);
            result = [];
            
            for i = 1:samples
                
                output = input_data(i);
                
                num_layers = length(obj.layers);
                
                for n = 1:num_layers
                    
                    layer = obj.layers{n};
                    
                    output = layer.forward_propagation(output);
                    
                end
                
                result = [result;output];               
                
            end
            
        end
        
        function fit(obj, x_train, y_train, iter, lr)
            
            samples = length(x_train);
            
            for i = 1:iter
                
                err = 0;
                
                for j = 1:samples
                    
                    output = x_train(j);
                    
                    num_layers = length(obj.layers);
                    
                    for n = 1:num_layers
                        
                        layer = obj.layers{n};
                       
                        output = layer.forward_propagation(output);
  
                    end
                                        
                    err = err + mse(y_train(j), output);
                    
                    error = mse_prime(y_train(j), output);
                    
                    for n = 1:num_layers
                       
                        layer = obj.layers{num_layers - n +1};
                        error = layer.backward_propagation(error, lr);
                        
                    end
                    
                end
                
                err = err/samples;
                disp(['iter: ' num2str(i) '   error: ' num2str(err)]);
                fs(i) = err;
                
            end
            
            figure;
            plot(fs), title('Plot of the Cost Function'); xlabel('Iterations'); ylabel('J');
            
        end

    end
 
end