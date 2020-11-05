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


N_set = [90 180 270 360];
DataType = 0;

M = 3;
  
sigma_set = [0.1 0.5];
tau_set = [1 1000];
T_set = [4 6];

VI_type_set = [0 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build data files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DetailedOutput = '.\output\SummaryTable_1.log'; 
fid1 = fopen(DetailedOutput, 'w+');
fprintf(fid1,'DataType LB/UB tau T M N NM_min NM_max VI_type Phi_max Phi_min Norme P_max_max P_max_min P_min_max P_min_min Elapsed_time System_time');
fclose(fid1); 

for N = N_set,
    
    for ss = sigma_set,

        rng(123);
        NM = (N/M)*ones(M,1);
        pp = zeros(1,N);
        
        pp(1) = round(ss*rand(1,1) + 1, 3);
        
        for ii = 2:N
            pp(ii) = pp(ii-1) + round(ss*rand(1,1)/log(NM(1)) + 1, 3);
        end

        pp = sort(pp);
        
        pp(N-1) = sum(pp(1:(N-2)));
        pp(N) = 1 + pp(N-1);
        
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
                       %[status, result] = system('ampl Main_Exact.run')
                       [status, result] = system('ampl Main_LB.run')
                   
                   end

                end
            end
        end
    end
end






