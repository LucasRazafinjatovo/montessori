package facturefournisseur;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.*;
public class Fournisseur extends ClassMAPTable{
public String idFournisseur;
public String nomFournisseur;
public String nifFournisseur;
public String statFournisseur;
public String telFournisseur;
public String emailFournisseur;
public String adresseFournisseur;
  public Fournisseur() {
  }
  public Fournisseur(String idF,String nF,String nifF,String statF,String telF,String emailF,String adresseF){
     super.setNomTable("FFournisseur");
    setidFournisseur(idF);
    setnomFournisseur(nF);
    setnifFournisseur(nifF);
    setstatFournisseur(statF);
    settelFournisseur(telF);
    setemailFournisseur(emailF);
    setadresseFournisseur(adresseF);
  }
  public Fournisseur(String nF,String nifF,String statF,String telF,String emailF,String adresseF){
   super.setNomTable("FFournisseur");
  setnomFournisseur(nF);
  setnifFournisseur(nifF);
  setstatFournisseur(statF);
  settelFournisseur(telF);
  setemailFournisseur(emailF);
  setadresseFournisseur(adresseF);
  setIndicePk("F");
  setNomProcedureSequence("getSeqFournisseur");
   setidFournisseur(makePK());
  }
  public String getTuppleID(){
   return String.valueOf(idFournisseur);
 }

   public String getAttributIDName(){
     return "idFournisseur";
     }
  public void setidFournisseur(String idf){
    this.idFournisseur=idf;
  }
  public void setnomFournisseur(String nF){
this.nomFournisseur=nF;
  }
  public void setnifFournisseur(String nifF){
this.nifFournisseur=nifF;
  }
  public void setstatFournisseur(String statF){
this.statFournisseur=statF;
  }
  public void settelFournisseur(String telF){
this.telFournisseur=telF;
  }
  public void setemailFournisseur(String emailF){
this.emailFournisseur=emailF;
  }
  public void setadresseFournisseur(String adresseF){
this.adresseFournisseur=adresseF;
  }


  public String getidFournisseur(){
   return this.idFournisseur;
 }
 public String getnomFournisseur(){
return this.nomFournisseur;
 }
 public String getnifFournisseur(){
return this.nifFournisseur;
 }
 public String getstatFournisseur(){
return this.statFournisseur;
 }
 public String gettelFournisseur(){
return this.telFournisseur;
 }
 public String getemailFournisseur(){
return this.emailFournisseur;
 }
 public String getadresseFournisseur(){
return this.adresseFournisseur;
  }


}