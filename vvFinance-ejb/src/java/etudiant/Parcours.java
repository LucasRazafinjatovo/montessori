package etudiant;

import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;

public class Parcours extends ClassMAPTable{


  private String idetudiant;
  private String moyenne;
  private String semestre;
  private String optionne;
  private String promotion;
  private int numero;
  private String idoptionne;
  private String codeclasse;
  private String optionetu;
  public Parcours() {
    super.setNomTable("Parcours");
  }
  public String getTuppleID(){
    return idetudiant;
  }
  public String getAttributIDName(){
    return "idetudiant";
  }
  public void setIdetudiant(String idetudiant) {
    this.idetudiant = idetudiant;
  }
  public String getIdetudiant() {
    return idetudiant;
  }
  public void setMoyenne(String moyenne) {
    this.moyenne = moyenne;
  }
  public String getMoyenne() {
    return moyenne;
  }
  public void setSemestre(String semestre) {
    this.semestre = semestre;
  }
  public String getSemestre() {
    return semestre;
  }
  public void setOptionne(String optionne) {
    this.optionne = optionne;
  }
  public String getOptionne() {
    return optionne;
  }
  public void setPromotion(String promotion) {
    this.promotion = promotion;
  }
  public String getPromotion() {
    return promotion;
  }
  public void setNumero(int numero) {
    this.numero = numero;
  }
  public int getNumero() {
    return numero;
  }
  public void setIdoptionne(String idoptionne) {
    this.idoptionne = idoptionne;
  }
  public String getIdoptionne() {
    return idoptionne;
  }
  public void setCodeclasse(String codeclasse) {
    this.codeclasse = codeclasse;
  }
  public String getCodeclasse() {
    return codeclasse;
  }
  public void setOptionetu(String optionetu) {
    this.optionetu = optionetu;
  }
  public String getOptionetu() {
    return optionetu;
  }
}