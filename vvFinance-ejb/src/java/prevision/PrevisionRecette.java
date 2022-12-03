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

public class PrevisionRecette extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private double montant;
  private String remarque;
  private String idor;
  public PrevisionRecette() {
    super.setNomTable("orvita");
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public PrevisionRecette(String id, java.sql.Date daty, double montant, String description,String idor){
    this.setId(id);
    this.setDaty(daty);
    this.setMontant(montant);
    this.setRemarque(description);
    this.setIdor(idor);
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("orvita");
    this.preparePk("ORV","getSeqOrVita");
    this.setId(makePK(c));
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
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
  public void setRemarque(String description) {
    this.remarque = description;
  }
  public String getRemarque() {
    return remarque;
  }
  public String getIdor() {
    return idor;
  }
  public void setIdor(String idor) {
    this.idor = idor;
  }


}