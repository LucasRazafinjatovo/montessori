package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Livraison extends ClassMAPTable{

  private String idproduction;
  private String idlivraison;
  private String heurelivraison;
  private double quantite;
  private java.sql.Date datelivraison;
  public Livraison(){
    super.setNomTable("livraison");
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("livraison");
     this.preparePk("LIV","getSeqLivraison");
     this.setIdlivraison(makePK(c));
  }

  public Livraison(String idp,String d,String h,String q){
     super.setNomTable("livraison");
     this.setIdproduction(idp);
     setDatelivraison(java.sql.Date.valueOf(d));
     setHeurelivraison(h);
     setQuantite(utilitaire.Utilitaire.stringToInt(q));
     setIndicePk("LIV");
     setNomProcedureSequence("getSeqLivraison");
     setIdlivraison(makePK());
  }

  public String getAttributIDName() {
    return "idlivraison";
  }

  public String getTuppleID() {
    return idlivraison;
  }
  public void setIdproduction(String idproduction) {
    this.idproduction = idproduction;
  }
  public String getIdproduction() {
    return idproduction;
  }
  public void setIdlivraison(String idlivraison) {
    this.idlivraison = idlivraison;
  }
  public String getIdlivraison() {
    return idlivraison;
  }
  public void setDatelivraison(java.sql.Date datelivraison) {
    this.datelivraison = datelivraison;
  }
  public java.sql.Date getDatelivraison() {
    return datelivraison;
  }
  public void setHeurelivraison(String heurelivraison) {
    this.heurelivraison = heurelivraison;
  }
  public String getHeurelivraison() {
    return heurelivraison;
  }
  public void setQuantite(double quantite) {
    this.quantite = quantite;
  }
  public double getQuantite() {
    return quantite;
  }

}
