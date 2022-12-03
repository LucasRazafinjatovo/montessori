// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EtatFacture.java

package facture;

import java.sql.Date;
import java.io.Serializable;

public class EtatFacture implements Serializable
{

    public EtatFacture(String num, Date dt, String clien, double montFille, String factEn, double montan, double pay, double rest, double avoi)
    {
        setIdFactureMere(num);
        setDaty(daty);
        setClient(clien);
        setMontant(montan);
        setPaye(pay);
        setReste(rest);
        setMontantFille(montFille);
        setIdFactureEn(factEn);
        setAvoir(avoi);
    }

    public EtatFacture(String num, Date dt, String clien, double montFille, String factEn, double montan, double pay, double rest, double htva,
            double tva, String etat, String idScat, double avoi,String res,String entit,String parutio)
    {
        setIdScatService(idScat);
        setIdFactureMere(num);
        setDaty(daty);
        setClient(clien);
        setMontant(montan);
        setPaye(pay);
        setReste(rest);
        setMontantFille(montFille);
        setIdFactureEn(factEn);
        setHtva(htva);
        setTva(tva);
        setEtat(etat);
        setAvoir(avoi);
        setResp(res);
        setEntite(entit);
        setParution(parutio);
    }

    public String getIdFactureMere()
    {
        return idFactureMere;
    }

    public void setIdFactureMere(String idFactureMere)
    {
        this.idFactureMere = idFactureMere;
    }

    public void setDaty(Date daty)
    {
        this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setClient(String client)
    {
        this.client = client;
    }

    public String getClient()
    {
        return client;
    }

    public void setMontant(double montant)
    {
        this.montant = montant;
    }

    public double getMontant()
    {
        return montant;
    }

    public void setPaye(double paye)
    {
        this.paye = paye;
    }

    public double getPaye()
    {
        return paye;
    }

    public void setReste(double reste)
    {
        this.reste = reste;
    }

    public double getReste()
    {
        return reste;
    }

    public void setMontantFille(double montantFille)
    {
        this.montantFille = montantFille;
    }

    public double getMontantFille()
    {
        return montantFille;
    }

    public void setIdFactureEn(String idFactureEn)
    {
        this.idFactureEn = idFactureEn;
    }

    public String getIdFactureEn()
    {
        return idFactureEn;
    }

    public void setHtva(double htva)
    {
        this.htva = htva;
    }

    public double getHtva()
    {
        return htva;
    }

    public void setTva(double tva)
    {
        this.tva = tva;
    }

    public double getTva()
    {
        return tva;
    }

    public void setEtat(String etat)
    {
        this.etat = etat;
    }

    public String getEtat()
    {
        return etat;
    }

    public void setIdScatService(String idScatService)
    {
        this.idScatService = idScatService;
    }

    public String getIdScatService()
    {
        return idScatService;
    }

    public void setAvoir(double avoir)
    {
        this.avoir = avoir;
    }

    public double getAvoir()
    {
        return avoir;
    }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public String getEntite() {
    return entite;
  }
  public void setResp(String resp) {
    this.resp = resp;
  }
  public String getResp() {
    return resp;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public String getParution() {
    return parution;
  }

    private Date daty;
    private String client;
    private String idFactureMere;
    private double montantFille;
    private String idFactureEn;
    private double montant;
    private double paye;
    private double reste;
    private double htva;
    private double tva;
    private String etat;
    private String idScatService;
    private double avoir;
  private String entite;
  private String resp;
  private String parution;
}
