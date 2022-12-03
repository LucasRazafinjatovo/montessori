package finance;

import bean.*;
import utilitaire.Utilitaire;
import facture.Compte;
import facture.FactureEjbLocal;
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

public class MvtCaisse_tdp extends ClassMAPTable {

  public String id;
  public java.sql.Date daty;
  public java.sql.Date date_paiement;
  public String designation;
  public double debit;
  public double credit;
  public String idDevise;
  public String idMode;
  public String idCaisse;
  public String remarque;
  public String agence;
  public String tiers;
  public String numPiece;
  public String typeMvt;
  public java.sql.Date datyValeur;
  public String idOrdre;
  private String numcheque;
  private String etablissement;
  private String idmvtor;
  private String typee;
  public MvtCaisse_tdp() {
    super.setNomTable("mvtcaisse");
  }

  public MvtCaisse_tdp(String daty,String datyValeur,String designation,String debit,String credit,String idDevise,String idMode,String idCaisse,String remarque,String agence,String tiers,String numpiece,String typ,String idOrdre)
  {
    setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    setDesignation(designation);
    setCredit(Utilitaire.stringToDouble(credit));
    setDebit(Utilitaire.stringToDouble(debit));
    setIdDevise(idDevise);
    setIdMode(idMode);
    setIdCaisse(idCaisse);
    setRemarque(remarque);
    setAgence(agence);
    setTiers(tiers);
    this.setDatyValeur(Utilitaire.string_date("dd/MM/yyyy",datyValeur));
    this.setTypeMvt(typ);
    this.setNumPiece(numpiece);
    setIdOrdre(idOrdre);
    setNomTable("mvtCaisse");
    setIndicePk("MVT");
    setNomProcedureSequence("getSeqMvt");
    this.setId(makePK());
  }
  public MvtCaisse_tdp(String id,String daty,String datyValeur,String designation,String debit,String credit,String idDevise,String idMode,String idCaisse,String remarque,String agence,String tiers,String numpiece,String typ,String idOrdre)
  {
    setNomTable("mvtCaisse");
    setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
    this.setDatyValeur(Utilitaire.string_date("dd/MM/yyyy",datyValeur));
    setDesignation(designation);
    setCredit(Utilitaire.stringToDouble(credit));
    setDebit(Utilitaire.stringToDouble(debit));
    setIdDevise(idDevise);
    setIdMode(idMode);
    setIdCaisse(idCaisse);
    setRemarque(remarque);
    setAgence(agence);
    setTiers(tiers);
    setIdOrdre(idOrdre);
    this.setTypeMvt(typ);
    this.setId(id);
  }

   public MvtCaisse_tdp(String id,String daty,String datyValeur,String designation,String debit,String credit,String idDevise,String idMode,String idCaisse,String remarque,String agence,String tiers,String numpiece,String typ,String idOrdre,String idmvtor)
      {
        setDaty(Utilitaire.string_date("dd/MM/yyyy",daty));
        setDesignation(designation);
        setCredit(Utilitaire.stringToDouble(credit));
        setDebit(Utilitaire.stringToDouble(debit));
        setIdDevise(idDevise);
        setIdMode(idMode);
        setIdCaisse(idCaisse);
        setRemarque(remarque);
        setAgence(agence);
        setTiers(tiers);
        this.setDatyValeur(Utilitaire.string_date("dd/MM/yyyy",datyValeur));
        this.setTypeMvt(typ);
        this.setNumPiece(numpiece);
        this.setIdmvtor(idmvtor);
        setIdOrdre(idOrdre);
        setNomTable("mvtCaisse");
        setIndicePk("MVT");
        setNomProcedureSequence("getSeqMvt");
        this.setId(makePK());
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public static void main(String[] args) {
    MvtCaisse mvtCaisse1 = new MvtCaisse();
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
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
  public void setIdDevise(String idDevise) {
    this.idDevise = idDevise;
  }
  public String getIdDevise() {
    return idDevise;
  }
  public void setIdMode(String idMode) {
    this.idMode = idMode;
  }
  public String getIdMode() {
    return idMode;
  }
  public void setIdCaisse(String idCaisse) {
    this.idCaisse = idCaisse;
  }
  public String getIdCaisse() {
    return idCaisse;
  }

  public Caisse getCaisse(Connection c) throws Exception
  {
    Caisse[]ca=(Caisse[])new CaisseUtil().rechercher(1,this.getIdCaisse(),c);
    if(ca.length==0) throw new Exception ("caisse non existante");
    return ca[0];
  }
  public String getNatureMvt()
  {
    if(this.getCredit()!=0&&this.getDebit()==0)
      return "credit";
    if(this.getCredit()==0&&this.getDebit()!=0)
      return "debit";
    return "normal";
  }
  public Caisse getCaisse() throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return getCaisse(c);
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null)c.close();
    }
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
  public void setNumPiece(String numPiece) {
    this.numPiece = numPiece;
  }
  public String getNumPiece() {
    return numPiece;
  }
  public void setTypeMvt(String typeMvt) {
    this.typeMvt = typeMvt;
  }
  public String getTypeMvt() {
    return typeMvt;
  }
  public java.sql.Date getDatyValeur() {
    return datyValeur;
  }
  public void setDatyValeur(java.sql.Date datyValeur) {
    this.datyValeur = datyValeur;
  }
  public String[] creerEcriture()throws Exception
  {
    FactureEjbLocal fel=facture.RecupLocalHome.recupFactureHome().create();
    Compte compteCaisse = fel.findCompte("%", "%", this.getIdCaisse(), Utilitaire.dateDuJour())[0];
    Compte compteTier=fel.findCompte("%", "%", this.getTiers(), Utilitaire.dateDuJour())[0];
    //facture.RecupLocalHome.recupFactureHome().create().createEcritureConnection(Utilitaire.dateDuJour(), compteCaisse.getId(), "mvt ".concat(String.valueOf(String.valueOf(desi))), String.valueOf(mont), "0", c.getTuppleID(), refUser, con);
    //facture.RecupLocalHome.recupFactureHome().create().createEcritureConnection(Utilitaire.dateDuJour(), compteTier.getId(), "mvt ".concat(String.valueOf(String.valueOf(desi))), "0", String.valueOf(mont), c.getTuppleID(), refUser, con);
    return null;
  }
  public String getIdOrdre() {
    return idOrdre;
  }
  public void setIdOrdre(String idOrdre) {
    this.idOrdre = idOrdre;
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
  public void setIdmvtor(String idmvtor) {
    this.idmvtor = idmvtor;
  }
  public String getIdmvtor() {
    return idmvtor;
  }
  public java.sql.Date getDate_paiement() {
    return date_paiement;
  }
  public void setDate_paiement(java.sql.Date date_paiement) {
    this.date_paiement = date_paiement;
  }
  public String getTypee() {
    return typee;
  }
  public void setTypee(String typee) {
    this.typee = typee;
  }
}