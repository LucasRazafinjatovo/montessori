package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class AbonnementJournal extends ClassMAPTable{

        private String id;
        private String idabonnement;
        private String idoffrejournal;
        private double quantite;

  public AbonnementJournal(){
  super.setNomTable("abonnementjournal");
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
  public String getIdabonnement() {
    return idabonnement;
  }
  public void setIdabonnement(String idabonnement) {
    this.idabonnement = idabonnement;
  }

}