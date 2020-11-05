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
% 0:    Apply the no VI;
% 1:    Apply the VI described in Proposition 3;
% 2:    Apply the VI described in Proposition 4;
% 3:    Apply both the VIs described in Proposition 3 and Proposition 4;
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

Categories = 2;
b = 1:Categories;
nb = 1:Categories;    
b(1) = 4;
b(2) = 5;

sigma_set = [0.1 0.5];
tau_set = [1 2 3];
T_set = [1000];
VI_type_set = [0 1];

Semester_set = [1 2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build data files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DetailedOutput = '.\output\SummaryTable_Data2.log'; 
fid1 = fopen(DetailedOutput, 'w+');
fprintf(fid1,'DataType LB/UB tau T M N NM_min NM_max VI_type Phi_max Phi_min Norme P_max_max P_max_min P_min_max P_min_min Elapsed_time System_time');
fclose(fid1); 

for r = Semester_set,
    
    DataType = r;
    
    if r == 1
        
        N = 10; 
        M = 2;
        NM_mean = floor(N/M);
        NM = ones(M,1);
        nb = (N/Categories)*ones(Categories,1);
        
        for i = 1:(M-1)
            NM(i) = NM_mean;
        end
        NM(M) = N - sum(NM(1:(M-1)));
            
    end

    if r == 2
        
        N = 12; 
        M = 2;
        NM_mean = floor(N/M);
        NM = ones(M,1);
        nb = (N/Categories)*ones(Categories,1);
        
        for i = 1:(M-1)
            NM(i) = NM_mean;
        end
        NM(M) = N - sum(NM(1:(M-1)));
        
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







