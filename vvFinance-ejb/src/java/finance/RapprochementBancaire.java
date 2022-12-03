package finance;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class RapprochementBancaire extends ClassMAPTable
{
  private String id;
  private String designation;
  private String idrib;
  private Date dateoperation;
  private String idmouvement;

  public RapprochementBancaire()
  {
    super.setNomTable("Rapprochement");
  }

  public RapprochementBancaire(String desce, String modepaye, String mvt) {
    super.setNomTable("Rapprochement");

    setDesignation(desce);
    setIdrib(modepaye);
    setIdmouvement(mvt);
    setDateoperation(Utilitaire.dateDuJourSql());
    setNomProcedureSequence("getSeqrapprochement");
    setIndicePk("RPC");
    setId(makePK());
  }
  public void construirePK(Connection c) throws Exception {
    super.setNomTable("Rapprochement");
    preparePk("RPC", "getSeqrapprochement");
    setId(makePK(c));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return this.id;
  }

  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return this.designation;
  }

  public void setIdrib(String modepayement) {
    this.idrib = modepayement;
  }
  public String getIdrib() {
    return this.idrib;
  }

  public void setId(String id)
  {
    this.id = id;
  }
  public String getId() {
    return this.id;
  }
  public Date getDateoperation() {
    return this.dateoperation;
  }
  public void setDateoperation(Date dateoperation) {
    this.dateoperation = dateoperation;
  }
  public String getIdmouvement() {
    return this.idmouvement;
  }
  public void setIdmouvement(String idmouvement) {
    this.idmouvement = idmouvement;
  }
}