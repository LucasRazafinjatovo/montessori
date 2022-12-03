package lc;

import java.rmi.RemoteException;

import javax.ejb.EJBObject;
import java.util.*;
import java.sql.Connection;
import bean.*;
import javax.ejb.Local;

@Local
public interface LCEjb{
  public String createLC(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser) throws Exception;
  public String createDetailLc(String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact, String refU) throws Exception;
  public String valideDetailLc(String idLC, String refU) throws Exception;
  public String updateDetailLc(String id, String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact, String refU) throws Exception;
  public LcDetail[] findDetailLc(String id, String idLC, String compteDet, String etat) throws Exception;
  public LcDetail[] findDetailLcLigneCredit(String id, String idLC, String compteDet, String etat, String typeLc, String compte, String ent, String dir, String mois1, String mois2, String annee, String paru) throws Exception;
  public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup, String nomTable, String refUser) throws Exception;
  public String createLCe(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser) throws Exception;
  public String copierLC(String idLigneToCopy, String idEntite, String iddirection, String mois, int annee, String rmq, String refUser) throws Exception;
  public String createDirection(String libelledir, String descdir, double idDirecteur, String abbrevDir, String refUser) throws Exception;
  public String updateDirection(String idToUpdate, String libelledir, String descdir, double idDirecteur, String abbrevDir, String refUser) throws Exception;
  public void updateLC(LigneCredit l, String refUser) throws Exception;
  public String updateCreditLC(String idLigne, double newCredit, String motif, String refUser) throws Exception;
  public Direction[] findDirection(String idDir, String libelledir, String descdir, String abbrevDir, String idDirecteur) throws Exception;
  public LigneCredit[] findLC(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable) throws Exception;
  public ResultatEtSomme findLCPage(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable, int numPage) throws Exception;
  public String mapperPrevisionRecetteLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception;
  public String mapperPrevisionDepenseLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception;
  public LigneCreditComplet[] findLCComplet(String idLigne, String designation, String mois, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception;
  public LigneCreditComplet[] findFCC(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception;
  public LigneCreditComplet[] findFCCParution(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String paruInf, String paruSup, String nomTable) throws Exception;
  public void validerMappageFactureLC(String nomTable, String numFact, String refUser) throws Exception;
  public void validerMappage(String nomTable, String numMap, String refUser) throws Exception;
  public void validerMappage(String nomTable, String numMap, String refUser, Connection c) throws Exception;
  public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, String refUser) throws Exception;
  public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, String refUser, Connection c) throws Exception;
  public void validerMappageLCMFactureRecette(String nomTable, String idMere, String refUser) throws Exception;
  public void validerMappageLCMFacture(String nomTable, String idMere, String refUser) throws Exception;
  public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere, String refUser) throws Exception;
  public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere, String refUser,Connection c) throws Exception;
 
  public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere, String refUser) throws Exception;
  public void validerMappageLCMOp(String nomTable, String idMere, String refUser) throws Exception;
  public void validerMappageLCM(String nomTable, String[] idMappage, String refUser) throws Exception;
  public void validerMappageLCPrevRecControle(String nomTable, String idMere, String idPrev,String refUser) throws Exception ;
  public void validerMappageLCPrevDepControle(String nomTable, String idMere, String refUser) throws Exception ;
  public UnionIntraTable validerMappageLCMavecOp(String nomTable, String idMere, String idOp, String refUser) throws Exception;
  public void validerMappageLC(String nomTable, String idMappage, String refUser) throws Exception;
  public void validerMappageLC(String nomTable, String idMappage, Connection c, String refUser) throws Exception;
  public void validerMappageOpFlc(String nomTable, String idMappage, Connection c, String refUser) throws Exception;
  public String mapperDepenseLC(String idSortie, String idLC, String rem, String montant, String refUser) throws Exception;
  public String mapperRecettesLC(String idEntree, String idLC, String rem, String montant, String refUser) throws Exception;
  public String mapperFactureLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception;
  public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception;
  
  public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception;
  public String mapperFactureFournisseurLCTableau(String idFacture, String[] idLC, String rem, String[] montant, String refUser) throws Exception;
  public String mapperFactureClientLCTableau(String idFacture, String[] idLC, String rem, String[] montant, String refUser) throws Exception;
  public String mapperFactureFournisseurLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception;
  public String mapperFactureClientLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception;
  public boolean deleteUnionIntraTable(String nomtable, String id, String refU) throws Exception;
  public boolean deleteUnionIntraTableLcOp(String nomtable, String nomTable2, String id, String refU) throws Exception;
  public String updateMontantUnionIntra(String nomTable, String id1, String[] id2, String[] montant, String refUser) throws Exception;
  public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant, String refUser) throws Exception;
  public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant, String refUser,Connection c) throws Exception;
  public String updateMontantUnionIntraLcPrev(String nomTable, String id1, String[] id2, String[] montant, String refUser) throws Exception ;
  public String copierLCRecette(String mois, String annee, String mois0, int annee0, String refUser) throws Exception;
  public String copierLC(String mois, String annee, String mois0, int annee0, String nomTable, String refUser) throws Exception;
  public String updateLC(String idLigne, String designation, String creditIni, String creditMod, String typeLigne, String numCompte, String entite, String dir, String mois, String annee, String nomTable, String refUser) throws Exception;
  public String copierLCRecette(String mois, String annee, String mois0, int annee0, String nomTable, String refUser) throws Exception;
  public String createLCRecette(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String rmq, String refUser) throws Exception;
  public String verifLCPrev(String idprev,String refUser)throws Exception;
  public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser,Connection c) throws Exception ;
  public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser, Connection c) throws Exception;
  public String mapperOrFactureClientLCTableauDupliquer(String idOp, String[] idLC, String rem, String[] montant, String refUser, Connection c) throws Exception;
  
  public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere, String refUser, Connection c) throws Exception;
	public double[][] calculResultat(LigneCreditNature[] lc) throws Exception;

public double[][] calculResultatRD(LigneCreditNature[] lc) throws Exception;

	public void dupliquerLC(String numObjet,String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable, String refUser) throws Exception;
public void dupliquerLCMultiple(String[] ids,String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable, String refUser) throws Exception;

}
