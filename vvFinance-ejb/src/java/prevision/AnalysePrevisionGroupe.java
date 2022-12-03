package prevision;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;
import java.sql.Date;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AnalysePrevisionGroupe extends AnalysePrevision{

  private int mois;
  private int annee;
  private int semaine;
  public AnalysePrevisionGroupe() {
  }
  public int getMois() {
    return mois;
  }
  public void setMois(int mois) {
    this.mois = mois;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public int getAnnee() {
    return annee;
  }
  public void setSemaine(int semaine) {
    this.semaine = semaine;
  }
  public int getSemaine() {
    return semaine;
  }
}