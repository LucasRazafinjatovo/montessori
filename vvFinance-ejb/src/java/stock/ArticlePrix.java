package stock;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import bean.*;

public class ArticlePrix extends ClassMAPTable {

  private String id;
  private String article;
  private double montant;
  private Date dateffective;

  private String description;
  public ArticlePrix() {
    super.setNomTable("LINK_ARTICLEPRIX");
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setArticle(String codeArticle) {
    this.article = codeArticle;
  }
  public String getCodeArticle() {
    return article;
  }

  public void setMontant(double montant) throws Exception{
     if(montant<0) throw new Exception("montant negatif");
     this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public Date getDateffective() {
    return dateffective;
  }
  public String getDescription() {
    return description;
  }
  public String getArticle() {
    return article;
  }

  public void setDateffective(Date dateffective) {
    this.dateffective = dateffective;
  }
  public void setDescription(String description) {
    this.description = description;
  }
  public static double getArticlePrix(String idarticle)throws Exception{
    ArticlePrix art = new ArticlePrix();
    art.setArticle(idarticle);
    ArticlePrix[] list = (ArticlePrix[])CGenUtil.rechercher(art,null,null,"");
    return list[0].getMontant();
  }
}
