package prevision;
import bean.TypeObjet;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Mois extends TypeObjet{

  private String mois;
  private String rang;
  public Mois() {
  }
  public String getMois() {
    return mois;
  }
  public void setMois(String mois) {
    this.mois = mois;
  }
  public void setRang(String rang) {
    this.rang = rang;
  }
  public String getRang() {
    return rang;
  }
}