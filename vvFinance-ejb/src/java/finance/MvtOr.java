package finance;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import java.util.*;
import bean.ClassMAPTable;
public class MvtOr extends ClassMAPTable{

  private String id;
  private String idmvt;
  private String idor;
  public MvtOr() {
  }
  public MvtOr(String id,String idmvt,String idor) {
    super.setNomTable("mvtor");
    setIdmvt(idmvt);
    setId(id);
    setIdor(idor);
  }
  public String getTuppleID()
{
  return id;
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
  public void setIdmvt(String idmvt) {
    this.idmvt = idmvt;
  }
  public String getIdmvt() {
    return idmvt;
  }
  public void setIdor(String idor) {
    this.idor = idor;
  }
  public String getIdor() {
    return idor;
  }
}