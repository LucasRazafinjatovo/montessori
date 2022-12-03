package ventegazety;
import bean.*;
import java.sql.Connection;

public class EtatVendeur extends ClassMAPTable{

  private String id;
  private String val;
  private String desce;
  public EtatVendeur() {
    this.setNomTable("EtatVendeur");
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
  public void setVal(String val) {
    this.val = val;
  }
  public String getVal() {
    return val;
  }
  public void setDesce(String desce) {
    this.desce = desce;
  }
  public String getDesce() {
    return desce;
  }
}