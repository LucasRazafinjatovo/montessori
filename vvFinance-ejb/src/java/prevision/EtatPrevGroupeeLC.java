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

public class EtatPrevGroupeeLC extends ClassMAPTable{

  private java.sql.Date daty; //
  private String description;//
  private String idligne;//
  private String designationLc;//
  private String identite;//
  private String iddirection;//
  private String idtypeligne;//
  private int mois;//
  private int annee;//
  private int mois_lc;//
  private int annee_lc;//
  private double montant;//
  private String id; //
  private String typecharge;
  private String idor;//
  public EtatPrevGroupeeLC() {
    super.setNomTable("EtatPrevGroupeeLC");
  }
  public String getTuppleID(){
   return id;
 }
 public String getAttributIDName(){
   return "id";
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDescription(String description) {
    this.description = description;
  }
  public String getDescription() {
    return description;
  }
  public void setIdligne(String idligne) {
    this.idligne = idligne;
  }
  public String getIdligne() {
    return idligne;
  }
  public void setDesignationLc(String designationLc) {
    this.designationLc = designationLc;
  }
  public String getDesignationLc() {
    return designationLc;
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
  public void setIdtypeligne(String idtypeligne) {
    this.idtypeligne = idtypeligne;
  }
  public String getIdtypeligne() {
    return idtypeligne;
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
  public void setMois_lc(int mois_lc) {
    this.mois_lc = mois_lc;
  }
  public int getMois_lc() {
    return mois_lc;
  }
  public void setAnnee_lc(int annee_lc) {
    this.annee_lc = annee_lc;
  }
  public int getAnnee_lc() {
    return annee_lc;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setTypecharge(String typecharge) {
    this.typecharge = typecharge;
  }
  public String getTypecharge() {
    return typecharge;
  }
  public void setIdor(String idor) {
    this.idor = idor;
  }
  public String getIdor() {
    return idor;
  }
}