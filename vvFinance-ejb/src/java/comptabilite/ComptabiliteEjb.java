package comptabilite;

import historique.MapUtilisateur;
import java.rmi.RemoteException;
import java.sql.Connection;
import javax.ejb.EJBObject;
import java.util.*;
import java.sql.*;
import bean.*;
//import employe.EmployeLibelleNoSal;
import javax.ejb.Local;

@Local
public interface ComptabiliteEjb   extends EJBObject {
	public Societe[] findSociete(String idSociete, String nom, String regime, String tel, String fax,
                                     String email, String gerant, String nif, String numstat, String rc, String capital, String quittance) throws Exception;
	public int insertMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
		java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit, String refUser) throws Exception;
	public void viserMultipleEcriture(String[] temp, String refUser) throws Exception;
	public void viserEcriture(String temp, String refUser) throws Exception;
	public void extournerEcriture(String num, String refUser) throws Exception;
	public void updateMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
		java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit, String[] id, int numero, int tailleInit, String refUser) throws Exception;
	public void ecrireFactureF (String idFact, Connection c, String refU) throws Exception;
	public void lettrerEcriture(String[] ecritures, String refUser) throws Exception;
	public void ecrireFactureC (String idFact, Connection c, String refU) throws Exception;
	public void ecrireMvt (String idMvt, String type, Connection c, String refU) throws Exception;
	public Balance[] setInitSoldeBalance (Balance[] liste, String daty) throws Exception;
	public BalanceTiers[] setInitSoldeBalanceTiers (BalanceTiers[] liste, String daty) throws Exception;
	public void insertTiersMultipleCompte (String reftiers, String comptes, Connection c, String refU) throws Exception;
	public void updateTiers(String reftiers, Connection c, String refUser) throws Exception;
	public void transcrireClientFournisseur (String refUser) throws Exception;
	public void transcrireDepense (int annee, String refUser) throws Exception;
	public void transcrireVente (int annee, String refUser) throws Exception;
	public void transcrireTresorerie (int annee, String refUser) throws Exception;
	public double[] calculSommeInit(Balance[] listeR) throws Exception;
	public void reporter(String exercice,  java.sql.Date daty, String refU) throws Exception;
	public Exercice cloturerExercice(String exercice, java.sql.Date daty, String refUser) throws Exception;
	public void lettrageAutomatique (String refUser) throws Exception;
	public void cloturerEtReporter (String exercice, java.sql.Date daty, String refUser) throws Exception;
	public Ecriture[] getPrevDeclaration(String[] debitD, String[] creditD, String[] debitU, String[] creditU) throws Exception;
	public void lettrerDeclaration(int numE, String debitD, String creditD, String debitU, String creditU, String refU) throws Exception;
	public void transcrireEmployeMultiple(String ids,String entites,String noms,String prenoms,String telephones,
            String adresses,String fonctions,String postes,String matricules, String refUser) throws Exception;
	public void retournerMvtCaisse(String mvt, String refUser, Connection c) throws Exception;
	public Bilan[] genererActifs (String exercice) throws Exception;
	public Bilan[] genererPassifs (String exercice) throws Exception;
	public Bilan[] genererCompteResultat (String exercice) throws Exception;
       public Bilan[] genererResultat(String exercice,int annee) throws Exception;
        public Bilan [] getResultatAvecFormule(String exercice,int annee) throws Exception;
        public Bilan[] getResultatActifs(String exercice,int annee) throws Exception;
        public Bilan[] getResultatPassifs(String exercice,int annee) throws Exception;
        public void insertEmploye(String id,String entite,String nom,String prenom,String telephone,
        String adresse,String fonction,String poste,String matricule, String refUser) throws Exception;
        public Bilan [] getResultatPassifFinal(String exercice,int annee) throws Exception;
        public Bilan [] getResultatActifFinal(String exercice,int annee) throws Exception;
}
