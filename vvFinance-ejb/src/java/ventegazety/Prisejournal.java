/***********************************************************************
 * Module:  Prisejournal.java
 * Author:  said
 * Purpose: Defines the Class Prisejournal
 ***********************************************************************/
package ventegazety;

import bean.*;
import java.util.*;
import java.sql.Connection;



public class Prisejournal extends ClassMAPTable{
  public Prisejournal(){
    super.setNomTable("prisejournal");
  }
  public void construirePK(Connection c) throws Exception
 {
     super.setNomTable("prisejournal");
     this.preparePk("PRJ","getSeqPrise"); //vv
     //this.preparePk("PRS","getSeqPrise"); //ankorondrano
     this.setId(makePK(c));
  }
  public Prisejournal(String dat, String vend, String publi, String nbrep,String prix) throws Exception
  {
    super.setNomTable("prisejournal");
    this.preparePk("PRJ","getSeqPrise");
    this.setId(makePK());
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat));
    setVendeur(vend);
    setPublicat(publi);
    setNbreprise(utilitaire.Utilitaire.stringToInt(nbrep));
    setIdPrix(utilitaire.Utilitaire.stringToDouble(prix));
  }
  public Prisejournal(String dat, String vend, String publi, String nbrep, String prix, Connection c) throws Exception
  {
   super.setNomTable("prisejournal");
   this.preparePk("PRJ","getSeqPrise");
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
/*extraction de publicat en tableau*/
 /*public String[] chaine(String publicat){
       Publication[]pu=null;
       String numparution="";
       String []tableau=null;
       String journal="";
       for(int u=0;u<publicat.length();u++){
          journal+=publicat.substring(1,u+1);
          if(publicat.substring(1,u+1)==" "){
               tableau[0]=journal;
               tableau[1]=publicat.substring(publicat.length()-journal.length(),u+1);
               numparution=tableau[1];
          }
       }
       Publication pb=new Publication("",journal,numparution,"","","","");
       pu=bean.CGenUtil.rechercher(pb,null,null,"and journal="+journal+"and numparution="+numparution);
       this.setPublicat()=pu[0].getId();
       return tableau;
  }*/

    String id;
   private java.sql.Date daty;
   private String vendeur;
   private String publicat;
   private int nbreprise;
   private double idPrix;
   private String place;
   //private String typevendeur;

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
/*  public void setTypevendeur(String typevendeur) {
   this.typevendeur = typevendeur;
 }
 public String getTypevendeur() {
   return typevendeur;
  }*/
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