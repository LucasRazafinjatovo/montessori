package pointage;

import bean.*;


public class TacheVue extends ClassMAPTable {

  private String id;
  private java.sql.Date daty;
  private java.sql.Date datefin;
  private String direction;
  private String entite;
  private String designation;
  private int urgence;
  private String donneur;
  private String resp;
  private String dernmessage;
  private String poste;
  public TacheVue() {
    this.setNomTable("Tache");
  }
  public TacheVue(String datyF,String donneu,String directio,String entit,String desi,String urg,String resp) throws Exception
  {
    this.setNomTable("Tache");
    this.setId(makePK("TAC","getseqTache"));
    this.setDonneur(donneu);
    this.setDirection(directio);
    this.setEntite(entit);
    this.setDesignation(desi);
    this.setUrgence(urg);
    this.setResp(resp);
    this.setDateFin(datyF);
    this.setDate("");
  }
  public void setDateFin(String datyF) throws Exception
  {
    datefin=utilitaire.Utilitaire.string_date("dd/MM/yyyy",datyF);
  }
  public void setDateFin(String datyF,String heure) throws Exception
  {
    datefin=utilitaire.Utilitaire.string_date("dd/MM/yyyy hh:mm",datyF+" "+heure);
  }
  public void setDate(String datye) throws Exception
  {
    if((datye==null)||(datye.compareTo("")==0))
      daty=utilitaire.Utilitaire.dateDuJourSql();
    else
      daty=utilitaire.Utilitaire.string_date("dd/MM/yyyy",datye);
  }

  public void setUrgence(String urg) throws Exception
  {
    int temp=1;
    if((urg!=null)&&(urg.compareToIgnoreCase("")!=0))
      temp=utilitaire.Utilitaire.stringToInt(urg);
    urgence=temp;//Rehefa tsy manao exception izy vao manao affectation
  }

  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
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
  public void setDatefin(java.sql.Date datefin) {
    this.datefin = datefin;
  }
  public java.sql.Date getDatefin() {
    return datefin;
  }
  public void setDonneur(String donneur) {
    this.donneur = donneur;
  }
  public String getDonneur() {
    return donneur;
  }
  public void setDirection(String direction) {
    this.direction = direction;
  }
  public String getDirection() {
    return direction;
  }
  public void setResp(String resp) {
    this.resp = resp;
  }
  public String getResp() {
    return resp;
  }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public String getEntite() {
    return entite;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setUrgence(int urgence) {
    this.urgence = urgence;
  }
  public int getUrgence() {
    return urgence;
  }
  public void setDernmessage(String dernmessage) {
    this.dernmessage = dernmessage;
  }
  public String getDernmessage() {
    return dernmessage;
  }
  public void setPoste(String poste) {
    this.poste = poste;
  }
  public String getPoste() {
    return poste;
  }
}