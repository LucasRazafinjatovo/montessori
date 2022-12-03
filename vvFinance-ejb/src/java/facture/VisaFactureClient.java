package facture;
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

public class VisaFactureClient extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private String remarque;
  private String idobjet;
  public VisaFactureClient() {
    super.setNomTable("visafactureclient");
  }
  public String getTuppleID()
    {
        return id ;
    }

    public String getAttributIDName()
    {
        return "id";
    }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setIdobjet(String idobjet) {
    this.idobjet = idobjet;
  }
  public String getIdobjet() {
    return idobjet;
  }
}