package finance;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ScatService extends facture.SCatService{

  private String idscatservice;
  private String nomscatservice;
  private String idcategorie;
  public ScatService() {
    super.setNomTable("scatservice");
  }
  public String getIdscatservice() {
    return idscatservice;
  }
  public void setIdscatservice(String idscatservice) {
    this.idscatservice = idscatservice;
  }
  public void setNomscatservice(String nomscatservice) {
    this.nomscatservice = nomscatservice;
  }
  public String getNomscatservice() {
    return nomscatservice;
  }
  public void setIdcategorie(String idcategorie) {
    this.idcategorie = idcategorie;
  }
  public String getIdcategorie() {
    return idcategorie;
  }
}