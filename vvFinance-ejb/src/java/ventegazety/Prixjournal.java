/***********************************************************************
 * Module:  Vendeur.java
 * Author:  said
 * Purpose: Defines the Class Vendeur
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;


public class Prixjournal extends ClassMAPTable{
  public Prixjournal(){
  super.setNomTable("prixjournal");
  }
  public Prixjournal(String prix, String journal) throws Exception
  {
    super.setNomTable("prixjournal");
   this.preparePk("PRXJ","getSeqPrixJournal");
   this.setId(makePK());
   setPrix(utilitaire.Utilitaire.stringToDouble(prix));
   setJournal(journal);
 }
 public Prixjournal(String prix, String journal, Connection c) throws Exception
  {
   super.setNomTable("prixjournal");
   this.preparePk("PRXJ","getSeqPrixJournal");
    setPrix(utilitaire.Utilitaire.stringToDouble(prix));
    setJournal(journal);
   if(c==null)
   {
     c= new utilitaire.UtilDB().GetConn();
   }
   this.setId(makePK(c));
  }
  public void construirePK(Connection c) throws Exception
 {
   this.preparePk("PRXJ","getSeqPrixJournal");
   this.setId(makePK(c));
  }
   private String id;
  private double prix;
  private String journal;

  public String getAttributIDName() {
    return "id";
  }
 public String getTuppleID() {
    return id;
  }
  public double getPrix() {
    return prix;
  }
  public void setPrix(double prix) {
    this.prix = prix;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }

}