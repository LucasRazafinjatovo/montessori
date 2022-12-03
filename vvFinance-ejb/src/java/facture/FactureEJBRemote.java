/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ErreurDAO;
import bean.ResultatEtSomme;
import java.rmi.RemoteException;
import java.sql.Connection;
import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface FactureEJBRemote  extends EJBObject{
    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String refUser) throws Exception, RemoteException;
  public int deleteFactureMere(String idFactureMere, String refUser) throws Exception, RemoteException;
  public String updateFactureMere(String idFactureMere, String daty, String idClient, String periodeDebut, String periodefin, String noteExplicative, String idTva, String idDeviseEn, String reduction, String idFactureEn, String idCoursChange, String dateLimite, String idEtat, String montantAPayer, String idSCatServic, String refUser) throws Exception, RemoteException;
  public FactMere[] findFactureMereDevise(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise) throws Exception, RemoteException;
  public FactMere[] findFactureMereDeviseResp(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp) throws Exception, RemoteException;
  public FactMere[] findFactureMereDeviseRespEntite(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp, String entite) throws Exception, RemoteException;
  public FactureRetard[] findFactureRetard(String datyinf, String datySup, String idFactureMere, String refObjet, String fact) throws Exception, RemoteException;
  public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception, RemoteException;
  public String createClientComptable(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String comptable, String typecontact, String soustypecontact, String refUser) throws Exception;
  public String createClient(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String refUser) throws Exception, RemoteException;
  public String updateClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String refUser) throws Exception, RemoteException;
  public int deleteClient(String idClient, String refUser) throws Exception, RemoteException;
  public Client[] findClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception, RemoteException;
  public ResultatEtSomme findClientPage(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, int numPage) throws Exception, RemoteException;
  public String createFactureFille(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF, String refUser) throws Exception, RemoteException;
  public int deleteFactureFille(String idFactureFille, String refUser) throws Exception, RemoteException;
  public String updateFactureFille(String idFactureFille, String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF, String refUser) throws Exception, RemoteException;
  public FactureFille[] findFactureFille(String idFactureFille, String refObj, String idSCatService, String idFactureMere) throws Exception, RemoteException;
  public String createFactureRedevance(String idClient, String daty, String dateDebut, String dateFin, String idScatService, String refUser) throws Exception, RemoteException;
  public String createFactureRedevanceFixe(String idClient, String daty, String dateDebut, String dateFin, String refUser) throws Exception, RemoteException;
  public String createFactureRedevanceVariable(String idClient, String daty, String dateDebut, String dateFin, String refUser) throws Exception, RemoteException;
  public String createAutorisationAnnulation(String idObjet, String responsable, String daty, String motif, String idTypeObjet, String refUser) throws Exception, RemoteException;
  public int deleteAutorisationAnnulation(String idAutorisation, String refUser) throws ErreurDAO, RemoteException;
  public String updateAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty, String motif, String idTypeObjet, String refUser) throws ErreurDAO, RemoteException;
  public AutorisationAnnulation[] findAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty1, String daty2, String motif, String idTypeObjet) throws Exception, RemoteException;
  public String createService(String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient, String refUser) throws Exception, RemoteException;
  public int deleteService(String idService, String refUser) throws ErreurDAO, RemoteException;
  public String updateService(String idService, String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient, String refUser) throws ErreurDAO, RemoteException;
  public Service[] findService(String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient) throws Exception, RemoteException;
  public String createSCatService(String nomSCat, String cat, String periodeFacturation, String factureEn, String refUser) throws Exception, RemoteException;
  public int deleteSCatService(String idSCatService, String refUser) throws ErreurDAO, RemoteException;
  public String updateSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, String factureEn, String refUser) throws ErreurDAO, RemoteException;
  public int annulationFacture(String idFactureMere, String refUser) throws Exception, RemoteException;
  public String updateParametreFacture(String dateLimite, String bonusEvp, String red, String dateDebutValid, String refUser) throws Exception, RemoteException;
  public ParametreFacture[] findParametreFacture(String idParametreFacture, String dateLimite, String bonusEvp, String red, String daty1, String daty2) throws Exception, RemoteException;
  public int verifChevauch(String datyDebut, String datyFin, String idSCatService) throws Exception, RemoteException;
  public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation) throws Exception, RemoteException;
  public String createTva(String val, String daty, String refUser) throws Exception, RemoteException;
  public String updateTva(String idTva, String val, String daty, String refUser) throws Exception, RemoteException;
  public int deleteTva(String idTva, String refUser) throws ErreurDAO, RemoteException;
  public Tva[] findTva(String idTva, String val, String daty1, String daty2) throws Exception, RemoteException;
  public Societe findMaSociete(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception, RemoteException;
  public Societe[] findMaSocieteTab(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit, String entite) throws Exception, RemoteException;
  public String updateMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty, String refUser) throws Exception, RemoteException;
  public String createMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty, String refUser) throws Exception, RemoteException;
  public ParametreFacture findParametreFactureEnCours(String daty) throws RemoteException;
  public ParametreFacture loadParametreFacture(String daty1) throws Exception, RemoteException;
  public FactMere[] findFactMereNonReglee(String datyinf, String datySup, String idFactureMere, String s, String s1, String s2) throws RemoteException;
  public FactMere[] findFactureValide(String datyinf, String datySup, String idFactureMere, String client, String etat, String sCatService) throws Exception, RemoteException;
  public double getRAPFacture(FactMere f, String daty) throws RemoteException;
  public Change[] findChange(String idChange, String idDevise, String datyInf) throws Exception, RemoteException;
  public String finaliseFacture(String idFacture, String user) throws Exception, RemoteException;
  public String finaliseFactureUpdate(String idFacture, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String user) throws Exception, RemoteException;
  public Tva loadTva(String daty1) throws Exception, RemoteException;
  public String createFacturePenalite(String idPenalite, String refUser) throws Exception, RemoteException;
  public EtatFacture[] findEtatFacture(String idFact, String daty1, String daty2, String etat, String clien) throws Exception, RemoteException;
  public EtatFacture[] findEtatFactureResp(String idFact, String daty1, String daty2, String etat, String clien, String resp) throws Exception, RemoteException;
  public EtatFacture[] findEtatFactureRespTypeEntite(String idFact, String daty1, String daty2, String etat, String clien, String resp, String type, String entite, String parution) throws Exception, RemoteException;
  public EtatFacture[] findEtatFactureTaxe(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise) throws Exception, RemoteException;
  public EtatFacture[] findEtatFactureTaxeRespEntite(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise, String resp, String entite, String parution) throws Exception, RemoteException;
  public Change[] findChange(String idChange, String etat) throws Exception, RemoteException;
  public String createEcritureConnection(String daty, String compte, String libelle, String debit, String credit, String piece, String refUser, Connection c) throws Exception, RemoteException;
  public String createEcriture(String daty, String compte, String libelle, String debit, String credit, String piece, String refUser) throws Exception, RemoteException;
  public String createCompteConnection(String val, String desc, String datyDebutVal, String refUser, Connection c) throws Exception, RemoteException;
  public String createCompte(String val, String desc, String datyDebutVal, String refUser) throws Exception, RemoteException;
  public Ecriture[] findEcriture(String idEcriture, String daty1, String daty2, String libelle, String compte, String piece) throws Exception, RemoteException;
  public Compte[] findCompte(String id, String type, String desc, String daty) throws Exception, RemoteException;
  public String createAvoir(String idFact, String resp, String da, String mot, String mont, String typ, String refUser) throws Exception, RemoteException;
  public String updateAvoir(String idAv, String idFact, String resp, String da, String mot, String mont, String refUser) throws Exception, RemoteException;
  public Avoir[] findAvoir(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception, RemoteException;
  public Avoir[] findAvoirValide(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception, RemoteException;
  public int annulationAvoir(String idAvoir, String refUser) throws Exception, RemoteException;
  public int verifExistTypObj(String id, String typ) throws Exception, RemoteException;
  public Change loadChangeValide(String devise, String datyInf) throws Exception, RemoteException;
  public String createChange(String idDevise, String valeurEnAriary, String datyDebutValid, String refUser) throws Exception, RemoteException;
  public String updateChange(String idChange, String idDevise, String valeurEnAriary, String s, String s1) throws RemoteException;
  public double calculChange(String valeur, String devise1, String devise2, String daty) throws Exception, RemoteException;
  public int annulerDevise(String idDevise, String refUser) throws Exception, RemoteException;
  public int annulerCompte(String idCompte, String refUser) throws Exception, RemoteException;
  public SyntheseEVP[] findSyntheseEVP(String daty1, String daty2) throws Exception, RemoteException;
  public FactMere[] findFactureMereNonPaye(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception, RemoteException;
  public String updateFactureFournisseur(String nomTable,String idf, String numFact,String designation, java.sql.Date daty, String fournisseur,  double tva, double montantTTC, String remarque, java.sql.Date dateemission, String idDevise,String refUser) throws Exception;
public java.sql.Date generateDateLimiteFactureClient (String periodeDebut, String daty, String idSCatService) throws Exception;
public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String refUser) throws Exception;
public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String modepaiement, String datelimite, String user) throws Exception;

}
