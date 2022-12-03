package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class VisaDevis extends ClassMAPTable{
  private String idVisa;
  private String idDevis;
  private String login;
  private String remarque;
  private java.sql.Date dateVisa;

  public VisaDevis(){
    super.setNomTable("visadevis");
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("visadevis");
     this.preparePk("VISA","getSeqVisaDevis");
     this.setIdVisa(makePK(c));
  }

  public VisaDevis(String idd){
    super.setNomTable("visadevis");
    this.setIdDevis(idd);
    setIndicePk("VISA");
    setNomProcedureSequence("getSeqVisaDevis");
    setIdVisa(makePK());
  }

  public String getAttributIDName() {
    return "idvisa";
  }

  public String getTuppleID() {
    return idVisa;
  }

  public String getIdVisa() {
    return idVisa;
  }
  public void setIdVisa(String idVisa) {
    this.idVisa = idVisa;
  }
  public void setIdDevis(String idDevis) {
    this.idDevis = idDevis;
  }
  public String getIdDevis() {
    return idDevis;
  }
  public void setLogin(String login) {
    this.login = login;
  }
  public String getLogin() {
    return login;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDateVisa(java.sql.Date dateVisa) {
    this.dateVisa = dateVisa;
  }
  public java.sql.Date getDateVisa() {
    return dateVisa;
  }

}
