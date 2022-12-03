package etudiant;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtudiantInactif extends ClassMAPTable{

  private String id;
  private String etudiant;
  private java.sql.Date daty;
  public EtudiantInactif() {
    super.setNomTable("EtudiantInactif");
  }
  public EtudiantInactif(String etudiant) {
    super.setNomTable("EtudiantInactif");
    this.setIndicePk("EI");
    this.setNomProcedureSequence("GETSEQETUDIANTINACTIF");
    this.setId(this.makePK());
    this.setEtudiant(etudiant);
    this.setDaty(Utilitaire.stringDate(Utilitaire.dateDuJour()));
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("EtudiantInactif");
    this.preparePk("EI","GETSEQETUDIANTINACTIF");
    this.setId(makePK(c));
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setEtudiant(String etudiant) {
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
}