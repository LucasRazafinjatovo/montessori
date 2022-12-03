package finance;
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

public class EtatRapprochement extends ClassMAPTable{

  private String id;
  private String idmvt;
  private String rapprochement;
  public EtatRapprochement() {
    super.setNomTable("etatrapprochement");
  }
  public EtatRapprochement(String idmvt, String rap) throws Exception
 {
    super.setNomTable("etatrapprochement");
    this.preparePk("ETR","getSeqEtatRapprochement");
    this.setId(makePK());
    setIdmvt(idmvt);
    setRapprochement(rap);
 }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("etatrapprochement");
    this.preparePk("ETR","getSeqEtatRapprochement");
    this.setId(makePK(c));
  }
  public String getAttributIDName(){
        return "id";
  }
  public String getTuppleID(){
        return id;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdmvt(String idmvt) {
    this.idmvt = idmvt;
  }
  public String getIdmvt() {
    return idmvt;
  }
  public void setRapprochement(String rapprochement) {
    this.rapprochement = rapprochement;
  }
  public String getRapprochement() {
    return rapprochement;
  }
}