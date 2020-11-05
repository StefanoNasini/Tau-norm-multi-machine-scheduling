
#-----------------------------------------------------------------------
# Even Norme
#-----------------------------------------------------------------------

problem Theta_UB_Even   : y, x, beta0, beta1, beta2, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Even, Beta1_Even, Beta2_Even;
problem Theta_UB_Even_VI: y, x, beta0, beta1, beta2, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Even, Beta1_Even, Beta2_Even, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;


#-----------------------------------------------------------------------
# Odd Norme
#-----------------------------------------------------------------------

problem Theta_UB_Odd   : y, x, beta0, beta1, beta2, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Odd, Beta1_Odd, Beta2_Odd;
problem Theta_UB_Odd_VI: y, x, beta0, beta1, beta2, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Odd, Beta1_Odd, Beta2_Odd, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;

#-----------------------------------------------------------------------
# Even MinMax
#-----------------------------------------------------------------------

problem Theta_UB_minmax_Even   : y, x, beta0, beta1, beta2, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Even, Beta1_Even, Beta2_Even;
problem Theta_UB_minmax_Even_VI: y, x, beta0, beta1, beta2, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Even, Beta1_Even, Beta2_Even, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;


#-----------------------------------------------------------------------
# Odd MinMax
#-----------------------------------------------------------------------

problem Theta_UB_minmax_Odd   : y, x, beta0, beta1, beta2, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Odd, Beta1_Odd, Beta2_Odd;
problem Theta_UB_minmax_Odd_VI: y, x, beta0, beta1, beta2, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Odd, Beta1_Odd, Beta2_Odd, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;
