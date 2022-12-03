package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PrevisionOr  extends ClassMAPTable{

  private String id;
  private String idop;
  private String idprev;
  private Date datycreation;
  public PrevisionOr() {
    super.setNomTable("PREVISIONRECDEJAOP");
  }
  public PrevisionOr(String idor,String prev) throws Exception
 {
   super.setNomTable("PREVISIONRECDEJAOP");
   this.preparePk("POR","getSeqPrevisionOr");
   this.setId(makePK());
   this.setIdop(idor);
   this.setIdprev(prev);
   this.setDatycreation(Utilitaire.dateDuJourSql());
 }
  public void construirePK(Connection c) throws Exception{
 super.setNomTable("PREVISIONRECDEJAOP");
 this.preparePk("POR","getSeqPrevisionOr");
 this.setId(makePK(c));
  }

  public String getTuppleID(){
   return id;
 }
 public String getAttributIDName(){
   return "id";
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public Date getDatycreation() {
    return datycreation;
  }
  public void setDatycreation(Date datycreation) {
    this.datycreation = datycreation;
  }
  public String getIdop() {
    return idop;
  }
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdprev() {
    return idprev;
  }
  public void setIdprev(String idprev) {
    this.idprev = idprev;
  }
}