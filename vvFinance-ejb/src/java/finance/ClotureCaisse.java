package finance;

import bean.*;
import java.sql.Connection;


public class ClotureCaisse extends ClassMAPTable {
  private String id;
  private String objet;
  private java.sql.Date daty;
  private String remarque;
  private java.sql.Date datysaisie;
  private String typeobjet;
  public ClotureCaisse()
  {
     super.setNomTable("cloture");
  }
  public ClotureCaisse(String i,String idC,java.sql.Date d,String r)
  {
    super.setNomTable("cloture");
    setId(i);
    setObjet(idC);
    setDaty(d);
    setRemarque(r);
  }
  public void construirePK(Connection c) throws Exception
  {
    super.setNomTable("cloture");
    this.preparePk("CCC","getseqCloture");
    this.setId(makePK(c));
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
  public void setObjet(String objet) {
    this.objet = objet;
  }
  public String getObjet() {
    return objet;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setDatysaisie(java.sql.Date datysaisie) {
    this.datysaisie = datysaisie;
  }
  public java.sql.Date getDatysaisie() {
    return datysaisie;
  }
  public void setTypeobjet(String typeobjet) {
    this.typeobjet = typeobjet;
  }
  public String getTypeobjet() {
    return typeobjet;
  }
}