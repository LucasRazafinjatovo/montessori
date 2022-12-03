/***********************************************************************
 * Module:  DetailBobinePoids.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class DetailBobinePoids
 ***********************************************************************/

package stock;

import java.util.*;
import bean.ClassMAPTable;

public class DetailBobinePoids extends ClassMAPTable
{
   public java.lang.String id;
   public java.lang.String numbobine;
   public double poidsbobine;
   public java.lang.String mvtStock;

  public DetailBobinePoids(){

  }
  public DetailBobinePoids(String id, String numbobine, double poids, String mvtStock){
    super.setNomTable("DetailBobinePoids");
    setId(id);
    setNumbobine(numbobine);
    setPoidsbobine(poids);
    setMvtStock(mvtStock);

}
public DetailBobinePoids(String numbobine, double poids, String mvtStock){
   super.setNomTable("DetailBobinePoids");
   setIndicePk("DB");
   setNomProcedureSequence("getSeqDetailBobinePoids");
   setId(makePK());
   setNumbobine(numbobine);
   setPoidsbobine(poids);
   setMvtStock(mvtStock);

}
public DetailBobinePoids(String numbobine, String poids, String mvtStock){
   super.setNomTable("DetailBobinePoids");
   setIndicePk("DB");
   setNomProcedureSequence("getSeqDetailBobinePoids");
   setId(makePK());
   setNumbobine(numbobine);
   setPoidsbobine(utilitaire.Utilitaire.stringToDouble(poids));
   setMvtStock(mvtStock);

}
  public String getId() {
    return id;
  }
  public String getMvtStock() {
    return mvtStock;
  }
  public String getNumbobine() {
    return numbobine;
  }
  public double getPoidsbobine() {
    return poidsbobine;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setMvtStock(String mvtStock) {
    this.mvtStock = mvtStock;
  }
  public void setNumbobine(String numbobine) {
    this.numbobine = numbobine;
  }
  public void setPoidsbobine(double poidsbobine) {
    this.poidsbobine = poidsbobine;
  }
  public String getTuppleID()
  {
      return id;
  }

  public String getAttributIDName()
  {
      return "id";
    }

}

