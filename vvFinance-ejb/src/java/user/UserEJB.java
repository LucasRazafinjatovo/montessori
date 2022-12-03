package user;

import javax.ejb.*;
import bean.*;
import comptabilite.Balance;
import comptabilite.BalanceTiers;
import comptabilite.Bilan;
import comptabilite.Exercice;
import facture.*;
import finance.*;
import historique.*;
import penalite.*;
import facturefournisseur.*;
import pcg.*;
import pointage.*;
import lc.*;
import ded.*;
import java.sql.Connection;
import java.util.HashMap;
import stock.*;
import prevision.*;
import pub.*;

@Local
public interface UserEJB {
    //public void assocEtatPieceMvtCaisse(String numObjet, String etatpiece)throws Exception;
    //public abstract void annulerOP(String paramString1, String paramString2)throws Exception;

    public void ejbRemove();
     
    public void miseAjourClientDouble(String depart, String cible) throws Exception;
    
    public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, Connection conn) throws Exception;
    
    public String modifEntryFactureFseur(String idFct, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String nature) throws Exception;
    
    public void savePrevision(String idPrev, String nomTablePrev, String nomTable, Connection connection) throws Exception;

    public void savePrevision(String idPrev, String nomTablePrev, String nomTable) throws Exception;

    public boolean controlerDoublon(ClassMAPTable object, Connection connection) throws Exception;

    public boolean controlerDoublon(ClassMAPTable object) throws Exception;

    public void devaliderUnionIntraTable(UnionIntraTable[] lcc, String nomtable) throws Exception;

    public int updateOR(String nomTable, String numObjet, String ded_id, String rmq, String daty, String montant) throws Exception;

    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] moyenneGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception;

    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ) throws Exception;
    
    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ, Connection c) throws Exception;

    public String createTypeObjet(String nomTable, String proc, String pref, String typ, String desc) throws Exception;

    public String updateTypeObjet(String table, String id, String typ, String desc) throws Exception;

    public int deleteTypeObjet(String nomTable, String id) throws Exception;

    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution) throws Exception;

    public String createFactureMereProforma(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution) throws Exception;

    public int deleteFactureMere(String idFactureMere) throws Exception;

    public String updateFactureMere(String idFactureMere, String daty, String idClient, String periodeDebut, String periodeFin, String noteExplicative, String idTva, String idDeviseEn, String reduction, String idFactureEn, String idCoursChange, String dateLimite, String idEtat, String montantAPayer, String idSCatService) throws Exception;

    public ResultatEtSomme findClientPage(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, int numPage) throws Exception;

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception;

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, Connection c) throws Exception;

    public FactureFille[] findFactureFilleProforma(String idFactureFille, String refObj, String idSCatService, String idFactureMere) throws Exception;
    
    public FactureFille[] findFactureFilleProforma(String idFactureFille, String refObj, String idSCatService, String idFactureMere, Connection c) throws Exception;

    public FactMere[] findFactureMereProforma(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception;

    public FactMere[] findFactureMereProforma(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, Connection c) throws Exception;

    public FactMere[] findFactureMereDevise(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise) throws Exception;

    public FactMere[] findFactureMereDeviseResp(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp) throws Exception;

    public FactMere[] findFactureMereDeviseRespEntite(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp, String entite) throws Exception;

    public String createClientComptable(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String idComptable, String typecontact, String soustypecontact) throws Exception;

    public String createClient(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception;

    public String updateClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception;

    public int deleteClient(String idClient) throws Exception;
    
    public String createfacturefilleMultiple(String[] g, String idfactureMere, String ttva, String dateParu) throws Exception;
    
    public String insertMereFille(String nomtableMappage, String[] idFille, String idMere, String rem, String montant, String montantTot) throws Exception;
    
    public void insertPubFact(String[] idpub, String idfact) throws Exception;
    
    public String createfacturefilleMultiple(String[] g, String idfactureMere, String ttva) throws Exception;

    public Client[] findClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception;

    public Client[] findClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, Connection c) throws Exception;

    public String createFactureFille(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF) throws Exception;

    public String createFactureFilleProforma(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF) throws Exception;

    public int deleteFactureFille(String idFactureFille) throws Exception;

    public String updateFactureFille(String idFactureFille, String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF) throws Exception;

    public FactureFille[] findFactureFille(String idFactureFille, String refObj, String idSCatService, String idFactureMere) throws Exception;

    public FactureFille[] findFactureFilleConn(String idFactureFille, String refObj, String idSCatService, String idFactureMere, Connection c) throws Exception;

    public String createFactureRedevance(String idClient, String daty, String dateDebut, String datyFin, String sCatService) throws Exception;

    public float calculPenalite(String datyDebut, String datyFin, String idSCatService) throws ErreurDAO;

    public String createAutorisationAnnulation(String idObjet, String responsable, String daty, String motif, String idTypeObjet) throws Exception;

    public int deleteAutorisationAnnulation(String idAutorisation) throws Exception;

    public String updateAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty, String motif, String idTypeObjet) throws Exception;

    public AutorisationAnnulation[] findAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty1, String daty2, String motif, String idTypeObjet) throws Exception;

    public String createService(String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient) throws Exception;

    public int deleteService(String idService) throws Exception;

    public String updateService(String idService, String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient) throws Exception;

    public Service[] findService(String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient) throws Exception;

    public String createSCatService(String nomSCat, String cat, String periodeFacturation, String factureEn) throws Exception;

    public int deleteSCatService(String idSCatService) throws Exception;

    public String updateSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, String factureEn) throws Exception;

    public String createCaisseComptable(String descCaisse, String respCaisse, String comptable) throws Exception;

    public String createCaisse(String descCaisse, String respCaisse) throws Exception;

    public String updateCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse) throws Exception;

    public int deleteCaisse(String idCaisse) throws Exception;

    public Caisse[] findCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse) throws Exception;

    public String createSortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String parution, String agence, String prj, String part, String fact, String idLigne) throws Exception;

    public String updateSortie(String idSortie, String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String eta, String rem, String prj, String part, String fact) throws Exception;

    public int deleteSortie(String idSortie) throws Exception;

    public Sortie[] findSortie(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat) throws Exception;

    public Sortie[] findSortieSourceCaisse(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String sourceC) throws Exception;

    public Sortie[] findSortieAgence(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String idLigne) throws Exception;

    public Sortie[] findSortieLettre(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String aW) throws Exception;

    public String createEntree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String paru, String agence, String source, String prj, String part, String idLigne) throws Exception;

    public String updateEntree(String idEntree, String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String eta, String rem, String prj, String part, String idLigne) throws Exception;

    public int deleteEntree(String idEntree) throws Exception;

    public void livraisonMultipleAbonne(String[] idabonne, String idcoursier) throws Exception;

    public Entree[] findEntreePiece(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat) throws Exception;

    public Entree[] findEntreeAgence(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre) throws Exception;

    public Entree[] findEntreeLettre(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre, String prj, String part, String apresWhere) throws Exception;

    public Entree[] findEntreeLettrePage(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre, String prj, String part, String apresWhere, int numPa) throws Exception;

    public Entree[] findEntree(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat) throws Exception;

    public Entree[] findEntreeBenCaisse(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String benCaisse) throws Exception;

    public String createHistorique(String dateHistorique, String heure, String objet, String action, String refuser, String refObjet) throws Exception;

    public String updateHistorique(String idHistorique, String dateHistorique, String heure, String objet, String action, String refuser, String refObjet) throws Exception;

    public int deleteHistorique(String idHistorique) throws Exception;

    public MapHistorique[] findHistoriquePage(String refuser, String refObjet, String objet, String action, String daty1, String daty2, int numPage) throws Exception;

    public MapHistorique[] findHistorique(String refuser, String refObjet, String objet, String action, String daty1, String daty2) throws Exception;

    public String createHistoriqueEtat(String idMere, String idUser, String idEtat, String dateModification) throws Exception;

    public String updateHistoriqueEtat(String idHistoriqueEtat, String idMere, String idUser, String idEtat, String dateModification) throws Exception;

    public int deleteHistoriqueEtat(String idHistoriqueEtat) throws Exception;

    public HistoriqueEtat[] findHistoriqueEtat(String idHistoriqueEtat, String idMere, String idUser, String idEtat, String dateModification) throws Exception;

    public String createAccident(String datySaisie, String datyAccident, String description, String nomEmploye, String rem) throws ErreurDAO;

    public String updateAccident(String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye, String rem) throws ErreurDAO;

    public int deleteAccident(String idAccident) throws Exception;

    public Accident[] findAccident(String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye) throws Exception;

    public String createChiffreAffTac(String mois, String annee, String montant) throws ErreurDAO;

    public String updateChiffreAffTac(String idChiffre, String mois, String annee, String montant) throws ErreurDAO;

    public int deleteChiffreAffTac(String idChiffre) throws Exception;

    public ChiffreAffTac[] findChiffreAffTac(String idChiffre, String mois, String annee, String montant) throws Exception;

    public int annulerChiffreAffTac(String idChiffre) throws Exception;

    public String createVolCont(String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant) throws ErreurDAO;

    public String updateVolCont(String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant) throws ErreurDAO;

    public int deleteVolCont(String idVol) throws Exception;

    public VolConteneur[] findVolCont(String idVol, String datyInf, String datySup, String numCont, String designation, String idDossier, String proprietaire, String montant) throws Exception;

    public String createDommageConteneur(String datyDebut, String datyFin, String designation, String montant, String idDossier, String nomProprietaire) throws ErreurDAO;

    public String updateDommageConteneur(String idDommage, String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire) throws ErreurDAO;

    public int deleteDommageConteneur(String idDommage) throws Exception;

    public DommageConteneur[] findDommageConteneur(String idDommage, String datyInf, String datySup, String designation, String montant, String idDossier, String nomProprietaire) throws Exception;

    public String updateParametrePenalite(String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String datyD, String pxAccExc) throws Exception;

    public ParametrePenalite[] findParametrePenalite(String idParametrePenalite, String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String date1) throws ErreurDAO;

    public String createTva(String val, String daty) throws Exception;

    public String updateTva(String idTva, String val, String daty) throws Exception;

    public int deleteTva(String idTva) throws Exception;

    public Tva[] findTva(String idTva, String val, String daty1, String daty2) throws Exception;

    public String createUtilisateurs(String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception;

    public String updateUtilisateurs(String refuser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception;

    public int deleteUtilisateurs(String refuser) throws Exception;

    public MapUtilisateur[] findUtilisateurs(String refuser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception;

    public String createFacturePenalite(String[] idPenalite) throws Exception;

    public String createPenalite(String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws ErreurDAO;

    public String updatePenalite(String idPenalite, String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws ErreurDAO;

    public int deletePenalite(String idPenalite) throws Exception;

    public Penalite[] findPenalite(String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws Exception;

    public int annulerPenalite(String idPenalite) throws Exception;

    public int annulationFacture(String idFactureMere) throws Exception;

    public int verifChevauch(String datyFin, String idSCatService) throws Exception;

    public String updateParametreFacture(String dateLimite, String bonusEvp, String red, String dateDebutValid) throws Exception;

    public ParametreFacture[] findParametreFacture(String idParametreFacture, String dateLimite, String bonusEvp, String red, String date1, String date2) throws Exception;

    public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation) throws Exception;

    public facture.Societe findMaSociete(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit) throws ErreurDAO;

    public facture.Societe[] findMaSocieteTab(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit, String entite) throws ErreurDAO;

    public String updateMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty) throws Exception;

    public String createMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty) throws Exception;

    public MapRoles[] findRole(String descRole) throws Exception;

    public String createTrafic(String daty, String datyDebut, String datyFin, String nb, String rem, String idserv) throws ErreurDAO;

    public String updateTrafic(String idTrafic, String daty, String datyDebut, String datyFin, String nb, String rem, String idserv) throws ErreurDAO;

    public int deleteTrafic(String idTrafic) throws Exception;

    public TraficConteneur[] findTrafic(String idTrafic, String datyDebut, String datyFin, String idserv) throws Exception;

    public TraficConteneur[] findTraficPeriode(String idTrafic, String datyDebut, String datyFin, String idserv, String mois1, String mois2, String annee1, String annee2) throws Exception;

    public int annulerTrafic(String idTrafic) throws Exception;

    public ParametreFacture findParametreFactureEnCours(String daty) throws Exception;

    public MapUtilisateur getUser();

    public String finaliseFacture(String id) throws Exception;

    public ParametreFacture loadParametreFacture(String daty1) throws Exception;

    public ParametrePenalite loadParametrePenalite(String daty1) throws Exception;

    public int annulerEntree(String idEntree) throws Exception;

    public int annulerSortie(String idSortie) throws Exception, ErreurDAO;

    public int getMontantBilletage(String dix, String cinq, String deux, String un, String deuxCinq, String deuxCent, String cent, String cinquante, String vingt);

    public Change[] findChange(String idChange, String idDevise, String datyInf) throws Exception;

    public int verifPenalite(String mois, String annee) throws Exception;

    public Objet[] findObjet(String obj, String des) throws Exception;

    public Tva loadTva(String daty1) throws Exception;

    public String createFacturePenalite(String idPenalite) throws Exception;

    public Penalite[] findPenaliteNonFacture(String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws Exception;

    public EtatFacture[] findEtatFacture(String idFact, String daty1, String daty2, String etat, String clien) throws Exception;

    public Change[] findChange(String idChange, String etat) throws Exception;

    public int desactiveUtilisateur(String ref) throws Exception;

    public String getMaxId(String table);

    public int activeUtilisateur(String ref) throws Exception;

    public int testException() throws Exception;

    public EtatFacture[] findEtatFactureTaxe(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise) throws Exception;

    public Ecriture[] findEcriture(String idEcriture, String daty1, String daty2, String libelle, String compte, String piece) throws Exception;

    public Compte[] findCompte(String id, String typ, String desc, String daty) throws Exception;

    public String createAvoir(String idFact, String resp, String da, String mot, String mont, String typ) throws Exception;

    public String updateAvoir(String idAv, String idFact, String resp, String da, String mot, String mont) throws Exception;

    public Avoir[] findAvoir(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception;

    public Avoir[] findAvoirValide(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception;

    public int annulationAvoir(String idAvoir) throws Exception;

    public String createChange(String idDevise, String valeurEnAriary, String datyDebutValid) throws Exception;

    public String updateChange(String idChange, String idDevise, String valeurEnAriary, String s);

    public SynthesePointage[] finSynthese(String datyinf, String datySup) throws Exception;

    public int calculNombrePage(int nombreElement);

    public int calculHistoriquePage(String refuser, String refObjet, String objet, String action, String daty1, String daty2) throws Exception;

    public double calculChange(String valeur, String devise1, String devise2, String daty) throws Exception;

    public Change loadChangeValide(String devise, String datyInf) throws Exception;

    public String createBeneficiaireCompta(String va, String des, String comptable) throws Exception;

    public int annulerDevise(String idDevise) throws Exception;

    public int annulerCompte(String idCompte) throws Exception;

    public String createCompte(String val, String desc, String datyDebutVal) throws Exception;

    
    public double calculCA(String datyInf, String datySup) throws Exception;

    public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim) throws Exception;

    public String finaliseFactureUpdateProforma(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim) throws Exception;

    public String finaliseFactureUpdateProforma(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, Connection c) throws Exception;

    public String createDetPenRetard(String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat) throws Exception;

    public String updateDetPenRetard(String id, String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat) throws Exception;

    public int deleteDetPenRetard(String id) throws Exception;

    public DetPenRetard[] findDetPenRetard(String id, String idPen, String daty1, String daty2, String nbJour, String numPiece) throws Exception;

    public SyntheseEVP[] findSyntheseEVP(String daty1, String daty2) throws Exception;

    public SyntheseEVP[] findSyntheseEVPMois(String mois, String annee) throws Exception;

    public int getNombreEVP(String mois, String annee) throws Exception;

    public int annulerAccident(String idAcc) throws Exception;

    public int annulerVol(String idVol) throws Exception;

    public int annulerDommage(String idDommage) throws Exception;

    public void testLogin(String user, String pass) throws Exception;

    public ResultatEtSomme findVirement(String nomtable, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW, int numPage) throws Exception;

    public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty) throws Exception;

    public void virerVirementMiltiple(String[] numCheque, String[] montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty) throws Exception;

    public Visa viserVirement(String idVir, String daty, String rem) throws Exception;

    public boolean virer(String daty, String caisse1, String caisse2, String montant, String remarque, String devise, String mode, String typeE, String typeS, String prj, String part, String fact, String idLigne) throws Exception;

    public EtatCaisseReste[] findEtatCaisseResteMvt(String daty1, String daty2, String caisse, String entite) throws Exception;

    public EtatCaisseReste[] findEtatCaisseReportMvt(String daty1, String daty2, String caisse, String entite) throws Exception;

    public ResultatEtSomme findReportPage(String daty1, String daty2, String caisse, String devise, int numP) throws Exception;

    public Report[] findReport(String daty1, String daty2, String caisse, String devise) throws Exception;

    public Report reporter(String daty, String montant, String caisse, String devise) throws Exception;

    public boolean reporter(String daty, String datyFin, String montant, String caisse, String devise, String prj, String part, String fact, String idLigne) throws Exception;

    public EtatFacture[] findEtatFactureResp(String idFact, String daty1, String daty2, String etat, String clien, String resp) throws Exception;

    public EtatFacture[] findEtatFactureRespTypeEntite(String idFact, String daty1, String daty2, String etat, String clien, String resp, String type, String entite, String parution) throws Exception;

    public String createEntryFacture(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String nature) throws Exception;

    public String createEntryFactureFseur(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String nature) throws Exception;

    public String createEntryFacture(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise) throws Exception;

    public ResultatEtSomme findFactureFournisseurPage(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW, int numPage) throws Exception;

    public FactureFournisseur[] findFactureFournisseur(String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception;

    public FactureFournisseur[] findFactureF(String num, String dateDebut, String dateFin, String fournisseur, String projet, String etat, String colonne, String ordre, String apresW) throws Exception;

    public FactureFournisseur annulerFact(String nomTable, String nomTableLiaison, String id) throws Exception;

    public String createFournisseur(String fournisseur, String nif, String stat, String tel, String email, String adresse) throws Exception;

    public Fournisseur[] findFournisseurF(String idF, String fournisseur, String nif, String stat, String tel, String email, String adresse, String apresW) throws Exception;

    public FactureFournisseur[] lolo();

    public String cloturerFactureFournisseur(String idf, String numFact, String designation, String daty, String fournisseur, String montantHT, String tva, String montantTTC, String remarque, String etat, String projet, String dateemission, String idDevise) throws Exception;

    public FactureFournisseur[] findSortieFactureFournisseur();

    public String ajouterCompte(String c, String lib, String pc) throws Exception;

    public String majCompte(String idCompte, String cpt, String lib, String pcpt) throws Exception;

    public Pcg[] findCompteTab(String idc, String cpt, String lib, String pcpt) throws Exception;

    public String findCompteTxt(String idc, String cpt, String lib, String pcpt) throws Exception;

    public FactMere[] findFactureMereNonPaye(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception;

    public String createPointage(String user, String daty, String heure, String type, String remarque, String ip, String agence, String machine) throws Exception;

    public Pointage[] findPointage(String idPointage, String user, String datyInf, String DateSup, String heureInf, String heureSup, String type, String rem, String ip, String agence, String machine) throws Exception;

    public EtatCaisse[] findEtatCaisseDepense(String daty1, String daty2, String caisse, String benC) throws Exception;

    public EtatCaisse[] findEtatCaisseEntree(String daty1, String daty2, String caisse, String benC) throws Exception;

    public EtatCaisseReste[] findEtatCaisseReste(String dateDebut, String dateFin, String caisse, String entite) throws Exception;

    public SyntheseCompte[] findSyntheseCompteSortie(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception;

    public SyntheseCompte[] findSyntheseCompteEntree(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception;

    public SyntheseCompte[] findSyntheseCompteSortieType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception;

    public SyntheseCompte[] findSyntheseCompteEntreeType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception;

    public String createLC(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable) throws Exception;

    public String updateLC(LigneCredit lc, String nomTable) throws Exception;

    public String updateLC(String id, String designation, double creditInitial, double cm, double montEng, double montVise, double montFact, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable) throws Exception;

    public String copierLCRecette(String mois, String annee, String mois0, String annee0) throws Exception;

    public String createLCRecette(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String rmq) throws Exception;

    public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup, String nomTable) throws Exception;

    public String createLCe(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable) throws Exception;

    public String mapperDepenseLC(String idSortie, String idLC, String rem, String montant) throws Exception;

    public void validerMappageLCMRecette(String nomTable, String idMappage) throws Exception;

    public void validerMappageLCM(String nomTable, String idMappage) throws Exception;

    public UnionIntraTable validerMappageLCMavecOp(String nomTable, String idMere, String idOp) throws Exception;

    public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere) throws Exception;

    public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere) throws Exception;

    public void validerMappageLCPrevRecControle(String nomTable, String idMere, String idPrev) throws Exception;

    public void validerMappageLCPrevDepControle(String nomTable, String idMere) throws Exception;

    public void validerMappageLCMOp(String nomTable, String idMere) throws Exception;

    public void validerMappageLC(String nomTable, String[] idMappage) throws Exception;

    public String attcherOrRCPrev(String idprev, String[] listeor) throws Exception;

    public String attcherOrRCPrev2(String idprev, String listeor) throws Exception;

    public String attcherOpDepPrev(String idprev, String[] listeor) throws Exception;

    public String attcherOpDepPrev2(String idprev, String idor) throws Exception;

    public EtatCaisseTableau[] findEtatCaisseTableau(String daty1, String daty2, String colonne, String ordre, String nomTable) throws Exception;

    public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, Connection c) throws Exception;

    public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal) throws Exception;

    public String mapperRecettesLC(String idEntree, String idLC, String rem, String montant) throws Exception;

    public String mapperFactureLC(String idFacture, String idLC, String rem, String montant) throws Exception;

    public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant) throws Exception;

    public String updateMontantUnionIntraLcPrev(String nomTable, String id1, String[] id2, String[] montant) throws Exception;

    public boolean deleteUnionIntraTableLcOp(String nomtable, String nomTable2, String id) throws Exception;

    public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception;

    public String mapperFactureFournisseurLCTableau(String idFacture, String[] idLC, String rem, String[] montant) throws Exception;

    public String mapperFactureClientLCTableau(String idFacture, String[] idLC, String rem, String[] montant) throws Exception;

    public boolean deleteUnionIntraTable(String nomtable, String id) throws Exception;

    public String updateMontantUnionIntra(String nomTable, String id1, String[] id2, String[] montant) throws Exception;

    public String mapperFactureFournisseurLC(String idFacture, String idLC, String rem, String montant) throws Exception;

    public String copierLC(String mois, String annee, String mois0, String annee0, String nomTable) throws Exception;

    public String copierLCAvecDetail(String mois, String annee, String mois0, String annee0, String nomTable) throws Exception;

    public void updateLC(LigneCredit l) throws Exception;

    public String copierLC(String idLigneToCopy, String idEntite, String iddirection, String mois, String rmq, String annee) throws Exception;

    public String createDirection(String libelledir, String descdir, double idDirecteur, String abbrevDir) throws Exception;

    public String updateCreditLC(String idLigne, double newCredit, String motif) throws Exception;

    public Direction[] findDirection(String idDir, String libelledir, String descdir, String abbrevDir, String idDirecteur) throws Exception;

    public LigneCredit[] findLC(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable) throws Exception;

    public ResultatEtSomme findLCPage(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable, int numPage) throws Exception;

    public LigneCreditComplet[] findFCC(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception;

    public LigneCreditComplet[] findFCCParution(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String paruInf, String paruSup, String nomTable) throws Exception;

    public LigneCreditComplet[] findLCComplet(String idLigne, String designation, String mois, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception;

    public String updateDirection(String idToUpdate, String libelledir, String descdir, double idDirecteur, String abbrevDir) throws Exception;

    public String createEntiteFact(String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String nature) throws Exception;

    public String viser(String nomT, String daty, String remarque, String idObjet) throws Exception;

    public String viserDed(String daty, String remarque, String idObjet) throws Exception;

    public String viserOr(String daty, String remarque, String idObjet) throws Exception;

    public String viserOp(String daty, String remarque, String idObjet) throws Exception;

    public String ventilerDed(String idDed, String[] idLcDet, String[] montant, String[] remarque, String[] eta) throws Exception;

    public String ventilerOp(String idOp, String[] idLcDet, String[] montant, String[] remarque, String[] eta) throws Exception;

    public String ventilerMvtCaisseDebit(String idMvt, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String nature) throws Exception;

    public String createDed(String desi, String daty, String mtht, String tax, String rem, String tiers, String idLigne) throws Exception;

    public String copierLcDetail(String idDepart, String idArrivee) throws Exception;

    public String createMvtCaisse(String daty, String datyValeur, String designation, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;

    public String createMvtCaisseDirecte(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;

    public String ventilerMvtCaisseLcDetailDepenseGroupe(String idDetLc, String idMvt, String rem, String montant) throws Exception;

    public String validerMvtCaisseLcDetailDepenseGroupe(String numMvtCaisse) throws Exception;

    public String createMvtCaisseDirecteRecette(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;

    public int checkCloture(String listepub) throws Exception;

    public String createMvtCaisseDirecteDepense(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;

    public String retourVola(String idMvt, String idLcDet, String montant) throws Exception;

    public String annulerMvtDepense(String idMvt) throws Exception;

    public String createMvtCaisseDepenseRetour(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idMvt) throws Exception;

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre) throws Exception;

    public String validerAutoAnnulation(String id) throws Exception;

    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre) throws Exception;

    public MvtCaisse[] findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception;

    public ResultatEtSomme findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, int numPage) throws Exception;

    public void assocOPSociete(String idop, String societe) throws Exception;

    public void assocOPMvtCaisse(String idop, String idmvt, String benef, String etatpiece) throws Exception;

    public String creerOpDirecte(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque) throws Exception;

    public String creerOpDirecteSansVisa(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque) throws Exception;

    public String createOp(String idDed, String daty, String montant, String rem) throws Exception;
    public String createOp(String idDed, String daty, String montant, String rem,Connection c) throws Exception;

    public String createOp(String idDed, String daty, String montant, String rem, String typePrevu, String datePaiement, String remarquePaiement) throws Exception;
    public String createOp(String idDed, String daty, String montant, String rem, String typePrevu, String datePaiement, String remarquePaiement,Connection c) throws Exception;

    public String createOp(String idDed, String daty, String montant, String rem, String prev) throws Exception;

    public String createDetailMvtCaisse(String deb, String crd, String tiers, String rem, String paru, String idMere, String numP) throws Exception;

    public String createDetEntFact(String idM, String desi, String qte, String puHt, String rem) throws Exception;

    public FactureFournisseur[] findEntFact(String nomT, String id, String numFact, String designation, String frns, String montant1, String montant2, String rmq, String date1, String date2, String idDevise) throws Exception;

    public FactureFournisseur[] findFactureFournisseur(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception;

    public DetailFact[] findDetailFact(String id, String idM, String desi, String mont1, String mont2, String rem) throws Exception;

    public Ded[] findDed(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String idLigne, String tiers) throws Exception;

    public ResultatEtSomme findDedPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, int numPage) throws Exception;

    public ResultatEtSomme findDedLcPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;

    public DedLc[] findDedLc(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception;

    public OrdonnerPayement[] findOp(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception;

    public ResultatEtSomme findOpPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;

    public ResultatEtSomme findOpPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;

    public ResultatEtSomme findOpLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;

    public ResultatEtSomme findOrLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;

    public DetailMvtCaisse[] findDetMvtCaisse(String tiers, String rem, String idMere) throws Exception;

    public DetailMvtCaisse[] findDetMvtCaisseParu(String id, String tiers, String rem, String idMere, String paruInf, String paruSup) throws Exception;

    public ResultatEtSomme findDetMvtCaisseParu(String id, String tiers, String rem, String idMere, String paruInf, String paruSup, int numPage) throws Exception;

    public ResultatEtSomme findDetMvtCaisse(String tiers, String rem, String idMere, int numPage) throws Exception;

    public String mapperMereFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String etat, Connection c) throws Exception;

    public String mapperMereFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String etat) throws Exception;

    public String mapperMereFille(String nomtableMappage, String idMere, String idFille, String rem, String montant, String montantTot) throws Exception;

    public String insertMereFille(String nomtableMappage, String idMere, String idFille, String rem, String montant, String montantTot) throws Exception;

    public String deleteMereFille(String nomtableMappage, String idMappage) throws Exception;

    public UnionIntraTable[] findUnionIntraTable(String nomTable, String id, String id1, String id2, String rem, String mont1, String mont2, String eta, String apresW) throws Exception;

    public Object[] findPrevisionPage(String nomtable, String id, String ap) throws Exception;

    public String creerMvtStock(String design, String type, String debit, String credit, String compte, String unite, String rmq) throws Exception;

    public String creerDossier(String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq) throws Exception;

    public String creerDetailBobine(String numBob, String poids, String idMvt) throws Exception;

    public String creerParution(String journal, String numP, String datyP, String nbpage, String nbex, String poids, String printer, String idMvt, String rmq) throws Exception;

    public String creerLettrageMvt(String parent, String fille, String rmq) throws Exception;

    public String creerVerification(String mag, String reste, String unite, String controleur, String rmq) throws Exception;

    public String creerDetailVerifi(String numBob, String pourcentage, String verif, String rmq) throws Exception;

    public MvtStock[] findMvtStock(String idMvt, String datyInf, String datySup, String typeMvt, String compte) throws Exception;

    public Dossier[] findDossier(String id, String idMvt, String typeDossier, String datyInf, String datySup) throws Exception;

    public DetailBobinePoids[] findDetailBobine(String id, String numBobine, String idMvt) throws Exception;

    public Parution[] findParution(String id, String datyInf, String datySup, String journal, String datyParInf, String datyParSup, String printer, String idMvt) throws Exception;

    public LettrageMvt[] findLettrageMvt(String id, String parent, String fille) throws Exception;

    public Verification[] findVerification(String id, String datyInf, String datySup, String mag, String controleur) throws Exception;

    public DetailVerif[] findDetailVerif(String id, String numBob, String idVerif) throws Exception;

    public String updateDossier(String id, String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq) throws Exception;

    public String enleverDetailBobine(String id) throws Exception;

    public String enleverDossier(String idDossier) throws Exception;

    public String faireMvtStock(String design, String type, String debitS, String creditS, String debitD, String creditD, String compteS, String compteD, String unite, String rmq) throws Exception;

    public double calculQte(String nbPage, String nbEx, String poids) throws Exception;

    public MvtCompte[] findMvtCompte(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String val, String desce) throws Exception;

    public MvtBobine[] findMvtBobine(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String numB) throws Exception;

    public String createDetailLc(String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact) throws Exception;

    public String valideDetailLc(String idLC) throws Exception;

    public String updateDetailLc(String id, String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact) throws Exception;

    public LcDetail[] findDetailLc(String id, String idLC, String compteDet, String etat) throws Exception;

    public String updateDed(String idDed, String desi, String daty, String mtht, String tax, String rem, String tiers) throws Exception;

    public String updateOp(String id, String daty, String mont) throws Exception;

    public String creerOR(String daty, String ligne, String mont, String eta) throws Exception;

    public String creerOR(String daty, String ligne, String mont, String eta, String typeprevu) throws Exception;

    public OrdonnerPayement[] findOr(String id, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception;

    public ResultatEtSomme findOrPage(String id, String ded, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception;

    public String createDetail(String nomTable, String idMere, String designation, String qte, String puHT, String rem) throws Exception;

    public String updateDetail(String nomTable, String id, String designation, String qte, String puHT, String rem) throws Exception;

    public Detail[] findDetail(String nomTable, String id, String idMere, String designation, String qte1, String qte2, String puHT1, String puHT2, String rem) throws Exception;

    public OpLc[] findOpLc(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception;

    public ResultatEtSomme findOpLcPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;

    public ResultatEtSomme findMvtCaisseLcPage(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception;

    public MvtCaisseLc[] findMvtCaisseLc(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception;

    public Cheque[] findCheque(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca) throws Exception;

    public Cheque createCheque(String mvt, String datyS, String datyV, String ord, String rem, String numC, String ca, String mont) throws Exception;

    public String degagerDed(String idDed) throws Exception;

    public String degagerOp(String idOp) throws Exception;

    public String degagerMvtCaisse(String idMvt) throws Exception;

    public String viserFactureF(String refFact, String rem) throws Exception;

    public FactureFournisseur createOrSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String resp, String rem) throws Exception;

    public FactureFournisseur createOrSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String resp, String rem, String typeprevu) throws Exception;

    public OrdonnerPayement annulerOp(String nomTable, String nomTableLiaison, String id) throws Exception;

    public void annulerOP(String id, String desc) throws Exception;

    public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String prev) throws Exception;

    public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem) throws Exception;

    public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String typeprevu, String datePaiement, String remarquePaiement) throws Exception;

    public SaisieVirement[] findVirementNormale(String nomtable, String id, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW);

    public String updateLC(String idLigne, String designation, String creditIni, String creditMod, String typeLigne, String numCompte, String entite, String dir, String mois, String annee, String nomTable) throws Exception;

    public String copierLCRecette(String mois, String annee, String mois0, String annee0, String nomTable) throws Exception;

    public String viserFactureC(String idFact, String remarque) throws Exception;

    public String viserFactureCProf(String idFact, String remarque) throws Exception;

    public void saveOpSolde(String idop, String solde) throws Exception;

    public String mapperFactureClientLC(String idFacture, String idLC, String rem, String montant) throws Exception;

    public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception;

    public String mapperPrevisionRecetteLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception;

    public String mapperPrevisionDepenseLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception;

    public ResultatEtSomme findFactureFournisseurPageLc(String nomtable, String id, String fourn, String designation, String numFact, String idLigne, String daty1, String daty2, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage, String colonne, String ordre) throws Exception;

    public ResultatEtSomme findOpPageLc(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String etat, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage) throws Exception;

    public String creerTache(Tache t) throws Exception;

    public String transfererTache(String t, String userFinal) throws Exception;

    public String modifierTache(Tache t) throws Exception;

    public void effectuerTache(EffTache ef) throws Exception;

    public String commenterTache(TypeObjet tc) throws Exception;

    public TacheVue[] findTache(TacheVue crt, String daty1, String daty2, String apresWher) throws Exception;

    public ResultatEtSomme findTachePage(Tache crt, String daty1, String daty2, String apresWher, int numPage) throws Exception;

    public MapUtilisateur[] findUserSubordonnee() throws Exception;

    public Publicite updatePub(Publicite p) throws Exception;

    public Publicite[] createPub(String parution1, String parution2, String idClient, String designation, String dimension, String couleur, String page, String journal, String bc, String rem, String cat, String resp, String numP, String formu, String remis) throws Exception;

    public String mapperPrevLCTableau(String idprev, String[] idLC, String rem, String[] montant) throws Exception;

    public String mapperPrevLCRTableau(String idprev, String[] idLC, String rem, String[] montant) throws Exception;

    public int remiserPub(String[] idPub, String[] listePage) throws Exception;

    public int corrigerPub(String[] idPub, String[] corr) throws Exception;

    public int mettrePage(String[] idPub, String[] listePage, String[] listePageAncien) throws Exception;

    public void corrigerPub(String idP) throws Exception;
    //public double getSoldeMois(Date d) throws Exception;

    public Publicite[] findPub(Publicite crt, String[] colInt, String[] valInt, String aW) throws Exception;

    public ResultatEtSomme getDataPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c) throws Exception;

    public ResultatEtSomme getDataPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception;

    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception;

    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception;

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception;

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception;

    public boolean testerProfil(String tableRestrict, String profil, String login, String action) throws Exception;

    public Object[] getData(ClassMAPTable e, String[] colInt, String[] valInt, Connection c, String apresWhere) throws Exception;

    public Remise[] createRemise(String[] idPub, String remise) throws Exception;

    public int getint();

    public void rapprochementRIBMultiple(String[] idrib, String idmvt) throws Exception;

    public void attacherORPUB(String[] temp, String idor) throws Exception;

    public String getSommeMontant(String idmontant) throws Exception;

    public void createRetourPiece(String idop, String daty, String refpiece, String rmq) throws Exception;

    public MvtCaisseTous findDetailMvt(String idmvt) throws Exception;

    public Rib findDetailRib(String idrib) throws Exception;

    public String getDetailCaisse(String idcaisse);

    public RapprochementBancaire getDetailRappro(String idrib) throws Exception;

    public void rapprochementRIBMultiple(String[] idrib) throws Exception;

    public void rapprocherAndUpdateRib(String idrib, String[] idmvt) throws Exception;

    public void rapprocherRibFiche(ClassMAPTable o) throws Exception;

    public String rapprocherMvt(ClassMAPTable o) throws Exception;

    public Object createObject(ClassMAPTable o) throws Exception;

    public void insertPubFact(String idpub, String idfact, String rem, double montant, int etat) throws Exception;

    public void insertPrevisionOp(FactureFournisseur facture, String prevision) throws Exception;

    public void insertPrevisionOr(FactureFournisseur facture, String prevision) throws Exception;

    public void insertCommissionOp(String facture, String idordre, String pourcentage) throws Exception;

    public void insertCommissionOp(String facture, String idordre) throws Exception;

    public String getMaxIdMarge();

    public String getMaxIdGestion();

    public String getMaxIdMaintenance();

    public String getMaxIdTirage();

    public void createPayementCommissionMultiple(String factclient, String client, String numcompte, String pourcentage) throws Exception;

    public String insertEtatRapprochement(String idmax, String etat) throws Exception;

    public Object updateTypeVente2(String type, String daty, String nbre, String id, String publicat, String vendeur) throws Exception;

    public Object updateTypeVente(String type, String daty, String nbre, String id, String publicat, String vendeur) throws Exception;

    public String getMaxIdProduction();

    public Object updateObject(ClassMAPTable o, String t) throws Exception;

    public Object updateObject(ClassMAPTable o) throws Exception;

    public void deleteObject(ClassMAPTable o) throws Exception;

    public Parution creerParution(String par1, String dateP, String journ, String nbpage, String remarque) throws Exception;

    public String viserPrevision(String nomtable, String idPrev, String remarque) throws Exception;

    public void facturerPub(String idFacture, String idPub) throws Exception;

    public void createOrPrevisionLC(String nomtable, String nomtable1, String nomtable2, String[] temps, FactureFournisseur ff) throws Exception;
    //public void createOrPrevisionLC(String nomtable, String nomtable1, String nomtable2, String[] temps, OrdonnerPayement[] lop, FactureFournisseur ff) throws Exception;

    public void createOpPrevisionLC(String nomtable, String nomtable1, String nomtable2, String[] temps, OrdonnerPayement[] lop, FactureFournisseur ff) throws Exception;

    public void validerFacturerPub(String idFacture) throws Exception;

    public void validerMappage(String idFacture, String nomTable) throws Exception;

    public boolean isSuperUser();

    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String numCheque, String etabliss, String idmvtor) throws Exception;

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idmvtor) throws Exception;

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String debitinitial, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idmvtor) throws Exception;
        
    public Cheque[] findChequeEtat(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca, String etat) throws Exception;

    public String saveMvtOr(String idmvtor, String idmvt, String numObjets) throws Exception;

    public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String numCheuqe) throws Exception;

    public void insertInvFact(String idinv, String idfact, String rem, int nbre, int etat) throws Exception;
    
    public void insertInvFact(String[] idinv, String idfact) throws Exception;
    
    public void insertPubRadioFact(String[] idinv, String idfact) throws Exception;

    public Object updateTypeVente(String type, String daty, String nbre, String id, String publicat, String vendeur, String idPrix) throws Exception;

    public Object updateTypeVente2(String type, String daty, String nbre, String id, String publicat, String vendeur, String idPrix) throws Exception;

    public ResultatEtSomme getDataPageMultiple(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception;

    public void setIdDirection(String idDirection);

    public String getIdDirection();

    public AnalysePrevision[] findAnalysePrevision(String daty1, String daty2, String colonne, String ordre, String nomTable) throws Exception;

    public String verifLCPrev(String idprev) throws Exception;

    public int reporterPrevision(String nomTable, String[] idPrev, String[] rep) throws Exception;

    public void deletePrevision(String nomTable, String no) throws Exception;

    public int reporterOp(String nomTable, String[] idOp, String[] rep) throws Exception;

    public int dupliquerOP(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception;
	 public int dupliquerOPLC(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception;

    public double getMontantRecette(String id) throws Exception;

    public void attacherRecetteFacture(String idrec, String idor, String montant, String daty) throws Exception;

    public String updateFactureFournisseur(String nomTable, String idf, String numFact, String designation, java.sql.Date daty, String fournisseur, double tva, double montantTTC, String remarque, java.sql.Date dateemission, String idDevise) throws Exception;

    public String updateOpVita(String nomtable, String nomtable2, String idornew, String idorancien) throws Exception;

    public int updateORFacture(String idor, String montant) throws Exception;

    public java.sql.Date[] getListDateDuplication(String dinf, String dsup, String[] jour, String reccurrecne) throws Exception;

    public int dupliquerOR(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception;
    public int dupliquerORLC(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception;

    public String[] getCommissionDetail(String[] listeComm) throws Exception;

    public String updateOrdre(String nomtable, String idordre, String sommeCommission) throws Exception;

    public int attacherOpCommission(String idordre, String listeComm) throws Exception;

    public String[] getSommeMontant(OrdonnerPayement[] ordre, String tableName, String idprev) throws Exception;

    public OrdonnerPayement[] getListeOrdre(String tableName, String[] idmontant) throws Exception;

    public String attcherOpRCPrev(String idprev, String[] listeor) throws Exception;

    public void saveException(String msg, String className) throws Exception;

    public void payerRibMultiple(String listeRib, String remarque, String typeprevu, String fournisseur, String dateDePaiement, String typelc, String mois, String annee, String[] entite) throws Exception;

    public double[][] calculResultat(LigneCreditNature[] lc) throws Exception;

    public double[][] calculResultatRD(LigneCreditNature[] lc) throws Exception;

    public Object[] getAllDataNoPagination(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception;

    public String retournerMouvementDeCaisse(String idMvt) throws Exception;

    public Integer[] getListMoisDuplication(String mois1, String mois2, String recurrence) throws Exception;

    public void dupliquerLC(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable) throws Exception;

    public void dupliquerLCMultiple(String[] ids, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable) throws Exception;

    public java.sql.Date generateDateLimiteFactureClient(String periodeDebut, String daty, String idSCatService) throws Exception;

    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite) throws Exception;

    public String createFactureMereRadio(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String[] g, String ttva, String datyparu) throws Exception;

    public String createFactureMereRadio2(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String[] g, String ttva, String datyparu) throws Exception;

    public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String modepaiement, String datelimite) throws Exception;

    public String updateDateOp(String[] id, java.sql.Date date_payement) throws Exception;

    public void modifEtatAbonne(String idvendeur) throws Exception;

    public String validerAbonnement(String idvendeur) throws Exception;
    
    public comptabilite.Societe[] findSociete(String idSociete, String nom, String regime, String tel, String fax,
                                     String email, String gerant, String nif, String numstat, String rc, String capital, String quittance) throws Exception;
	public int insertMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
		java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit) throws Exception;
	public void viserMultipleEcriture(String[] temp) throws Exception;
	public void viserEcriture(String temp) throws Exception;
	public void extournerEcriture(String num) throws Exception;
	public void updateMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
		java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit, String[] id, int numero, int tailleInit) throws Exception;
	public void lettrerEcriture(String[] ecritures) throws Exception;
	public Balance[] setInitSoldeBalance (Balance[] liste, String daty) throws Exception;
	public BalanceTiers[] setInitSoldeBalanceTiers (BalanceTiers[] liste, String daty) throws Exception;
	public void transcrireClientFournisseur () throws Exception;
	public void transcrireDepense () throws Exception;
	public void transcrireVente () throws Exception;
	public void transcrireTresorerie () throws Exception;
	public double[] calculSommeInit(Balance[] listeR) throws Exception;
	public void reporter(String exercice, java.sql.Date daty) throws Exception;
	public Exercice cloturerExercice(String exercice, java.sql.Date daty) throws Exception;
	public void lettrageAutomatique () throws Exception;
	public void cloturerEtReporter (String exercice, java.sql.Date daty) throws Exception;
	public comptabilite.Ecriture[] getPrevDeclaration(String[] debitD, String[] creditD, String[] debitU, String[] creditU) throws Exception;
	public void lettrerDeclaration(int numE, String debitD, String creditD, String debitU, String creditU) throws Exception;
	public void transcrireEmployeMultiple(String ids,String entites,String noms,String prenoms,String telephones,
            String adresses,String fonctions,String postes,String matricules) throws Exception;
	public Bilan[] genererActifs (String exercice) throws Exception;
	public Bilan[] genererPassifs (String exercice) throws Exception;
	public Bilan[] genererCompteResultat (String exercice) throws Exception;
         public Bilan[] genererResultat(String exercice,int annee) throws Exception;
         public Bilan[] getResultatAvecFormule(String exercice,int annee) throws Exception;
         public Bilan[] getResultatActifs(String exercice,int annee) throws Exception;
         public Bilan[] getResultatPassifs(String exercice,int annee) throws Exception ;
        public void rapprocher(String[] idRappro, String[] idGrandLivre,String idcaisse) throws Exception;
    
    public void rapprochementAutomatique(String idcaisse) throws Exception ;
    public double calculmontantApresCommission(double montant);
        public void insertEmploye(String id,String entite,String nom,String prenom,String telephone,
            String adresse,String fonction,String poste,String matricule) throws Exception;
    
        public void annulerOPReste(String[] idop, HashMap<String,String> remarque) throws Exception;
        public void decalerOP(String [] id,String []daty)throws Exception;
        public Bilan [] getResultatPassifFinal(String exercice,int annee) throws Exception;
        public Bilan [] getResultatActifFinal(String exercice,int annee) throws Exception;
        public void remplacerOP(String idop)throws Exception;
        public void annulerORReste(String[] idop, HashMap<String,String> remarque) throws Exception;
        public void decalerOR(String [] id,String []daty)throws Exception;
        public String creerOR(String daty, String ligne, String mont, String eta, String remarque,String typeprevu,Connection c) throws Exception;
        
        public int annulationFactureClient(String idFactureClient) throws Exception;
        public int annulationPub(String idPub) throws Exception;
        public void cloturerPrise(String idprise) throws Exception;
        public void modifierFacture(String idfm, String[] idfactureFille, double[] prixUnitaire, double[] quantite, int[] reduction, double tva) throws Exception;
}
