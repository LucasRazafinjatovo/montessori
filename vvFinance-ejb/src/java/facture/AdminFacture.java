// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   AdminFacture.java

package facture;


// Referenced classes of package facture:
//            FactMere, FactureFille, EtatFacture

public class AdminFacture
{

    public AdminFacture()
    {
    }

    public static double calculSommeFacture(FactMere a[], int indiceMin, int indiceMax)
    {
        double somme = 0.0D;
        for(int i = indiceMin; i < indiceMax + 1; i++)
            if(i < a.length)
                somme += a[i].getMontantAPayer();
            else
                return somme;

        return somme;
    }

    public static double calculSommeFacture(FactureFille a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getMontant();

        return somme;
    }

    public static double calculMoyennePventeFacture(FactureFille a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getPrixUnitaire();

        return somme / (double)a.length;
    }

    public static double getSommeFacture(FactureFille a[])
    {
        return calculSommeFacture(a);
    }

    public static double calculSommeFactureGroupe(FactMere a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getMontantAPayer();

        return somme;
    }

    public static double calculSommeFactureGroupe(FactMere a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getMontantAPayer();

        return somme;
    }

    public static double calculSommeFactureGroupeEntite(FactMere a[], String devise, String entite)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0 && a[i].getEntite().compareToIgnoreCase(entite) == 0 )
                somme += a[i].getMontantAPayer();

        return somme;
    }
    public static double calculSommeImPayeFacture(EtatFacture a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getReste();

        return somme;
    }
    public static double grouperEtatFacture(EtatFacture a[], String devise,String client)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if((a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)&&(a[i].getClient().compareToIgnoreCase(client))==0)
                somme += a[i].getReste();

        return somme;
    }
    public static double grouperEtatFactureClient(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        return somme;
    }
    public static double calculSommeImPayeFacture(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getReste();

        return somme;
    }

    public static double calculSommeFacture(EtatFacture a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getMontant();

        return somme;
    }

    public static double calculSommePayeFacture(EtatFacture a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getPaye();

        return somme;
    }

    public static double calculSommePayeFacture(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getPaye();

        return somme;
    }

    public static double calculSommeAvoirFacture(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getAvoir();

        return somme;
    }

    public static double calculSommeEtatFacture(EtatFacture a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getMontant();

        return somme;
    }

    public static double calculSommeEtatFacture(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getMontant();

        return somme;
    }

    public static double calculSommeTvaFacture(EtatFacture a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getTva();

        return somme;
    }

    public static double calculSommeTvaFacture(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getTva();

        return somme;
    }

    public static double calculSommeHTvaFacture(EtatFacture a[])
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            somme += a[i].getHtva();

        return somme;
    }

    public static double calculSommeHTvaFacture(EtatFacture a[], String devise)
    {
        double somme = 0.0D;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme += a[i].getHtva();

        return somme;
    }

    public static int getNombreFacture(EtatFacture a[], String devise)
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme++;

        return somme;
    }

    public static int getNombreFacture(FactMere a[], String devise)
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0)
                somme++;

        return somme;
    }
    public static int getNombreFactureEntiteDevise(FactMere a[], String devise,String entite)
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            if(a[i].getIdFactureEn().compareToIgnoreCase(devise) == 0 && a[i].getEntite().compareToIgnoreCase(entite) == 0 )
                somme++;

        return somme;
    }

    public static int getNombreFactureEntite(FactMere a[], String entite)
    {
        int somme = 0;
        for(int i = 0; i < a.length; i++)
            if(a[i].getEntite().compareToIgnoreCase(entite) == 0)
                somme++;

        return somme;
    }
}
