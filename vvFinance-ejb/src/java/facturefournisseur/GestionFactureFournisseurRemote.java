/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

import bean.ResultatEtSomme;
import java.sql.Connection;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface GestionFactureFournisseurRemote extends EJBObject{
    public String createDetail(String nomTable, String idMere, String designation, String qte, String puHT, String rem, String refU) throws Exception;
  public String updateDetail(String nomTable, String id, String designation, String qte, String puHT, String rem, String refU) throws Exception;
  public Detail[] findDetail(String nomTable, String id, String idMere, String designation, String qte1, String qte2, String puHT1, String puHT2, String rem) throws Exception;
  public FactureFournisseur annulerFact(String nomTable, String nomTableLiaison, String id, String user) throws Exception;
  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception;
  public String createEntiteFact(String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String refUser) throws Exception;
  public String createEntiteFactFseur(String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String refUser) throws Exception;
  public String creerFactureFournisseur(String numFact, String designation, String dE, String dR, String idFrns, String idTVA, String mTTC, String rmq, String idDevise) throws Exception;
  public String cloturerFactureFournisseur(String designation, String dE, String dR, String idFrns, String mTHT, String idTVA, String mTTC, String rmq, String idP, String etat, String idDevise);
  public FactureFournisseur[] findFactureFournisseur(String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception;
  public ResultatEtSomme findFactureFournisseurPageLc(String nomtable, String id, String fourn, String designation, String numFact, String idLigne, String daty1, String daty2, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage, String colonne, String ordre) throws Exception;
  public ResultatEtSomme findFactureFournisseurPage(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW, int numPage) throws Exception;
  public FactureFournisseur[] findFactureFournisseur(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception;
  public Fournisseur[] findFournisseurF(String idF, String fournisseur, String nif, String stat, String tel, String email, String adresse, String apresW) throws Exception;
  public String createFournisseur(String fournisseur, String nif, String stat, String tel, String email, String adresse);
  public String cloturerFactureFournisseur(String idf, String numFact, String designation, String daty, String fournisseur, String montantHT, String tva, String montantTTC, String remarque, String etat, String projet, String dateemission, String idDevise) throws Exception;
  public String viserFactureF(String idFact, String remarque, Connection c, String refU) throws Exception;
  public String viserFactureF(String idFact, String remarque, String refU) throws Exception;
  public String viserFactureC(String idFact, String remarque, Connection c, String refU) throws Exception;
  public String viserFactureC(String idFact, String remarque, String refU) throws Exception;
}
