package finance;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import java.util.*;
import bean.ClassMAPTable;
public class MvtCaisseTvaHT extends ClassMAPTable{

  private String id;
  private java.sql.Date daty;
  private String designation;
  private double debit;
  private double credit;
  private double tva;
  private double ht;
  private String iddevise;
  private String idmode;
  private String idcaisse;
  private String remarque;
  private String agence;
  private String tiers;
  private String numpiece;
  private String typemvt;
  private java.sql.Date datyvaleur;
  private String idordre;
  private String numcheque;
  private String etablissement;

  public MvtCaisseTvaHT() {
    super.setNomTable("MVTCAISSETVAHT");
  }

  public String getTuppleID()
{
  return id;
}

public String getAttributIDName()
{
  return "id";
  }

  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setDesignation(String designation) {
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setDebit(double debit) {
    this.debit = debit;
  }
  public double getDebit() {
    return debit;
  }
  public void setCredit(double credit) {
    this.credit = credit;
  }
  public double getCredit() {
    return credit;
  }
  public void setIddevise(String iddevise) {
    this.iddevise = iddevise;
  }
  public String getIddevise() {
    return iddevise;
  }
  public void setIdmode(String idmode) {
    this.idmode = idmode;
  }
  public String getIdmode() {
    return idmode;
  }
  public void setIdcaisse(String idcaisse) {
    this.idcaisse = idcaisse;
  }
  public String getIdcaisse() {
    return idcaisse;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setAgence(String agence) {
    this.agence = agence;
  }
  public String getAgence() {
    return agence;
  }
  public void setTiers(String tiers) {
    this.tiers = tiers;
  }
  public String getTiers() {
    return tiers;
  }
  public void setNumpiece(String numpiece) {
    this.numpiece = numpiece;
  }
  public String getNumpiece() {
    return numpiece;
  }
  public void setTypemvt(String typemvt) {
    this.typemvt = typemvt;
  }
  public String getTypemvt() {
    return typemvt;
  }
  public void setDatyvaleur(java.sql.Date datyvaleur) {
    this.datyvaleur = datyvaleur;
  }
  public java.sql.Date getDatyvaleur() {
    return datyvaleur;
  }
  public void setIdordre(String idordre) {
    this.idordre = idordre;
  }
  public String getIdordre() {
    return idordre;
  }
  public void setNumcheque(String numcheque) {
    this.numcheque = numcheque;
  }
  public String getNumcheque() {
    return numcheque;
  }
  public void setEtablissement(String etablissement) {
    this.etablissement = etablissement;
  }
  public String getEtablissement() {
    return etablissement;
  }
  public double getTva() {
    return tva;
  }
  public void setTva(double tva) {
    this.tva = tva;
  }
  public double getHt() {
    return ht;
  }
  public void setHt(double ht) {
    this.ht = ht;
  }

}