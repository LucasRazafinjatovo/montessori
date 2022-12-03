package stock;
import bean.*;
import java.sql.Connection;
//import produit.*;
import java.sql.Date;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class MvtStock2 extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private String article;
  private String depot;
  private double montant;
  private String remarque;
  private double entree;
  private double sortie;
  private String typeMvt;
  private String idTypeMvt;
  private String client;


  public MvtStock2() {
     super.setNomTable("LINK_MVTSTOCK");
  }
  public String getId() {
    return id;
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setArticle(String article)throws Exception {
    if(article.compareTo("")==0)throw new Exception("champ article vide");
    this.article = article;
  }
  public String getArticle() {
    return article;
  }
  public void setDepot(String depot)throws Exception {
    this.depot = depot;
  }
  public String getDepot() {
    return depot;
  }
  public void setMontant(double montant)throws Exception {
  if(montant<0)throw new Exception("montant doit etre positif");
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setRemarque(String remarque)throws Exception {
     this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setEntree(double entree)throws Exception {
    if(entree<0)throw new Exception("entree doit etre positif");
    this.entree = entree;
  }
  public double getEntree() {
    return entree;
  }
  public void setSortie(double sortie)throws Exception {
    //if(sortie<0)throw new Exception("sortie doit etre positif");
    this.sortie = sortie;
  }
  public double getSortie() {
    return sortie;
  }
  public void setTypeMvt(String typeMvt) {
    this.typeMvt = typeMvt;
  }
  public String getTypeMvt() {
    return typeMvt;
  }
  public void setIdTypeMvt(String idTypeMvt) {
    this.idTypeMvt = idTypeMvt;
  }
  public String getIdTypeMvt() {
    return idTypeMvt;
  }


  /*public static Etatstocksommevue[] getInfoStockByArticle(String idArticle,String date)throws Exception{

    Etatstocksommevue article = new Etatstocksommevue();
    String apw = " and article like '%" + idArticle + "%'";
    Etatstocksommevue[] liste = (Etatstocksommevue[])CGenUtil.rechercher(article,null,null,apw);
    Date dmvt = utilitaire.Utilitaire.string_date("dd/MM/yyyy",date);

    Etatstocksommevue drnmvt = new Etatstocksommevue();

    double sommeentree = 0;
    double sommesortie = 0;

    for(int i = 0; i < liste.length; i++){
      if(liste[i].getDatemvt().before(dmvt)){
        sommeentree += liste[i].getEntree();
        sommesortie += liste[i].getSortie();
      }else{
        drnmvt.setEntree(liste[i].getEntree());
        drnmvt.setSortie(liste[i].getSortie());
      }
    }
    Etatstocksommevue statebefore = new Etatstocksommevue();
    statebefore.setReste(sommeentree - sommesortie);
    Etatstocksommevue[] ret = {statebefore,drnmvt};
    return ret;
  }*/
  public String getClient() {
    return client;
  }
  public void setClient(String client) {
    this.client = client;
  }
}