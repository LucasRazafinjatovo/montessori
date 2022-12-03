package commercial;
import bean.ClassMAPTable;
import java.sql.Date;
import java.sql.Connection;
public class CommRespSociete extends ClassMAPTable {

  private String id;
  private String idcommercial;
  private String idsociete;
  private Date dateapplication;
  private String observation;

  public CommRespSociete(){
    this.setNomTable("RESPONSABLESOCIETE");
  }

  public void construirePK(Connection c) throws Exception
  {
      super.setNomTable("RESPONSABLESOCIETE");
      this.preparePk("CRS","getSeqCommRespSociete");
      this.setId(makePK(c));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }

  public Date getDateapplication() {
    return dateapplication;
  }
  public String getId() {
    return id;
  }
  public String getIdcommercial() {
    return idcommercial;
  }
  public String getIdsociete() {
    return idsociete;
  }
  public String getObservation() {
    return observation;
  }
  public void setDateapplication(Date dateapplication) {
    this.dateapplication = dateapplication;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdcommercial(String idcommercial) {
    this.idcommercial = idcommercial;
  }
  public void setIdsociete(String idsociete) {
    this.idsociete = idsociete;
  }
  public void setObservation(String observation) {
    this.observation = observation;
  }



}
