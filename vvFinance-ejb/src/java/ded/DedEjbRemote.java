/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import bean.ResultatEtSomme;
import facturefournisseur.FactureFournisseur;
import java.rmi.RemoteException;
import java.sql.Connection;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface DedEjbRemote extends EJBObject{
  public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String refU) throws Exception;
  public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String typeprevu,String refU) throws Exception;

  public String creerOrResp(String daty, String idDed, String mont, String eta, String remarque,String resp, String refU) throws Exception;
  public String createDed(String desi, String daty, String mtht, String tax, String rem, String tiers, String idLigne, String refU) throws Exception;
  public String ventilerDed(String idDed, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String refU) throws Exception;
  public Ded[] findDed(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne) throws Exception;
  public DedLc[] findDedLc(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception;
  public ResultatEtSomme findDedPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, int numPage) throws Exception;
  public ResultatEtSomme findDedLcPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;
  public String creerOpDirecte(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque, String refU) throws Exception;
  public String creerOpDirecteSansVisa(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque, String refU) throws Exception;
  public String creerOr(String daty, String idDed, String mont, String eta, String remarque, String refU) throws Exception;
  public String creerOr(String daty, String idDed, String mont, String eta, String remarque, String typeprevu,String refU) throws Exception;

  public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String refU) throws Exception;
  public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String typePrevu, String datePaiement, String remarquePaiement, String refU) throws Exception;
  public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String prev, String refU) throws Exception;
  public FactureFournisseur createOrSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception;
  public OrdonnerPayement annulerOp(String nomTable, String nomTableLiaison, String id, String user) throws Exception;
  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception;
  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem,String typeprevu, String refU) throws Exception;
  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem,String typeprevu,String datePaiement, String remarquePaiement, String refU) throws Exception;
  public String creerOR(String daty, String ligne, String mont, String eta, String refU) throws Exception;
  public String creerOR(String ded, String ligne, String dt, String mont, String rem, String eta, String refU) throws Exception;
  public String viserOr(String daty, String remarque, String idObjet, String refU) throws Exception;
  public String viserOpDed(String daty, String remarque, String idDed, String refU) throws Exception;
  public String viserOp(String daty, String remarque, String idObjet, String refU) throws Exception;
  public String ventilerOp(String idOp, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String refU) throws Exception;
  public OrdonnerPayement[] findOp(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception;
  public OrdonnerPayement[] findOr(String id, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception;
  public ResultatEtSomme findOpPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;
  public ResultatEtSomme findOpPage(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;
  public ResultatEtSomme findOpPageLc(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String etat, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage) throws Exception;
  public ResultatEtSomme findOrPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;
  public ResultatEtSomme findOrPage(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;
  public ResultatEtSomme findPrevPage(String nomtable, String id, String description, String idLigne, String daty1, String daty2, String montant1, String mont2, String rang, int numPage) throws Exception;

  public String viserDed(String daty, String remarque, String idObjet, String refU) throws Exception;
  public String updateDed(String idDed, String desi, String daty, String mtht, String tax, String rem, String tiers, String refU) throws Exception;
  public String updateOp(String id, String daty, String mont, String refU) throws Exception;
  public OpLc[] findOpLc(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception;
  public ResultatEtSomme findOpLcPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;
  public ResultatEtSomme findOpLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;
  public ResultatEtSomme findOrLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;
  public String degagerDed(String idDed, String refU) throws Exception;
  public String degagerOp(String idOp, String refU) throws Exception;
  public String degagerMvtCaisse(String idMvt, String refU) throws Exception;
  public int reporterOp(String nomTable,String[] idOp, String[] rep, String refU) throws Exception;
  public int dupliquerOP(String numObjet,String[] montantTab,int n_dupl,String[] lmois,String[] lannee,String[] ldate, String refU)throws Exception;
  public String updateOpVita(String nomtable,String nomtable2,String idornew,String idorancien,String refUser) throws Exception;
  public int dupliquerOR(String numObjet,String[] montantTab,int n_dupl,String[] lmois,String[] lannee,String[] ldate, String refU)throws Exception;
  public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String typeprevu, String refU, Connection c) throws Exception;
  public String updateOrdre(String nomtable, String idordre, double sommeCommission, String refUser)throws Exception;
}
