package etudiant;
import bean.ClassEtat;
import java.sql.Connection;
public class EtudiantAnneeScolaire extends ClassEtat{

  private String id;
  private String nom;
  private String prenom;
  private String ecole;
  private String idniveau;
  private String niveau;
  private String idAnneeScolaire;
  private String anneeScolaire;
  public EtudiantAnneeScolaire() {
    super.setNomTable("etudiant_anneescolaire");
  }
  public String getTuppleID(){
   return id;
 }
 public String getAttributIDName(){
   return "id";
 }

  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setNom(String nom) throws Exception{
  //  if(nom.compareToIgnoreCase("")==0) throw new Exception("Nom ecole vide");
    this.nom = nom;
  }
  public String getNom() {
    return nom;
  }
  public void setPrenom(String prenom) {
    this.prenom = prenom;
  }
  public String getPrenom() {
    return prenom;
  }
  public String getEcole() {
    return ecole;
}

public void setEcole(String ecole) {
    this.ecole = ecole;
}
public String getIdAnneeScolaire() {
    return idAnneeScolaire;
  }
  public void setIdAnneeScolaire(String idAnneeScolaire) {
    this.idAnneeScolaire = idAnneeScolaire;
  }
  public String getAnneeScolaire() {
    return anneeScolaire;
  }
  public void setAnneeScolaire(String anneeScolaire) {
    this.anneeScolaire = anneeScolaire;
  }
  public String getIdNiveau() {
    return idniveau;
  }
  public void setIdNiveau(String idniveau) {
    this.idniveau = idniveau;
  }
  public String getNiveau() {
    return niveau;
  }
  public void setNiveau(String niveau) {
    this.niveau = niveau;
  }
  
}