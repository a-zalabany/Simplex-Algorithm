function [] = simplexAlg(type, A,b,c, tableau, knn)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Simplex Algorithm takes A, b, and c, TYPE, and TABLEAU
%
%   #################
%   ### ARGUMENTS ###
%   #################
%
%   Standard form:
%       type= 1
%       A,b,c should be entered
%       tableau should be equal to zero
%
%   Assignment problem:
%       type= 0
%       A,b,c should be equal to 0
%       tableau should be entered
%
%   ############################
%   ### TEST CASE GENERATION ###
%   ############################ 
%       
%       Use the "test_case_gen.m" file to generate test
%       cases for the "Assignment Problem"
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format shortG
% get the size of A
[m,n]= size(A);
solVar=[];

%in case of standard form
if type==1
    % concatinate the identitiy matrix with A
    A=[A eye(m)];
    oneZero=[1 0];
    % transpose b
    b=b';
    % negate c
    c= -c;
    %use z coefficients
    z=c;
    disp('This is the initial Tableau');
    tab=[A zeros(m,1) b; c zeros(1,m) oneZero]
else 
    %in case of assignment form
    n = knn;
    tab= tableau
    [m,n]=size(tableau);
    z=tableau(m,1:n);
end

%make a vector to check whether z has values below zero
test=find(z<0);

while ~isempty(test)
    %the minimum objective function coefficients
    [mz,nz]=size(z);
    [minValue,minIndex]=min(z);
    [tabM,tabN]=size(tab);
    lastColumn=tab(:,tabN);
    %slice the last column to exclude Z's zero
    %there is a bug here with slicing (replace n by n-1)
    lastColumn= lastColumn(1:tabM-1);
    %assign the last column now to b
    b=lastColumn;
    %locate the entire pivot column
    pivotColumn=tab(:,minIndex);
    %slice the pivot column  (another bug replace n by n-1)
    pivotColumn=pivotColumn(1:tabM-1)
    pivotColumn(find(pivotColumn<0))=0;
    %divide last column by pivot column
    d= bsxfun(@rdivide,lastColumn,pivotColumn);
    % value and index of pivot element
    
    [pivotValue,pivotRow]=min(d);
    %location and value of pivot index
    pivot=tab(pivotRow,minIndex);
    %divide entire row by pivot value
    tab(pivotRow,:)=tab(pivotRow,:)/pivot;
    %iterate all rows except for the pivot row
    for i = 1:tabM
        if(i~=pivotRow)
            %subtract rows and multiply by value
            tab(i,:)=tab(i,:)-(tab(pivotRow,:)*tab(i,minIndex))
        end
    end
    z=tab(tabM,1:n);
    test=find(z<0);
    
    
    
end
% loop on each column to detect the zeros and only 1
for i = 1:tabN-1
    vertical =tab(:,i);
    count=find(vertical == 0);
    [zero, ones]=size(count);
    % here we found the column that corresponds to a solution
    
    if(zero== numel(vertical)-1)
        
        o = find(vertical ==1);
        
        if ~isempty(o)
            solution=tab(o,tabN);
            solVar=[solVar solution];
            % in case of x and y
            if(o<tabM)
                %disp(['The value of x' num2str(i) ' is equal to: ' num2str(solution)])

            % in case of Z
            elseif(o==tabM)
                %disp(['The value of max Z is equal to: ' num2str(solution)])

        end
    
end
 %disp(['The rest of the variables are equal to: 0']);
else
        solVar=[solVar 0];
end

end
disp(['The final solution of variables in order (last one is Z) is' mat2str(solVar)])

