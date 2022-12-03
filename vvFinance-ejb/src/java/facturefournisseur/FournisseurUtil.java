package facturefournisseur;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

import bean.GenUtil;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
public class FournisseurUtil extends GenUtil{

  public FournisseurUtil() {
     super("FFournisseur");
  }
  public Object[] resultatGen(ResultSet rs){
  try
     {
         try
         {
             int i = 0;
             int k = 0;
            Fournisseur temp = null;
             Vector vect = new Vector();
             while(rs.next()){

             temp = new Fournisseur(rs.getString("IDFOURNISSEUR"),rs.getString("NOMFOURNISSEUR"),rs.getString("NIFFOURNISSEUR"),rs.getString("STATFOURNISSEUR"),rs.getString("TELFOURNISSEUR"),rs.getString("EMAILFOURNISSEUR"),rs.getString("ADRESSEFOURNISSEUR"));

// temp = new FactureFournisseur(rs.getString("DESIGNATION"),rs.getDate("DATEEMISSION"), rs.getDate(3), rs.getString(4), rs.getDouble(5), rs.getInt(6), rs.getDouble(7), rs.getString(8), rs.getString(9),rs.getString(10),rs.getString(11));
                 vect.add(i, temp);
                 i++;
             }
             Fournisseur retour[] = new Fournisseur[i];
             for(; k < i; k++)
                 retour[k] = (Fournisseur)vect.elementAt(k);

            Fournisseur aentree[] = retour;
             return aentree;
         }
         catch(Exception s)
         {
             System.out.println(" Fournisseur  ".concat(String.valueOf(String.valueOf(s.getMessage()))));
             return null;
         }
     }
     finally
     {
         try
         {
             if(rs != null)
                 rs.close();
         }
         catch(SQLException e)
         {
             System.out.println("Erreur Fermeture SQL Entree ".concat(String.valueOf(String.valueOf(e.getMessage()))));
         }
      }
}
public Object[] resultatLimit (int numBloc,ResultSet rs){
  throw new UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}