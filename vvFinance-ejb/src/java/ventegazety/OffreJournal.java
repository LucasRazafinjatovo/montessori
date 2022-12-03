package ventegazety;

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

public class OffreJournal extends ClassMAPTable{
  private String id;
  private String idoffre;
  private String idjournal;
  private double montant;
  public OffreJournal() {
    this.setNomTable("offrejournal");
  }
  public OffreJournal(String id,String idoffre,String idjournal,double montant) {
    this.setId(id);
    this.setIdoffre(idoffre);
    this.setIdjournal(idjournal);
    this.setMontant(montant);
    this.setNomTable("offrejournal");
  }
  public OffreJournal(String idoffre,String idjournal,double montant) {
   this.setIdoffre(idoffre);
   this.setIdjournal(idjournal);
   this.setMontant(montant);
   this.setNomTable("offrejournal");
  }
  public String getId()
  {
    return id;
  }
  public void setId(String id)
  {
    this.id=id;
  }
  public String getIdoffre()
  {
    return idoffre;
  }
  public void setIdoffre(String idoffre)
  {
    this.idoffre=idoffre;
  }
  public String getIdjournal()
  {
    return idjournal;
  }
  public void setIdjournal(String idjournal)
  {
    this.idjournal=idjournal;
  }
  public double getMontant()
  {
    return montant;
  }
  public void setMontant(double montant)
  {
    this.montant=montant;
  }
  public void construirePK(Connection c) throws Exception
  {
    this.preparePk("OFJ","GETSEQOFFREJOURNAL");
    this.setId(makePK(c));
  }
  public String getTuppleID(){
        return id;
    }
    public String getAttributIDName(){
        return "id";
    }
}