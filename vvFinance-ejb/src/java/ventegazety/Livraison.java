package ventegazety;

import bean.*;
import java.sql.Date;
import java.sql.Connection;

public class Livraison extends ClassMAPTable{

  private String id;
  private String idcoursier;
  private Date datelivraison;
  private String idabonnement;

  public Livraison(){
    this.setNomTable("livraison");
  }

  public void construirePK(Connection c) throws Exception
  {
    super.setNomTable("livraison");
    this.preparePk("LVA","GETSEQLIVRAISON");
    this.setId(makePK(c));
  }
  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public Date getDatelivraison() {
    return datelivraison;
  }
  public String getId() {
    return id;
  }
  public String getIdcoursier() {
    return idcoursier;
  }
  public void setIdcoursier(String idcoursier) {
    this.idcoursier = idcoursier;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDatelivraison(Date datelivraison) {
    this.datelivraison = datelivraison;
  }
  public void setIdabonnement(String idabonnement) {
    this.idabonnement = idabonnement;
  }
  public String getIdabonnement() {
    return idabonnement;
  }

}

