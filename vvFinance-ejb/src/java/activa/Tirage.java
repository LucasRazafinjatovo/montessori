package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Tirage extends ClassMAPTable{
  private String idTirage;
  private double nbTirageNoir;
  private double nbTirageCouleur;
  private double prixEncreNoir;
  private double prixEncreCouleur;
  private java.sql.Date daty;

  public Tirage(){
    super.setNomTable("tirage");
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("tirage");
     this.preparePk("TIR","getSeqTirage");
     this.setIdTirage(makePK(c));
  }
  public Tirage(String nbt,String coutnb,String typec) {
     super.setNomTable("tirage");
     //this.setNbTirage(utilitaire.Utilitaire.stringToDouble(nbt));
    // setcoutNombreTirage(utilitaire.Utilitaire.stringToDouble(coutnb));
     //setTypeCouleur(typec);
     setIndicePk("TIR");
     setNomProcedureSequence("getSeqTirage");
     setIdTirage(makePK());
  }

  public String getAttributIDName() {
    return "idTirage";
  }

  public String getTuppleID() {
    return idTirage;
  }

  public String getIdTirage() {
    return idTirage;
  }
  public void setIdTirage(String idTirage) {
    this.idTirage = idTirage;
  }
  public void setNbTirageNoir(double nbTirageNoir) {
    this.nbTirageNoir = nbTirageNoir;
  }
  public double getNbTirageNoir() {
    return nbTirageNoir;
  }
  public void setNbTirageCouleur(double nbTirageCouleur) {
    this.nbTirageCouleur = nbTirageCouleur;
  }
  public double getNbTirageCouleur() {
    return nbTirageCouleur;
  }
  public void setPrixEncreNoir(double prixEncreNoir) {
    this.prixEncreNoir = prixEncreNoir;
  }
  public double getPrixEncreNoir() {
    return prixEncreNoir;
  }
  public void setPrixEncreCouleur(double prixEncreCouleur) {
    this.prixEncreCouleur = prixEncreCouleur;
  }
  public double getPrixEncreCouleur() {
    return prixEncreCouleur;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}
