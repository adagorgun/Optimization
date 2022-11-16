%% Ada Görgün
classdef FCLayer < handle
    
    properties
        
        input_size
        output_size
        weights 
        bias
        input        
    end
    
    methods  % init
        
        function obj = FCLayer(input_size, output_size)   
            
            obj.input_size = input_size;
            obj.output_size = output_size;
            obj.weights = randn(input_size, output_size)/sqrt(input_size+output_size);
            obj.bias = randn(1, output_size)/sqrt(input_size+output_size); 
        end    
        
    end
    
    methods % functions
        
        function out = forward_propagation(obj, input)
            
            obj.input = input;
            out = input*obj.weights + obj.bias;            
            
        end
        
        function inp_err = backward_propagation(obj, out_err, lr)
            
            inp_err = out_err*obj.weights';
            weights_err = obj.input'*out_err;            
            obj.weights = obj.weights - lr*weights_err;
            obj.bias = obj.bias - lr*out_err;
            
        end
        
    end
 
end