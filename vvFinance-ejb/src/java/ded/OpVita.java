package ded;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class OpVita extends OrdonnerPayement{

  private String idor;
  public OpVita() {
    super.setNomTable("opvita");
  }
  public OpVita(String ded,String ligne,String dt,String mont,String rem,String eta,String idor) throws Exception {
    super(ded,ligne,dt,mont,rem,eta);
    this.setIdor(idor);
    super.setNomTable("OpVita");
    this.preparePk("OPV","getSeqOpVita");
    this.setId(makePK());
  }
  public OpVita(String ded,String ligne,String dt,String mont,String rem,String eta,String idor,String id) throws Exception{
    super(ded,ligne,dt,mont,rem,eta);
    this.setIdor(idor);
    super.setNomTable("OrVita");
    this.preparePk("ORV","getSeqOrVita");
    this.setId(makePK());
  }
  public OpVita(String id,String ded,java.sql.Date dt,double mont,String rem,String idor) throws Exception{
   super(id,ded,dt,mont,rem);
   this.setIdor(idor);
   super.setNomTable("OrVita");
  }
  public String getIdor() {
    return idor;
  }
  public void setIdor(String idor) {
    this.idor = idor;
  }
}