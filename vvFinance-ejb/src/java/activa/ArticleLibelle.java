package activa;

public class ArticleLibelle extends Article{
  private String typearticle;
  private int nombrerame;
  public ArticleLibelle() {
    super.setNomTable("articleavectype");
  }
  public String getTypearticle() {
    return typearticle;
  }
  public void setTypearticle(String typearticle) {
    this.typearticle = typearticle;
  }
  public void setNombrerame(int nombrerame) {
    this.nombrerame = nombrerame;
  }
  public int getNombrerame() {
    return nombrerame;
  }
}