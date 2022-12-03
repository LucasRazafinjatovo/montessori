package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import prevision.PrevisionEtat;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PrevisionService{

  public PrevisionService() {
  }
  public static double calculerSoldePrevision(double soldeInit, PrevisionEtat[] etatPrev) throws Exception{
    try{
      double sld = (etatPrev[0].getCredit() - etatPrev[0].getDebit()) + soldeInit;
      etatPrev[0].setSolde(sld);
      for(int i = 1; i < etatPrev.length; i++){
        etatPrev[i].setSolde((etatPrev[i].getCredit() - etatPrev[i].getDebit()) + etatPrev[i - 1].getSolde());
      }

      return etatPrev[etatPrev.length - 1].getSolde();
    }catch(Exception ex){
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
}