
#-----------------------------------------------------------------------
# Even Norme
#-----------------------------------------------------------------------

problem Theta_LB_Even   : y, x, beta0, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Even;
problem Theta_LB_Even_VI: y, x, beta0, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Even, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;


#-----------------------------------------------------------------------
# Odd Norme
#-----------------------------------------------------------------------

problem Theta_LB_Odd   : y, x, beta0, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Odd;
problem Theta_LB_Odd_VI: y, x, beta0, phi, MinNorme, Norme, Y_to_X, X_order, Y0, Y3, Beta0_Odd, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;

#-----------------------------------------------------------------------
# Even MinMax
#-----------------------------------------------------------------------

problem Theta_LB_minmax_Even   : y, x, beta0, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Even;
problem Theta_LB_minmax_Even_VI: y, x, beta0, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Even, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;


#-----------------------------------------------------------------------
# Odd MinMax
#-----------------------------------------------------------------------

problem Theta_LB_minmax_Odd   : y, x, beta0, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Odd;
problem Theta_LB_minmax_Odd_VI: y, x, beta0, Phi, MinMax, Norme_MinMax, Y_to_X, X_order, Y0, Y3, Beta0_Odd, Set_VI_1a,Set_VI_1b, Set_VI_0, Set_VI_2;
