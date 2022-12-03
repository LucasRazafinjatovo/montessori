package prevision;
import bean.*;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import  utilitaire.Utilitaire;
public class PrevdejaOP extends ClassMAPTable{

  private String id;
  private String idop;
  private String idprev;
  private Date datycreation;

  public PrevdejaOP() {
    this.setNomTable("previsiondejaop");
  }
  public PrevdejaOP(String op, String prev, Date datyc) {
   this.setNomTable("previsiondejaop");
   this.setIdop(op);
   this.setIdprev(prev);
   this.setDatycreation(datyc);
  }
  public PrevdejaOP(String op, String prev) throws Exception{
   this.setNomTable("previsiondejaop");
   this.preparePk("POP","getSeqPrevisionDejaop");
   this.setId(makePK());
   this.setIdop(op);
   this.setIdprev(prev);
   this.setDatycreation(Utilitaire.dateDuJourSql());
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("Previsiondejaop");
    this.preparePk("POP","getSeqPrevisionDejaop");
    this.setId(makePK(c));
  }
  public String getAttributIDName()
    {
        return "id";
    }

    public String getTuppleID()
    {
        return id;
    }
  public String getIdop() {
    return idop;
  }
  public String getId() {
    return id;
  }
  public Date getDatycreation() {
    return datycreation;
  }
  public void setDatycreation(Date datycreation) {
    this.datycreation = datycreation;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setIdop(String idop) {
    this.idop = idop;
  }
  public String getIdprev() {
    return idprev;
  }
  public void setIdprev(String idprev) {
    this.idprev = idprev;
  }
}
