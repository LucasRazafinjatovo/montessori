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

public class PrevRecetteSum extends ClassMAPTable{

  private java.sql.Date daty;
  private String idligne;
  private String designationlc;
  private double montant;
  private String identite;
  public PrevRecetteSum() {
    super.setNomTable("PrevRecetteSum");
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public String getTuppleID(){
  return idligne;
}
public String getAttributIDName(){
  return "idligne";
  }
  public void setIdligne(String idligne) {
    this.idligne = idligne;
  }
  public String getIdligne() {
    return idligne;
  }
  public void setDesignationlc(String designationlc) {
    this.designationlc = designationlc;
  }
  public String getDesignationlc() {
    return designationlc;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setIdentite(String identite) {
    this.identite = identite;
  }
  public String getIdentite() {
    return identite;
  }

}