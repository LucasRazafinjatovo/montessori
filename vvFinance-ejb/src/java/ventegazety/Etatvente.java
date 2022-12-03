package ventegazety;

public class Etatvente extends Prisejournallib {

  private double invendu;
  private double vente;
  private double montant;
  private double recette;
  private double reste;
  private String place;
  private String province;
  private double totalcommission;
  private double taux;
  private String jour;
  private String heure;
  private String rubrique;
  public Etatvente() {
    this.setNomTable("EtatVente");
  }
  public double getInvendu() {
    return invendu;
  }
  public void setInvendu(double invendu) {
    this.invendu = invendu;
  }
  public void setVente(double vente) {
    this.vente = vente;
  }
  public double getVente() {
    return vente;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setRecette(double recette) {
    this.recette = recette;
  }
  public double getRecette() {
    return recette;
  }
  public void setReste(double reste) {
    this.reste = reste;
  }
  public double getReste() {
    return reste;
  }
  public void setPlace(String place) {
    this.place = place;
  }
  public String getPlace() {
    return place;
  }
  public void setProvince(String province) {
    this.province = province;
  }
  public String getProvince() {
    return province;
  }
  public void setTaux(double taux) {
    this.taux = taux;
  }
  public double getTaux() {
    if(getVente()==0||getNbreprise()==0)return 0;
    return getVente()/(double)(this.getNbreprise());
  }
  public void setTotalcommission(double totalcommission) {
  this.totalcommission = totalcommission;
}
public double getTotalcommission() {
  return totalcommission;
  }
  public void setJour(String jour) {
   this.jour = jour;
 }
 public String getJour() {
   return jour;
  }
  public void setRubrique(String rubrique) {
   this.rubrique = rubrique;
 }
 public String getRubrique() {
   return rubrique;
  }
  public void setHeure(String heure) {
  this.heure = heure;
}
public String getHeure() {
  return heure;
  }
}