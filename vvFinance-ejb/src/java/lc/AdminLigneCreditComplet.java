package lc;

import bean.AdminGen;
import bean.ResultatGroupe;


public class AdminLigneCreditComplet {
	//getSommeEntreeByDevise
	public AdminLigneCreditComplet()
    {
    }

	public static ResultatGroupe[] findGroupe(LigneCreditComplet[] e,int numColGroupe,int numColSomme)
	{
		return AdminGen.findGroupe(e,numColGroupe,numColSomme);
	}

	/* Récupère les sommes des colonnes suivants dans un tableau:
	 * credit Init, credit Modif, MontantEng, MontantVis, MontantFac, nbrRes */
	public static double[] getAllSommeMontantLC(LigneCreditComplet[] l, String typeLC){
		double mont[] = {0,0,0,0,0,0}; //6 colonne
		for(int i=0; i<l.length; i++){
			if(l[i].getTypeLC().compareToIgnoreCase(typeLC) == 0){
				mont[0] += l[i].getCreditInitial();
				mont[1] += l[i].getCreditModifier();
				mont[2] += l[i].getMontantEng();
				mont[3] += l[i].getMontantVis();
				mont[4] += l[i].getMontantFac();
				mont[5] +=1;
			}
		}
		return mont;

	}

	public static double[] getAllSommeMontantLC(LigneCreditComplet[] l){
		double mont[] = {0,0,0,0,0,0}; //6 colonne
		for(int i=0; i<l.length; i++){

				mont[0] += l[i].getCreditInitial();
				mont[1] += l[i].getCreditModifier();
				mont[2] += l[i].getMontantEng();
				mont[3] += l[i].getMontantVis();
				mont[4] += l[i].getMontantFac();
				mont[5] +=1;

		}
		return mont;

	}
        public static double[] getAllSommeMontantLCDiff(Difflcgroupe[] l){
                double mont[] = {0,0,0,0,0,0,0,0,0}; //6 colonne
                for(int i=0; i<l.length; i++){

                                mont[0] += l[i].getCmrec();
                                mont[1] += l[i].getEngrec();
                                mont[2] += l[i].getViserec();
                                mont[3] += l[i].getFacrec();
                                mont[4] += l[i].getCmdep();
                                mont[5] += l[i].getEngdep();
                                mont[6] += l[i].getVisedep();
                                mont[7] += l[i].getFacdep();
                                mont[8] +=1;

                }
                return mont;

	}
}
