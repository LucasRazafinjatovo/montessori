package crieur;

import bean.*;
import java.sql.Connection;



public class Recettecrieur extends ClassMAPTable{
  public Recettecrieur(){
    super.setNomTable("recettecrieur");
  }
  public void construirePK(Connection c) throws Exception
 {
   super.setNomTable("recettecrieur");
   this.preparePk("REC","getSeqRecettecrieur");//vv
   this.setId(makePK(c));
  }
  public void controler(Connection c) throws Exception
 {

 }
  public Recettecrieur(int somme, String prise, String daty) throws Exception
  {
    super.setNomTable("recettecrieur");
    this.preparePk("REC","getSeqRecettecrieur");
    this.setId(makePK());
    setSomme(somme);
    setPrise(prise);
    setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
  }
  public Recettecrieur(int somme, String prise, String daty, Connection c) throws Exception
  {
    super.setNomTable("recettecrieur");
    this.preparePk("REC","getSeqRecettecrieur");
    setSomme(somme);
    setPrise(prise);
    setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
    if(c==null){
      c=new utilitaire.UtilDB().GetConn();
    }
    this.setId(makePK(c));
  }

   String id;
  private String prise;
  private java.sql.Date daty;
  private double somme;

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
  public String getPrise() {
    return prise;
  }
  public void setPrise(String prise) throws Exception{
      this.prise = prise;
  }
  public double getSomme() {
    return somme;
  }
  public void setSomme(double somme)throws Exception {
      this.somme = somme;
  }
  public void setDaty(java.sql.Date daty) throws Exception{
    double nbJour= utilitaire.Utilitaire.diffJourDaty(daty,utilitaire.Utilitaire.dateDuJourSql());
    if(Math.abs(nbJour)>3000) throw new Exception("date invalide");
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }

}