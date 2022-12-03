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
public class FactureFournisseurUtil extends GenUtil{

  public FactureFournisseurUtil() {
     super("FactureFournisseur","facturefournisseur.FactureFournisseur");
     //super.setNomClasse("facturefournisseur.FactureFournisseur");
  }
  public FactureFournisseurUtil(String nT) {
     super(nT,"facturefournisseur.FactureFournisseur");
     //super.setNomClasse("facturefournisseur.FactureFournisseur");
  }
/*
  public Object[] resultatGen(ResultSet rs){
    try
       {
           try
           {
               int i = 0;
               int k = 0;
               FactureFournisseur temp = null;
               Vector vect = new Vector();
               while(rs.next()){
                 // public FactureFournisseur(String idFF,String numFact,                                        String designation,java.sql.Date dE,                                     String idFrns,int idTVA,double mTTC,String rmq, String idDevise)
               temp = new FactureFournisseur(rs.getString("IDFACTUREFOURNISSEUR"),rs.getString("NUMFACT"),rs.getString("DESIGNATION"),rs.getDate("DATEEMISSION"), rs.getDate("DATY"), rs.getString("IDFOURNISSEUR"), rs.getInt("IDTVA"), rs.getDouble("MONTANTTTC"), rs.getString("REMARQUE"), rs.getString("IDDEVISE"));
// temp = new FactureFournisseur(rs.getString("DESIGNATION"),rs.getDate("DATEEMISSION"), rs.getDate(3), rs.getString(4), rs.getDouble(5), rs.getInt(6), rs.getDouble(7), rs.getString(8), rs.getString(9),rs.getString(10),rs.getString(11));
                   vect.add(i, temp);
                   i++;
               }
               FactureFournisseur retour[] = new FactureFournisseur[i];
               for(; k < i; k++)
                   retour[k] = (FactureFournisseur)vect.elementAt(k);

               FactureFournisseur aentree[] = retour;
               return aentree;
           }
           catch(Exception s)
           {
               System.out.println("Facture Fournisseur  ".concat(String.valueOf(String.valueOf(s.getMessage()))));
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
  }*/
  public Object[] resultatLimit (int numBloc,ResultSet rs){
    throw new UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}