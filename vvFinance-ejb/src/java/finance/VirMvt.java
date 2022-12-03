package finance;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class VirMvt extends ClassMAPTable {

  private String id;
  private String idVir;
  private String idMvtDep;
  private String idMvtRec;
  private String remarque;
  public VirMvt() {
    this.setNomTable("VirMvt");
  }
  public VirMvt(String idVir,String idMvtDep,String idMvtRec,String rem) {
    this.setNomTable("VirMvt");
    this.setNomProcedureSequence("getseqVirMvt");
    this.setIndicePk("VMV");
    this.setId(makePK());
    this.setIdVir(idVir);
    this.setIdMvtDep(idMvtDep);
    this.setIdMvtRec(idMvtRec);
    this.setRemarque(rem);
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
  public void setIdVir(String idVir) {
    this.idVir = idVir;
  }
  public String getIdVir() {
    return idVir;
  }
  public void setIdMvtDep(String idMvtDep) {
    this.idMvtDep = idMvtDep;
  }
  public String getIdMvtDep() {
    return idMvtDep;
  }
  public void setIdMvtRec(String idMvtRec) {
    this.idMvtRec = idMvtRec;
  }
  public String getIdMvtRec() {
    return idMvtRec;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
}