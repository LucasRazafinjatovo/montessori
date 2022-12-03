package stock;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;



public class MvmtStock extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private String article;
  private String depot;
  private double reste;
  private String remarque;
  private double entree;
  private double sortie;
  private String typeMvt;
  private String idTypeMvt;
  private String client;


  public MvmtStock() {
     super.setNomTable("MvtStock");
  }
  public MvmtStock(java.sql.Date dt,String a,String dp,String rmq, double ent,String tpmvt,String idtpmvt)throws Exception{
    this.setDaty(dt);
    this.setArticle(a);
    this.setDepot(dp);
    this.setReste(0);
    this.setRemarque(rmq);
    this.setEntree(ent);
    this.setSortie(0);
    this.setTypeMvt(tpmvt);
    this.setIdTypeMvt(idtpmvt);
    super.setNomTable("MvtStock");
  }
  public MvmtStock(java.sql.Date dt,String a,String dp,String rmq, double entr)throws Exception{
    this.setDaty(dt);
    this.setArticle(a);
    this.setDepot(dp);
    this.setReste(0);
    this.setRemarque(rmq);
    this.setEntree(entr);
    this.setSortie(0);
    this.setTypeMvt("1");
    this.setIdTypeMvt("1");
    super.setNomTable("MvtStock");
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
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("MvtStock");
    this.preparePk("MVS","getSeqmvtStock"); // a revoir
    this.setId(makePK(c));
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
    /*Article dep = new Article();
    dep.setId(depot);
    Article[]liste=(Article[])CGenUtil.rechercher(dep,null,null,"");
    if(liste.length==0)throw new Exception("Article non existant");*/
    this.article = article;
  }
  public String getArticle() {
    return article;
  }
  public void setDepot(String depot)throws Exception {
    //if(depot.compareTo("")==0)throw new Exception("champ Depot vide");
   /* Depot dep = new Depot();
    dep.setId(depot);
    Depot[]liste=(Depot[])CGenUtil.rechercher(dep,null,null,"");
    if(liste.length==0)throw new Exception("Depot non existant");*/
    this.depot = depot;
  }
  public String getDepot() {
    return depot;
  }
  public void setReste(double montant)throws Exception {
  //if(montant<0)throw new Exception("montant doit etre positif");
    this.reste = montant;
  }
  public double getReste() {
    return reste;
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
  public String getClient() {
    return client;
  }
  public void setClient(String client) {
    this.client = client;
  }
}