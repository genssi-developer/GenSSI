function model = NGF_Erk_M3()
	syms TrkA_NGF RasGTP pRaf pMek pErk
	syms k_1 k_2 k_4 k_5 k_7 k_9 k_11 k_3__TrkA_0 k_6__Ras_0 k_8__Raf_0 k_10__Mek_0 s__Erk_0 s_K n NGF_0
	model.Name = 'NGF_Erk_M3';
	model.Nder = 4;
	model.X = [TrkA_NGF,RasGTP,pRaf,pMek,pErk];
	model.Neq = 5;
	model.G = [0  0  0  0  0];
	model.Noc = 0;
	model.Par = [k_1,k_2,k_4,k_5,k_7,k_9,k_11,k_3__TrkA_0,k_6__Ras_0,k_8__Raf_0,k_10__Mek_0,s__Erk_0,s_K,n,NGF_0];
	model.Npar = 15;
	model.IC = [0,(k_4*k_6__Ras_0)/(k_4 + k_5),(k_4*k_6__Ras_0*k_8__Raf_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5))),(k_4*k_6__Ras_0*k_8__Raf_0*k_10__Mek_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5))*(k_9 + (k_4*k_6__Ras_0*k_8__Raf_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5))))),(k_4*k_6__Ras_0*k_8__Raf_0*k_10__Mek_0*s__Erk_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5))*(k_11 + (k_4*k_6__Ras_0*k_8__Raf_0*k_10__Mek_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5))*(k_9 + (k_4*k_6__Ras_0*k_8__Raf_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5))))))*(k_9 + (k_4*k_6__Ras_0*k_8__Raf_0)/((k_4 + k_5)*(k_7 + (k_4*k_6__Ras_0)/(k_4 + k_5)))))];
	model.H = [pErk];
	model.Nobs = 1;
	model.F = [- TrkA_NGF*k_2 - NGF_0*k_1*(TrkA_NGF - k_3__TrkA_0),- RasGTP*k_5 - (RasGTP - k_6__Ras_0)*(k_4 + (TrkA_NGF*s_K^n)/(pErk^n + s_K^n)),RasGTP*(k_8__Raf_0 - pRaf) - k_7*pRaf,pRaf*(k_10__Mek_0 - pMek) - k_9*pMek,- k_11*pErk - pMek*(pErk - s__Erk_0)];
end