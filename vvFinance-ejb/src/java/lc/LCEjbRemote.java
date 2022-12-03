/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lc;

import bean.ResultatEtSomme;
import bean.UnionIntraTable;
import java.rmi.RemoteException;
import java.sql.Connection;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface LCEjbRemote extends EJBObject{
    public String createLC(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser) throws Exception, RemoteException;
  public String createDetailLc(String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact, String refU) throws Exception, RemoteException;
  public String valideDetailLc(String idLC, String refU) throws Exception, RemoteException;
  public String updateDetailLc(String id, String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact, String refU) throws Exception, RemoteException;
  public LcDetail[] findDetailLc(String id, String idLC, String compteDet, String etat) throws Exception, RemoteException;
  public LcDetail[] findDetailLcLigneCredit(String id, String idLC, String compteDet, String etat, String typeLc, String compte, String ent, String dir, String mois1, String mois2, String annee, String paru) throws Exception, RemoteException;
  public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup, String nomTable, String refUser) throws Exception, RemoteException;
  public String createLCe(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser) throws Exception, RemoteException;
  public String copierLC(String idLigneToCopy, String idEntite, String iddirection, String mois, int annee, String rmq, String refUser) throws Exception, RemoteException;
  public String createDirection(String libelledir, String descdir, double idDirecteur, String abbrevDir, String refUser) throws Exception, RemoteException;
  public String updateDirection(String idToUpdate, String libelledir, String descdir, double idDirecteur, String abbrevDir, String refUser) throws Exception, RemoteException;
  public void updateLC(LigneCredit l, String refUser) throws Exception, RemoteException;
  public String updateCreditLC(String idLigne, double newCredit, String motif, String refUser) throws Exception, RemoteException;
  public Direction[] findDirection(String idDir, String libelledir, String descdir, String abbrevDir, String idDirecteur) throws Exception, RemoteException;
  public LigneCredit[] findLC(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable) throws Exception, RemoteException;
  public ResultatEtSomme findLCPage(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable, int numPage) throws Exception, RemoteException;
  public LigneCreditComplet[] findLCComplet(String idLigne, String designation, String mois, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception, RemoteException;
  public LigneCreditComplet[] findFCC(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception, RemoteException;
  public LigneCreditComplet[] findFCCParution(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String paruInf, String paruSup, String nomTable) throws Exception, RemoteException;
  public void validerMappageFactureLC(String nomTable, String numFact, String refUser) throws Exception, RemoteException;
  public void validerMappage(String nomTable, String numMap, String refUser) throws Exception, RemoteException;
  public void validerMappage(String nomTable, String numMap, String refUser, Connection c) throws Exception, RemoteException;
  public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, String refUser) throws Exception, RemoteException;
  public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, String refUser, Connection c) throws Exception, RemoteException;
  public void validerMappageLCMFactureRecette(String nomTable, String idMere, String refUser) throws Exception, RemoteException;
  public void validerMappageLCMFacture(String nomTable, String idMere, String refUser) throws Exception, RemoteException;
  public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere, String refUser) throws Exception, RemoteException;
  public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere, String refUser) throws Exception, RemoteException;
  public void validerMappageLCMOp(String nomTable, String idMere, String refUser) throws Exception, RemoteException;
  public void validerMappageLCM(String nomTable, String[] idMappage, String refUser) throws Exception, RemoteException;
  public UnionIntraTable validerMappageLCMavecOp(String nomTable, String idMere, String idOp, String refUser) throws Exception, RemoteException;
  public void validerMappageLC(String nomTable, String idMappage, String refUser) throws Exception, RemoteException;
  public void validerMappageLC(String nomTable, String idMappage, Connection c, String refUser) throws Exception, RemoteException;
  public void validerMappageOpFlc(String nomTable, String idMappage, Connection c, String refUser) throws Exception, RemoteException;
  public String mapperDepenseLC(String idSortie, String idLC, String rem, String montant, String refUser) throws Exception, RemoteException;
  public String mapperRecettesLC(String idEntree, String idLC, String rem, String montant, String refUser) throws Exception, RemoteException;
  public String mapperFactureLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception, RemoteException;
  public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception, RemoteException;
  public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception, RemoteException;
  public String mapperPrevisionRecetteLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception, RemoteException;
  public String mapperFactureFournisseurLCTableau(String idFacture, String[] idLC, String rem, String[] montant, String refUser) throws Exception, RemoteException;
  public String mapperFactureClientLCTableau(String idFacture, String[] idLC, String rem, String[] montant, String refUser) throws Exception, RemoteException;
  public String mapperFactureFournisseurLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception, RemoteException;
  public String mapperFactureClientLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception, RemoteException;
  public boolean deleteUnionIntraTable(String nomtable, String id, String refU) throws Exception, RemoteException;
  public boolean deleteUnionIntraTableLcOp(String nomtable, String nomTable2, String id, String refU) throws Exception, RemoteException;
  public String updateMontantUnionIntra(String nomTable, String id1, String[] id2, String[] montant, String refUser) throws Exception, RemoteException;
  public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant, String refUser) throws Exception, RemoteException;
  public String updateMontantUnionIntraLcPrev(String nomTable, String id1, String[] id2, String[] montant, String refUser) throws Exception ;
  public void validerMappageLCPrevRecControle(String nomTable, String idMere, String idprev, String refUser) throws Exception ;
  public String copierLCRecette(String mois, String annee, String mois0, int annee0, String refUser) throws Exception, RemoteException;
  public String copierLC(String mois, String annee, String mois0, int annee0, String nomTable, String refUser) throws Exception, RemoteException;
  public String updateLC(String idLigne, String designation, String creditIni, String creditMod, String typeLigne, String numCompte, String entite, String dir, String mois, String annee, String nomTable, String refUser) throws Exception, RemoteException;
  public String copierLCRecette(String mois, String annee, String mois0, int annee0, String nomTable, String refUser) throws Exception, RemoteException;
  public String createLCRecette(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String rmq, String refUser) throws Exception, RemoteException;
  public String verifLCPrev(String idprev,String refUser)throws Exception;
	public double[][] calculResultat(LigneCreditNature[] lc) throws Exception;
public double[][] calculResultatRD(LigneCreditNature[] lc) throws Exception;
	public void dupliquerLC(String numObjet,String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable, String refUser) throws Exception;
public void dupliquerLCMultiple(String[] ids,String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable, String refUser) throws Exception;

}
