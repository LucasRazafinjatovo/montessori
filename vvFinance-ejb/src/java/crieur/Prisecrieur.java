package crieur;

import bean.*;
import java.util.*;
import java.sql.Connection;



public class Prisecrieur extends ClassMAPTable{
  public Prisecrieur(){
    super.setNomTable("prisecrieur");
  }
  public void construirePK(Connection c) throws Exception
 {
     super.setNomTable("prisecrieur");
     this.preparePk("PRJ","getSeqPrisecrieur"); //vv
     this.setId(makePK(c));
  }
  public Prisecrieur(String dat, String vend, String publi, String nbrep,String prix) throws Exception
  {
    super.setNomTable("prisecrieur");
    this.preparePk("PRJ","getSeqPrisecrieur");
    this.setId(makePK());
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setVendeur(vend);
    setPublicat(publi);
    setNbreprise(utilitaire.Utilitaire.stringToInt(nbrep));
    setIdPrix(utilitaire.Utilitaire.stringToDouble(prix));
  }
  public Prisecrieur(String dat, String vend, String publi, String nbrep, String prix, Connection c) throws Exception
  {
   super.setNomTable("prisecrieur");
   this.preparePk("PRJ","getSeqPrisecrieur");
   this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setVendeur(vend);
    setPublicat(publi);
    setNbreprise(utilitaire.Utilitaire.stringToInt(nbrep));
    setIdPrix(utilitaire.Utilitaire.stringToDouble(prix));
    if(c==null){
      c=new utilitaire.UtilDB().GetConn();
    }
    this.setId(makePK(c));
  }

    String id;
   private java.sql.Date daty;
   private String vendeur;
   private String publicat;
   private int nbreprise;
   private double idPrix;
   private String place;

  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDaty(java.sql.Date daty) throws Exception {
    double nbJour= utilitaire.Utilitaire.diffJourDaty(daty,utilitaire.Utilitaire.dateDuJourSql());
    if(Math.abs(nbJour)>3000) throw new Exception("date invalide");
    this.daty = daty;
  }
  public int getNbreprise() {
    return nbreprise;
  }
  public void setNbreprise(int nbreprise) throws Exception {
    if((nbreprise<=0)&&getMode().compareToIgnoreCase("insert")==0)throw new Exception("nombre invalide");
    this.nbreprise = nbreprise;
  }
  public String getPublicat() {
    return publicat;
  }
  public void setPublicat(String publicat) {
    this.publicat = publicat;
  }
  public String getVendeur() {
    return vendeur;
  }
  public void setVendeur(String vendeur) {
    this.vendeur = vendeur;
  }
  public String getId() {
    return id;
  }
  public void setPlace(String place) {
   this.place = place;
 }
 public String getPlace() {
   return place;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdPrix(double idPrix) {
    this.idPrix = idPrix;
  }
  public double getIdPrix() {
    return idPrix;
  }
  public double getMontantTheorique() {
  return this.getIdPrix()*this.getNbreprise();
  }

}