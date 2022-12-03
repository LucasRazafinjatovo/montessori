package finance;

import bean.AdminGen;
import java.util.Vector;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AdminEtatCaisseReste extends AdminGen {

  public AdminEtatCaisseReste() {
  }
  public static EtatCaisseReste grouperTous(EtatCaisseReste[] x)
  {
    //java.sql.Date dt,String idCaisse,String descC,String entite,double credit,double deb,double res
    EtatCaisseReste retour=new EtatCaisseReste(null,"-","-","-",0,0,0,0,0);
    for (int i=0;i<x.length;i++)
    {
        retour.setCredit(retour.getCredit()+x[i].getCredit());
        retour.setDebit(retour.getDebit()+x[i].getDebit());
        retour.setRepEntree(retour.getRepEntree()+x[i].getRepEntree());
        retour.calculReste();
    }

    return retour;
  }
  public static EtatCaisseReste grouperCaisse(EtatCaisseReste[] x,String descCaisse)
  {
    //java.sql.Date dt,String idCaisse,String descC,String entite,double credit,double deb,double res
    EtatCaisseReste retour=new EtatCaisseReste(null,"-",descCaisse,"-",0,0,0,0,0);
    int numCaisse=-1;
    String idC=null;
    for (int i=0;i<x.length;i++)
    {
      if(x[i].getDescCaisse().compareToIgnoreCase(descCaisse)==0)
      {
        retour.setCredit(retour.getCredit()+x[i].getCredit());
        retour.setDebit(retour.getDebit()+x[i].getDebit());
        if (numCaisse==-1)
          retour.setRepEntree(retour.getRepEntree()+x[i].getRepEntree());
        retour.calculReste();
        numCaisse=i;
        idC=x[i].getIdCaisse();
      }
      if(numCaisse>=0)
        retour.setRepDepense(x[numCaisse].getRepDepense());
    }
    retour.setIdCaisse(idC);
    return retour;
  }
  public static EtatCaisseReste grouperEntite(EtatCaisseReste[] x,String ent)
  {
    //java.sql.Date dt,String idCaisse,String descC,String entite,double credit,double deb,double res
    EtatCaisseReste retour=new EtatCaisseReste(null,"-","-",ent,0,0,0,0,0);
    int numEntite=-1;
    Vector dejaCaisse=new Vector();
    for (int i=0;i<x.length;i++)
    {
      if(x[i].getEntite().compareToIgnoreCase(ent)==0)
      {
        retour.setCredit(retour.getCredit()+x[i].getCredit());
        retour.setDebit(retour.getDebit()+x[i].getDebit());
        if (testIfCaisseExist(x[i].getIdCaisse(),dejaCaisse)==false)
        {
          retour.setRepEntree(retour.getRepEntree()+ x[i].getRepEntree());
          dejaCaisse.add(x[i].getIdCaisse());
        }
        retour.calculReste();
        numEntite=i;
      }
    }
    if (numEntite>=0)
      retour.setRepDepense(x[numEntite].getRepDepense());
    return retour;
  }
  public static boolean testIfCaisseExist(String idCaisse,Vector dejaCaisse)
  {
    String[] c=new String[dejaCaisse.size()];
    dejaCaisse.copyInto(c);
    for (int i=0;i<c.length;i++)
    {
      if(c[i].compareToIgnoreCase(idCaisse)==0)
        return true;
    }
    return false;
  }
}