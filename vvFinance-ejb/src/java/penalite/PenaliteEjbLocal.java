// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   PenaliteEjbLocal.java

package penalite;

import bean.ClassMAPTable;
import bean.ErreurDAO;
import historique.MapUtilisateur;
import javax.ejb.EJBLocalObject;
import java.util.*;

// Referenced classes of package penalite:
//            Accident, DommageConteneur, ParametrePenalite, Penalite, 
//            VolConteneur, ChiffreAffTac, TraficConteneur, SynthesePointage, 
//            DetPenRetard

public interface PenaliteEjbLocal
    extends EJBLocalObject
{
  public String createAccident(String datySaisie, String datyAccident, String description, String nomEmploye, String rem, String refUser) throws ErreurDAO;
  public String updateAccident(String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye, String rem, String refUser) throws ErreurDAO;
  public int deleteAccident(String idAccident, String refUser) throws ErreurDAO;
  public Accident[] findAccident(String idAccident, String datyDebut, String datyFin, String description, String nomEmploye) throws ErreurDAO;
  public String createDommageConteneur(String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire, String refUser) throws ErreurDAO;
  public String updateDommageConteneur(String idDommage, String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire, String refUser) throws ErreurDAO;
  public int deleteDommageConteneur(String idDommage, String refUser) throws ErreurDAO;
  public DommageConteneur[] findDommageConteneur(String idDommage, String datyDebut, String datyFin, String designation, String montant, String idDossier, String nomProprietaire) throws ErreurDAO;
  public String updateParametrePenalite(String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String dateDebutValid, String refUser) throws ErreurDAO;
  public ParametrePenalite[] findParametrePenalite(String idParametrePenalite, String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String date1) throws ErreurDAO;
  public String createPenalite(String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4, String refUser) throws ErreurDAO;
  public String updatePenalite(String idPenalite, String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4, String refUser) throws ErreurDAO;
  public int deletePenalite(String idPenalite, String refUser) throws ErreurDAO;
  public Penalite[] findPenalite(String idPenalite, String daty1, String daty2, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws ErreurDAO;
  public int annulerPenalite(String idPenalite, String refUser) throws Exception;
  public String createVolCont(String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant, String refUser) throws ErreurDAO;
  public String updateVolCont(String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant, String refUser) throws ErreurDAO;
  public int deleteVolCont(String idVol, String refUser) throws ErreurDAO;
  public VolConteneur[] findVolCont(String idVol, String datyDebut, String datyFin, String numCont, String designation, String idDossier, String proprietaire, String montant) throws ErreurDAO;
  public String createChiffreAffTac(String mois, String annee, String montant, String refUser) throws ErreurDAO;
  public String updateChiffreAffTac(String idChiffre, String mois, String annee, String montant, String refUser) throws ErreurDAO;
  public int deleteChiffreAffTac(String idChiffre, String refUser) throws ErreurDAO;
  public ChiffreAffTac[] findChiffreAffTac(String idChiffre, String mois, String annee, String montant) throws ErreurDAO;
  public int annulerChiffreAffTac(String idChifffre, String refUser) throws Exception;
  public String createTrafic(String daty, String datyDebut, String datyFin, String nb, String rem, String idserv, String refUser) throws ErreurDAO;
  public String updateTrafic(String idTrafic, String daty, String datyDebut, String datyFin, String nb, String rem, String idserv, String refUser) throws ErreurDAO;
  public int deleteTrafic(String idTrafic, String refUser) throws ErreurDAO;
  public TraficConteneur[] findTrafic(String idTrafic, String datyDebut, String datyFin, String idserv) throws ErreurDAO;
  public int annulerTrafic(String idTrafic, String refUser) throws Exception;
  public float calculPenalite(String datyDebut, String datyFin, String idSCatService, String s) throws ErreurDAO;
  public String createFacturePenalite(String[] idPenalite, String refUser);
  public int verifPenalite(String daty1, String daty2, String user) throws Exception;
  public int verifPenaliteRetard(String daty1, String daty2, String user);
  public String verifChevauchPenalite(String datyDeb, String datyDeFin, String typePen) throws Exception;
  public int verifPenaliteVol(String daty1, String daty2, String user);
  public int verifPenaliteAccident(String daty1, String daty2, String user);
  public int verifPenaliteDommage(String daty1, String daty2, String user);
  public int verifPenliteQuai(String daty1, String daty2, String user);
  public double calculCA(String datyInf, String datySup) throws Exception;
  public int verifPenaliteTrafic(String daty1, String daty2, String user);
  public SynthesePointage[] findSynthese(String datyinf, String datySup) throws Exception;
  public ParametrePenalite loadParametrePenalite(String daty1) throws Exception;
  public Penalite[] findPenaliteNonFacture(String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws Exception;
  public String createDetPenRetard(String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat, String user) throws Exception;
  public String updateDetPenRetard(String id, String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat, String user) throws Exception;
  public int deleteDetPenRetard(String id, String user) throws Exception;
  public DetPenRetard[] findDetPenRetard(String id, String idPen, String daty1, String daty2, String nbJour, String numPiece) throws Exception;
  public int annulerAccident(String idAcc, String refUser) throws Exception;
  public int annulerVol(String idVol, String refUser) throws Exception;
  public int annulerDommage(String idDommage, String refUser) throws Exception;
  public int create(ClassMAPTable value1, MapUtilisateur value2) throws java.lang.Exception;
  public int update(ClassMAPTable value1, MapUtilisateur value2) throws java.lang.Exception;
  public int delete(ClassMAPTable value1, MapUtilisateur value2) throws java.lang.Exception;





















































}
