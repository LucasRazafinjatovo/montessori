package facture;

import bean.*;


/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Change extends ClassMAPTable {

  public String idChange;
  public java.sql.Date datydebutvalid;
  public String idDevise;
  public double valeurEnAriary;
  public Change( String idChange, String idDevise, double valeurEnAriary,java.sql.Date daty) {
    this.setIdChange(idChange);
    this.setIdDevise(idDevise);
    this.setValeurEnAriary(valeurEnAriary);
    this.setDatydebutvalid(daty);
    super.setNomTable("Change");
  }
  public Change(String idDevise, double valeurEnAriary,java.sql.Date daty) {
    super.setNomTable("Change");
    this.setIndicePk("chg");
    this.setNomProcedureSequence("getSeqChange");
    this.setIdChange(makePK());
    this.setIdDevise(idDevise);
    this.setValeurEnAriary(valeurEnAriary);
    this.setDatydebutvalid(daty);
  }
  public String getAttributIDName() {
    return "idChange";
  }
  public String getTuppleID() {
    return this.getIdChange();
  }
  public void setIdChange(String idChange) {
    this.idChange = idChange;
  }
  public String getIdChange() {
    return idChange;
  }
  public void setValeurEnAriary(double valeurEnAriary) {
    if (valeurEnAriary>0 ||String.valueOf(valeurEnAriary).compareTo("")>0)
    this.valeurEnAriary = valeurEnAriary;
  }
  public double getValeurEnAriary() {
    return valeurEnAriary;
  }
  public void setIdDevise(String idDevise) {
    this.idDevise = idDevise;
  }
  public String getIdDevise() {
    return idDevise;
  }
  public void setDatydebutvalid(java.sql.Date datydebutvalid) {
    if (String.valueOf(datydebutvalid).compareTo("")==0 || datydebutvalid==null){
      this.datydebutvalid=utilitaire.Utilitaire.dateDuJourSql();
    }
    else this.datydebutvalid = datydebutvalid;
  }
  public java.sql.Date getDatydebutvalid() {
    return datydebutvalid;
  }
}