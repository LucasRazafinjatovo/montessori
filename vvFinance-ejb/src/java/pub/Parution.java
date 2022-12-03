package pub;

import bean.*;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Parution extends ClassMAPTable {

  public Parution() {
    super.setNomTable("Parution");
  }
  public Parution(String dat,String journ,String numP,String datyP,String nbp,String nbEx,String rem) throws Exception {
    super.setNomTable("Parution");
    this.preparePk("PAR","getSeqParution");
    //this.preparePk("PAT","getSeqParution");//ank
    this.setId(makePK());
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    this.setJournal(journ);
    this.setNumParution(utilitaire.Utilitaire.stringToInt(numP));
    this.setDatyParution(utilitaire.Utilitaire.string_date("dd/MM/yyyy",datyP));
    this.setNbpage(utilitaire.Utilitaire.stringToInt(nbp));
    this.setNbexth(utilitaire.Utilitaire.stringToInt(nbEx));
    this.setRemarque(rem);
  }
  public Parution(String datP,String journ,String numP,Date daty,String nbp,String nbEx,String rem) throws Exception {
    super.setNomTable("Parution");
    this.preparePk("PAR","getSeqParution");
    //this.preparePk("PAT","getSeqParution");//ank
    this.setId(makePK());
    this.setDaty(daty);
    this.setJournal(journ);
    this.setNumParution(utilitaire.Utilitaire.stringToInt(numP));
    this.setDatyParution(utilitaire.Utilitaire.string_date("dd/MM/yyyy",datP));
    this.setNbpage(utilitaire.Utilitaire.stringToInt(nbp));
    this.setNbexth(utilitaire.Utilitaire.stringToInt(nbEx));
    this.setRemarque(rem);
  }
  String id;
  private java.sql.Date daty;
  private String journal;
  private int numParution;
  private java.sql.Date datyParution;
  private int nbpage;
  private int nbexth;
  private String remarque;

  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setNumParution(int numParution) {
    this.numParution = numParution;
  }
  public int getNumParution() {
    return numParution;
  }
  public void setDatyParution(java.sql.Date datyParution) {
    this.datyParution = datyParution;
  }
  public java.sql.Date getDatyParution() {
    return datyParution;
  }
  public void setNbpage(int nbpage) {
    this.nbpage = nbpage;
  }
  public int getNbpage() {
    return nbpage;
  }
  public void setNbexth(int nbexth) {
    this.nbexth = nbexth;
  }
  public int getNbexth() {
    return nbexth;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
}