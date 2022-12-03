package promotion;
import bean.ClassMAPTable;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AvancementComplet extends Avancement{

  private String etudiant;
  private String promotion;
  public AvancementComplet() {
    super.setNomTable("AVANCEMENTCOMPLET");
  }
  /*public String getTuppleID(){
 return id;
}
public String getAttributIDName(){
 return "id";
}*/
  public void setEtudiant(String etudiant) throws Exception{
   // if(etudiant.compareToIgnoreCase("")==0) throw new Exception("Etudiant vide");
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
  public void setPromotion(String promotion) {
    this.promotion = promotion;
  }
  public String getPromotion() {
    return promotion;
  }
}