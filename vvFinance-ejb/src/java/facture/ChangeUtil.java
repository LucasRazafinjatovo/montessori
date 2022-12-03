package facture;

import bean.*;
import java.sql.*;
import java.util.Vector;


/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ChangeUtil extends GenUtil {

  public ChangeUtil() {
    super.setNomTable("CHANGE");
  }
  public Change loadChangeValide(String devise,String datyInf) throws Exception{
    try {
      int a[]={2};
      String[] val=new String [a.length];
      val[0]=devise;//," and datyDebutValid<='"+daty1+"' order by datyDebutValid desc"
      return (Change) rechercher(a,val," and datyDebutValid<='"+datyInf+"' order by datyDebutValid desc")[0];
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public Object[] resultatGen (ResultSet rs)
  {
	  try
	  {
		  int i = 0, k = 0;
		  Change temp = null;
		  Vector vect = new Vector();
		  while(rs.next())
		  {
		    //String idChange, String idDevise, float valeurEnAriary,java.sql.Date daty
			  temp = new Change (rs.getString(1),rs.getString(2),rs.getDouble(3),rs.getDate(4));
			  vect.add(i,temp);
			  i++;
		  }

		  Change []retour = new Change[i];

		  while (k < i)
		  {
			  retour[k] = (Change)(vect.elementAt(k));
			  k++;
		  }
		  return retour;
	  }
	  catch (Exception s)
	  {
		  System.out.println("Recherche Change "+s.getMessage());
		  return null;
	  }
	  finally
	  {
	    try
	    {
		  if (rs!=null) rs.close();
	    }
	    catch(SQLException e)
	    {
	      System.out.println("Erreur Fermeture SQL Change "+ e.getMessage());
	    }
	  }
  }

}