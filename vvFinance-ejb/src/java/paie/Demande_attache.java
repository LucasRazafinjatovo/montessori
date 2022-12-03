package paie;

import bean.ClassMAPTable;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Demande_attache extends ClassMAPTable
{
  private String id;
  private String ordrepaiement;
  private String iddemande;
  private String employe;
  private double montant;
  private java.sql.Date date_demande;
  private String motif;
  public Demande_attache()
  {
    super.setNomTable("demande_attache");
  }
  public Demande_attache(String ordrepaiement,String demande,String emp,double montant,java.sql.Date daty,String motif)
  {
    super.setNomTable("demande_attache");
    this.setOrdrepaiement(ordrepaiement);
    this.setIddemande(demande);
    this.setEmploye(emp);
    this.setMontant(montant);
    this.setDate_demande(daty);
    this.setMotif(motif);
  }
  public String getId()
  {
    return this.id;
  }
  public void setId(String id)
  {
    this.id = id;
  }
  public String getTuppleID()
  {
    return id;
  }
  public String getAttributIDName()
  {
    return "id";
  }
  public void  construirePK(Connection c)throws Exception
  {
    super.setNomTable("demande_attache");
    this.preparePk("DEMAT","getDemande_attache");
    this.setId(makePK(c));
  }
  public java.sql.Date getDate_demande() {
    return date_demande;
  }
  public void setDate_demande(java.sql.Date date_demande) {
    this.date_demande = date_demande;
  }
  public String getEmploye() {
    return employe;
  }
  public void setEmploye(String employe) {
    this.employe = employe;
  }
  public String getIddemande() {
    return iddemande;
  }
  public void setIddemande(String iddemande) {
    this.iddemande = iddemande;
  }
  public double getMontant() {
    return montant;
  }
  public String getMotif() {
    return motif;
  }
  public String getOrdrepaiement() {
    return ordrepaiement;
  }
  public void setOrdrepaiement(String ordrepaiement) {
    this.ordrepaiement = ordrepaiement;
  }
  public void setMotif(String motif) {
    this.motif = motif;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
}