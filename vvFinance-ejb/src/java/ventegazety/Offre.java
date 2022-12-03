package ventegazety;

import java.sql.Date;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Offre extends ClassMAPTable{
  private String id;
  private Date dateeffectivite;
  private int duree;
  public String getTuppleID(){
        return id;
    }
    public String getAttributIDName(){
        return "id";
    }
  public Offre() {
    this.setNomTable("offre");
  }
  public Offre(String id,Date dateeffectivite,int duree) {
    this.setId(id);
    this.setDateeffectivite(dateeffectivite);
    this.setDuree(duree);
    this.setNomTable("offre");
  }
  public Offre(Date dateeffectivite,int duree) {
    this.setDateeffectivite(dateeffectivite);
    this.setDuree(duree);
    this.setNomTable("offre");
  }
  public void construirePK(Connection c) throws Exception
  {
    this.preparePk("OFR","GETSEQOFFRE");
    this.setId(makePK(c));
  }
  public String getId()
  {
    return id;
  }
  public void setId(String id)
  {
     this.id=id;
  }
  public void setDateeffectivite(Date dateeffectivite)
  {
     this.dateeffectivite=dateeffectivite;
  }
  public int getDuree()
  {
    return duree;
  }
  public void setDuree(int duree)
  {
     this.duree=duree;
  }
  public Date getDateeffectivite() {
    return dateeffectivite;
  }
}