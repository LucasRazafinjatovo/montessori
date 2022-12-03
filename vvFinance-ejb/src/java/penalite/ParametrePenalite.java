// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ParametrePenalite.java

package penalite;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class ParametrePenalite extends ClassMAPTable
{

    public ParametrePenalite(String i, double taux, double majBC, int delai, int perfA, 
            int seuilTauxO, int majorTauxO, int slRapPeAn, int slNbPerAn, int pUVol, int slRapEnDomTo, int pxPtaExc, 
            int valLiCo, int nbLiAcAn, int pxAccExc, Date datyDeb)
    {
        super.setNomTable("parametrepenalite");
        setIdParametrePenalite(i);
        setDatyDebut(datyDeb);
        setTauxDirBanqCentrEurop(taux);
        setMajorBanqueCentrale(majBC);
        setDelaiPaiementPenalite(delai);
        setPerformanceAnnuel(perfA);
        setSeuilTauxOccupation(seuilTauxO);
        setMajorTauxOccupation(majorTauxO);
        setSlRapPerteAnnuel(slRapPeAn);
        setSlNbPerteAnnuel(slNbPerAn);
        setPxUnVol(pUVol);
        setSlRapEnDomTotal(slRapEnDomTo);
        setPxPtageExc(pxPtaExc);
        setValLimCont(valLiCo);
        setNbLimAccAnnuel(nbLiAcAn);
        setPxAccExc(pxAccExc);
    }

    public ParametrePenalite(String i, float taux, float majBC, int delai, int perfA, int seuilTauxO, int majorTauxO, 
            int slRapPeAn, int slNbPerAn, int pUVol, int slRapEnDomTo, int pxPtaExc, int valLiCo, int nbLiAcAn, 
            int pxAccExc, Date datyDeb)
    {
        super.setNomTable("parametrepenalite");
        setIdParametrePenalite(i);
        setDatyDebut(datyDeb);
        setTauxDirBanqCentrEurop(taux);
        setMajorBanqueCentrale(majBC);
        setDelaiPaiementPenalite(delai);
        setPerformanceAnnuel(perfA);
        setSeuilTauxOccupation(seuilTauxO);
        setMajorTauxOccupation(majorTauxO);
        setSlRapPerteAnnuel(slRapPeAn);
        setSlNbPerteAnnuel(slNbPerAn);
        setPxUnVol(pUVol);
        setSlRapEnDomTotal(slRapEnDomTo);
        setPxPtageExc(pxPtaExc);
        setValLimCont(valLiCo);
        setNbLimAccAnnuel(nbLiAcAn);
        setPxAccExc(pxAccExc);
    }

    public ParametrePenalite(float taux, float majBC, int delai, int perfA, int seuilTauxO, int majorTauxO, int slRapPeAn, 
            int slNbPerAn, int pUVol, int slRapEnDomTo, int pxPtaExc, int valLiCo, int nbLiAcAn, int pxAccExc, 
            Date datyDeb)
    {
        super.setNomTable("parametrepenalite");
        setIndicePk("PP");
        setNomProcedureSequence("getSeqParametrePenalite");
        setIdParametrePenalite(makePK());
        setDatyDebut(datyDeb);
        setTauxDirBanqCentrEurop(taux);
        setMajorBanqueCentrale(majBC);
        setDelaiPaiementPenalite(delai);
        setPerformanceAnnuel(perfA);
        setSeuilTauxOccupation(seuilTauxO);
        setMajorTauxOccupation(majorTauxO);
        setSlRapPerteAnnuel(slRapPeAn);
        setSlNbPerteAnnuel(slNbPerAn);
        setPxUnVol(pUVol);
        setSlRapEnDomTotal(slRapEnDomTo);
        setPxPtageExc(pxPtaExc);
        setValLimCont(valLiCo);
        setNbLimAccAnnuel(nbLiAcAn);
        setPxAccExc(pxAccExc);
    }

    public ParametrePenalite(String taux, String majBC, String delai, String perfA, String seuilTauxO, String majorTauxO, String slRapPeAn, 
            String slNbPerAn, String pUVol, String slRapEnDomTo, String pxPtaExc, String valLiCo, String nbLiAcAn, String pxAccExc, 
            String datyDeb)
    {
        super.setNomTable("parametrepenalite");
        setIndicePk("PP");
        setNomProcedureSequence("getSeqParametrePenalite");
        setIdParametrePenalite(makePK());
        if(String.valueOf(datyDeb).compareTo("") == 0 || datyDeb == null)
            setDatyDebut(Utilitaire.dateDuJourSql());
        else
            setDatyDebut(Utilitaire.string_date("dd/MM/yyyy", datyDeb));
        if(String.valueOf(taux).compareTo("") == 0)
            setTauxDirBanqCentrEurop(0.0D);
        else
            setTauxDirBanqCentrEurop(Utilitaire.stringToDouble(taux));
        if(String.valueOf(majBC).compareTo("") == 0)
            setMajorBanqueCentrale(0.0D);
        else
            setMajorBanqueCentrale(Utilitaire.stringToDouble(majBC));
        if(String.valueOf(delai).compareTo("") == 0)
            setDelaiPaiementPenalite(0);
        else
            setDelaiPaiementPenalite(Utilitaire.stringToInt(delai));
        if(String.valueOf(perfA).compareTo("") == 0)
            setPerformanceAnnuel(0);
        else
            setPerformanceAnnuel(Utilitaire.stringToInt(perfA));
        if(String.valueOf(seuilTauxO).compareTo("") == 0)
            setSeuilTauxOccupation(0);
        else
            setSeuilTauxOccupation(Utilitaire.stringToInt(seuilTauxO));
        if(String.valueOf(majorTauxO).compareTo("") == 0)
            setMajorTauxOccupation(0);
        else
            setMajorTauxOccupation(Utilitaire.stringToInt(majorTauxO));
        if(String.valueOf(slRapPeAn).compareTo("") == 0)
            setSlRapPerteAnnuel(0);
        else
            setSlRapPerteAnnuel(Utilitaire.stringToInt(slRapPeAn));
        if(String.valueOf(slNbPerAn).compareTo("") == 0)
            setSlNbPerteAnnuel(0);
        else
            setSlNbPerteAnnuel(Utilitaire.stringToInt(slNbPerAn));
        if(String.valueOf(pUVol).compareTo("") == 0)
            setPxUnVol(0);
        else
            setPxUnVol(Utilitaire.stringToInt(pUVol));
        if(String.valueOf(slRapEnDomTo).compareTo("") == 0)
            setSlRapEnDomTotal(0);
        else
            setSlRapEnDomTotal(Utilitaire.stringToInt(slRapEnDomTo));
        if(String.valueOf(pxPtaExc).compareTo("") == 0)
            setPxPtageExc(0);
        else
            setPxPtageExc(Utilitaire.stringToInt(pxPtaExc));
        if(String.valueOf(valLiCo).compareTo("") == 0)
            setValLimCont(0);
        else
            setValLimCont(Utilitaire.stringToInt(valLiCo));
        if(String.valueOf(nbLiAcAn).compareTo("") == 0)
            setNbLimAccAnnuel(0);
        else
            setNbLimAccAnnuel(Utilitaire.stringToInt(nbLiAcAn));
        if(String.valueOf(pxAccExc).compareTo("") == 0)
            setPxAccExc(0);
        else
            setPxAccExc(Utilitaire.stringToInt(pxAccExc));
    }

    public String getAttributIDName()
    {
        return "idParametrePenalite";
    }

    public String getTuppleID()
    {
        return String.valueOf(idParametrePenalite);
    }

    public void setIdParametrePenalite(String idParametrePenalite)
    {
        this.idParametrePenalite = idParametrePenalite;
    }

    public String getIdParametrePenalite()
    {
        return idParametrePenalite;
    }

    public void setTauxDirBanqCentrEurop(double tauxDirBanqCentrEurop)
    {
        if(String.valueOf(tauxDirBanqCentrEurop).compareTo("") == 0)
            this.tauxDirBanqCentrEurop = 0.0D;
        else
            this.tauxDirBanqCentrEurop = tauxDirBanqCentrEurop;
    }

    public double getTauxDirBanqCentrEurop()
    {
        return tauxDirBanqCentrEurop;
    }

    public void setMajorBanqueCentrale(double majorBanqueCentrale)
    {
        if(String.valueOf(majorBanqueCentrale).compareTo("") == 0)
            this.majorBanqueCentrale = 0.0D;
        else
            this.majorBanqueCentrale = majorBanqueCentrale;
    }

    public double getMajorBanqueCentrale()
    {
        return majorBanqueCentrale;
    }

    public void setDelaiPaiementPenalite(int delaiPaiementPenalite)
    {
        if(String.valueOf(delaiPaiementPenalite).compareTo("") == 0)
            this.delaiPaiementPenalite = 0;
        else
            this.delaiPaiementPenalite = delaiPaiementPenalite;
    }

    public int getDelaiPaiementPenalite()
    {
        return delaiPaiementPenalite;
    }

    public void setPerformanceAnnuel(int performanceAnnuel)
    {
        if(String.valueOf(performanceAnnuel).compareTo("") == 0)
            this.performanceAnnuel = 0;
        else
            this.performanceAnnuel = performanceAnnuel;
    }

    public int getPerformanceAnnuel()
    {
        return performanceAnnuel;
    }

    public void setSeuilTauxOccupation(int seuilTauxOccupation)
    {
        if(String.valueOf(seuilTauxOccupation).compareTo("") == 0)
            this.seuilTauxOccupation = 0;
        else
            this.seuilTauxOccupation = seuilTauxOccupation;
    }

    public int getSeuilTauxOccupation()
    {
        return seuilTauxOccupation;
    }

    public void setMajorTauxOccupation(int majorTauxOccupation)
    {
        if(String.valueOf(majorTauxOccupation).compareTo("") == 0)
            this.majorTauxOccupation = 0;
        else
            this.majorTauxOccupation = majorTauxOccupation;
    }

    public int getMajorTauxOccupation()
    {
        return majorTauxOccupation;
    }

    public void setSlRapPerteAnnuel(int slRapPerteAnnuel)
    {
        if(String.valueOf(slRapPerteAnnuel).compareTo("") == 0)
            this.slRapPerteAnnuel = 0;
        else
            this.slRapPerteAnnuel = slRapPerteAnnuel;
    }

    public int getSlRapPerteAnnuel()
    {
        return slRapPerteAnnuel;
    }

    public void setSlNbPerteAnnuel(int slNbPerteAnnuel)
    {
        if(String.valueOf(slNbPerteAnnuel).compareTo("") == 0)
            this.slNbPerteAnnuel = 0;
        else
            this.slNbPerteAnnuel = slNbPerteAnnuel;
    }

    public int getSlNbPerteAnnuel()
    {
        return slNbPerteAnnuel;
    }

    public void setPxUnVol(int pxUnVol)
    {
        if(String.valueOf(pxUnVol).compareTo("") == 0)
            this.pxUnVol = 0;
        else
            this.pxUnVol = pxUnVol;
    }

    public int getPxUnVol()
    {
        return pxUnVol;
    }

    public void setSlRapEnDomTotal(int slRapEnDomTotal)
    {
        if(String.valueOf(slRapEnDomTotal).compareTo("") == 0)
            this.slRapEnDomTotal = 0;
        else
            this.slRapEnDomTotal = slRapEnDomTotal;
    }

    public int getSlRapEnDomTotal()
    {
        return slRapEnDomTotal;
    }

    public void setPxPtageExc(int pxPtageExc)
    {
        if(String.valueOf(pxPtageExc).compareTo("") == 0)
            this.pxPtageExc = 0;
        else
            this.pxPtageExc = pxPtageExc;
    }

    public int getPxPtageExc()
    {
        return pxPtageExc;
    }

    public void setValLimCont(int valLimCont)
    {
        if(String.valueOf(valLimCont).compareTo("") == 0)
            this.valLimCont = 0;
        else
            this.valLimCont = valLimCont;
    }

    public int getValLimCont()
    {
        return valLimCont;
    }

    public void setNbLimAccAnnuel(int nbLimAccAnnuel)
    {
        if(String.valueOf(nbLimAccAnnuel).compareTo("") == 0)
            this.nbLimAccAnnuel = 0;
        else
            this.nbLimAccAnnuel = nbLimAccAnnuel;
    }

    public int getNbLimAccAnnuel()
    {
        return nbLimAccAnnuel;
    }

    public void setPxAccExc(int pxAccExc)
    {
        if(String.valueOf(pxAccExc).compareTo("") == 0)
            this.pxAccExc = 0;
        else
            this.pxAccExc = pxAccExc;
    }

    public int getPxAccExc()
    {
        return pxAccExc;
    }

    public void setDatyDebut(Date datyDebut)
    {
        if(String.valueOf(datyDebut).compareTo("") == 0 || datyDebut == null)
            this.datyDebut = Utilitaire.dateDuJourSql();
        else
            this.datyDebut = datyDebut;
    }

    public Date getDatyDebut()
    {
        return datyDebut;
    }

    public String idParametrePenalite;
    public Date datyDebut;
    public int delaiPaiementPenalite;
    public int performanceAnnuel;
    public int seuilTauxOccupation;
    public int majorTauxOccupation;
    public int slRapPerteAnnuel;
    public int slNbPerteAnnuel;
    public int pxUnVol;
    public int slRapEnDomTotal;
    public int pxPtageExc;
    public int valLimCont;
    public int nbLimAccAnnuel;
    public int pxAccExc;
    public double majorBanqueCentrale;
    public double tauxDirBanqCentrEurop;
}
