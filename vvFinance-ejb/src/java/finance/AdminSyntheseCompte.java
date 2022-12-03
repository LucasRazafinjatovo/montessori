package finance;

import bean.AdminGen;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AdminSyntheseCompte extends AdminGen {

  public AdminSyntheseCompte() {
  }
  public static double calculSommeetGroupCatCompte(SyntheseCompte[] s,String catCompte,String enti)
  {
    double so=0;
    for (int i=0;i<s.length;i++)
    {
      if ((s[i].getCatCompte().compareToIgnoreCase(catCompte)==0)&&(s[i].getCaisse().compareToIgnoreCase(enti)==0))
        so=so+s[i].getMontant();
    }
    return so;
  }
  public static double calculSommeetGroupCatCompte(SyntheseCompte[] s,String catCompte)
  {
    double so=0;
    for (int i=0;i<s.length;i++)
    {
      if (s[i].getCatCompte().compareToIgnoreCase(catCompte)==0)
        so=so+s[i].getMontant();
    }
    return so;
  }
  public static double calculSommeetGroupEntite(SyntheseCompte[] s,String enti)
  {
    double so=0;
    for (int i=0;i<s.length;i++)
    {
      if (s[i].getCaisse().compareToIgnoreCase(enti)==0)
        so=so+s[i].getMontant();
    }
    return so;
  }
  public static double calculSommeetGroupType(SyntheseCompte[] s,String typ)
  {
    double so=0;
    for (int i=0;i<s.length;i++)
    {
      if (s[i].getIdType().compareToIgnoreCase(typ)==0)
        so=so+s[i].getMontant();
    }
    return so;
  }
}