package pub;

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

public class Montant extends ClassMAPTable {

  public Montant() {
    super.setNomTable("montant");
  }
  String id;
  private String idgazety;
  private int couleur;
  private String taille;
  private double mont;
  private int page;
  public void construirePK(Connection c) throws Exception
  {
      super.setNomTable("Montant");
      this.preparePk("TRF","getSeqMontant");
      this.setId(makePK(c));
  }
  public void controler(Connection c)throws Exception
  {
    if(getTaille()==null||getTaille().compareToIgnoreCase("")==0)throw new Exception("Taille non valide");
    if(getMont()<0) throw new Exception("Montant non valide");
    if(getCouleur()<0||getCouleur()>4)throw new Exception("Couleur non valide");
    Montant temp=this;
    Montant crt=new Montant();
    crt.setTaille(temp.getTaille());
    crt.setIdgazety(temp.getIdgazety());
    if(CGenUtil.rechercher(crt,null,null,c," and couleur="+temp.getCouleur()+" and page="+temp.getPage()).length>0)throw new Exception("Tarif deja existant");
  }
  public void controlerUpdate(Connection c)throws Exception
    {
      Montant temp=this;
      Montant crt=new Montant();
      crt.setTaille(temp.getTaille());
      crt.setIdgazety(temp.getIdgazety());
      Montant[] r=(Montant[])CGenUtil.rechercher(crt,null,null,c," and couleur="+temp.getCouleur()+" and page="+temp.getPage());
      if(r.length>1)throw new Exception("Tarif deja existant");
      if(r.length==1)
      {
        int g=r[0].getId().compareToIgnoreCase(getId());
        if(g!=0)
        {
          throw new Exception("Tarif deja existante");
        }
      }
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setIdgazety(String idgazety) {
    this.idgazety = idgazety;
  }
  public String getIdgazety() {
    return idgazety;
  }
  public void setCouleur(int couleur) {
    this.couleur = couleur;
  }
  public int getCouleur() {
    return couleur;
  }
  public void setTaille(String taille) {
    this.taille = taille;
  }
  public String getTaille() {
    return taille;
  }
  public void setMont(double mont) {
    this.mont = mont;
  }
  public double getMont() {
    return mont;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setPage(int page) {
    this.page = page;
  }
  public int getPage() {
    return page;
  }
}