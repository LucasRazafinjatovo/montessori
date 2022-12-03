package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class AbonnementJournalVue extends ClassMAPTable{

        private String id;
        private String idabonnement;
        private String idoffrejournal;
        private double quantite;
        private double pu;

  public AbonnementJournalVue(){
  super.setNomTable("abonnement_journal_vue");
  }


  public String getAttributIDName() {
   return "id";
 }
 public String getTuppleID() {
   return id;
  }
  public String getId() {
   return id;
 }
 public void setId(String id) {
   this.id = id;
  }
  public String getIdoffrejournal() {
    return idoffrejournal;
  }
  public double getQuantite() {
    return quantite;
  }
  public void setQuantite(double quantite) {
    this.quantite = quantite;
  }
  public void setIdoffrejournal(String idoffrejournal) {
    this.idoffrejournal = idoffrejournal;
  }
  public double getPu() {
    return pu;
  }
  public void setPu(double pu) {
    this.pu = pu;
  }
  public String getIdabonnement() {
    return idabonnement;
  }
  public void setIdabonnement(String idabonnement) {
    this.idabonnement = idabonnement;
  }

}