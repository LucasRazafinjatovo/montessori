package lc;

import bean.*;


public class Difflcgroupe extends ClassMAPTable {

  private String entite;
  private String mois;
  private double cmrec;
  private double engrec;
  private double viserec;
  private double facrec;
  private double cmdep;
  private double engdep;
  private double visedep;
  private double facdep;
  private String idDirection;
  private int annee;
  private double engreste;
  private double visereste;
  private double facreste;
  private double factrecor;
  private double factdepop;

  public Difflcgroupe() {
    setNomTable("DIFFLCGROUPE");
  }
  public String getAttributIDName() {
    return "entite";
  }
  public String getTuppleID() {
    return entite;
  }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public String getEntite() {
    return entite;
  }
  public void setMois(String mois) {
    this.mois = mois;
  }
  public String getMois() {
    return mois;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public int getAnnee() {
    return annee;
  }
  public void setCmrec(double cmrec) {
    this.cmrec = cmrec;
  }
  public double getCmrec() {
    return cmrec;
  }
  public void setEngrec(double engrec) {
    this.engrec = engrec;
  }
  public double getEngrec() {
    return engrec;
  }
  public void setViserec(double viserec) {
    this.viserec = viserec;
  }
  public double getViserec() {
    return viserec;
  }
  public void setFacrec(double facrec) {
    this.facrec = facrec;
  }
  public double getFacrec() {
    return facrec;
  }
  public void setCmdep(double cmdep) {
    this.cmdep = cmdep;
  }
  public double getCmdep() {
    return cmdep;
  }
  public void setEngdep(double engdep) {
    this.engdep = engdep;
  }
  public double getEngdep() {
    return engdep;
  }
  public void setVisedep(double visedep) {
    this.visedep = visedep;
  }
  public double getVisedep() {
    return visedep;
  }
  public void setFacdep(double facdep) {
    this.facdep = facdep;
  }
  public double getFacdep() {
    return facdep;
  }
  public void setIdDirection(String idDirection) {
    this.idDirection = idDirection;
  }
  public String getIdDirection() {
    return idDirection;
  }
  public void setEngreste(double engreste) {
    this.engreste = engreste;
  }
  public double getEngreste() {
    return engreste;
  }
  public void setVisereste(double visereste) {
    this.visereste = visereste;
  }
  public double getVisereste() {
    return visereste;
  }
  public void setFacreste(double facreste) {
    this.facreste = facreste;
  }
  public double getFacreste() {
    return facreste;
  }
  public void setFactrecor(double factrecor) {
    this.factrecor = factrecor;
  }
  public double getFactrecor() {
    return factrecor;
  }
  public void setFactdepop(double factdepop) {
    this.factdepop = factdepop;
  }
  public double getFactdepop() {
    return factdepop;
  }
}