function [] = test_case_gen(N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This function is used to generate tableau test cases
%   for the "assignment problem"
%   you need only to call this function and it calls the simplex
%   algorithm by itself
%
%   N argument : the size of the matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     % double n
     M = 2*N;
     Sq= N*N;
     % generate the b and c
     b = ones(M, 1);
     c = randi([1, 20], 1, Sq);
     %emtpy tableau
     tableau=[];
     
     for row = 1:N
         firstTab=[];
         for i = 1:N
             if (i == row)
                 firstTab = [firstTab; ones(1, N)];
                 
             else
                 firstTab = [firstTab; zeros(1, N)];
             end
         end
         tableau = [tableau firstTab];
     end

     firstTab = [];
     for row = 1:N
         firstTab = [firstTab eye(N)];
     end
     tableau = [tableau; firstTab];
     tableau = [tableau zeros(M, 1) ones(M, 1)];
     tableau = [tableau; -c 1 0];
     % call the simplex function
     simplexAlg(0,0,0,0,tableau,N);
end