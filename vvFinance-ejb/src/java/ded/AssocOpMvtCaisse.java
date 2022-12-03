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

public class AssocOpMvtCaisse extends ClassMAPTable {

  private String id;
  private String idop;
  private String idmvt;
  private String beneficiaire;
  public AssocOpMvtCaisse() {
    this.setNomTable("AssocOpMvtCaisse");
  }
  public AssocOpMvtCaisse(String idop,String idmvt,String benef)throws Exception  {
   this.setNomTable("AssocOpMvtCaisse");
   this.preparePk("AMC","getSeqAssocOpMvtCaisse");
   this.setId(makePK());
   this.setIdop(idop);
   this.setIdmvt(idmvt);
   this.setBeneficiaire(benef);
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
  public void setIdmvt(String idmvt) {
    this.idmvt = idmvt;
  }
  public String getIdmvt() {
    return idmvt;
  }
  public void setBeneficiaire(String beneficiaire) {
    this.beneficiaire = beneficiaire;
  }
  public String getBeneficiaire() {
    return beneficiaire;
  }
}