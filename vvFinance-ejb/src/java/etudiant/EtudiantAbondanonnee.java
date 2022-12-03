package etudiant;
import bean.ClassEtat;

public class EtudiantAbondanonnee extends ClassEtat{

  private String id;
  private String nom;
  private String prenom;
  private String motif;
  private String mois;
  private int annee;
  String ecole;

  public EtudiantAbondanonnee() {
    super.setNomTable("etudiant_abondant");
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
  public String getMois() {
    return mois;
}

public void setMois(String mois) {
    this.mois = mois;
}
public String getMotif() {
    return motif;
  }
  public void setMotif(String motif) {
    this.motif = motif;
  }
  public int getAnnee() {
    return annee;
  }
  public void setAnnee(int annee) {
    this.annee = annee;
  }
  public String getEcole() {
    return ecole;
}
public void setEcole(String ecole) {
  this.ecole= ecole;
}
  
}