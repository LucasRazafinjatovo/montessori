package facturefournisseur;

import bean.*;
import java.sql.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ConstantesFF extends GenUtil {

  private static bean.CaractTable[] objetFactureProfFourn={new CaractTable()};
  public ConstantesFF() {
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
  public static void setObjetFactureProfFourn(bean.CaractTable[] objetFactureProfFour) {
    objetFactureProfFourn = objetFactureProfFour;
  }
  public static bean.CaractTable[] getObjetFactureProfFourn() {
    return objetFactureProfFourn;
  }
}