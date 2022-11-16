%% Ada Görgün
classdef SigmoidLayer < handle
    
    properties
            
        input
     
    end
    
    methods % functions
        
        function obj = SigmoidLayer()
            
            obj.input = [];
        end
                   
        function out = forward_propagation(obj, input)
            
            obj.input = input;
            out = sigmoid(input);            
            
        end
        
        function inp_err = backward_propagation(obj, out_err, lr)
            
            inp_err = out_err.*sigmoid_prime(obj.input);
            
        end
        
    end
 
end