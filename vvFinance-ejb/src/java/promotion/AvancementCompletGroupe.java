package promotion;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AvancementCompletGroupe extends Avancement{

  private String etudiant;
  private String promotion;
  public AvancementCompletGroupe() {
    super.setNomTable("AVANCEMENTCOMPLET");
  }
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