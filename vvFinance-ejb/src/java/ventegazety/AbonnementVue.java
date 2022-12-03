package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class AbonnementVue extends ClassMAPTable{

	private String id;
	private String abonne;
	private String civilite;
	private Date datedebut;
        private Date datefin;
	private String idoffre;
        private int etat;
	private String telephone;
	private  String adresse;
	private String observation;

  public AbonnementVue(){
  super.setNomTable("abonnement_vue");
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


  public String getTelephone() {
   return telephone;
 }
 public void setTelephone(String telephone) throws Exception{
   if (getMode().compareToIgnoreCase("modif") == 0) {
			if (telephone == null || telephone.compareTo("") == 0) {
				throw new Exception("Champ telephone manquant");
			}
			else{
				String[] numeros = Utilitaire.split(telephone, ";");
				for (int i=0; i<numeros.length; i++){
					if (!numeros[i].startsWith("0") && !numeros[i].startsWith("261")) throw new Exception("Numero invalide");
					else if (numeros[i].startsWith("0") && numeros[i].length() != 10) throw new Exception("Numero invalide");
					else if (numeros[i].startsWith("261") && numeros[i].length() != 12) throw new Exception("Numero invalide");
				}
				this.telephone = telephone;
			}
		}
		else this.telephone = telephone;
  }
  public String getAdresse() {
   return adresse;
 }
 public void setAdresse(String adresse) {
   this.adresse = adresse;
  }
  public String getAbonne() {
    return abonne;
  }
  public void setAbonne(String abonne) {
    this.abonne = abonne;
  }
  public String getCivilite() {
    return civilite;
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
  public void setCivilite(String civilite) {
    this.civilite = civilite;
  }
  public void setDatedebut(Date datedebut) {
    this.datedebut = datedebut;
  }
  public void setDatefin(Date datefin) {
    this.datefin = datefin;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }

}