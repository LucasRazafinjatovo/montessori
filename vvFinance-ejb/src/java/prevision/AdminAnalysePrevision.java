package prevision;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AdminAnalysePrevision {

  public AdminAnalysePrevision() {
  }
  public static void calculerSolde(AnalysePrevision[] liste,double soldeInitial){
    if(liste!=null){
    liste[0].setSoldeth(soldeInitial);
    liste[0].setSoldepr(soldeInitial);
    for(int i=1;i<liste.length;i++)
    {
      //System.out.println("i="+i+" solde th="+liste[i-1].getSoldeth()+" Recette prev= "+liste[i].getRecprev()+" Dep prev = "+ liste[i].getDepprev());
      liste[i].setSoldeth(liste[i-1].getSoldeth()+liste[i-1].getRec_prev()-liste[i-1].getDep_prev());
      liste[i].setSoldepr(liste[i-1].getSoldepr() +liste[i-1].getRec_eff()-liste[i-1].getDep_eff());
    }
    }
  }
}