%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve all the collection of instances
%--------------------------------------------------------------------------
% To run the experiment execute from the matlab terminal the command MAIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose('all');
close all;
clear all;
clc;

delete('.\output\*.*');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arguments:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Solve_bound:      If 0, solve the exact prob, if 1 solve the LB prob, if
%                   2 solve the UB
% VI_type           An integer from 1 to 6, denoting the type of VI to used
%                   (see list of VI types below);
% Mean_bound:       If 1, the mean_bound is solved and appended as a VI to 
%                   the problem. If 0, the problem is solved directly;
% M:                Number of machines;
% N:                Number of jobs;
% mu:               Expectation of the processing times;
% N:                Standard deviation of the processing times;
%
%--------------------------------------------------------------------------
% List of VI types
%--------------------------------------------------------------------------
%
% 0:    Do not include the VI;
% 1:    Apply the VI
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%--------------------------------------------------------------------------
% Job-machine cross-combination experiment
%--------------------------------------------------------------------------
% Solve_bound_set = [0 1];
% VI_type_set = [0 2];
% Mean_bound_set = [0];
% M_set = [4 8 12];
% NM_set = [4 8 12];
% mu_set = [1];
% sigma_set = [50];


%--------------------------------------------------------------------------
% Many jobs experiment
%--------------------------------------------------------------------------

Hour_set = [1 2 3];

N = 72;
M = 8;
NM = 9*ones(M,1);
Categories = 3;
b = 1:Categories;
nb = 1:Categories;    
b(1) = 7;
b(2) = 12;
b(3) = 20;  
nb(1) = 26;
nb(2) = 22;
nb(3) = 24; 
  
sigma_set = [0.1 0.5];
tau_set = [1 2];
T_set = [4 6];

VI_type_set = [0 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build data files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DetailedOutput = '.\output\SummaryTable_Data_3.log'; 
fid1 = fopen(DetailedOutput, 'w+');
fprintf(fid1,'DataType LB/UB tau T M N NM_min NM_max VI_type Phi_max Phi_min Norme P_max_max P_max_min P_min_max P_min_min Elapsed_time System_time');
fclose(fid1); 

for r = Hour_set,
    
    DataType = r;
    
    if r == 1
        
        N = 66; 
        M = 20;
        NM = [3*ones(17,1); 5*ones(3,1)]; %3*17 + 3*5 = 66
        Categories = 5;
        b = 1:Categories;
        nb = 1:Categories;    
        b(1) = 5;
        b(2) = 10;
        b(3) = 15;  
        b(4) = 20;  
        b(5) = 20;          
        nb(1) = 10;
        nb(2) = 10;
        nb(3) = 26; 
        nb(4) = 10; 
        nb(5) = 10;         
    end

    if r == 2
        
        N = 48; 
        M = 10;
        NM = [6*ones(1,1); 4*ones(6,1); 6*ones(3,1)]; %6*1 + 4*6 + 6*3
        Categories = 3;
        b = 1:Categories;
        nb = 1:Categories;    
        b(1) = 5;
        b(2) = 10;
        b(3) = 15;  
        nb(1) = 15;
        nb(2) = 15;
        nb(3) = 18; 
        
    end
    
    if r == 3
        
        N = 9; 
        M = 3;
        NM = 3*ones(3,1);
        Categories = 3;
        b = 1:Categories;
        nb = 1:Categories;    
        b(1) = 5;
        b(2) = 10;
        b(3) = 15;  
        nb(1) = 15;
        nb(2) = 15;
        nb(3) = 18; 
        
    end
    
    for ss = sigma_set,

        rng(123);
        pp = zeros(1,N);

        Count = 1;
        for ii = 1:Categories
            for jj = Count:(Count + nb(ii) - 1)  
                pp(jj) = round(rand(1)*((1+ss)*b(ii) - (1-ss)*b(ii)) +  (1-ss)*b(ii), 3);
            end
            Count = Count + nb(ii);
        end

        pp = sort(pp);

        MS_max = sum(pp((N-max(NM)+1):N));

       for T = T_set
           for tau = tau_set
               for VI_type = VI_type_set
                   
                   Print_AMPL;
                   
                   if VI_type == 1 & length(VI_type_set) > 0
                   
                       [status, result] = system('ampl Main_UB.run')
                       [status, result] = system('ampl Main_LB.run')
                   
                   else
                   
                       [status, result] = system('ampl Main_UB.run')
                       [status, result] = system('ampl Main_Exact.run')
                       [status, result] = system('ampl Main_LB.run')
                   
                   end

                end
            end
        end
    end
end
