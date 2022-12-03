package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
public class PrevRecetteAVise extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private double montant;
  private String description;
  private String idligne;
  public PrevRecetteAVise() {
    super.setNomTable("PrevRecetteAVise");
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
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
}