// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EtatCaisse.java

package finance;

import java.sql.Date;
import java.sql.Connection;
import bean.ClassMAPTable;
import java.util.Hashtable;
public class EtatCaisseTableau2  extends ClassMAPTable
{
  private String id;
  private Date daty;
  private String caisse;
  private double depense;
  private double recette;
  private double report;
  private double disponible;

  public String getTuppleID()
  {
    return id;
  }
  public String getAttributIDName()
  {
    return "id";
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("ETATCAISSEENREGISTREE");
     this.preparePk("ETC","getSeqEtatCaisseEnregistree");
     this.setId(makePK(c));
  }
  public EtatCaisseTableau2(){
    super.setNomTable("ETATCAISSEENREGISTREE");
  }



    public void setCaisse(String caisse)
    {
        this.caisse = caisse;
    }
    public String getCaisse()
    {
        return caisse;
    }

  public Date getDaty() {
    return daty;
  }


  public void setDaty(Date daty) {
    this.daty = daty;
  }






  public double getReport() {
    return report;
  }
  public void setReport(double report) {
    this.report = report;
  }
  public double getDepense() {
    return depense;
  }
  public double getDisponible() {
    return disponible;
  }
  public String getId() {
    return id;
  }
  public double getRecette() {
    return recette;
  }
  public void setRecette(double recette) {
    this.recette = recette;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDisponible(double disponible) {
    this.disponible = disponible;
  }
  public void setDepense(double depense) {
    this.depense = depense;
  }
}
