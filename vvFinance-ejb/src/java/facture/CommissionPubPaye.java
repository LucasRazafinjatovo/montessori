package facture;
import bean.*;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class CommissionPubPaye extends ClassMAPTable{

  private String id;
  private String factclient;
  private String client;
  private String numcompte;
  public CommissionPubPaye() {
    this.setNomTable("commissionpubpaye");
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("commissionpubpaye");
     this.preparePk("CPP","GETSEQCOMMISSIONPUBPAYE");
     this.setId(makePK(c));
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setFactclient(String factclient) {
    this.factclient = factclient;
  }
  public String getFactclient() {
    return factclient;
  }
  public void setClient(String client) {
    this.client = client;
  }
  public String getClient() {
    return client;
  }
  public void setNumcompte(String numcompte) {
    this.numcompte = numcompte;
  }
  public String getNumcompte() {
    return numcompte;
  }
}