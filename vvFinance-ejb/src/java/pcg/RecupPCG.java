package pcg;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import javax.naming.*;
public class RecupPCG {

  public static GestionPlanComptableLocalHome recupHome() {
    GestionPlanComptableLocalHome gfflocalhome;
    try
      {
          Context ctx = new InitialContext();
          Object objRef = ctx.lookup("GestionPlanComptableLocal");
           GestionPlanComptableLocalHome pcLHome = (GestionPlanComptableLocalHome)objRef;
           GestionPlanComptableLocalHome gfflocalhome1 = pcLHome;
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

