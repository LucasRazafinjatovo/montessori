package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PrevRecetteLib extends ClassMAPTable{

  private java.sql.Date daty;
  private String designation;
  private String id;
  private String idligne;
  private String remarque;
  private String designationlc;
  private String idtypeligne;
  private String numcompte;
  private String identite;
  private String iddirection;
  private String parution;
  private int mois;
  private int annee;
  private double creditinitial;
  private double creditmodifier;
  private double montant;
  public PrevRecetteLib() {
    super.setNomTable("PrevRecetteLib");
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public String getTuppleID(){
  return id;
}
public String getAttributIDName(){
  return "id";
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setIdligne(String idligne) {
    this.idligne = idligne;
  }
  public String getIdligne() {
    return idligne;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDesignationlc(String designationlc) {
    this.designationlc = designationlc;
  }
  public String getDesignationlc() {
    return designationlc;
  }
  public void setIdtypeligne(String idtypeligne) {
    this.idtypeligne = idtypeligne;
  }
  public String getIdtypeligne() {
    return idtypeligne;
  }
  public void setNumcompte(String numcompte) {
    this.numcompte = numcompte;
  }
  public String getNumcompte() {
    return numcompte;
  }
  public void setIdentite(String identite) {
    this.identite = identite;
  }
  public String getIdentite() {
    return identite;
  }
  public void setIddirection(String iddirection) {
    this.iddirection = iddirection;
  }
  public String getIddirection() {
    return iddirection;
  }
  public void setParution(String parution) {
    this.parution = parution;
  }
  public String getParution() {
    return parution;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public int getMois() {
    return mois;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public int getAnnee() {
    return annee;
  }
  public void setCreditinitial(double creditinitial) {
    this.creditinitial = creditinitial;
  }
  public double getCreditinitial() {
    return creditinitial;
  }
  public void setCreditmodifier(double creditmodifier) {
    this.creditmodifier = creditmodifier;
  }
  public double getCreditmodifier() {
    return creditmodifier;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }

}