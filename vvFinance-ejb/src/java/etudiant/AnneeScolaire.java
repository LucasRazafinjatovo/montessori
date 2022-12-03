package etudiant;

import bean.ClassMAPTable;
import java.sql.Connection;
public class AnneeScolaire extends ClassMAPTable{

  private String id;
  private String nom;
  public AnneeScolaire(){
    super.setNomTable("anneescolaire");
  }
  public String getTuppleID(){
   return id;
 }
 public String getAttributIDName(){
   return "id";
 }
 public void construirePK(Connection c) throws Exception{
  super.setNomTable("anneescolaire");
  this.preparePk("ANN","getSeqAnneescolaire");
  this.setId(makePK(c));
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
  
 
}