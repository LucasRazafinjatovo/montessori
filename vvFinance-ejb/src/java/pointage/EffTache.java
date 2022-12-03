package pointage;

import bean.*;


public class EffTache extends ClassMAPTable {

  private String id;
  private String tache;
  private double taux;
  private String commentaire;
  private java.sql.Date daty;
  private int poste;
  public EffTache() {
    setNomTable("tacheEff");
  }
  public EffTache(String t,String ta,String comment,int p)throws Exception {
    setNomTable("tacheEff");
    this.setId(makePK("EFT","getSeqEffTache"));
    setTache(t);
    setTaux(ta);
    setCommentaire(comment);
    setDaty("");
    setPoste(p);
  }
  public void setDaty(String dat)
  {
    if(dat.compareTo("")==0)
      daty=utilitaire.Utilitaire.dateDuJourSql();
    else
      daty=utilitaire.Utilitaire.string_date("dd/MM/yyyy",dat);
  }
  public void setTaux(String to) throws Exception
  {
    int temp=0;
    if((to!=null)&&(to.compareTo("")!=0))
      temp=utilitaire.Utilitaire.stringToInt(to);
    if(temp<0 ||temp>100) throw new Exception("Valeur de taux incorrecte");
    taux=temp;
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
  public void setTache(String tache) {
    this.tache = tache;
  }
  public String getTache() {
    return tache;
  }
  public void setTaux(double taux) {
    this.taux = taux;
  }
  public double getTaux() {
    return taux;
  }
  public void setCommentaire(String commentaire) {
    this.commentaire = commentaire;
  }
  public String getCommentaire() {
    return commentaire;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setPoste(int poste) {
    this.poste = poste;
  }
  public int getPoste() {
    return poste;
  }
}