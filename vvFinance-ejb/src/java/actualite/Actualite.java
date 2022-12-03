// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Caisse.java

package actualite;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class Actualite extends ClassMAPTable{
  public Actualite(){
    super.setNomTable("actualites");
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("actualites");
     this.preparePk("ACT","getSeqActu");
     this.setId(makePK(c));
  }
  public Actualite(String direction, String typeActu, String actualite, String daty) throws Exception{
   super.setNomTable("actualites");
   this.preparePk("ACT","getSeqActu");
   this.setId(makePK());
   this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
   setActualite(actualite);
   setDirection(direction);
   //this.setHeure(utilitaire.Utilitaire.heureCouranteHMS());

 }
  public Actualite(String direction, String typeActu, String actualite, String daty, Connection c) throws Exception{
    super.setNomTable("actualites");
    this.preparePk("ACT","getSeqActu");
    this.setId(makePK());
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
    setActualite(actualite);
    setDirection(direction);
    //this.setHeure(utilitaire.Utilitaire.heureCouranteHMS());
    if(c==null){
      c=new utilitaire.UtilDB().GetConn();
    }
    this.setId(makePK(c));
  }


   String id;
   private java.sql.Date daty;
   private String direction;
   private String typeActu;
   private String actualite;
   private String heure;
  private String entite;

  public String getAttributIDName() {
     return "id";
   }
  public String getTuppleID() {
     return id;
  }
  public String getActualite() {
    return actualite;
  }
  public void setActualite(String actualite) {
    this.actualite = actualite;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public String getDirection() {
    return direction;
  }
  public void setDirection(String direction) {
    this.direction = direction;
  }
  public void setTypeActu(String typeActu) {
    this.typeActu = typeActu;
  }
  public String getTypeActu() {
    return typeActu;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getHeure() {
    return heure;
  }
  public void setHeure(String heure) {
    this.heure = heure;
  }
  public void setEntite(String entite) {
    this.entite = entite;
  }
  public String getEntite() {
    return entite;
  }
}
