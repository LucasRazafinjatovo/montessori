package facturefournisseur;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import javax.naming.*;
public class RecupLocalGFF {

  public static  GestionFactureFournisseurLocalHome recupHome() {
    GestionFactureFournisseurLocalHome gfflocalhome;
       try
       {
           Context ctx = new InitialContext();
           Object objRef = ctx.lookup("GestionFactureFournisseurLocal");
            GestionFactureFournisseurLocalHome pcLHome = (GestionFactureFournisseurLocalHome)objRef;
            GestionFactureFournisseurLocalHome gfflocalhome1 = pcLHome;
           return gfflocalhome1;
       }
       catch(NamingException ex)
       {
           gfflocalhome = null;
           ex.printStackTrace();
       }
       return gfflocalhome;
    }

  }