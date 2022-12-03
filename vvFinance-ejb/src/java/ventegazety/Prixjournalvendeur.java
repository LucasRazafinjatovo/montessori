package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;


public class Prixjournalvendeur extends ClassMAPTable {

  private String id;
  private String vendeur;
  private double prix;
  private String journal;
  private Date dateeffective;
  private String matricule;

  public Prixjournalvendeur() {
    setNomTable("Prixjournalvendeur");
  }
  public void construirePK(Connection c) throws Exception
  {
  super.setNomTable("Prixjournalvendeur");
  this.preparePk("PVJ","getSeqPvj");
  this.setId(makePK(c));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setVendeur(String vendeur) {
    this.vendeur = vendeur;
  }
  public String getVendeur() {
    return vendeur;
  }
  public void setPrix(double prix)throws Exception {
    if(prix<=0)throw new Exception("prix invalide");
    this.prix = prix;
  }
  public double getPrix() {
    return prix;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setMatricule(String matricule) {
    this.matricule = matricule;
  }
  public String getMatricule() {
    return matricule;
  }
  public Date getDateeffective() {
    return dateeffective;
  }
  public void setDateeffective(Date dateeffective) {
    this.dateeffective = dateeffective;
  }
}