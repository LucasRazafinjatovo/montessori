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

public class Restriction extends ClassMAPTable{

  private String id;
  private String profil;
  private String tableRestrict;
  private String action;
  private String remarque;
  private String login;
  public Restriction() {
    super.setNomTable("restriction");
  }
  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("restriction");
     this.preparePk("REST","getSeqRestriction");
     this.setId(makePK(c));
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setProfil(String profil) {
    this.profil = profil;
  }
  public String getProfil() {
    return profil;
  }
  public void setTableRestrict(String tableRestrict) {
    this.tableRestrict = tableRestrict;
  }
  public String getTableRestrict() {
    return tableRestrict;
  }
  public void setAction(String action) {
    this.action = action;
  }
  public String getAction() {
    return action;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
    /*Fonction qui permet de lister tous les tables qui ont une Restriction : */
  public static String[] getAllTableRestrict(Connection c,String action)
  {
    try
    {
      Vector v=new Vector();
      java.sql.Statement st=c.createStatement();
      String sql="select tableRestrict  from restriction where action='"+action+"' group by tableRestrict";
      //System.out.println(sql);
      java.sql.ResultSet rset=st.executeQuery(sql);
      while(rset.next()!=false)
      {
        v.addElement(rset.getString("tableRestrict"));
      }
      String[]ret=new String[v.size()];
      v.copyInto(ret);
      return ret;
    }
    catch(SQLException ex)
    {
      System.out.println("Erreur sql de la classe Restriction : "+ex.getMessage());
      ex.printStackTrace();
      return null;
    }
  }
  public String[]getAllProfil(String table,Connection c,String action)
  {
    try
    {
      Vector v=new Vector();
      java.sql.Statement st=c.createStatement();
      String sql="select profil  from restriction where tableRestrict = '"+table+"' and action='"+action+"'";

      java.sql.ResultSet rset=st.executeQuery(sql);
      while(rset.next()!=false)
      {
        v.addElement(rset.getString("profil"));
      }
      String[]ret=new String[v.size()];
      v.copyInto(ret);
      return ret;
    }
    catch(SQLException ex)
    {
      System.out.println("Erreur sql de la classe Restriction : "+ex.getMessage());
      ex.printStackTrace();
      return null;
    }
  }
  public void setLogin(String login) {
    this.login = login;
  }
  public String getLogin() {
    return login;
  }
}