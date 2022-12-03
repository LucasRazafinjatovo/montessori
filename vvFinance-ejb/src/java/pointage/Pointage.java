package pointage;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Pointage extends ClassMAPTable {

  public String idPointage;
  public String idUser;
  public String heure;
  public String idType;
  public String remarque;
  public String ip;
  public java.sql.Date daty;
  public String agence;
  public String machine;
  public Pointage() {
    this.setNomTable("Pointage");
  }
  public Pointage(String idPointag, String idUse, java.sql.Date dat, String heur, String idTyp, String rem, String i ,String agenc,String machin) {
    this.setNomTable("Pointage");
    this.setIdPointage(idPointag);
    this.setIdUser(idUse);
    this.setDaty(dat);
    this.setHeure(heur);
    this.setIdType(idTyp);
    this.setRemarque(rem);
    this.setIp(i);
    this.setAgence(agenc);
    this.setMachine(machin);
  }
  public Pointage(String idUse, String dat, String heur, String idTyp, String rem, String i,String  agence,String machin) {
    this.setNomTable("Pointage");
    setNomProcedureSequence("getSeqPointage");
    this.setIdPointage(makePK());
    this.setIdUser(idUse);
    this.setDaty(utilitaire.Utilitaire.dateDuJourSql());
    this.setHeure(utilitaire.Utilitaire.heureCourante());
    this.setIdType(idTyp);
    this.setRemarque(rem);
    this.setIp(i);
    this.setAgence(agence);
  }
  public Pointage(String idUse, String idTyp, String rem, String i ,String  agence,String machin) {
    this.setNomTable("Pointage");
        setIndicePk("PO");
    setNomProcedureSequence("getSeqPointage");
    this.setIdPointage(makePK());
    this.setIdUser(idUse);
    this.setDaty(utilitaire.Utilitaire.dateDuJourSql());
    this.setHeure(utilitaire.Utilitaire.heureCouranteHMS());
        if(rem.compareTo("") == 0 || rem == null)
            this.setRemarque("-");
        else    this.setRemarque(rem);
        this.setIdType(idTyp);
    this.setAgence(agence);
    this.setMachine(machin);
    this.setIp(i);
  }
  public String getAttributIDName() {
    return ("idPointage");
  }
  public String getTuppleID() {
    return idPointage;
  }
  public void setIdPointage(String idPointage) {
    this.idPointage = idPointage;
  }
  public String getIdPointage() {
    return idPointage;
  }
  public void setIdUser(String idUser) {
    this.idUser = idUser;
  }
  public String getIdUser() {
    return idUser;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setHeure(String heure) {
    this.heure = heure;
  }
  public String getHeure() {
    return heure;
  }
  public void setIdType(String idType) {
    this.idType = idType;
  }
  public String getIdType() {
    return idType;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setIp(String ip) {
    this.ip = ip;
  }
  public String getIp() {
    return ip;
  }
  public void setAgence(String agence) {
    this.agence = agence;
  }
  public String getAgence() {
    return agence;
  }
  public void setMachine(String machine) {
    this.machine = machine;
  }
  public String getMachine() {
    return machine;
  }
}