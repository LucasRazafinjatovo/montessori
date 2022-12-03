package ded;
import bean.*;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class BenefPiece extends ClassMAPTable{

  private String id;
  private String nom;
  private String tel;
  private String poste;
  public BenefPiece() {
    this.setNomTable("BenefPiece");
  }
  public BenefPiece(String nom,String tel,String poste)throws Exception  {
   this.setNomTable("BenefPiece");
   this.preparePk("COU","getSeqBenefPiece");
   this.setId(makePK());
   this.setNom(nom);
   this.setTel(tel);
   this.setPoste(poste);
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("BenefPiece");
    this.preparePk("BEP","getSeqBenefPiece");
    this.setId(makePK(c));
  }
  public String getAttributIDName() {
   return "id";
 }
  public String getTuppleID() {
   return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setNom(String nom) {
    this.nom = nom;
  }
  public String getNom() {
    return nom;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
  public String getTel() {
    return tel;
  }
  public void setPoste(String poste) {
    this.poste = poste;
  }
  public String getPoste() {
    return poste;
  }
}