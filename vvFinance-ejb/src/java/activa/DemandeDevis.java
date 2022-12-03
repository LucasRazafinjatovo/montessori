package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class DemandeDevis extends ClassMAPTable{
  private String idDevis;
  private String idCodeRV;
  private String idArticle;
  private String designation;
  private double remise;
  private java.sql.Date dateDevis;
  private String idClient;
  private String idMarge;
  private String idGestion;
  private String idTirage;
  private double margeBenefice;
  private double nbExemplaireA3;
  private int statut;
  private double nombre;

  public DemandeDevis() {
    super.setNomTable("DemandeDevis");
  }

  public void construirePK(Connection c) throws Exception{
   super.setNomTable("DemandeDevis");
   this.preparePk("DMD","getSeqDemandeDevis");
   this.setIdDevis(makePK(c));
 }

  public DemandeDevis(String idCodeRV,String idArt,String desi,String nb,String rem,String d) {
    super.setNomTable("DemandeDevis");
    setIdArticle(idArt);
    setDesignation(desi);
   // setNombreImpression(Integer.parseInt(nb));
    setRemise(utilitaire.Utilitaire.stringToDouble(rem));
    setDateDevis(java.sql.Date.valueOf(d));
    setIndicePk("DMD");
    setNomProcedureSequence("getSeqDemandeDevis");
    setIdArticle(makePK());
  }

  public String getAttributIDName() {
     return "idDevis";
   }

   public String getTuppleID() {
     return idDevis;
  }

  public String getIdDevis() {
    return idDevis;
  }
  public void setIdDevis(String idDevis) {
    this.idDevis = idDevis;
  }
  public void setIdCodeRV(String idCodeRV) {
    this.idCodeRV = idCodeRV;
  }
  public String getIdCodeRV() {
    return idCodeRV;
  }
  public void setIdArticle(String idArticle) {
    this.idArticle = idArticle;
  }
  public String getIdArticle() {
    return idArticle;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setRemise(double remise) {
    this.remise = remise;
  }
  public double getRemise() {
    return remise;
  }
  public void setDateDevis(java.sql.Date dateDevis) {
    this.dateDevis = dateDevis;
  }
  public java.sql.Date getDateDevis() {
    return dateDevis;
  }
  public void setIdClient(String idClient) {
    this.idClient = idClient;
  }
  public String getIdClient() {
    return idClient;
  }
  public void setIdMarge(String idMarge) {
    this.idMarge = idMarge;
  }
  public String getIdMarge() {
    return idMarge;
  }
  public void setIdGestion(String idGestion) {
    this.idGestion = idGestion;
  }
  public String getIdGestion() {
    return idGestion;
  }
  public void setIdTirage(String idTirage) {
    this.idTirage = idTirage;
  }
  public String getIdTirage() {
    return idTirage;
  }
  public void setMargeBenefice(double margeBenefice) {
    this.margeBenefice = margeBenefice;
  }
  public double getMargeBenefice() {
    return margeBenefice;
  }
  public void setNbExemplaireA3(double nbExemplaireA3) {
    this.nbExemplaireA3 = nbExemplaireA3;
  }
  public double getNbExemplaireA3() {
    return nbExemplaireA3;
  }
  public void setStatut(int statut) {
    this.statut = statut;
  }
  public int getStatut() {
    return statut;
  }
  public void setNombre(double nombre) {
    this.nombre = nombre;
  }
  public double getNombre() {
    return nombre;
  }

}
