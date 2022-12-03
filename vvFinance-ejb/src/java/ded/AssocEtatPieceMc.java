package ded;
import bean.*;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AssocEtatPieceMc extends ClassMAPTable {

  private String id;
  private String idop;
  private String etatpiece;
  public AssocEtatPieceMc() {
    this.setNomTable("AssocEtatPieceMc");
  }
  public AssocEtatPieceMc(String idop,String eta)throws Exception  {
    this.setNomTable("AssocEtatPieceMc");
    this.preparePk("AEP","getSeqAssocEtatPieceMc");
    this.setId(makePK());
    this.setIdop(idop);
    this.setEtatpiece(eta);
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
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdop() {
    return idop;
  }
  public void setEtatpiece(String eta) {
    this.etatpiece = eta;
  }
  public String getEtatpiece() {
    return etatpiece;
  }
}