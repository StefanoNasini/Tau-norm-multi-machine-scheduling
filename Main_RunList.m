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

VI_type_set = [0];
M_set = [2];
NM_set = [5 10];
mu_set = [1];
sigma_set = [1];
tau_set = [2];
T_set = [10 100];
DataType = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build data files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DetailedOutput = '.\output\SummaryTable.log'; 
fid1 = fopen(DetailedOutput, 'w+');
fprintf(fid1,'DataType LB/UB tau M N NM_min NM_max VI_type Phi_max Phi_min Norme P_max_max P_max_min P_min_max P_min_min Elapsed_time System_time');
fclose(fid1); 

for M = M_set,
    for NM = NM_set,
        for sigma = sigma_set
            for mu = mu_set
                
                N = M*NM;
                
                rng(123);

                pp = zeros(1,N);
                pp(1) = round(sigma*rand(1,1) + mu, 3);

                for ii = 2:N
                   pp(ii) = pp(ii-1) + round(sigma*rand(1,1)/log(1 + NM) + mu, 3);
                end
                
                MS_max = sum(pp((N-NM+1):N));
                
                for T = T_set
                    for tau = tau_set
                        for VI_type = VI_type_set

                           Print_AMPL;

                           if VI_type == 1 & length(VI_type_set) > 0

                               [status, result] = system('ampl Main_UB.run')
                               [status, result] = system('ampl Main_Exact.run')
                               [status, result] = system('ampl Main_LB.run')

                           else

                               [status, result] = system('ampl Main_UB.run')
                               [status, result] = system('ampl Main_LB.run')

                           end

                        end
                    end
                end
            end
        end
    end
end






