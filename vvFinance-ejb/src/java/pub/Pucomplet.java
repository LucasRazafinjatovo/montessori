package pub;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Pucomplet extends Publicite {

  private String libClient;
  private double montantVal;
  private String libCat;
  private String libAgence;
  private int numParution;
  private java.sql.Date datyParution;
  private String libJournal;
  private double nbExTh;
  private int couleur;
  private double montantht;
  private java.sql.Date datycloture;
  public Pucomplet() {
    this.setNomTable("pubComplet");
  }
  public String getLibClient() {
    return libClient;
  }
  public void setLibClient(String libClient) throws Exception{
    if(libClient==null ||libClient.compareToIgnoreCase("")==0) throw new Exception("libClient vide");
    this.libClient = libClient;
  }
  public void setMontantVal(double montantVal) {
    this.montantVal = montantVal;
  }
  public double getMontantVal() {
    return montantVal;
  }
  public void setLibCat(String libCat) {
    this.libCat = libCat;
  }
  public String getLibCat() {
    return libCat;
  }
  public void setLibAgence(String libAgence) {
    this.libAgence = libAgence;
  }
  public String getLibAgence() {
    return libAgence;
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
  public void setLibJournal(String libJournal) {
    this.libJournal = libJournal;
  }
  public String getLibJournal() {
    return libJournal;
  }
  public void setNbExTh(double nbExTh) {
    this.nbExTh = nbExTh;
  }
  public double getNbExTh() {
    return nbExTh;
  }
  public void setCouleur(int couleur) {
    this.couleur = couleur;
  }
  public int getCouleur() {
    return couleur;
  }
  public void setMontantht(double montantht) {
    this.montantht = montantht;
  }
  public double getMontantht() {
    return montantht;
  }
  public void setDatycloture(java.sql.Date datycloture) {
    this.datycloture = datycloture;
  }
  public java.sql.Date getDatycloture() {
    return datycloture;
  }
}