package facturefournisseur;

import java.sql.ResultSet;
import bean.GenUtil;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class DetailUtil extends GenUtil {

  public DetailUtil() {
    super("detailBC","facturefournisseur.Detail");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
   /**@todo Implement this bean.GenUtil abstract method*/
   throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}