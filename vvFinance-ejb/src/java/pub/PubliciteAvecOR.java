package pub;
import java.sql.Date;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.*;
import java.sql.Connection;
import java.sql.Date;
public class PubliciteAvecOR extends ClassMAPTable{

  private String id;
  private String id1;
  private String id2;
  private String remarque;
  private Date datyoperation;
  public PubliciteAvecOR() {
    super.setNomTable("publiciteavecor");
  }
  public PubliciteAvecOR(String idinv,String idfact, String rem,Date daty) throws Exception{
   super.setNomTable("publiciteavecor");
   this.preparePk("POR","getSeqpubOR");
   this.setId(makePK());
   this.setId1(idinv);
   this.setId2(idfact);
   this.setRemarque(rem);
   this.setDatyoperation(daty);
  }
  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setId1(String id1) {
    this.id1 = id1;
  }
  public String getId1() {
    return id1;
  }
  public void setId2(String id2) {
    this.id2 = id2;
  }
  public String getId2() {
    return id2;
  }

  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public Date getDatyoperation() {
    return datyoperation;
  }
  public void setDatyoperation(Date datyoperation) {
    this.datyoperation = datyoperation;
  }

}