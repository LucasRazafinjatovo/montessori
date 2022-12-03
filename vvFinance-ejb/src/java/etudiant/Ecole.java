package etudiant;
import bean.ClassMAPTable;
import java.sql.Connection;
public class Ecole extends ClassMAPTable{

  private String id;
  private String nom;
  private String typeEcole;
  private String lieu;
  private String remarque;
  public Ecole() {
    super.setNomTable("ecole");
  }
  public String getTuppleID(){
   return id;
 }
 public String getAttributIDName(){
   return "id";
 }
 public void construirePK(Connection c) throws Exception{
  super.setNomTable("ecole");
  this.preparePk("ECO","getSeqEcole");
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
  public void setTypeEcole(String typeEcole) {
    this.typeEcole = typeEcole;
  }
  public String getTypeEcole() {
    return typeEcole;
  }
  public void setLieu(String lieu) {
    this.lieu = lieu;
  }
  public String getLieu() {
    return lieu;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
}