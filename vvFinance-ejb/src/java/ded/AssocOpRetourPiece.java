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

public class AssocOpRetourPiece extends ClassMAPTable {

  private String id;
  private String idop;
  private String referencepiece;
  private String remarque;
  private java.sql.Date daty;
  public AssocOpRetourPiece() {
    this.setNomTable("AssocOpRetourPiece");
  }
  public AssocOpRetourPiece(String idop,String referencepiece,java.sql.Date daty,String remarque)throws Exception  {
   this.setNomTable("AssocOpRetourPiece");
   this.preparePk("ARP","getSeqAssocOpRetourPiece");
   this.setId(makePK());
   this.setIdop(idop);
   this.setReferencepiece(referencepiece);
   this.setDaty(daty);
   this.setRemarque(remarque);
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
  public void setReferencepiece(String referencepiece) {
    this.referencepiece = referencepiece;
  }
  public String getReferencepiece() {
    return referencepiece;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}