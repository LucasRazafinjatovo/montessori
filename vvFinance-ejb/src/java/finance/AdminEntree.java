// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   AdminEntree.java

package finance;

import java.io.*;
import java.lang.reflect.*;
import bean.ResultatGroupe;
import java.util.Vector;
import bean.AdminGen;


// Referenced classes of package finance:
//            Entree

public class AdminEntree{

    public AdminEntree()
    {
    }

public static ResultatGroupe[] findGroupe(Entree[] e,int numColGroupe,int numColSomme)
{
  return AdminGen.findGroupe(e,numColGroupe,numColSomme);
}
    public static double [][] getTableauCroise(Entree a[],String col, String ligne)
    {
      String valCol[]=utilitaire.Utilitaire.getvalCol("Entree",col);
      String valLigne[]=utilitaire.Utilitaire.getvalCol("Entree",ligne);
      return getSommeEntree(a,col,valCol,ligne,valLigne);
    }

    public static double[][] getSommeEntree(Entree a[],String col,String valCol[], String lig, String valLigne[])
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

    public static double getSommeEntree(Entree a[],String col,String valCol, String lig, String valLigne)
    {
      double retour=0;
      try {
        for (int i=0;i<a.length;i++)
        {
          String valColAi=(String) (a[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(col),null).invoke(a[i],null));
          String valLigneAi=(String) (a[i].getClass().getMethod("get"+utilitaire.Utilitaire.convertDebutMajuscule(lig),null).invoke(a[i],null));
          if(valColAi.compareToIgnoreCase(valCol)==0 && valLigneAi.compareToIgnoreCase(valLigne)==0)
          {
            retour=retour+a[i].getMontant();
          }
        }
        return retour;
      }
      catch (Exception ex) {
        ex.printStackTrace();
        return 0;
      }
    }

    public static double getSommeEntree(Entree a[], int indiceInf, int indiceSup)
    {
        double retour = 0.0D;
        for(int i = indiceInf; i < indiceSup + 1; i++)
            if(i < a.length)
                retour += a[i].getMontant();
            else
                return retour;

        return retour;
    }

    public static double getSommeEntree(Entree a[])
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            retour += a[i].getMontant();

        return retour;
    }

    public static double getMoyenneEntree(Entree a[])
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            retour += a[i].getMontant();

        return retour / (double)a.length;
    }

    public static double getSommeEntreeByType(Entree a[], String type)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdTypeEntree().compareToIgnoreCase(type) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeEntreeBySource(Entree a[], String source)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getClient().compareToIgnoreCase(source) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static double getSommeEntreeByDevise(Entree a[], String devise)
    {
        double retour = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdDevise().compareToIgnoreCase(devise) == 0)
                retour += a[i].getMontant();

        return retour;
    }

    public static int getNombreEntreeByDevise(Entree a[], String devise)
    {
        int retour = 0;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdDevise().compareToIgnoreCase(devise) == 0)
                retour++;

        return retour;
    }
}
