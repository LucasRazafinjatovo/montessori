package lc;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class LcDetail extends ClassMAPTable {

  private String id;
  private String idLc;
  private String compteDetail;
  private double credit;
  private double montantEng;
  private double montantVis;
  private double montantFact;
  private int etat;
  public LcDetail() {
  }
  public LcDetail(String idLc,String compteDet,String credit) {
    this.setNomTable("lcDetails");
    this.setNomProcedureSequence("getSeqLcDet");
    this.setIndicePk("LCD");
    this.setId(makePK());
    this.setIdLc(idLc);
    this.setCompteDetail(compteDet);
    this.setCredit(utilitaire.Utilitaire.stringToDouble(credit));
  }
  public LcDetail(String idLc,String compteDet,String credit,String montantEng, String montantVis, String montantFact,String etat) {
   this.setNomTable("lcDetails");
   this.setNomProcedureSequence("getSeqLcDet");
   this.setIndicePk("LCD");
   this.setId(makePK());
   this.setIdLc(idLc);
   this.setCompteDetail(compteDet);
   this.setCredit(utilitaire.Utilitaire.stringToDouble(credit));
   this.setMontantEng(utilitaire.Utilitaire.stringToDouble(montantEng));
   this.setMontantVis(utilitaire.Utilitaire.stringToDouble(montantVis));
   this.setMontantFact(utilitaire.Utilitaire.stringToDouble(montantFact));
   this.setEtat(utilitaire.Utilitaire.stringToInt(etat));

  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setIdLc(String idLc) {
    this.idLc = idLc;
  }
  public String getIdLc() {
    return idLc;
  }
  public void setCompteDetail(String compteDetail) {
    this.compteDetail = compteDetail;
  }
  public String getCompteDetail() {
    return compteDetail;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public double getCredit() {
    return credit;
  }
  public void setMontantEng(double montantEng) {
    this.montantEng = montantEng;
  }
  public double getMontantEng() {
    return montantEng;
  }
  public void setMontantVis(double montantVis) {
    this.montantVis = montantVis;
  }
  public double getMontantVis() {
    return montantVis;
  }
  public void setMontantFact(double montantFact) {
    this.montantFact = montantFact;
  }
  public double getMontantFact() {
    return montantFact;
  }
  public int getEtat() {
    return etat;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
}