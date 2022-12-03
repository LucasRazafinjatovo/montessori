package ventegazety;

import bean.*;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

public class Abonne extends ClassMAPTable{

	private String id;
	private String idvendeur;
	private String idcivilite;
	private Date datenaissance;
	private String cin;
	private String telephone;
	private  String adresse;
	private String idquartier;

  public Abonne(){
  super.setNomTable("abonne");
  }
  public Abonne(String idvendeur, String idcivilite, Date datenaissance, String cin, String telephone, String adresse, String idquartier){
	super.setNomTable("abonne");
	try{
        this.setIdvendeur(idvendeur);
	this.setIdcivilite(idcivilite);
	this.setDatenaissance(datenaissance);
	this.setCin(cin);
	this.setTelephone(telephone);
	this.setAdresse(adresse);
	this.setIdquartier(idquartier);
	}catch(Exception ex){
          ex.printStackTrace();
        }

  }
  public void construirePK(Connection c) throws Exception
 {
   super.setNomTable("abonne");
   this.preparePk("ABN","GETSEQABONNE");
   //this.preparePk("VED","getSeqVend"); //ankorondrano
   this.setId(makePK(c));
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
  public String getIdvendeur() {
   return idvendeur;
 }
 public void setIdvendeur(String idvendeur) {
   this.idvendeur = idvendeur;
  }
  public String getIdcivilite() {
   return idcivilite;
 }
 public void setIdcivilite(String idcivilite) {
   this.idcivilite = idcivilite;
  }
  public void setDatenaissance(Date datenaissance){
    this.datenaissance = datenaissance;
  }
  public Date getDatenaissance() {
    return datenaissance;
  }
  public String getCin() {
   return cin;
 }
 public void setCin(String cin) {
   this.cin = cin;
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
  public String getIdquartier() {
   return idquartier;
 }
 public void setIdquartier(String idquartier) {
   this.idquartier = idquartier;
  }
}