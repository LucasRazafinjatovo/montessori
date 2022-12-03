package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Abonnement extends ClassMAPTable{

        private String id;
        private String idoffre;
        private String idabonne;
        private Date datedebut;
        private Date datefin;
        private int etat;
        private String observation;

  public Abonnement(){
  super.setNomTable("abonnement");
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
  public Date getDatedebut() {
    return datedebut;
  }
  public Date getDatefin() {
    return datefin;
  }
  public int getEtat() {
    return etat;
  }
  public String getIdabonne() {
    return idabonne;
  }
  public String getIdoffre() {
    return idoffre;
  }
  public String getObservation() {
    return observation;
  }
  public void setObservation(String observation) {
    this.observation = observation;
  }
  public void setIdoffre(String idoffre) {
    this.idoffre = idoffre;
  }
  public void setIdabonne(String idabonne) {
    this.idabonne = idabonne;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public void setDatefin(Date datefin) {
    this.datefin = datefin;
  }
  public void setDatedebut(Date datedebut) {
    this.datedebut = datedebut;
  }

  public void construirePK(Connection c) throws Exception
   {
     super.setNomTable("abonnement");
     this.preparePk("ABN","GETSEQABONNEMENT");
     //this.preparePk("VED","getSeqVend"); //ankorondrano
     this.setId(makePK(c));
  }

}