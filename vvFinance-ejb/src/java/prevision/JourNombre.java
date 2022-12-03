package prevision;

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

public class JourNombre extends ClassMAPTable{

  private String jour;
  public JourNombre() {
     super.setNomTable("JourNombre");
  }
  public String getTuppleID(){
    return jour;
  }
  public String getAttributIDName(){
    return "jour";
  }
  public void setJour(String jour) {
    this.jour = jour;
  }
  public String getJour() {
    return jour;
  }
}