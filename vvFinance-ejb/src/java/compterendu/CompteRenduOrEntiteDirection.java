package compterendu;
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

public class CompteRenduOrEntiteDirection extends ClassMAPTable{

  private String entite;
  private String direction;
  private java.sql.Date daty;
  private double montant;
  public CompteRenduOrEntiteDirection() {
  }
  public String getTuppleID()
    {
        return entite;
    }

    public String getAttributIDName()
    {
        return "entite";
    }
  public String getEntite() {
    return entite;
  }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public void setDirection(String direction) {
    this.direction = direction;
  }
  public String getDirection() {
    return direction;
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
}