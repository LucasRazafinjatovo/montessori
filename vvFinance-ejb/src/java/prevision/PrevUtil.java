package prevision;
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

public class PrevUtil extends GenUtil{

  public PrevUtil() {
    super("PrevisionDepense","prevision.PrevisionDepense");
  }
  public PrevUtil(String nomTable) {
   super(nomTable,"prevision.PrevisionDepense");
  }
  public Object[] resultatLimit(int numBloc, ResultSet rs) {
   /**@todo Implement this bean.GenUtil abstract method*/
   throw new java.lang.UnsupportedOperationException("Method resultatLimit() not yet implemented.");
  }
}
