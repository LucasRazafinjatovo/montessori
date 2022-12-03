package pub;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Remise extends ClassMAPTable {

  public Remise() {
    super.setNomTable("remise");
  }
  public Remise(String idPub,String remise) throws Exception{
    super.setNomTable("remise");
    this.preparePk("REM","getSeqRemise");
    this.setId(makePK());
    setIdPub(idPub);
    setRemis(utilitaire.Utilitaire.stringToDouble(remise));
  }
  String id;
  private String idPub;
  private double remis;
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setIdPub(String idPub) {
    this.idPub = idPub;
  }
  public String getIdPub() {
    return idPub;
  }
  public void setRemis(double remis)throws Exception {
    if(remis<=0||remis>99) throw new Exception("Remise invalide");
    this.remis = remis;
  }
  public double getRemis() {
    return remis;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
}