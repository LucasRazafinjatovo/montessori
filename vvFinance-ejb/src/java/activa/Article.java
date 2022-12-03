package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Article extends ClassMAPTable{
  private String idArticle;
  private double grs;
  private String format;
  private String idTypeArticle;
  private String idNombreRame;
  private String libelle;

  public Article(){
   super.setNomTable("article");
  }

  public void construirePK(Connection c) throws Exception{
    super.setNomTable("article");
    this.preparePk("ART","getSeqArticle");
    this.setIdArticle(makePK(c));
 }


  public Article(String lib,String idNombreRame,String g,String puRame,String format,String prixR,String prixRV){
     super.setNomTable("article");
     this.setIdTypeArticle(idTypeArticle);
     setLibelle(lib);
     setIdNombreRame(idNombreRame);
     setGrs(Integer.parseInt(g));
     // conversion String => double
   //  setPuRame(utilitaire.Utilitaire.stringToDouble(puRame));
     setFormat(format);
     // Creation du clé primaire de la table article
     setIndicePk("ART");
     setNomProcedureSequence("getSeqArticle");
     setIdArticle(makePK());
  }

  public String getAttributIDName() {
    return "idArticle";
  }

  public String getTuppleID() {
    return idArticle;
  }

  public void setIdArticle(String idArticle) {
    this.idArticle = idArticle;
  }

  public String getIdArticle() {
    return idArticle;
  }

  public void setGrs(double grs) {
    this.grs = grs;
  }
  public double getGrs() {
    return grs;
  }
  public void setFormat(String format) {
    this.format = format;
  }
  public String getFormat() {
    return format;
  }
  public void setIdTypeArticle(String idTypeArticle) {
    this.idTypeArticle = idTypeArticle;
  }
  public String getIdTypeArticle() {
    return idTypeArticle;
  }
  public void setIdNombreRame(String idNombreRame) {
    this.idNombreRame = idNombreRame;
  }
  public String getIdNombreRame() {
    return idNombreRame;
  }
  public void setLibelle(String libelle) {
    this.libelle = libelle;
  }
  public String getLibelle() {
    return libelle;
  }
}
