package etudiant;
import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
public class EtudiantEnCours extends ClassEtat{

  private String idEtudiant;
  private String nom;
  private String prenom;
  private String idniveau;
  private String niveau;
  private String idAnneeScolaire;
  private String anneeScolaire;
  String idEcole;
  String ecole;
  String idTarif;
  String designation;
  double montant;
  public EtudiantEnCours() {
    super.setNomTable("etudiantencours");
  }
  

  public String getIdEtudiant() {
    return idEtudiant;
  }
  public void setIdEtudiant(String idEtudiant) {
    this.idEtudiant = idEtudiant;
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
public String getIdEcole() {
  return idEcole;
}

public void setIdEcole(String idEcole) {
  this.idEcole = idEcole;
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

  public String getIdTarif()
  {
    return idTarif;
  }
  public void setIdTarif(String idTarif)
  {
    this.idTarif=idTarif;
  }
  public String getDesignation()
  {
    return designation;
  }
  public void setDesignation(String designation)
  {
    this.designation=designation;
  }
  public double getMontant()
  {
    return montant;
  }
  public void setMontant(double montant)
  {
    this.montant=montant;
  }
  public Tarif[] getTarif(Connection c) throws Exception
  {
  
      Tarif[] tarifr = (Tarif[]) CGenUtil.rechercher(new Tarif(), null, null, c,"and idEcole ='"+this.idEcole+"' and (designation like '%Once off Registration fee%' or DESIGNATION like '%Stationary and toiletries%')");
      return tarifr;
  }
  @Override
  public String getTuppleID() {
    // TODO Auto-generated method stub
    return null;
  }


  @Override
  public String getAttributIDName() {
    // TODO Auto-generated method stub
    return null;
  }
  
}