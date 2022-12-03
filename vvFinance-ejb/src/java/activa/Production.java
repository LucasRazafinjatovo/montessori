package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Production extends ClassMAPTable{
  private String idProduction;
  private int debutCompteur;
  private int finCompteur;
  private String idcmd;
  private String remarque;
  private String idMaintenance;

  public Production(){
    super.setNomTable("production");
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("production");
     this.preparePk("PROD","getSeqProduction");
     this.setIdProduction(makePK(c));
  }

  public Production(String idd,String deb,String fin){
    super.setNomTable("production");
    this.setIdProduction(idd);
    setDebutCompteur(utilitaire.Utilitaire.stringToInt(deb));
    setFinCompteur(utilitaire.Utilitaire.stringToInt(fin));
    setIndicePk("PROD");
    setNomProcedureSequence("getSeqProduction");
    setIdProduction(makePK());
  }

  public String getAttributIDName() {
   return "idProduction";
  }
  public String getTuppleID() {
   return idProduction;
  }
  public String getIdProduction() {
    return idProduction;
  }
  public void setIdProduction(String idProduction) {
    this.idProduction = idProduction;
  }
  public void setDebutCompteur(int debutCompteur) {
    this.debutCompteur = debutCompteur;
  }
  public int getDebutCompteur() {
    return debutCompteur;
  }
  public void setFinCompteur(int finCompteur) {
    this.finCompteur = finCompteur;
  }
  public int getFinCompteur() {
    return finCompteur;
  }
  public void setIdcmd(String idcmd) {
    this.idcmd = idcmd;
  }
  public String getIdcmd() {
    return idcmd;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setIdMaintenance(String idMaintenance) {
    this.idMaintenance = idMaintenance;
  }
  public String getIdMaintenance() {
    return idMaintenance;
  }

}
