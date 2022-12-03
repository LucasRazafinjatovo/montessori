package facturefournisseur;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import java.io.*;
import java.lang.reflect.*;
public class AdminFF {

  public AdminFF() {
  }
  public static double [][] getTableauCroise(FactureFournisseur a[],String col, String ligne)
  {
    String valCol[]=utilitaire.Utilitaire.getvalCol("FactureFournisseur",col);
    String valLigne[]=utilitaire.Utilitaire.getvalCol("FactureFournisseur",ligne);
    return getSommeEntree(a,col,valCol,ligne,valLigne);
  }

  public static double[][] getSommeEntree(FactureFournisseur a[],String col,String valCol[], String lig, String valLigne[])
  {
    double[][] retour=new double[valCol.length][valLigne.length];
    for (int i=0;i<valCol.length;i++)
    {
      for(int j=0;j<valLigne.length;j++)
      {
        retour[i][j]=getSommeEntree(a,col,valCol[i],lig,valLigne[j]);
      }
    }
    return retour;
  }

  public static double getSommeEntree(FactureFournisseur a[],String col,String valCol, String lig, String valLigne)
  {
    double retour=0;
    try {
      for (int i=0;i<a.length;i++)
      {
        String valColAi=(String) (a[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(col),null).invoke(a[i],null));
        String valLigneAi=(String) (a[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(lig),null).invoke(a[i],null));
        if(valColAi.compareToIgnoreCase(valCol)==0 && valLigneAi.compareToIgnoreCase(valLigne)==0)
        {
          retour=retour+a[i].getMontantTTC();
        }
      }
      return retour;
    }
    catch (Exception ex) {
      ex.printStackTrace();
      return 0;
    }
  }

  public static double getSommeEntree(FactureFournisseur a[], int indiceInf, int indiceSup)
  {
      double retour = 0.0D;
      for(int i = indiceInf; i < indiceSup + 1; i++)
          if(i < a.length)
              retour += a[i].getMontantTTC();
          else
              return retour;

      return retour;
  }

  public static double getSommeEntree(FactureFournisseur a[])
  {
      double retour = 0.0D;
      for(int i = 0; i < a.length; i++)
          retour += a[i].getMontantTTC();

      return retour;
  }

  public static double getMoyenneEntree(FactureFournisseur a[])
  {
      double retour = 0.0D;
      for(int i = 0; i < a.length; i++)
          retour += a[i].getMontantTTC();

      return retour / (double)a.length;
  }

  public static double getSommeEntreeByType(FactureFournisseur a[], String type)
  {
      double retour = 0.0D;
      for(int i = 0; i < a.length; i++)
          if(a[i].getIdFactureFournisseur().compareToIgnoreCase(type) == 0)
              retour += a[i].getMontantTTC();

      return retour;
  }

 /* public static double getSommeEntreeBySource(FactureFournisseur a[], String source)
  {
      double retour = 0.0D;
      for(int i = 0; i < a.length; i++)
          if(a[i].getClient().compareToIgnoreCase(source) == 0)
              retour += a[i].getMontant();

      return retour;
  }*/

  public static double getSommeEntreeByDevise(FactureFournisseur a[], String devise)
  {
      double retour = 0.0D;
      for(int i = 0; i < a.length; i++)
          if(a[i].getIdDevise().compareToIgnoreCase(devise) == 0)
              retour += a[i].getMontantTTC();

      return retour;
  }

  public static int getNombreEntreeByDevise(FactureFournisseur a[], String devise)
  {
      int retour = 0;
      for(int i = 0; i < a.length; i++)
          if(a[i].getIdDevise().compareToIgnoreCase(devise) == 0)
              retour++;

      return retour;
    }

}


