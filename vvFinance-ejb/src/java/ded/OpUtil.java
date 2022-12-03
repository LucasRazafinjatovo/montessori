package ded;

import bean.*;
import java.sql.ResultSet;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class OpUtil extends GenUtil {

  public OpUtil() {
    super("OrdonnerPayement","ded.OrdonnerPayement");
  }
  public OpUtil(String nomTable)
  {
    super(nomTable,"ded.OrdonnerPayement");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
    /**@todo Implement this bean.GenUtil abstract method*/
    throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}