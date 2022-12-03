package commercial;
import bean.ClassMAPTable;
import java.sql.Date;
import java.sql.Connection;
public class SituationSociete extends ClassMAPTable {

  private String id;
  private Date daty;
  private String societe;
  private Date daterdv;
  private String etat;
  private String observation;

  public SituationSociete(){
    this.setNomTable("SITUATIONSOCIETE");
  }

  public void construirePK(Connection c) throws Exception
  {
      super.setNomTable("SITUATIONSOCIETE");
      this.preparePk("SCTE","getSeqSituationSociete");
      this.setId(makePK(c));
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

  public String getObservation() {
    return observation;
  }

  public void setId(String id) {
    this.id = id;
  }


  public void setObservation(String observation) {
    this.observation = observation;
  }
  public Date getDaterdv() {
    return daterdv;
  }
  public Date getDaty() {
    return daty;
  }
  public String getEtat() {
    return etat;
  }
  public String getSociete() {
    return societe;
  }
  public void setSociete(String societe) {
    this.societe = societe;
  }
  public void setEtat(String etat) {
    this.etat = etat;
  }
  public void setDaty(Date daty) {
    this.daty = daty;
  }
  public void setDaterdv(Date daterdv) {
    this.daterdv = daterdv;
  }



}
