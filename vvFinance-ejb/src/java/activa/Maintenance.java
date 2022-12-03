package activa;
import bean.*;
import java.util.*;
import java.sql.Connection;

public class Maintenance extends ClassMAPTable{

  private String idMaintenance;
  private String remarque;
  private double prix;
  private java.sql.Date daty;
  private double nombre;
  private double prixMO;
  private int finCompteur;

public Maintenance() {
     super.setNomTable("maintenance");
}

public void construirePK(Connection c) throws Exception{
  super.setNomTable("maintenance");
  this.preparePk("MAIN","getSeqMaintenance");
  this.setIdMaintenance(makePK(c));
}

public String getAttributIDName() {
  return "idMaintenance";
}

public String getTuppleID() {
  return idMaintenance;
}

 public String getIdMaintenance() {
    return idMaintenance;
  }
  public void setIdMaintenance(String idMaintenance) {
    this.idMaintenance = idMaintenance;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setPrix(double prix) {
    this.prix = prix;
  }
  public double getPrix() {
    return prix;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setNombre(double nombre) {
    this.nombre = nombre;
  }
  public double getNombre() {
    return nombre;
  }
  public void setPrixMO(double prixMO) {
    this.prixMO = prixMO;
  }
  public double getPrixMO() {
    return prixMO;
  }
  public void setFinCompteur(int finCompteur) {
    this.finCompteur = finCompteur;
  }
  public int getFinCompteur() {
    return finCompteur;
  }
}