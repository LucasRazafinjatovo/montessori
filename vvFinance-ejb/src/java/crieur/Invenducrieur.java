package crieur;

import bean.*;
import java.sql.Connection;


public class Invenducrieur extends ClassMAPTable{
  public Invenducrieur(){
    super.setNomTable("Invenducrieur");
  }
  public Invenducrieur(String dat, String nbrinv, String prise, String remarque) throws Exception
  {
    super.setNomTable("Invenducrieur");
    this.preparePk("INV","getSeqInvenducrieur");
    this.setId(makePK());
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setNombreinvendu(utilitaire.Utilitaire.stringToInt(nbrinv));
    setIdprise(prise);
    setRemarque(remarque);
  }
  public Invenducrieur(String dat, String nbrinv, String prise, String remarque, Connection c) throws Exception
  {
    super.setNomTable("Invenducrieur");
    this.preparePk("INV","getSeqInvenducrieur");
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setNombreinvendu(utilitaire.Utilitaire.stringToInt(nbrinv));
    setIdprise(prise);
    setRemarque(remarque);
    if(c==null){
      c=new utilitaire.UtilDB().GetConn();
    }
    this.setId(makePK(c));
  }
  public void construirePK(Connection c) throws Exception
  {
    super.setNomTable("Invenducrieur");
    this.preparePk("INV","getSeqInvenducrieur");
    this.setId(makePK(c));
  }

  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public int getNombreinvendu() {
    return nombreinvendu;
  }
  public void setNombreinvendu(int nombreinvendu) {
    this.nombreinvendu = nombreinvendu;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setIdprise(String idprise) {
    this.idprise = idprise;
  }
  public String getIdprise() {
    return idprise;
  }

  String id;
 private java.sql.Date daty;
 private int nombreinvendu;
  private String remarque;
  private String idprise;



}