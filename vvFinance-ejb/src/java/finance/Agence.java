package finance;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.ClassMAPTable;
public class Agence extends ClassMAPTable{

  private String id;
  private String val;
  private String desce;
  public Agence() {
    super.setNomTable("agence");
  }
  public String getTuppleID()
    {
        return String.valueOf(id);
    }

    public String getAttributIDName()
    {
        return "id";
    }

  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
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