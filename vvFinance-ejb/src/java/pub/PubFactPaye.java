package pub;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.*;
import java.sql.Connection;
import facture.Client;
import utilitaire.Utilitaire;
public class PubFactPaye extends ClassMAPTable{

  private String factclient;
  private double montant;
  private double paye;
  private double commission;
  private String client;
  private String numcompte;
  private int mois;
  private int annee;
  private String idop;


  public PubFactPaye() {
    this.setNomTable("PubFactPaye");
  }
  public PubFactPaye(String fact,String clt, String numcompte) {
    this.setFactclient(fact);
    this.setClient(clt);
    this.setNumcompte(numcompte);
  }
  public String getAttributIDName() {
    return "factclient";
  }
  public String getTuppleID() {
    return factclient;
  }
  public String getFactclient() {
    return factclient;
  }
  public void setFactclient(String factclient) {
    this.factclient = factclient;
  }
  public void setMontant(double montant) {
    this.montant = montant;
    //this.setCommission(montant);
  }
  public double getMontant() {
    return montant;
  }
  public void setPaye(double paye) {
    this.paye = paye;
  }
  public double getPaye() {
    return paye;
  }
  public void setCommission(double commission) {

    /*if(this.getNumcompte().compareToIgnoreCase("DComm")==0){
      this.commission = commission * utilitaire.Constante.tauxSansRemiseDComm;
    }else if (this.getNumcompte().compareToIgnoreCase("Liliane") == 0){
      this.commission = commission * utilitaire.Constante.tauxCommissionLiliane;
    }else{ // commission commercial sans remise
      this.commission = commission * utilitaire.Constante.tauxSansRemiseCommercial;
    }*/

      this.commission = commission;
  }

  public double getCommission() {
    return commission;
  }
  public void setClient(String client) {
    this.client = client;
  }
  public String getClient() {
    return client;
  }
  public void setNumcompte(String numcompte) {
    this.numcompte = numcompte;
  }
  public String getNumcompte() {
    return numcompte;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public int getAnnee() {
    return annee;
  }
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdop() {
    return idop;
  }
  public int getMois() {
    return mois;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
}