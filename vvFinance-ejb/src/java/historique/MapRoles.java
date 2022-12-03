package historique;
import java.sql.*;
import java.util.*;

public class MapRoles extends bean.ClassMAPTable implements java.io.Serializable{


  public String descRole;
  public String idRole;

  /**
   * Constructeur par défaut
   */
  public MapRoles(){
   // this.setIdRole("admin");
    //this.setDescRole(null);
  }


  public MapRoles(String id, String des){
//    this.setIdRole(id);
    if (id.compareTo("")==0 || id==null) {
      this.setIdRole("-");
    }
    else this.setIdRole(id);

//    this.setDescRole(des);
    if (des.compareTo("")==0 || des==null) {
      this.setDescRole("-");
    }
    else this.setDescRole(des);

    super.setNomTable("roles");
  }
  public String getAttributIDName()
  {
    return "idRole";
  }

  public String getTuppleID()
  {
    return String.valueOf(idRole);
  }
  public String getDescRole()
  {
    return descRole;
  }
  public void setDescRole(String descRole)
  {
    this.descRole = descRole;
  }
  public void setIdRole(String idRole) {
    this.idRole = idRole;
  }
  public String getIdRole() {
    return idRole;
  }
}