package finance;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class DetailMvtCaisse extends ClassMAPTable {

  private String id;
  private double debit;
  private double credit;
  private String tiers;
  private String remarque;
  private String idMere;
  private int parution;
  private String numPieces;
  public DetailMvtCaisse() {
  }
  public DetailMvtCaisse(String id, double debit, double credit, String tiers, String remarque, String idMere,int paru) {
    setNomTable("DetailMvtCaisse");
    setId(id);
    setDebit(debit);
    setCredit(credit);
    setTiers(tiers);
    setRemarque(remarque);
    setIdMere(idMere);
    this.setParution(paru);
  }
  public DetailMvtCaisse(String debit, String credit, String tiers, String remarque, String idMere,String paru) {
   setNomTable("DetailMvtCaisse");
   setIndicePk("DET");
   setNomProcedureSequence("getSeqDetMvt");
   id=makePK();
   setDebit(utilitaire.Utilitaire.stringToDouble(debit));
   setCredit(utilitaire.Utilitaire.stringToDouble(credit));
   setTiers(tiers);
   setRemarque(remarque);
   setIdMere(idMere);
   setParution(utilitaire.Utilitaire.stringToInt(paru));
  }
  public DetailMvtCaisse(String debit, String credit, String tiers, String remarque, String idMere,String paru,String numP) {
   setNomTable("DetailMvtCaisse");
   setIndicePk("DET");
   setNomProcedureSequence("getSeqDetMvt");
   id=makePK();
   setDebit(utilitaire.Utilitaire.stringToDouble(debit));
   setCredit(utilitaire.Utilitaire.stringToDouble(credit));
   setTiers(tiers);
   setRemarque(remarque);
   setIdMere(idMere);
   setParution(utilitaire.Utilitaire.stringToInt(paru));
   this.setNumPieces(numP);
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
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public double getDebit() {
    return debit;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public double getCredit() {
    return credit;
  }
  public void setTiers(String tiers) {
    this.tiers = tiers;
  }
  public String getTiers() {
    return tiers;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setIdMere(String idMere) {
    this.idMere = idMere;
  }
  public String getIdMere() {
    return idMere;
  }
  public void setParution(int parution) {
    this.parution = parution;
  }
  public int getParution() {
    return parution;
  }
  public void setNumPieces(String numPieces) {
    this.numPieces = numPieces;
  }
  public String getNumPieces() {
    return numPieces;
  }
}