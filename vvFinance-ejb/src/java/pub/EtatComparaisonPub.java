package pub;

import bean.*;
import java.sql.Connection;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtatComparaisonPub extends ClassMAPTable {

  private java.sql.Date daty;
  private String journal;
  private String format;
  private int couleur;
  private int nbsaisie;
  private int nbverifie;
  private int nbpublie;
  private int diffverif;
  private int diffpublie;

  public EtatComparaisonPub() {
    super.setNomTable("ETATCOMPARAISONPUB");
  }


  public String getAttributIDName() {
    return "";
  }
  public String getTuppleID() {
    return null;
  }
  public int getCouleur() {
    return couleur;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public int getDiffpublie() {
    return diffpublie;
  }

  public String getFormat() {
    return format;
  }
  public String getJournal() {
    return journal;
  }
  public int getNbpublie() {
    return nbpublie;
  }
  public int getNbsaisie() {
    return nbsaisie;
  }
  public int getNbverifie() {
    return nbverifie;
  }
  public void setNbverifie(int nbverif) {
    this.nbverifie = nbverif;
  }
  public void setNbsaisie(int nbsaisie) {
    this.nbsaisie = nbsaisie;
  }
  public void setNbpublie(int nbpublie) {
    this.nbpublie = nbpublie;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public void setFormat(String format) {
    this.format = format;
  }

  public void setDiffpublie(int diffpublie) {
    this.diffpublie = diffpublie;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setCouleur(int couleur) {
    this.couleur = couleur;
  }
  public int getDiffverif() {
    return diffverif;
  }
  public void setDiffverif(int diffverif) {
    this.diffverif = diffverif;
  }

}