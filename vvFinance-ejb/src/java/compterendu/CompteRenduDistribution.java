package compterendu;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class CompteRenduDistribution extends ClassMAPTable{

  private java.sql.Date daty;
  private String journal;
  private String titre;
  private String heure;
  private int nbreexemplaire;
  private int prise;
  private int vente;
  public CompteRenduDistribution() {

  }
  public String getTuppleID()
   {
       return null;
   }

   public String getAttributIDName()
   {
       return "journal";
    }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setTitre(String titre) {
    this.titre = titre;
  }
  public String getTitre() {
    return titre;
  }
  public void setHeure(String heure) {
    this.heure = heure;
  }
  public String getHeure() {
    return heure;
  }
  public void setNbreexemplaire(int nbreexemplaire) {
    this.nbreexemplaire = nbreexemplaire;
  }
  public int getNbreexemplaire() {
    return nbreexemplaire;
  }
  public void setPrise(int prise) {
    this.prise = prise;
  }
  public int getPrise() {
    return prise;
  }
  public void setVente(int vente) {
    this.vente = vente;
  }
  public int getVente() {
    return vente;
  }

}