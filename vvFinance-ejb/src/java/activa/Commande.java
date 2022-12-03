package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Commande extends ClassMAPTable{
  private String idcmd;
  private String iddevis;
  private String remarque;
  private java.sql.Date datecmd;
  private java.sql.Date dateLivraisonCmd;

  public Commande(){
    super.setNomTable("commande");
  }

  public void construirePK(Connection c) throws Exception{
     super.setNomTable("commande");
     this.preparePk("CMD","getSeqCommande");
     this.setIdcmd(makePK(c));
  }

  public Commande(String idd,String rmq,String d1,String d2) {
     super.setNomTable("commande");
     this.setIddevis(idd);
     setRemarque(rmq);
     setDatecmd(java.sql.Date.valueOf(d1));
     setDateLivraisonCmd(java.sql.Date.valueOf(d2));
     setIndicePk("CMD");
     setNomProcedureSequence("getSeqCommande");
     setIdcmd(makePK());
  }

  public String getAttributIDName() {
   return "idcmd";
 }

 public String getTuppleID() {
   return idcmd;
  }
  public String getIdcmd() {
    return idcmd;
  }
  public void setIdcmd(String idcmd) {
    this.idcmd = idcmd;
  }
  public void setIddevis(String iddevis) {
    this.iddevis = iddevis;
  }
  public String getIddevis() {
    return iddevis;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDatecmd(java.sql.Date datecmd) {
    this.datecmd = datecmd;
  }
  public java.sql.Date getDatecmd() {
    return datecmd;
  }
  public void setDateLivraisonCmd(java.sql.Date dateLivraisonCmd) {
    this.dateLivraisonCmd = dateLivraisonCmd;
  }
  public java.sql.Date getDateLivraisonCmd() {
    return dateLivraisonCmd;
  }

}
