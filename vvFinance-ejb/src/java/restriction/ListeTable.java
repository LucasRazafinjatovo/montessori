package restriction;
import bean.*;
import java.util.*;
import java.sql.Connection;
import java.sql.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ListeTable extends ClassMAPTable{

  private String id;
  private String nom;
  private String remarque;
  public ListeTable() {
    super.setNomTable("listetable");
  }
  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("listetable");
     this.preparePk("LT","getSeqListeTable");
     this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public String getNom() {
    return nom;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
}