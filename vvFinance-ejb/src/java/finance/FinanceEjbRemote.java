/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package finance;

import bean.ClassMAPTable;
import bean.ErreurDAO;
import bean.ResultatEtSomme;
import ded.Visa;
import historique.MapUtilisateur;
import java.rmi.RemoteException;
import java.sql.Connection;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface FinanceEjbRemote extends EJBObject{
    public String createCaisse(String descCaisse, String respCaisse, String etatCaisse, String refUser) throws Exception, RemoteException;
  public String createCaisseComptable(String descCaisse, String respCaisse, String etatCaisse, String comptable, String refUser) throws Exception;
  public String updateCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse, String refUser) throws ErreurDAO;
  public int deleteCaisse(String idCaisse, String refUser) throws ErreurDAO;
  public Caisse[] findCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse) throws ErreurDAO;
  public String mapperMouvementDepenseFacture(String numMvt, String numFact, String montant, Connection c, String refUser) throws Exception;
  public String mapperMouvementRecetteFacture(String numMvt, String numFact, String montant, Connection c, String refUser) throws Exception;
  public void validerMappageMouvement(String nomTable, String idMvt, Connection c, String refUser) throws Exception;
  public void validerMappage(String nomTable, String idMappage, Connection c, String refUser) throws Exception;
  public String createSortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String refUser, String parution, String agence, String prj, String part, String fact, String idLigne, Connection con) throws Exception;
  public String createSortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String refUser, String parution, String agence, String prj, String part, String fact, String idLigne) throws Exception;
  public String createSortie(String datee, String desi, String mont, String idDevise, String idMode, String idCaisse, String remarque, String agence, String projet, String numpiece, String idFacture, String idLigne, String refUser) throws Exception;
  public String updateSortie(String idSortie, String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String eta, String refUser, String prj, String part, String fact) throws ErreurDAO;
  public int deleteSortie(String idSortie, String refUser, String prj, String part, String fact) throws ErreurDAO;
  public Sortie[] findSortie(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat) throws ErreurDAO;
  public Sortie[] findSortieSourceCaissse(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String sourceC) throws ErreurDAO;
  public Sortie[] findSortieLettre(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String apresW) throws ErreurDAO;
  public Sortie[] findSortieAgence(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String idLigne) throws ErreurDAO;
  public SyntheseCompte[] findSyntheseCompteSortie(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception;
  public SyntheseCompte[] findSyntheseCompteEntree(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception;
  public SyntheseCompte[] findSyntheseCompteSortieType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception;
  public SyntheseCompte[] findSyntheseCompteEntreeType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception;
  public String createEntree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String refUser, String paru, String agence, String source, String prj, String part, String idLigne) throws Exception;
  public String updateEntree(String idEntree, String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String eta, String rem, String refUser, String prj, String part, String idLigne) throws ErreurDAO, Exception;
  public int deleteEntree(String idEntree, String refUser) throws ErreurDAO;
  public Entree[] findEntree(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String idDevise, String idEtat) throws ErreurDAO;
  public Entree[] findEntreeBenCaisse(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String benCaisse) throws ErreurDAO;
  public Entree[] findEntree(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat) throws ErreurDAO;
  public Entree[] findEntreeAgence(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agenc, String paru, String colonne, String ordre) throws ErreurDAO;
  public Entree[] findEntreePenalite(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat) throws ErreurDAO;
  public String verifEtatCaisse(String cais) throws ErreurDAO;
  public int annulerEntree(String idEntree, String refuser) throws ErreurDAO;
  public int annulerSortie(String idSortie, String refuser) throws ErreurDAO;
  public int verifExistFacture(String idObj, String typ) throws ErreurDAO;
  public ResultatEtSomme findVirement(String nomtable, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW, int numPage) throws Exception;
  public SaisieVirement[] findVirementNormale(String nomtable, String id, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW) throws Exception;
  public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String refUser) throws Exception;
  public void virerVirementMiltiple(String[] numCheque, String[] montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String refUser)throws Exception;
  public Visa viserVirement(String idVir, String daty, String rem, String refUser) throws Exception;
  public boolean virer(String daty, String caisse1, String caisse2, String montant, String remarque, String devise, String mode, String refUser, String typeE, String typeS, String prj, String part, String fact, String idLigne) throws Exception;
  public boolean reporter(String daty, String datyFin, String montant, String caisse, String devise, String refUser, String prj, String part, String fact, String idLigne) throws Exception;
  public Report[] findReport(String daty1, String daty2, String caisse, String devise) throws Exception;
  public EtatCaisseReste[] findEtatCaisseResteMvt(String daty1, String daty2, String caisse, String entite) throws Exception;
  public EtatCaisseReste[] findEtatCaisseReportMvt(String daty1, String daty2, String caisse, String entite) throws Exception;
  public ResultatEtSomme findReportPage(String daty1, String daty2, String caisse, String devise, int numP) throws Exception;
  public Report reporter(String daty, String montant, String caisse, String devise, String refUser) throws Exception;
  public double[] calculResteCaisse(String idCaisse, String daty1, String daty2);
  public Entree[] findEntreeLettre(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agenc, String paru, String colonne, String ordre, String prj, String part, String apresW) throws Exception;
  public Entree[] findEntreeLettrePage(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agenc, String paru, String colonne, String ordre, String prj, String part, String apresW, int numPa) throws Exception;
  public EtatCaisse[] findEtatCaisseDepense(String daty1, String daty2, String caisse, String benCaisse) throws Exception;
  public EtatCaisse[] findEtatCaisseEntree(String daty1, String daty2, String caisse, String benCaisse) throws Exception;
  public EtatCaisseReste[] findEtatCaisseReste(String dateDebut, String dateFin, String caisse, String entite) throws Exception;
  public String ventilerMvtCaisseDebit(String idMvt, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String nature, String refU) throws Exception;
  public MvtCaisse[] findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;
  public MvtCaisseLc[] findMvtCaisseLc(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception;
  public ResultatEtSomme findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, int numPage) throws Exception;
  public ResultatEtSomme findMvtCaisseLcPage(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;
  public Cheque createCheque(String mvt, String datyS, String datyV, String ord, String rem, String numC, String ca, String mont, String refU) throws Exception;
  public Cheque[] findCheque(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca) throws Exception;
  public String createMvtCaisseDepenseRetour(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idMvt, String refU) throws Exception;
  public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String refU) throws Exception;
  public String ventilerMvtCaisseLcDetailDepenseGroupe(String idDetLc, String idMvt, String rem, String montant, String refU) throws Exception;
  public String validerMvtCaisseLcDetailDepenseGroupe(String numMvtCaisse, String refU) throws Exception;
  public String retourVola(String idMvt, String idLcDet, String montant, String refU) throws Exception;
  public String annulerMvtDepense(String idMvt, String refU) throws Exception;
  public String createMvtCaisseDirecteDepense(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String refU) throws Exception;
  public String createMvtCaisseDirecteRecette(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String refU) throws Exception;
  public String createMvtCaisse(String daty, String datyValeur, String designation, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String refU) throws Exception;
  public String createDetailMvtCaisse(String deb, String crd, String tiers, String rem, String idMere, String paru, String numP, String refU) throws Exception;
  public DetailMvtCaisse[] findDetMvtCaisseParu(String id, String tiers, String rem, String idMere, String paruInf, String paruSup) throws Exception;
  public ResultatEtSomme findDetMvtCaisseParu(String tiers, String rem, String idMere, String paruInf, String paruSup, int numPage) throws Exception;
  public DetailMvtCaisse[] findDetMvtCaisse(String tiers, String rem, String idMere) throws Exception;
  public ResultatEtSomme findDetMvtCaisse(String tiers, String rem, String idMere, int numPage) throws Exception;
  public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String refU) throws Exception;
  public int create(ClassMAPTable value1, MapUtilisateur value2) throws java.lang.Exception;
  public int update(ClassMAPTable value1, MapUtilisateur value2) throws java.lang.Exception;
  public int delete(ClassMAPTable value1, MapUtilisateur value2) throws java.lang.Exception;
  public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String numCheque, String etabliss, String idmvtor,String refU) throws Exception;
  public MvtCaisseTous[] findMvtCaissetous(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;
  public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idmvtor,String refU) throws Exception;
  public Cheque[] findChequeEtat(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca, String etat) throws Exception;
  public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String refUser, String numCheque) throws Exception;
}
