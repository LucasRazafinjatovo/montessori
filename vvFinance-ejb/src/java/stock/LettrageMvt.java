/***********************************************************************
 * Module:  LETTRAGEMVT.java
 * Author:  lalaina
 * Created: mercredi 17 septembre 2008 04:49:23
 * Purpose: Defines the Class LETTRAGEMVT
 ***********************************************************************/

package stock;

import java.util.*;
import bean.ClassMAPTable;

public class LettrageMvt extends ClassMAPTable
{
   public java.lang.String id;
   public java.lang.String parent;
   public java.lang.String fille;
   public java.lang.String remarque;

    public LettrageMvt(){

    }
    public LettrageMvt(String id, String parent, String fille, String rmq){
      super.setNomTable("LettrageMvt");
      setId(id);
      setParent(parent);
      setFille(fille);
      setRemarque(rmq);

    }
    public LettrageMvt(String parent, String fille, String rmq){
      super.setNomTable("LettrageMvt");
      setIndicePk("LM");
      setNomProcedureSequence("getSeqLettrageMvt");
      setId(makePK());
      setParent(parent);
      setFille(fille);
      setRemarque(rmq);

    }
  public String getFille() {
    return fille;
  }
  public String getId() {
    return id;
  }
  public String getParent() {
    return parent;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setFille(String fille) {
    this.fille = fille;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setParent(String parent) {
    this.parent = parent;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
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

