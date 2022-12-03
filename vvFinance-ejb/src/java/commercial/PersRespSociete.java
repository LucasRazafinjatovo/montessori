package commercial;
import bean.ClassMAPTable;
import java.sql.Date;
import java.sql.Connection;
public class PersRespSociete extends ClassMAPTable {

  private String id;
  private String nom;
  private String societe;
  private Date dateapplication;
  private String contact;
  private String observation;

  public PersRespSociete(){
    this.setNomTable("PERSRESPSOCIETE");
  }
  public void construirePK(Connection c) throws Exception
  {
      super.setNomTable("PERSRESPSOCIETE");
      this.preparePk("RSE","getSeqPersRespSociete");
      this.setId(makePK(c));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public String getContact() {
    return contact;
  }
  public Date getDateapplication() {
    return dateapplication;
  }
  public String getId() {
    return id;
  }
  public String getNom() {
    return nom;
  }
  public String getObservation() {
    return observation;
  }
  public String getSociete() {
    return societe;
  }
  public void setSociete(String societe) {
    this.societe = societe;
  }
  public void setObservation(String observation) {
    this.observation = observation;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDateapplication(Date dateapplication) {
    this.dateapplication = dateapplication;
  }
  public void setContact(String contact) {
    this.contact = contact;
  }

}
