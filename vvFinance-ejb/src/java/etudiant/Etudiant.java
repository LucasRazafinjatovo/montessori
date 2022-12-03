package etudiant;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Etudiant extends ClassEtat{

  private String id;
  private String nom;
  private String prenom;
  private java.sql.Date dateNaissance;
  private String pere;
  private String proffPere;
  private String mere;
  private String profMere;
  private String adresse;
  private String contact;
  private String mail;
  private String chemin;
  private String sexe;
  private String entite;
  private String pays;
  private int niveau;
  private Date date_debut;
  private Date date_fin;

  public Etudiant() {
    super.setNomTable("etudiant");
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("etudiant");
    this.preparePk("ETU","getSeqEtudiant");
    this.setId(makePK(c));
  }

  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setNom(String nom) throws Exception {
    String temp=nom==null?"":nom.trim();
    if(temp.equals(""))throw new Exception("Nom invalide .");
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
  public void setDateNaissance(java.sql.Date dateNaissance) throws Exception{
    java.sql.Date today=Utilitaire.dateDuJourSql();
    if(Utilitaire.getAnnee(today)-Utilitaire.getAnnee(dateNaissance)<=0 || Utilitaire.getAnnee(today)-Utilitaire.getAnnee(dateNaissance)>=60)
      throw new Exception("Date de naissance incorrecte");
    this.dateNaissance = dateNaissance;
  }
  public java.sql.Date getDateNaissance() {
    return dateNaissance;
  }
  public void setPere(String pere) {
    this.pere = pere;
  }
  public String getPere() {
    return pere;
  }
  public void setProffPere(String proffPere) {
    this.proffPere = proffPere;
  }
  public String getProffPere() {
    return proffPere;
  }
  public void setMere(String mere) {
    this.mere = mere;
  }
  public String getMere() {
    return mere;
  }
  public void setProfMere(String profMere) {
    this.profMere = profMere;
  }
  public String getProfMere() {
    return profMere;
  }
  public void setAdresse(String adresse) {
    this.adresse = adresse;
  }
  public String getAdresse() {
    return adresse;
  }
    public void setContact(String contact) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0 || getMode().compareToIgnoreCase("insert") == 0) {
            if (contact.equals("")) {
                throw new Exception("Contact obligatoire.");
            }
        }
        this.contact = contact;
    }
  public String getContact() {
    return contact;
  }
  public void setMail(String mail)throws Exception {
    String temp=mail==null?"":mail.trim();
    if(temp.equals(""))throw new Exception("Votre email n est pas valide .");
    this.mail = temp;
  }
  public String getMail() {
    return mail;
  }
  public void setChemin(String chemin) {
    this.chemin = chemin;
  }
  public String getChemin() {
    return chemin;
  }
  public void setSexe(String sexe) {
    this.sexe = sexe;
  }
  public String getSexe() {
    return sexe;
  }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }
  public void setNiveau(int niveau) throws Exception{
    if(niveau<-2 || niveau>8) throw new Exception("Niveau invalide");
    this.niveau = niveau;
  }
  public int getNiveau() {
    return niveau;
  }
  public void setPays(String pays) {
    this.pays = pays;
  }
  public String getPays() {
    return pays;
  }
  

  public Etudiant(EtudiantPromo etu){
    super.setNomTable("etudiant");
  /*setId(etu.);
  private String nom;
  private String prenom;
  private java.sql.Date dateNaissance;
  private String pere;
  private String proffPere;
  private String mere;
  private String profMere;
  private String adresse;
  private String contact;
  private String mail;
  private String chemin;
  private String sexe;
  private String ecole;
  private String nature;
  private String pays;*/
  }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
      
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }
   
  
  
}