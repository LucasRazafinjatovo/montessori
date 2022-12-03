package ventegazety;

import bean.*;
//import java.sql.Connection;


public class PayementSaisie extends ClassMAPTable{
  public PayementSaisie(){

  }
  public PayementSaisie(String numpar,String vendeur,String journal,String dat,String montant,String remarque) throws Exception
  {
    setNumeroParution(utilitaire.Utilitaire.stringToInt(numpar));
    setVendeur(vendeur);
    setJournal(journal);
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setMontant(utilitaire.Utilitaire.stringToDouble(montant));
    setRemarque(remarque);
  }
 /* public PayementSaisie(String numpar,String vendeur,String journal,String dat, String nbrinv, String remarque, Connection c) throws Exception
  {
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setNumeroParution(utilitaire.Utilitaire.stringToInt(numpar));
    setVendeur(vendeur);
    setJournal(journal);
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setMontant(utilitaire.Utilitaire.stringToInt(nbrinv));
    setRemarque(remarque);
    if(c==null){
      c=new utilitaire.UtilDB().GetConn();
    }
    this.setId(makePK(c));
  }*/


  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getVendeur() {
    return vendeur;
  }
  public void setVendeur(String vendeur) {
    this.vendeur = vendeur;
  }
  public double getMontant() {
    return montant;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setNumeroParution(int numeroParution) {
    this.numeroParution = numeroParution;
  }
  public int getNumeroParution() {
    return numeroParution;
  }

  String id;
 private java.sql.Date daty;
 private String vendeur;
  private String remarque;
  private String journal;
  private int numeroParution;
  private double montant;



}