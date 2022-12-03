package stock;
import bean.ClassMAPTable;
import java.sql.Connection;
import bean.*;

public class ArticleBL extends ClassMAPTable {
        private String id;
        private String article;
        private double quantite;
        private double prixunitaire;
        private String designation;
        private String lcunique;
        private String idmere;

        public ArticleBL() {
                super.setNomTable("articlebl");
        }
        public String getAttributIDName() {
                return "id";
        }
        public void construirePK(Connection c) throws Exception{
                super.setNomTable("articlebl");
                this.preparePk("ABL","getSeqArticleBL");
                this.setId(makePK(c));
        }
        public String getTuppleID() {
          return id;
  }

        public String getArticle(){
                return this.article;
        }
        public void setArticle(String article) throws Exception{
                this.article = article;
        }
        public double getQuantite(){
                return this.quantite;
        }
        public void setQuantite(double quantite) throws Exception{
          if(quantite<0) throw new Exception("quantite negatif ou null");
                this.quantite = quantite;
        }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public double getPrixunitaire() {
    return prixunitaire;
  }
  public void setPrixunitaire(double prixunitaire) throws Exception{
    if(prixunitaire<0) throw new Exception("prix unitaire doit etre positif");
    this.prixunitaire = prixunitaire;
  }
  public void setIdmere(String idmere) {
    this.idmere = idmere;
  }
  public String getIdmere() {
    return idmere;
  }
  public String getDesignation() {
    return designation;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public static ArticleBL[] getArticleBLByIdMere(String idobjet){
    try{
      ArticleBL abl = new ArticleBL();
      String apw = " and idmere like '%"+idobjet+"%'";
      ArticleBL[] ret = (ArticleBL[])CGenUtil.rechercher(abl,null,null,apw);
      return ret;
    }catch(Exception ex){
      ex.printStackTrace();
    }
    return null;
  }
  public static ArticleBL[] getNumLC(String idBL){
   ArticleBL art = new ArticleBL();
   art.setNomTable("articlebl");
   art.setIdmere(idBL);
   ArticleBL[] listelc = null;
   try{
     ArticleBL[] a = (ArticleBL[])bean.CGenUtil.rechercher(art,null,null,"");
     listelc = new ArticleBL[a.length];
     for(int i = 0; i < a.length; i++){
       listelc[i] = new ArticleBL();
       listelc[i].setLcunique(a[i].getLcunique());
       listelc[i].setPrixunitaire(a[i].getQuantite()*a[i].getPrixunitaire());
     }
   }catch(Exception ex){
     ex.printStackTrace();
   }
   return listelc;
  }
  public String getLcunique() {
    return lcunique;
  }
  public void setLcunique(String lcunique) {
    this.lcunique = lcunique;
  }
}