package etudiant;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.*;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ResultatFinale extends ClassMAPTable{

  private String etudiant;
  private double moyennes5;
  private double moyennes6;
  private double moyennegeneral;
  private String mention;
  private String optionetu;
  private String promotion;
  public ResultatFinale() {
    super.setNomTable("ResultatFinale");
  }
  public String getTuppleID(){
    return "";
  }
  public String getAttributIDName(){
    return "id";
  }
  public void setEtudiant(String etudiant) {
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
  public void setMoyennes5(double moyennes5) {
    this.moyennes5 = moyennes5;
  }
  public double getMoyennes5() {
    return moyennes5;
  }
  public void setMoyennes6(double moyennes6) {
    this.moyennes6 = moyennes6;
  }
  public double getMoyennes6() {
    return moyennes6;
  }
  public void setMoyennegeneral(double moyennegeneral) {
    this.moyennegeneral = moyennegeneral;
  }
  public double getMoyennegeneral() {
    return moyennegeneral;
  }
  public void setMention(String mention) {
    this.mention = mention;
  }
  public String getMention() {
    return mention;
  }
  public void setOptionetu(String optionetu) {
    this.optionetu = optionetu;
  }
  public String getOptionetu() {
    return optionetu;
  }
  public void setPromotion(String promotion) {
    this.promotion = promotion;
  }
  public String getPromotion() {
    return promotion;
  }
}