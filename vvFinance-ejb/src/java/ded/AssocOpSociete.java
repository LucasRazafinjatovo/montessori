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

public class AssocOpSociete extends ClassMAPTable {

  private String id;
  private String idop;
  private String libsoc;
  public AssocOpSociete() {
    this.setNomTable("AssocOpSociete");
  }
  public AssocOpSociete(String idop,String libsoc)throws Exception  {
    this.setNomTable("AssocOpSociete");
    this.preparePk("AOS","getSeqAssocOpSociete");
    this.setId(makePK());
    this.setIdop(idop);
    this.setLibsoc(libsoc);
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
  public void setLibsoc(String libsoc) {
    this.libsoc = libsoc;
  }
  public String getLibsoc() {
    return libsoc;
  }
}