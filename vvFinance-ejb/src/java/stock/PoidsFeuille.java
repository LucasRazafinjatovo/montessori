/***********************************************************************
 * Module:  POIDSFEUILLE.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class POIDSFEUILLE
 ***********************************************************************/

package stock;

import java.sql.*;
import bean.ClassMAPTable;

public class PoidsFeuille extends ClassMAPTable
{
   public double poidsfeuille;
   public PoidsFeuille(){

   }
   public PoidsFeuille(double poids){
     super.setNomTable("PoidsFeuille");
     setPoidsfeuille(poids);
   }
   public PoidsFeuille(String poids){
    super.setNomTable("PoidsFeuille");
    setPoidsfeuille(utilitaire.Utilitaire.stringToDouble(poids));
   }
  public double getPoidsfeuille() {
    return poidsfeuille;
  }
  public void setPoidsfeuille(double poidsfeuille) {
    this.poidsfeuille = poidsfeuille;

  }
  public String getTuppleID()
{
    return String.valueOf(poidsfeuille);
}

public String getAttributIDName()
{
return "poidsfeuille";
   }

}

