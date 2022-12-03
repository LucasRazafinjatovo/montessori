package user;

import facture.AutorisationAnnulation;
import facture.Avoir;
import facture.CommissionOp;
import facture.Change;
import facture.Client;
import facture.Compte;
import facture.Ecriture;
import compte.*;
import java.io.*;
import crieur.*;
import restriction.Restriction;
import facture.EtatFacture;
import facture.FactMere;
import facture.FactureMereUtil;
import facture.FactureFilleUtil;
import facture.FactureEjb;
import facture.FactureFille;
import facture.HAHA;
import restriction.*;
import facture.ParametreFacture;
import facture.SCatService;
import facture.Service;
import facture.Societe;
import facture.SyntheseEVP;
import facture.Tva;
import activa.*;
import facturefournisseur.FactureFournisseur;
import facturefournisseur.FactureFournisseurPrevisionLc;
import facturefournisseur.FactureFournisseurPrevision;
import facturefournisseur.LiaisonFFPrevisionLc;
import facturefournisseur.Fournisseur;
import facturefournisseur.GestionFactureFournisseur;
import finance.Caisse;
import finance.Entree;
import finance.EtatCaisse;
import finance.EtatCaisseReste;
import finance.FinanceEjb;
import finance.Sortie;
import finance.EtatRapprochement;
import finance.SyntheseCompte;
import historique.HistoriqueEtat;
import historique.MapHistorique;
import historique.MapRoles;
import historique.MapUtilisateur;
import historique.Objet;
import java.util.Vector;
import stock.*;
import java.sql.Connection;
import java.sql.*;
import javax.ejb.CreateException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import lc.Direction;
import lc.LCEjb;
import lc.LigneCredit;
import lc.LigneCreditComplet;
import lc.LigneCreditDatee;
import lc.LigneCreditNature;
import pcg.GestionPlanComptable;
import pcg.Pcg;
import penalite.Accident;
import penalite.ChiffreAffTac;
import penalite.DetPenRetard;
import penalite.DommageConteneur;
import penalite.ParametrePenalite;
import penalite.Penalite;
import penalite.PenaliteEjb;
import penalite.SynthesePointage;
import penalite.TraficConteneur;
import penalite.VolConteneur;
import prevision.*;
import pointage.Pointage;
import pointage.PointageEjb;
import utilitaire.Parametre;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import bean.ErreurDAO;
import bean.TypeObjet;
import bean.TypeObjetUtil;
import facturefournisseur.DetailFact;
import ded.*;
import ladies.*;
import ded.OrdonnerPayement;
import finance.DetailMvtCaisse;
import finance.MvtCaisse;
import bean.UnionIntraTable;
import bean.ResultatEtSomme;
import ded.DedLc;
import ded.DedEjb;
import ded.AssocOpSociete;
import lc.LcDetail;
import facturefournisseur.Detail;
import ded.OpLc;
import finance.MvtCaisseLc;
import finance.Cheque;
import finance.Report;
import bean.UnionIntraTableUtil;
import finance.SaisieVirement;
import ded.Visa;
import pointage.Tache;
import pointage.TacheVue;
import pointage.EffTache;
import pointage.TacheComment;
import historique.UtilisateurUtil;
import pub.Publicite;
import pub.Montant;
import pub.Parution;
import pub.Remise;
import pub.PubliciteComplet;
import pub.*;
import bean.ClassMAPTable;
import bean.CGenUtil;
import ventegazety.*;
import facturefournisseur.FactureFournisseurCompte;
import actualite.Actualite;
import facture.FactureClient;
import facture.FactureEJBClient;
import facture.FactureEjb;
import facturefournisseur.GestionFactureFournisseurClient;
import finance.*;
import historique.Historique;
import historique.HistoriqueClient;
import java.rmi.RemoteException;
import javax.ejb.AccessTimeout;
import javax.ejb.EJBHome;
import javax.ejb.EJBObject;
import javax.ejb.Handle;
import javax.ejb.RemoveException;
import javax.ejb.Stateful;
import lc.LCEjb;
import lc.LCEjbClient;
import pcg.GestionPlanComptableClient;
import penalite.PenaliteEjbClient;
import pointage.PointageEjbClient;
import utilitaire.UtilitaireMetier;

import comptabilite.*;
import etudiant.AbondantEtudiant;
import etudiant.AnneeScolaire;
import etudiant.InscriptionEtudiant;
import etudiant.Edition;
import etudiant.Etudiant;
import etudiant.EtudiantService;
import etudiant.FactureMere;
import etudiant.MouvementEtudiant;
import etudiant.Paiement;
import etudiant.PaiementDetail;
import facture.FactureEjbBean;
import java.util.HashMap;
import recette.ConfPrixEtudiant;
import recette.RubriquePrixEntite;
import utilitaire.Constante;

@Stateful
@AccessTimeout(0)
public class UserEJBBean implements UserEJB, UserEJBRemote, SessionBean {

    SessionContext sessionContext;
    MapUtilisateur u;
    MapUtilisateur uVue;
    String type;
    String idDirection;

    public UserEJBBean() {
        u = null;
    }

    public void ejbRemove() {
        MapHistorique histo = new MapHistorique("logout", "logout", String.valueOf(u.getRefuser()), String.valueOf(u.getRefuser()));
        histo.insertToTable();
    }

    public void ejbActivate() {
    }

    public void ejbPassivate() {
    }

    public void setSessionContext(SessionContext sessionContext) {
        this.sessionContext = sessionContext;
    }

    public void miseAjourClientDouble(String depart, String cible) throws Exception{
        Connection conn = null;
        try{
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            
            finance.MvtCaisse m = new finance.MvtCaisse();
            finance.MvtCaisse[] l = (finance.MvtCaisse[]) CGenUtil.rechercher(m, null, null, conn, " and tiers='" + depart + "'");
            if (l.length != 0) {
                for (int i = 0; i < l.length; i++) {
                    String id = (String) CGenUtil.miseajourDifferentTable(conn, "MVTCAISSE", l[i].getId(), cible, "tiers", "id");
                }
            }
            pub.Publicite p = new pub.Publicite();
            pub.Publicite[] lp = (pub.Publicite[]) CGenUtil.rechercher(p, null, null,conn, " and idclient='" + depart + "'");
            if (lp.length != 0) {
                for (int i = 0; i < lp.length; i++) {
                    String id = (String) CGenUtil.miseajourDifferentTable(conn, "PUBLICITE", lp[i].getId(), cible, "idclient", "id");
                }
            }
            facture.FactMere f = new facture.FactMere();
            facture.FactMere[] lf = (facture.FactMere[]) CGenUtil.rechercher(f, null, null, conn, " and idclient='" + depart + "'");
            if (lf.length != 0) {
                for (int i = 0; i < lf.length; i++) {
                    String id = (String) CGenUtil.miseajourDifferentTable(conn, "FACTUREMERE", lf[i].getIdFactureMere(), cible, "idclient", "IDFACTUREMERE");
                }
            }
            facturefournisseur.FactureFournisseur fa = new facturefournisseur.FactureFournisseur();
            facturefournisseur.FactureFournisseur[] lfa = (facturefournisseur.FactureFournisseur[]) CGenUtil.rechercher(fa, null, null, conn, " and idfournisseur='" + depart + "'");
            if (lfa.length != 0) {
                for (int i = 0; i < lfa.length; i++) {
                    String id = (String) CGenUtil.miseajourDifferentTable(conn, "FACTUREFOURNISSEUR", lfa[i].getIdFactureFournisseur(), cible, "idfournisseur", "IDFACTUREFOURNISSEUR");
                }
            }
            facture.FactureClient fc = new facture.FactureClient();
            facture.FactureClient[] lfc = (facture.FactureClient[]) CGenUtil.rechercher(fc, null, null, conn, " and idfournisseur='" + depart + "'");
            if (lfc.length != 0) {
                for (int i = 0; i < lfc.length; i++) {
                    String id = (String) CGenUtil.miseajourDifferentTable(conn, "FactureClient", lfc[i].getIdfacturefournisseur(), cible, "idfournisseur", "IDFACTUREFOURNISSEUR");
                }
            }
            facture.Client c = new facture.Client();
            facture.Client[] lc = (facture.Client[]) CGenUtil.rechercher(c, null, null, conn, " and idclient='" + depart + "'");
            if (lc.length != 0) {
                String id = (String) CGenUtil.modifClient(conn, "Client", lc[0].getNom(), lc[0].getIdRegime(), lc[0].getAdresse(), lc[0].getTelephone(), lc[0].getFax(), lc[0].getNumstat(), lc[0].getNif(), lc[0].getRc(), lc[0].getTp(), lc[0].getQuittance(), cible);

            }
			//modifCompta : comptetiers, ecriturecompta
			
			//alaina daholo ny comptetiers rehetra
			comptabilite.CompteTiers cpt = new comptabilite.CompteTiers();
            comptabilite.CompteTiers[] cpts = (comptabilite.CompteTiers[]) CGenUtil.rechercher(cpt, null, null, conn, " and reftiers='" + depart + "'");
			comptabilite.CompteTiers cpt1 = new comptabilite.CompteTiers();
			comptabilite.CompteTiers[] cptCibles = (comptabilite.CompteTiers[]) CGenUtil.rechercher(cpt1, null, null, conn, " and reftiers='" + cible + "'");
            if (cpts.length != 0) {
                for (int i = 0; i < cpts.length; i++) {
                    comptabilite.Ecriture ecriture = new comptabilite.Ecriture();
					comptabilite.Ecriture[] ecrs = (comptabilite.Ecriture[]) CGenUtil.rechercher(ecriture, null, null, conn, " and comptetiers='" + cpts[i].getId() + "'");
					if (ecrs.length != 0) {
						for (int j = 0; j < ecrs.length; j++) {
							String id = (String) CGenUtil.miseajourDifferentTable(conn, "EcritureCompta", ecrs[j].getComptetiers(), cptCibles[i].getId(), "comptetiers", "comptetiers");
						}
					}
					cpts[i].deleteToTable(conn);
                }
            }
			
			
            deleteClient(depart, conn);
            conn.commit();
        }catch(Exception ex){
            ex.printStackTrace();
            conn.rollback();
            throw new Exception(ex.getMessage());
        }finally{
            if(conn != null){
                conn.close();
            }
        }
    }
    public void savePrevision(String idPrev, String nomTablePrev, String nomTable, Connection connection) throws Exception {
        try {

            Prevision prev = new Prevision();
            prev.setNomTable(nomTablePrev);
            prev.setId(idPrev);
            Prevision[] list = (Prevision[]) CGenUtil.rechercher(prev, null, null, connection, "");
            if (list.length <= 0) {
                OrdonnerPayement op = new OrdonnerPayement();
                op.setNomTable(nomTable);
                op.setId(idPrev);
                OrdonnerPayement[] listOP = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, connection, "");

                Prevision prevision = new Prevision(idPrev, listOP[0].getDaty(), listOP[0].getMontant(), listOP[0].getRemarque());
                prevision.setNomTable(nomTablePrev);

                prevision.setEtat(11);
                prevision.insertToTableWithHisto(u.getTuppleID(), connection);
            } else {
                list[0].setEtat(11);
                list[0].updateToTableWithHisto(u.getTuppleID(), connection);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public void savePrevision(String idPrev, String nomTablePrev, String nomTable) throws Exception {
        Connection connection = null;
        try {
            connection = (new UtilDB()).GetConn();
            savePrevision(idPrev, nomTablePrev, nomTable, connection);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    public boolean controlerDoublon(ClassMAPTable object, Connection connection) throws Exception {
        try {
            ClassMAPTable[] listObject = (ClassMAPTable[]) CGenUtil.rechercher(object, null, null, connection, "");
            if (listObject.length > 0) {
                return true;
            }
            return false;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public boolean controlerDoublon(ClassMAPTable object) throws Exception {
        boolean ret = false;
        Connection connection = null;
        try {
            connection = (new UtilDB()).GetConn();
            ret = controlerDoublon(object, connection);
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("erreur durant la recherche doublon " + ex.getMessage());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    public void saveException(String msg, String className) throws Exception {
        String filename = utilitaire.Constante.errorFileName;
        String directory = "c:\\TEMP\\";
        String path = directory + filename;
        PrintWriter printWriter = null;
        File file = new File(path);
        final String newLine = System.getProperty("line.separator");
        try {
            if (!file.exists()) {
                file.createNewFile();
            }
            printWriter = new PrintWriter(new FileOutputStream(path, true));

            String errorMessage = Utilitaire.dateDuJour() + "    " + Utilitaire.heureCouranteHMS() + "    " + className + "    " + msg;
            printWriter.write(newLine + errorMessage);
        } catch (IOException ioex) {
            ioex.printStackTrace();
        } finally {
            if (printWriter != null) {
                printWriter.flush();
                printWriter.close();
            }
        }
    }

    public TarifPub getTarifPubEncours(String idFormat) throws Exception {
        try {
            TarifPub tarifpub = new TarifPub();
            TarifPub[] listTarif = (TarifPub[]) CGenUtil.rechercher(tarifpub, null, null, " order by dateffective desc");
            return listTarif[0];
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ) throws Exception {
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            TypeObjet atypeobjet[] = to.findTypeObjet(nomTable, id, typ);
            return atypeobjet;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public TypeObjet[] findTypeObjet(String nomTable, String id, String typ, Connection c) throws Exception {
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            TypeObjet atypeobjet[] = to.findTypeObjet(nomTable, id, typ, c);
            return atypeobjet;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createTypeObjet(String nomTable, String proc, String pref, String typ, String desc) throws Exception {
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                TypeObjet to = new TypeObjet(nomTable, proc, pref, typ, desc);
                to.insertToTable(new MapHistorique(nomTable, "insert", u.getTuppleID(), to.getId()));
                String s = to.getId();
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateTypeObjet(String table, String id, String typ, String desc) throws Exception {
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                TypeObjet to = new TypeObjet(table, id, typ, desc);
                to.updateToTableWithHisto(new MapHistorique(table, "update", u.getTuppleID(), to.getId()));
                String s = to.getId();
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteTypeObjet(String nomTable, String id) throws Exception {
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                TypeObjet to = new TypeObjet(nomTable, id, "-", "-");
                MapHistorique h = new MapHistorique(nomTable, "delete", u.getTuppleID(), id);
                to.deleteToTable(h);
                int i = 1;
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFactureMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, respe, entite, parution, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureMereProforma(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution) throws Exception {

        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            Date datelimitepaiement = null;
            String idEtat = null;
            ParametreFacture pf = loadParametreFacture(periodeDebut);
            ParametrePenalite ppen = PenaliteEjbClient.getInterface().loadParametrePenalite(periodeDebut);
            Date dat = null;
            Date datFin = null;
            dat = Utilitaire.string_date("dd/MM/yyyy", daty);
            datFin = Utilitaire.string_date("dd/MM/yyyy", periodeFin);
            Date limite = null;
            limite = Utilitaire.ajoutJourDate(daty, pf.getDelaiPaiement());
            if (idSCatService.compareToIgnoreCase("scat3") == 0) {
                limite = Utilitaire.ajoutMoisDate(dat, ppen.getDelaiPaiementPenalite());
            }
            FactMere fm = new FactMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, "eta2", String.valueOf(Utilitaire.formatterDaty(limite)), "0", idSCatService, idTypePaim, respe, entite, parution, "");
            MapHistorique h = new MapHistorique("FactureMereProforma", "insert", u.getTuppleID(), fm.getTuppleID());
            fm.insertToTable(c);
            h.insertToTable(c);
            String s = fm.getTuppleID();
            c.commit();
            return s;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            }
        }
    }

    public int deleteFactureMere(String idFactureMere) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteFactureMere(idFactureMere, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateFactureMere(String idFactureMere, String daty, String idClient, String periodeDebut, String periodeFin, String noteExplicative, String idTva, String idDeviseEn, String reduction, String idFactureEn, String idCoursChange, String dateLimite, String idEtat, String montantAPayer, String idSCatService) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateFactureMere(idFactureMere, daty, idClient, periodeDebut, periodeFin, noteExplicative, idTva, idDeviseEn, reduction, idFactureEn, idCoursChange, dateLimite, idEtat, montantAPayer, idSCatService, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ResultatEtSomme findClientPage(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, int numPage) throws Exception {
        FactureEjb fl = null;
        fl = FactureEJBClient.getInterface();
        ResultatEtSomme afactmere = fl.findClientPage(idClient, nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit, numPage);
        return afactmere;
    }

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactMere afactmere[] = fl.findFactureMere(datyinf, datySup, idFactureMere, client, dateLimite, etatFacture, catService, sCatService);
            return afactmere;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, Connection c) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactMere afactmere[] = fl.findFactureMere(datyinf, datySup, idFactureMere, client, dateLimite, etatFacture, catService, sCatService, c);
            return afactmere;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactureFille[] findFactureFilleProforma(String idFactureFille, String refObj, String idSCatService, String idFactureMere, Connection c) throws Exception {
        FactureFille afacturefille[];
        try {
            int a[] = {
                1, 2, 3
            };
            String val[] = new String[a.length];
            val[0] = idFactureFille;
            val[1] = idFactureMere;
            val[2] = refObj;
            FactureFilleUtil ffu = new FactureFilleUtil();
            ffu.setNomTable("facturefilleproforma");
            FactureFille afacturefille1[] = (FactureFille[]) ffu.rechercher(a, val, c);
            return afacturefille1;
        } catch (Exception ex) {
            afacturefille = null;
        }
        return afacturefille;
    }
    
    public FactureFille[] findFactureFilleProforma(String idFactureFille, String refObj, String idSCatService, String idFactureMere) throws Exception {
        FactureFille afacturefille[];
        try {
            int a[] = {
                1, 2, 3
            };
            String val[] = new String[a.length];
            val[0] = idFactureFille;
            val[1] = idFactureMere;
            val[2] = refObj;
            FactureFilleUtil ffu = new FactureFilleUtil();
            ffu.setNomTable("facturefilleproforma");
            FactureFille afacturefille1[] = (FactureFille[]) ffu.rechercher(a, val);
            return afacturefille1;
        } catch (Exception ex) {
            afacturefille = null;
        }
        return afacturefille;
    }

    public FactMere[] findFactureMereProforma(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception {
        try {
            int a[] = {
                1, 5, 12, 15
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etatFacture;
            val[3] = sCatService;
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("facturemereproforma");
            if ((datyinf.compareTo("") == 0) & (datySup.compareTo("") == 0)) {
                FactMere afactmere[] = (FactMere[]) fmu.rechercher(a, val, " order by daty desc");
                return afactmere;
            }
            if ((datyinf.compareTo("") > 0) & (datySup.compareTo("") == 0)) {
                FactMere afactmere1[] = (FactMere[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyinf).append("' order by daty desc"))));
                return afactmere1;
            }
            if ((datyinf.compareTo("") == 0) & (datySup.compareTo("") > 0)) {
                FactMere afactmere2[] = (FactMere[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(datySup).append("' order by daty desc"))));
                return afactmere2;
            }
            if ((datyinf.compareTo("") != 0) & (datySup.compareTo("") != 0)) {
                FactMere afactmere3[] = (FactMere[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyinf).append("' and daty<='").append(datySup).append("' order by daty desc"))));
                return afactmere3;
            } else {
                FactMere afactmere4[] = null;
                return afactmere4;
            }
        } catch (Exception ex) {
            throw new Exception("Facture non trouv�e : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
    }

    public FactMere[] findFactureMereProforma(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, Connection c) throws Exception {
        try {
            int a[] = {
                1, 5, 12, 15
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etatFacture;
            val[3] = sCatService;
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("facturemereproforma");
            if ((datyinf.compareTo("") == 0) & (datySup.compareTo("") == 0)) {
                FactMere afactmere[] = (FactMere[]) fmu.rechercher(a, val, " order by daty desc", c);
                return afactmere;
            }
            if ((datyinf.compareTo("") > 0) & (datySup.compareTo("") == 0)) {
                FactMere afactmere1[] = (FactMere[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyinf).append("' order by daty desc"))), c);
                return afactmere1;
            }
            if ((datyinf.compareTo("") == 0) & (datySup.compareTo("") > 0)) {
                FactMere afactmere2[] = (FactMere[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(datySup).append("' order by daty desc"))), c);
                return afactmere2;
            }
            if ((datyinf.compareTo("") != 0) & (datySup.compareTo("") != 0)) {
                FactMere afactmere3[] = (FactMere[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyinf).append("' and daty<='").append(datySup).append("' order by daty desc"))), c);
                return afactmere3;
            } else {
                FactMere afactmere4[] = null;
                return afactmere4;
            }
        } catch (Exception ex) {
            throw new Exception("Facture non trouv�e : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
    }

    public FactMere[] findFactureMereDevise(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactMere afactmere[] = fl.findFactureMereDevise(datyinf, datySup, idFactureMere, client, dateLimite, etatFacture, catService, sCatService, devise);
            return afactmere;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMereDeviseResp(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactMere afactmere[] = fl.findFactureMereDeviseResp(datyinf, datySup, idFactureMere, client, dateLimite, etatFacture, catService, sCatService, devise, resp);
            return afactmere;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMereDeviseRespEntite(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp, String entite) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactMere afactmere[] = fl.findFactureMereDeviseRespEntite(datyinf, datySup, idFactureMere, client, dateLimite, etatFacture, catService, sCatService, devise, resp, entite);
            return afactmere;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createClientComptable(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String idComptable, String typecontact, String soustypecontact) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createClientComptable(nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit, idComptable, typecontact, soustypecontact, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createClient(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createClient(nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateClient(idClient, nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteClient(String idClient) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteClient(idClient, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteClient(String idClient, Connection conn) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteClient(idClient, u.getTuppleID(), conn);
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public Client[] findClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Client aclient[] = fl.findClient(idClient, nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit);
            return aclient;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Client[] findClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, Connection c) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Client aclient[] = fl.findClientConn(idClient, nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit, c);
            return aclient;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createfacturefilleMultiple(String[] g, String idfactureMere, String ttva) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createfacturefilleMultiple(g, idfactureMere, u.getTuppleID(), ttva);
            return s;
        } catch (ErreurDAO ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createfacturefilleMultiple(String[] g, String idfactureMere, String ttva, String dateParu) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createfacturefilleMultiple(g, idfactureMere, u.getTuppleID(), ttva, dateParu);
            return s;
        } catch (ErreurDAO ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureFille(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFactureFille(idFactureMere, refObj, des, qte, unite, pu, reductionF, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureFilleProforma(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            FactMere temp[] = findFactureMereProforma("", "", idFactureMere, "%", "", "%", "%", "%");
            FactMere mr = null;
            if (temp.length > 0) {
                mr = temp[0];
                if (mr.idEtat.compareToIgnoreCase("eta4") == 0 || mr.idEtat.compareToIgnoreCase("eta3") == 0) {
                    throw new Exception("Facture d�ja finalis�e ou regl�e");
                }
            }
            FactureFille ff = new FactureFille(idFactureMere, refObj, des, qte, unite, pu, reductionF, "");
            MapHistorique h = new MapHistorique("FactureFilleProforma", "insert", u.getTuppleID(), ff.getTuppleID());
            ff.insertToTable(c);
            h.insertToTable(c);
            c.commit();
            String s = ff.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (Exception ex) {
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            }
        }
    }

    public int deleteFactureFille(String idFactureFille) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            int i = fl.deleteFactureFille(idFactureFille, u.getTuppleID());
            return i;
        } catch (CreateException ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String updateFactureFille(String idFactureFille, String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateFactureFille(idFactureFille, idFactureMere, refObj, des, qte, unite, pu, reductionF, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateFactureFournisseur(String nomTable, String idf, String numFact, String designation, java.sql.Date daty, String fournisseur, double tva, double montantTTC, String remarque, java.sql.Date dateemission, String idDevise) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateFactureFournisseur(nomTable, idf, numFact, designation, daty, fournisseur, tva, montantTTC, remarque, dateemission, idDevise, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactureFille[] findFactureFilleConn(String idFactureFille, String refObj, String idSCatService, String idFactureMere, Connection c) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactureFille afacturefille[] = fl.findFactureFilleConn(idFactureFille, refObj, idSCatService, idFactureMere, c);
            return afacturefille;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactureFille[] findFactureFille(String idFactureFille, String refObj, String idSCatService, String idFactureMere) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactureFille afacturefille[] = fl.findFactureFille(idFactureFille, refObj, idSCatService, idFactureMere);
            return afacturefille;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureRedevance(String idClient, String daty, String dateDebut, String datyFin, String sCatService) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFactureRedevance(idClient, daty, dateDebut, datyFin, sCatService, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public float calculPenalite(String datyDebut, String datyFin, String idSCatService) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            float f = pl.calculPenalite(datyDebut, datyFin, idSCatService, u.getTuppleID());
            return f;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String createAutorisationAnnulation(String idObjet, String responsable, String daty, String motif, String idTypeObjet) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                fl = FactureEJBClient.getInterface();
                String s = fl.createAutorisationAnnulation(idObjet, responsable, daty, motif, idTypeObjet, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            System.out.println(ex.getMessage());
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteAutorisationAnnulation(String idAutorisation) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteAutorisationAnnulation(idAutorisation, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty, String motif, String idTypeObjet) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0 || u.getIdrole().compareTo("assistCom") == 0) {
                fl = FactureEJBClient.getInterface();
                String s = fl.updateAutorisationAnnulation(idAutorisation, idObjet, responsable, daty, motif, idTypeObjet, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public AutorisationAnnulation[] findAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty1, String daty2, String motif, String idTypeObjet) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            AutorisationAnnulation aautorisationannulation[] = fl.findAutorisationAnnulation(idAutorisation, idObjet, responsable, daty1, daty2, motif, idTypeObjet);
            return aautorisationannulation;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createService(String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createService(sCatService, datyDebutValid, unite, des, pu, devise, tva, idClient, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteService(String idService) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteService(idService, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateService(String idService, String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateService(idService, sCatService, datyDebutValid, unite, des, pu, devise, tva, idClient, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Service[] findService(String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Service aservice[] = fl.findService(idService, idSCatService, daty1, daty2, unite, des, devise, idClient);
            return aservice;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createSCatService(String nomSCat, String cat, String periodeFacturation, String factureEn) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createSCatService(nomSCat, cat, periodeFacturation, factureEn, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteSCatService(String idSCatService) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteSCatService(idSCatService, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, String factureEn) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateSCatService(idSCatService, nomSCat, cat, periodeFacturation, factureEn, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createCaisseComptable(String descCaisse, String respCaisse, String comptable) throws Exception {
        //utilis�e user
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = fi.createCaisseComptable(descCaisse, respCaisse, "etaCs1", comptable, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            throw new Exception(ex.getMessage());
        }
    }

    public String createCaisse(String descCaisse, String respCaisse) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = fi.createCaisse(descCaisse, respCaisse, "etaCs1", u.getTuppleID());
            return s;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            throw new Exception(ex.getMessage());
        }
    }

    public String updateCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = fi.updateCaisse(idCaisse, descCaisse, respCaisse, etatCaisse, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteCaisse(String idCaisse) throws Exception {
        FinanceEjb fi = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                fi = FinanceEjbClient.getInterface();
                int i = fi.deleteCaisse(idCaisse, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Caisse[] findCaisse(String idCaisse, String descCaisse, String respCaisse, String etatCaisse) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Caisse acaisse[] = fi.findCaisse(idCaisse, descCaisse, respCaisse, etatCaisse);
            return acaisse;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createSortie(String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String rem, String parution, String agence, String prj, String part, String fact, String idLigne) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = fi.createSortie(datee, desi, mont, ben, typ, dev, mode, cais, rem, u.getTuppleID(), parution, agence, prj, part, fact, idLigne);
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateSortie(String idSortie, String datee, String desi, String mont, String ben, String typ, String dev, String mode, String cais, String eta, String rem, String prj, String part, String fact) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = fi.updateSortie(idSortie, datee, desi, mont, ben, typ, dev, mode, cais, eta, rem, u.getTuppleID(), prj, part, fact);
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteSortie(String idSortie) throws Exception {
        /*FinanceEjb fi = null;
        try
        {
            fi = FinanceEjbClient.getInterface();
            int i = fi.deleteSortie(idSortie, u.getTuppleID());
            return i;
        }
        catch(ErreurDAO ex)
        {
            throw new Exception(ex.getMessage());
        }*/
        return 1;
    }

    public Sortie[] findSortie(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Sortie asortie[] = fi.findSortie(idSortie, daty1, daty2, beneficiaire, typeSortie, designation, idModePaiement, idDevise, idCaisse, idEtat);
            return asortie;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Sortie[] findSortieSourceCaisse(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String sourceC) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Sortie asortie[] = fi.findSortieSourceCaissse(idSortie, daty1, daty2, beneficiaire, typeSortie, designation, idModePaiement, idDevise, idCaisse, idEtat, sourceC);
            return asortie;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Sortie[] findSortieAgence(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String idLigne) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Sortie asortie[] = fi.findSortieAgence(idSortie, daty1, daty2, beneficiaire, typeSortie, designation, idModePaiement, idDevise, idCaisse, idEtat, parution, agence, colonne, ordre, prj, part, fact, idLigne);
            return asortie;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Sortie[] findSortieLettre(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String prj, String part, String fact, String aW) throws Exception {

        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Sortie asortie[] = fi.findSortieLettre(idSortie, daty1, daty2, beneficiaire, typeSortie, designation, idModePaiement, idDevise, idCaisse, idEtat, parution, agence, colonne, ordre, prj, part, fact, aW);

            return asortie;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createEntree(String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String rem, String paru, String agence, String source, String prj, String part, String idLigne) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = null;
            s = fi.createEntree(datee, desi, mont, sour, typ, n_pie, dev, mode, cais, rem, u.getTuppleID(), paru, agence, source, prj, part, idLigne);
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateEntree(String idEntree, String datee, String desi, String mont, String sour, String typ, String n_pie, String dev, String mode, String cais, String eta, String rem, String prj, String part, String idLigne) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            String s = fi.updateEntree(idEntree, datee, desi, mont, sour, typ, n_pie, dev, mode, cais, eta, rem, u.getTuppleID(), prj, part, idLigne);
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteEntree(String idEntree) throws Exception {
        FinanceEjb fi = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                fi = FinanceEjbClient.getInterface();
                int i = fi.deleteEntree(idEntree, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Entree[] findEntreePiece(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Entree aentree[] = fi.findEntree(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, numPiece, idDevise, idCaisse, idEtat);
            return aentree;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Entree[] findEntreeAgence(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Entree aentree[] = fi.findEntreeAgence(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, numPiece, idDevise, idCaisse, idEtat, agence, parution, colonne, ordre);
            return aentree;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Entree[] findEntreeLettre(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre, String prj, String part, String apresWhere) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Entree aentree[] = fi.findEntreeLettre(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, numPiece, idDevise, idCaisse, idEtat, agence, parution, colonne, ordre, prj, part, apresWhere);
            return aentree;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Entree[] findEntreeLettrePage(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre, String prj, String part, String apresWhere, int numPa) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Entree aentree[] = fi.findEntreeLettrePage(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, numPiece, idDevise, idCaisse, idEtat, agence, parution, colonne, ordre, prj, part, apresWhere, numPa);
            return aentree;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Entree[] findEntree(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Entree aentree[] = fi.findEntree(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, "%", idDevise, idCaisse, idEtat);
            return aentree;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Entree[] findEntreeBenCaisse(String idEntree, String daty1, String daty2, String client, String typeEntree, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String benCaisse) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            Entree aentree[] = fi.findEntreeBenCaisse(idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, "%", idDevise, idCaisse, idEtat, benCaisse);
            return aentree;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createHistorique(String dateHistorique, String heure, String objet, String action, String refuser, String refObjet) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            String s = rl.createHistorique(dateHistorique, heure, objet, action, refuser, refObjet);
            return s;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateHistorique(String idHistorique, String dateHistorique, String heure, String objet, String action, String refuser, String refObjet) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            String s = rl.updateHistorique(idHistorique, dateHistorique, heure, objet, action, refuser, refObjet);
            return s;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteHistorique(String idHistorique) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                rl = HistoriqueClient.getInterface();;
                int i = rl.deleteHistorique(idHistorique, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapHistorique[] findHistoriquePage(String refuser, String refObjet, String objet, String action, String daty1, String daty2, int numPage) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                MapHistorique amaphistorique[] = rl.findHistoriquePage(refuser, refObjet, objet, action, daty1, daty2, numPage);
                return amaphistorique;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapHistorique[] findHistorique(String refuser, String refObjet, String objet, String action, String daty1, String daty2) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                MapHistorique amaphistorique[] = rl.findHistorique(refuser, refObjet, objet, action, daty1, daty2);
                return amaphistorique;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createHistoriqueEtat(String idMere, String idUser, String idEtat, String dateModification) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            String s = rl.createHistoriqueEtat(idMere, idUser, idEtat, dateModification);
            return s;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateHistoriqueEtat(String idHistoriqueEtat, String idMere, String idUser, String idEtat, String dateModification) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            String s = rl.updateHistoriqueEtat(idHistoriqueEtat, idMere, idUser, idEtat, dateModification);
            return s;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteHistoriqueEtat(String idHistoriqueEtat) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                int i = rl.deleteHistoriqueEtat(idHistoriqueEtat, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public HistoriqueEtat[] findHistoriqueEtat(String idHistoriqueEtat, String idMere, String idUser, String idEtat, String dateModification) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            HistoriqueEtat ahistoriqueetat[] = rl.findHistoriqueEtat(idHistoriqueEtat, idMere, idUser, idEtat, dateModification);
            return ahistoriqueetat;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createAccident(String datySaisie, String datyAccident, String description, String nomEmploye, String rem) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createAccident(datySaisie, datyAccident, description, nomEmploye, rem, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateAccident(String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye, String rem) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.updateAccident(idAccident, datySaisie, datyAccident, description, nomEmploye, rem, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteAccident(String idAccident) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.deleteAccident(idAccident, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Accident[] findAccident(String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            Accident aaccident[] = pl.findAccident(idAccident, datySaisie, datyAccident, description, nomEmploye);
            return aaccident;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createChiffreAffTac(String mois, String annee, String montant) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createChiffreAffTac(mois, annee, montant, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateChiffreAffTac(String idChiffre, String mois, String annee, String montant) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.updateChiffreAffTac(idChiffre, mois, annee, montant, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteChiffreAffTac(String idChiffre) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.deleteChiffreAffTac(idChiffre, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ChiffreAffTac[] findChiffreAffTac(String idChiffre, String mois, String annee, String montant) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            ChiffreAffTac achiffreafftac[] = pl.findChiffreAffTac(idChiffre, mois, annee, montant);
            return achiffreafftac;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerChiffreAffTac(String idChiffre) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.annulerChiffreAffTac(idChiffre, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createVolCont(String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createVolCont(datySaisie, datyVol, numCont, designation, idDossier, proprietaire, montant, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateVolCont(String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.updateVolCont(idVol, datySaisie, datyVol, numCont, designation, idDossier, proprietaire, montant, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteVolCont(String idVol) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.deleteVolCont(idVol, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public VolConteneur[] findVolCont(String idVol, String datyInf, String datySup, String numCont, String designation, String idDossier, String proprietaire, String montant) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            VolConteneur avolconteneur[] = pl.findVolCont(idVol, datyInf, datySup, numCont, designation, idDossier, proprietaire, montant);
            return avolconteneur;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createDommageConteneur(String datyDebut, String datyFin, String designation, String montant, String idDossier, String nomProprietaire) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createDommageConteneur(datyDebut, datyFin, designation, montant, idDossier, nomProprietaire, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateDommageConteneur(String idDommage, String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.updateDommageConteneur(idDommage, datySaisie, datyDommage, designation, montant, idDossier, nomProprietaire, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteDommageConteneur(String idDommage) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.deleteDommageConteneur(idDommage, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public DommageConteneur[] findDommageConteneur(String idDommage, String datyInf, String datySup, String designation, String montant, String idDossier, String nomProprietaire) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            DommageConteneur adommageconteneur[] = pl.findDommageConteneur(idDommage, datyInf, datySup, designation, montant, idDossier, nomProprietaire);
            return adommageconteneur;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateParametrePenalite(String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String datyD, String pxAccExc) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                String s = pl.updateParametrePenalite(tauxDirBcEurop, majorBcEurop, delaiPaiementPenalit, performAnnuel, slTauxOccup, majorTauxOccup, slRappPerteAnnu, slNbPerteAnnu, pxUnitVol, slRappDommagTotal, pxPourcExc, valLimitcont, nbLimitAccAnnu, pxAccExc, datyD, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ParametrePenalite[] findParametrePenalite(String idParametrePenalite, String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String date1) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            ParametrePenalite aparametrepenalite[] = pl.findParametrePenalite(idParametrePenalite, tauxDirBcEurop, majorBcEurop, delaiPaiementPenalit, performAnnuel, slTauxOccup, majorTauxOccup, slRappPerteAnnu, slNbPerteAnnu, pxUnitVol, slRappDommagTotal, pxPourcExc, valLimitcont, nbLimitAccAnnu, pxAccExc, date1);
            return aparametrepenalite;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String createTva(String val, String daty) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createTva(val, daty, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateTva(String idTva, String val, String daty) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateTva(idTva, val, daty, u.getTuppleID());
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteTva(String idTva) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.deleteTva(idTva, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Tva[] findTva(String idTva, String val, String daty1, String daty2) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Tva atva[] = fl.findTva(idTva, val, daty1, daty2);
            return atva;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createUtilisateurs(String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("dg") == 0) {
                rl = HistoriqueClient.getInterface();;
                String s = rl.createUtilisateurs(loginuser, pwduser, nomuser, adruser, teluser, idrole, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateUtilisateurs(String refuser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            if (u.getIdrole().compareTo("dg") == 0) {
                return rl.updateUtilisateurs(refuser, loginuser, pwduser, nomuser, adruser, teluser, idrole, u.getTuppleID());
            } else if (String.valueOf(u.getRefuser()).compareTo(refuser) == 0) {
                return rl.updateUtilisateurs(refuser, loginuser, pwduser, nomuser, adruser, teluser, u.getIdrole(), u.getTuppleID());
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteUtilisateurs(String refuser) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                int i = rl.deleteUtilisateurs(refuser, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapUtilisateur[] findUtilisateurs(String refuser, String loginuser, String pwduser, String nomuser, String adruser, String teluser, String idrole) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            MapUtilisateur amaputilisateur[] = rl.findUtilisateurs(refuser, loginuser, pwduser, nomuser, adruser, teluser, idrole);
            return amaputilisateur;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFacturePenalite(String[] idPenalite) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createFacturePenalite(idPenalite, u.getTuppleID());
            return s;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createPenalite(String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createPenalite(dateDebut, dateFin, designation, montant, idSCatService, champ1, champ2, champ3, champ4, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updatePenalite(String idPenalite, String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            String s = pl.updatePenalite(idPenalite, dateDebut, dateFin, designation, montant, idSCatService, champ1, champ2, champ3, champ4, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deletePenalite(String idPenalite) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.deletePenalite(idPenalite, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Penalite[] findPenalite(String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            Penalite apenalite[] = pl.findPenalite(idPenalite, daty, "", designation, montant, idSCatService, champ1, champ2, champ3, champ4);
            return apenalite;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerPenalite(String idPenalite) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.annulerPenalite(idPenalite, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulationFacture(String idFactureMere) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.annulationFacture(idFactureMere, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int verifChevauch(String datyFin, String idSCatService) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            int i = fl.verifChevauch(datyFin, datyFin, idSCatService);
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateParametreFacture(String dateLimite, String bonusEvp, String red, String dateDebutValid) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                String s = fl.updateParametreFacture(dateLimite, bonusEvp, red, dateDebutValid, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            String s1 = null;
            return s1;
        }
    }

    public ParametreFacture[] findParametreFacture(String idParametreFacture, String dateLimite, String bonusEvp, String red, String date1, String date2) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            ParametreFacture aparametrefacture[] = fl.findParametreFacture(idParametreFacture, dateLimite, bonusEvp, red, date1, date2);
            return aparametrefacture;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            SCatService ascatservice[] = fl.findSCatService(idSCatService, nomSCat, cat, periodeFacturation);
            return ascatservice;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, Connection conn) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            SCatService ascatservice[] = fl.findSCatService(idSCatService, nomSCat, cat, periodeFacturation, conn);
            return ascatservice;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Societe findMaSociete(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit) throws ErreurDAO {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Societe societe = fl.findMaSociete(idMaSociete, nomMaSociete, numCompte, tel, adr, numStat, nif, rc, tp, quit);
            Societe societe1 = societe;
            return societe1;
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public Societe[] findMaSocieteTab(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit, String entite) throws ErreurDAO {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Societe[] societe = fl.findMaSocieteTab(idMaSociete, nomMaSociete, numCompte, tel, adr, numStat, nif, rc, tp, quit, entite);
            return societe;
        } catch (Exception ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String updateMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                String s = fl.updateMaSociete(d, no, reg, adr, phone, fa, mai, ger, ni, sta, r, cap, b1, b2, log, t, q, entite, daty, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                String s = fl.createMaSociete(d, no, reg, adr, phone, fa, mai, ger, ni, sta, r, cap, b1, b2, log, t, q, entite, daty, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapRoles[] findRole(String descRole) throws Exception {
        Historique rl = null;
        try {
            rl = HistoriqueClient.getInterface();;
            MapRoles amaproles[] = rl.findRole(descRole);
            return amaproles;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createTrafic(String daty, String datyDebut, String datyFin, String nb, String rem, String idserv) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            String daty1 = null;
            String daty2 = null;
            daty1 = Utilitaire.getBorneDatyMoisAnnee(datyDebut, datyFin)[0];
            daty2 = Utilitaire.getBorneDatyMoisAnnee(datyDebut, datyFin)[1];
            pl = PenaliteEjbClient.getInterface();
            String s = pl.createTrafic(daty, daty1, daty2, nb, rem, idserv, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateTrafic(String idTrafic, String daty, String datyDebut, String datyFin, String nb, String rem, String idserv) throws ErreurDAO {
        PenaliteEjb pl = null;
        try {
            String daty1 = null;
            String daty2 = null;
            daty1 = Utilitaire.getBorneDatyMoisAnnee(datyDebut, datyFin)[0];
            daty2 = Utilitaire.getBorneDatyMoisAnnee(datyDebut, datyFin)[1];
            pl = PenaliteEjbClient.getInterface();
            String s = pl.updateTrafic(idTrafic, daty, daty1, daty2, nb, rem, idserv, u.getTuppleID());
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteTrafic(String idTrafic) throws Exception {
        try {
            double a = 10000000D;
            double v = 10000000D;
            double c = 1000D;
            HAHA h = new HAHA(a * v * c, 0.52500000000000002D);
            h.insertToTable();
            int j = 1;
            return j;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        int i = 0;
        return i;
    }

    public TraficConteneur[] findTrafic(String idTrafic, String datyDebut, String datyFin, String idserv) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            TraficConteneur atraficconteneur[] = pl.findTrafic(idTrafic, datyDebut, datyFin, idserv);
            return atraficconteneur;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public TraficConteneur[] findTraficPeriode(String idTrafic, String datyDebut, String datyFin, String idserv, String mois1, String mois2, String annee1, String annee2) throws Exception {
        PenaliteEjb pl = null;
        try {
            String daty1 = null;
            String daty2 = null;
            daty1 = Utilitaire.getBorneDatyMoisAnnee(mois1, annee1)[0];
            daty2 = Utilitaire.getBorneDatyMoisAnnee(mois2, annee2)[1];
            pl = PenaliteEjbClient.getInterface();
            TraficConteneur atraficconteneur[] = pl.findTrafic(idTrafic, daty1, daty2, idserv);
            return atraficconteneur;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerTrafic(String idTrafic) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.annulerTrafic(idTrafic, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int attacherOPLCDupl(String idFactureF, LigneCredit[] listeLC, String rem, String montantmere) throws Exception {

        try {
            for (int i = 0; i < listeLC.length; i++) {

            }
        } catch (Exception ex) {

        }
        return 0;
    }

    public ParametreFacture findParametreFactureEnCours(String daty) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            ParametreFacture parametrefacture = fl.findParametreFactureEnCours(daty);
            return parametrefacture;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MapUtilisateur getUser() {
        return u;
    }

    public String finaliseFacture(String id) throws Exception {
        try {
            FactureEjb fl = FactureEJBClient.getInterface();
            String s = fl.finaliseFacture(id, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public ParametreFacture loadParametreFacture(String daty1) throws Exception {
        try {
            FactureEjb fl = FactureEJBClient.getInterface();
            ParametreFacture parametrefacture = fl.loadParametreFacture(daty1);
            return parametrefacture;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ParametrePenalite loadParametrePenalite(String daty1) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            ParametrePenalite parametrepenalite = pl.loadParametrePenalite(daty1);
            return parametrepenalite;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerEntree(String idEntree) throws Exception {
        FinanceEjb fi = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                fi = FinanceEjbClient.getInterface();
                int i = fi.annulerEntree(idEntree, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de Droit");
            }
        } catch (CreateException ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    @Override
    public int annulerSortie(String idSortie) throws Exception, ErreurDAO {
        FinanceEjb fi = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                fi = FinanceEjbClient.getInterface();
                int i = fi.annulerSortie(idSortie, u.getTuppleID());
                return i;
            } else {
                throw new ErreurDAO("Erreur de Droit");
            }
        } catch (CreateException ex) {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public int getMontantBilletage(String dix, String cinq, String deux, String un, String deuxCinq, String deuxCent, String cent, String cinquante, String vingt) {
        int retour1 = Utilitaire.stringToInt(dix) * 10000 + 5000 * Utilitaire.stringToInt(cinq) + 2000 * Utilitaire.stringToInt(deux) + 1000 * Utilitaire.stringToInt(un);
        int retour2 = Utilitaire.stringToInt(deuxCinq) * 500 + 200 * Utilitaire.stringToInt(deuxCent) + 100 * Utilitaire.stringToInt(cent) + 50 * Utilitaire.stringToInt(cinquante) + 20 * Utilitaire.stringToInt(vingt);
        return retour1 + retour2;
    }

    public Change[] findChange(String idChange, String idDevise, String datyInf) throws Exception {
        try {
            Change achange[] = FactureEJBClient.getInterface().findChange(idChange, idDevise, datyInf);
            return achange;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int verifPenalite(String mois, String annee) throws Exception {
        try {
            String daty1 = null;
            String daty2 = null;
            daty1 = Utilitaire.getBorneDatyMoisAnnee(mois, annee)[0];
            daty2 = Utilitaire.getBorneDatyMoisAnnee(mois, annee)[1];
            int i = PenaliteEjbClient.getInterface().verifPenalite(daty1, daty2, u.getTuppleID());
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Objet[] findObjet(String obj, String des) throws Exception {
        try {
            Objet aobjet[] = HistoriqueClient.getInterface().findObjet(obj, des);
            return aobjet;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Tva loadTva(String daty1) throws Exception {
        try {
            Tva tva = FactureEJBClient.getInterface().loadTva(daty1);
            return tva;
        } catch (Exception ex) {
            Tva tva1 = null;
            return tva1;
        }
    }

    public String createFacturePenalite(String idPenalite) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFacturePenalite(idPenalite, u.getTuppleID());
            return s;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Penalite[] findPenaliteNonFacture(String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            Penalite apenalite[] = pl.findPenaliteNonFacture(idPenalite, "", designation, montant, idSCatService, champ1, champ2, champ3, champ4);
            return apenalite;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFacture(String idFact, String daty1, String daty2, String etat, String clien) throws Exception {
        try {
            EtatFacture aetatfacture[] = FactureEJBClient.getInterface().findEtatFacture(idFact, daty1, daty2, etat, clien);
            return aetatfacture;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Change[] findChange(String idChange, String etat) throws Exception {
        try {
            Change achange[] = FactureEJBClient.getInterface().findChange(idChange, etat);
            return achange;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int desactiveUtilisateur(String ref) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                int i = rl.desactiveUtilisateur(ref, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }
//        public static String getMaxId(String table){
//
//               
//  }

    public int activeUtilisateur(String ref) throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                int i = rl.activeUtilisateur(ref, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int testException() throws Exception {
        Historique rl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                rl = HistoriqueClient.getInterface();;
                int i = rl.testException();
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureTaxe(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise) throws Exception {
        try {
            EtatFacture aetatfacture[] = FactureEJBClient.getInterface().findEtatFactureTaxe(idFact, daty1, daty2, etat, clien, scat, devise);
            return aetatfacture;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Ecriture[] findEcriture(String idEcriture, String daty1, String daty2, String libelle, String compte, String piece) throws Exception {
        try {
            Ecriture aecriture[] = FactureEJBClient.getInterface().findEcriture(idEcriture, daty1, daty2, libelle, compte, piece);
            return aecriture;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Compte[] findCompte(String id, String typ, String desc, String daty) throws Exception {
        try {
            Compte acompte[] = FactureEJBClient.getInterface().findCompte(id, typ, desc, daty);
            return acompte;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createAvoir(String idFact, String resp, String da, String mot, String mont, String typ) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                String s = fl.createAvoir(idFact, resp, da, mot, mont, typ, u.getTuppleID());
                return s;
            } else {
                throw new Exception("Erreur de Droit");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateAvoir(String idAv, String idFact, String resp, String da, String mot, String mont) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.updateAvoir(idAv, idFact, resp, da, mot, mont, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Avoir[] findAvoir(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Avoir aavoir[] = fl.findAvoir(idAv, idFact, resp, datyDebut, datyFin, mot, typ);
            return aavoir;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Avoir[] findAvoirValide(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Avoir aavoir[] = fl.findAvoirValide(idAv, idFact, resp, datyDebut, datyFin, mot, typ);
            return aavoir;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulationAvoir(String idAvoir) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareToIgnoreCase("admin") != 0 && u.getIdrole().compareToIgnoreCase("dg") != 0 && u.getIdrole().compareToIgnoreCase("adminFacture") != 0) {
                throw new Exception("Erreur de Droit");
            } else {
                fl = FactureEJBClient.getInterface();
                int i = fl.annulationAvoir(idAvoir, u.getTuppleID());
                return i;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createChange(String idDevise, String valeurEnAriary, String datyDebutValid) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createChange(idDevise, valeurEnAriary, datyDebutValid, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateChange(String idChange, String idDevise, String valeurEnAriary, String s) {
        return null;
    }

    public SynthesePointage[] finSynthese(String datyinf, String datySup) throws Exception {
        try {
            SynthesePointage asynthesepointage[] = PenaliteEjbClient.getInterface().findSynthese(datyinf, datySup);
            return asynthesepointage;
        } catch (Exception ex) {
            SynthesePointage asynthesepointage1[] = null;
            return asynthesepointage1;
        }
    }

    public int calculNombrePage(int nombreElement) {
        if (nombreElement % Parametre.getNbParPage() == 0) {
            return nombreElement / Parametre.getNbParPage();
        } else {
            return 1 + nombreElement / Parametre.getNbParPage();
        }
    }

    public int calculHistoriquePage(String refuser, String refObjet, String objet, String action, String daty1, String daty2) throws Exception {
        try {
            int i = HistoriqueClient.getInterface().calculHistoriquePage(refuser, refObjet, objet, action, daty1, daty2);
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public double calculChange(String valeur, String devise1, String devise2, String daty) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            double d = fl.calculChange(valeur, devise1, devise2, daty);
            return d;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public facture.Change loadChangeValide(String devise, String datyInf) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            Change change = fl.loadChangeValide(devise, datyInf);
            return change;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createBeneficiaireCompta(String va, String des, String comptable) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            TypeObjet cmpte = new TypeObjet("beneficiaire", "getSeqBeneficiaire", "BE", va, des);
            MapHistorique h = new MapHistorique("Beneficiaire", "insert", u.getTuppleID(), cmpte.getTuppleID());
            cmpte.insertToTable(c);
            h.insertToTable(c);
            String idB = cmpte.getTuppleID();
            FactureEJBClient.getInterface().createCompteConnection(comptable, idB, String.valueOf(Utilitaire.dateDuJourSql()), u.getTuppleID(), c);

            c.commit();

            String s = cmpte.getTuppleID();
            return s;
        } catch (Exception e) {
            c.rollback();
            throw new Exception(e.getMessage());
        } finally {
            c.close();
        }
    }

    public int annulerDevise(String idDevise) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            int i = fl.annulerDevise(idDevise, u.getTuppleID());
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerCompte(String idCompte) throws Exception {
        FactureEjb fl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0 || u.getIdrole().compareTo("adminFacture") == 0) {
                fl = FactureEJBClient.getInterface();
                int i = fl.annulerCompte(idCompte, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createCompte(String val, String desc, String datyDebutVal) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createCompte(val, desc, datyDebutVal, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public double calculCA(String datyInf, String datySup) throws Exception {
        PenaliteEjb pl = null;
        try {
            pl = PenaliteEjbClient.getInterface();
            double d = pl.calculCA(datyInf, datySup);
            return d;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim) throws Exception {
        try {
            String s = FactureEJBClient.getInterface().finaliseFactureUpdate(idFact, daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String finaliseFactureUpdateConnProforma(String idFacture, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String user, Connection c) throws Exception {
        try {
            Date dte = Utilitaire.string_date("dd/MM/yyyy", daty);
            Date periodeF = Utilitaire.string_date("dd/MM/yyyy", periodeFin);
            if ((idSCatService.compareToIgnoreCase("scat2") == 0 || idSCatService.compareToIgnoreCase("scat1") == 0)) {
                throw new Exception("Existance de chevauchement");
            }
            //if(Utilitaire.compareDaty(dte, periodeF) == -1)
            // throw new Exception("Date d'�dition et p�riode fin non conformes!");
            ParametreFacture pf = loadParametreFacture(periodeDebut);
            int duree = pf.getDelaiPaiement();
            ParametrePenalite ppen = PenaliteEjbClient.getInterface().loadParametrePenalite(periodeDebut);
            int dureePen = ppen.getDelaiPaiementPenalite();
            FactMere fm = findFactureMereProforma("", "", idFacture, "%", "", "%", "%", "%")[0];
            fm.setIdClient(idClient);
            fm.setNoteExplicative(noteExplicative);
            fm.setIdTypePaiement(idTypePaim);
            fm.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
            fm.setPeriodeDebut(Utilitaire.string_date("dd/MM/yyyy", periodeDebut));
            fm.setPeriodeFin(Utilitaire.string_date("dd/MM/yyyy", periodeFin));
            fm.setIdTva(Utilitaire.stringToInt(idTva));
            fm.setIdFactureEn(idFactureEn);
            fm.setIdDeviseEn(idDeviseEn);
            fm.setReduction(Utilitaire.stringToInt(reduction));
            if (fm.getIdSCatService().compareToIgnoreCase("scat3") == 0) {
                fm.setDateLimitePaiement(Utilitaire.ajoutMoisDate(fm.getDaty(), dureePen));
            } else {
                fm.setDateLimitePaiement(Utilitaire.ajoutJourDate(fm.getDaty(), duree));
            }
            FactMere ffin = new FactMere(fm.getTuppleID(), fm.getDaty(), fm.getPeriodeDebut(), fm.getPeriodeFin(), fm.getIdClient(), fm.getNoteExplicative(), fm.getIdTva(), fm.getIdFactureEn(), fm.getIdDeviseEn(), fm.getReduction(), fm.getIdCoursChange(), fm.getIdEtat(), fm.getDateLimitePaiement(), fm.getMontantAPayer(), fm.getIdSCatService(), fm.getIdTypePaiement(), fm.getResp(), fm.getEntite(), fm.getParution(), "");
            FactureFille ff[] = null;
            ff = fm.getFactureFilleProforma(c);
            //fm.setNomTable("facturefilleproforma");
            double montantAP = fm.getMontantTtcProforma();
            if (fm.getIdEtat().compareToIgnoreCase("eta4") == 0) {
                throw new Exception("Facture d�j� finalis�e");
            }
            if (montantAP <= (double) 0) {
                throw new Exception("Facture de montant �gal � 0");
            }
            ffin.setNomProcedureSequence("getSeqFactureFinaliseProforma");
            SCatService scc = findSCatService(ffin.getIdSCatService(), "", "", "")[0];
            TypeObjetUtil tu = new TypeObjetUtil();
            tu.setNomTable("beneficiaire");
            bean.TypeObjet ben = (TypeObjet) tu.rechercher(1, ffin.getEntite(), c)[0];
            facture.FactureEjbBean feb = new facture.FactureEjbBean();
            String retour = feb.makeIndiceFactureEntite(ffin.getDaty(), ffin.getIdTypePaiement(), Utilitaire.getDebutmot(scc.getNomSCatService()), Utilitaire.getDebutMots(ben.getDesce()));
            //System.out.print("retour anatiny:"+retour);
            ffin.setIndicePk("PROF" + retour);
            ffin.setIdEtat("eta4");
            ffin.setIdFactureMere(ffin.makePKCFinEntiteProforma(daty, ffin.getEntite()));
            ffin.setMontantAPayer(montantAP);
            ffin.insertToTable(c);
            for (int g = 0; g < ff.length; g++) {
                ff[g].setIdFactureFille(ff[g].getIdFactureFille());
                ff[g].setNomTable("facturefilleproforma");
                ff[g].setIdFactureMere(ffin.getTuppleID());
                ff[g].setDesignation(ff[g].getDesignation());
                ff[g].setIdUnite(ff[g].getIdUnite());
                ff[g].setReduction(ff[g].getReduction());
                ff[g].setRefObj(ff[g].getRefObj());
                ff[g].setPrixUnitaire(ff[g].getPrixUnitaire());
                ff[g].setQuantite(ff[g].getQuantite());
                ff[g].updateToTable(c);
            }

            MapHistorique hfm = new MapHistorique("factureMereProforma", "finalise", user, ffin.getTuppleID());
            hfm.insertToTable(c);
            fm.setNomTable("facturemereproforma");
            fm.deleteToTable(c);
            HistoriqueEtat he = new HistoriqueEtat(idFacture, user, "eta4", Utilitaire.dateDuJourSql());
            MapHistorique hhe = new MapHistorique("HistoriqueEtat", "create", user, he.getTuppleID());
            he.insertToTable(c);
            hhe.insertToTable(c);
            Compte compteFact = findCompte("%", "%", ffin.getIdSCatService(), Utilitaire.dateDuJour())[0];
            Compte compteClient = findCompte("%", "%", ffin.getIdClient(), Utilitaire.dateDuJour())[0];
            Compte compteTva = findCompte("%", "%", "TVA", Utilitaire.dateDuJour())[0];
            Compte compteVirement = findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
            feb.createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantHTvaProforma()), ffin.getTuppleID(), user, c);
            feb.createEcritureConnection(Utilitaire.dateDuJour(), compteTva.getId(), "TVA sur facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantTvaProforma()), ffin.getTuppleID(), user, c);
            if (ffin.getIdTypePaiement().compareTo("typ01") == 0) {
                feb.createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtcProforma()), "0", ffin.getTuppleID(), user, c);
            } else {
                feb.createEcritureConnection(Utilitaire.dateDuJour(), compteVirement.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtcProforma()), "0", ffin.getTuppleID(), user, c);
            }
            ffin.makePK(c);
            String s = ffin.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String finaliseFactureUpdateProforma(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            String retour = finaliseFactureUpdateConnProforma(idFact, daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, u.getTuppleID(), c);
            //System.out.println("retour:"+retour);
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("facturemereproforma");
            FactMere[] fm = (FactMere[]) fmu.rechercher(1, retour, c);
            if (fm.length == 0) {
                throw new Exception("Facture mere " + retour + " non existante");
            }
            //public FactureFournisseur(String nomTable,String numFact,String designation,String dE, String dR, String idFrns,String idTVA,String mTTC,String rmq, String idDevise)
            //System.out.println("Montant tva " + String.valueOf(fm[0].getMontantTvaProforma()) + " Montant ttc fournisseur" + String.valueOf(fm[0].getMontantTtcProforma()));

            facturefournisseur.FactureFournisseur fc = new facturefournisseur.FactureFournisseur("factureclientproforma", retour, "facture client auto selon " + retour, daty, daty, fm[0].getIdClient(), String.valueOf(fm[0].getMontantTvaProforma()), String.valueOf(fm[0].getMontantTtcProforma()), fm[0].getResp(), fm[0].getIdDeviseEn(), "", "",c);
            fc.setResp(fm[0].getResp());
            fc.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            String s = retour;
            return s;
        } catch (Exception ex) {
            try {
                c.rollback();
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            } catch (Exception ss) {
                throw new Exception(ss.getMessage());
            }
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                throw new Exception(ex.getMessage());
            }
        }
    }

    public String finaliseFactureUpdateProforma(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, Connection c) throws Exception {
        try {
            String retour = finaliseFactureUpdateConnProforma(idFact, daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, u.getTuppleID(), c);
            //System.out.println("retour:"+retour);
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("facturemereproforma");
            FactMere[] fm = (FactMere[]) fmu.rechercher(1, retour, c);
            if (fm.length == 0) {
                throw new Exception("Facture mere " + retour + " non existante");
            }
            //public FactureFournisseur(String nomTable,String numFact,String designation,String dE, String dR, String idFrns,String idTVA,String mTTC,String rmq, String idDevise)
            //System.out.println("Montant tva " + String.valueOf(fm[0].getMontantTvaProforma()) + " Montant ttc fournisseur" + String.valueOf(fm[0].getMontantTtcProforma()));

            facturefournisseur.FactureFournisseur fc = new facturefournisseur.FactureFournisseur("factureclientproforma", retour, "facture client auto selon " + retour, daty, daty, fm[0].getIdClient(), String.valueOf(fm[0].getMontantTvaProforma()), String.valueOf(fm[0].getMontantTtcProforma()), fm[0].getResp(), fm[0].getIdDeviseEn(), "", "",c);
            fc.setResp(fm[0].getResp());
            fc.insertToTableWithHisto(u.getTuppleID(), c);
            String s = retour;
            return s;
        } catch (Exception ex) {
            try {
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            } catch (Exception ss) {
                throw new Exception(ss.getMessage());
            }
        }
    }
    
    public String createDetPenRetard(String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat) throws Exception {
        try {
            String s = PenaliteEjbClient.getInterface().createDetPenRetard(idPenalit, datyIn, datySu, rest, nbJourRetar, numPiec, montat, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateDetPenRetard(String id, String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat) throws Exception {
        try {
            String s = PenaliteEjbClient.getInterface().updateDetPenRetard(id, idPenalit, datyIn, datySu, rest, nbJourRetar, numPiec, montat, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteDetPenRetard(String id) throws Exception {
        try {
            int i = PenaliteEjbClient.getInterface().deleteDetPenRetard(id, u.getTuppleID());
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public DetPenRetard[] findDetPenRetard(String id, String idPen, String daty1, String daty2, String nbJour, String numPiece) throws Exception {
        try {
            DetPenRetard adetpenretard[] = PenaliteEjbClient.getInterface().findDetPenRetard(id, idPen, daty1, daty2, nbJour, numPiece);
            return adetpenretard;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public SyntheseEVP[] findSyntheseEVP(String daty1, String daty2) throws Exception {
        try {
            SyntheseEVP asyntheseevp[] = FactureEJBClient.getInterface().findSyntheseEVP(daty1, daty2);
            return asyntheseevp;
        } catch (CreateException ex) {
            SyntheseEVP asyntheseevp1[] = null;
            return asyntheseevp1;
        }
    }

    public SyntheseEVP[] findSyntheseEVPMois(String mois, String annee) throws Exception {
        SyntheseEVP asyntheseevp[];
        try {
            String daty1 = null;
            String daty2 = null;
            daty1 = Utilitaire.getBorneDatyMoisAnnee(mois, annee)[0];
            daty2 = Utilitaire.getBorneDatyMoisAnnee(mois, annee)[1];
            SyntheseEVP asyntheseevp1[] = findSyntheseEVP(daty1, daty2);
            return asyntheseevp1;
        } catch (Exception ex) {
            asyntheseevp = null;
        }
        return asyntheseevp;
    }

    public int getNombreEVP(String mois, String annee) throws Exception {
        int i;
        try {
            int retour = 0;
            String daty1 = null;
            String daty2 = null;
            daty1 = Utilitaire.getBorneDatyMoisAnnee(mois, annee)[0];
            daty2 = Utilitaire.getBorneDatyMoisAnnee(mois, annee)[1];
            //retour = AdminSyntheseEVP.getSommeEVP(findSyntheseEVP(daty1, daty2));
            int j = 1;
            return j;
        } catch (Exception ex) {
            i = 0;
        }
        return i;
    }

    public int annulerAccident(String idAcc) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.annulerAccident(idAcc, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerVol(String idVol) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.annulerVol(idVol, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerDommage(String idDommage) throws Exception {
        PenaliteEjb pl = null;
        try {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                pl = PenaliteEjbClient.getInterface();
                int i = pl.annulerDommage(idDommage, u.getTuppleID());
                return i;
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void testLogin(String user, String pass) throws Exception {
        try {
            Historique rl = null;
            rl = HistoriqueClient.getInterface();
            u = rl.testeValide(user, pass);
            UtilisateurUtil crt = new UtilisateurUtil();
            uVue = crt.testeValide("utilisateurVue", user, pass);
            type = u.getIdrole();
            if (type.compareToIgnoreCase(utilitaire.Constante.getIdRoleDirecteur()) == 0) {
                Direction d[] = findDirection("", "", "", "", String.valueOf(u.getRefuser()));
                if (d.length > 0) {
                    this.setIdDirection(d[0].getIdDir());
                } else {
                    u.setIdrole("compta"); //default value of idrole
                    type = u.getIdrole();
                }
            }

            MapHistorique histo = new MapHistorique("login", "login", String.valueOf(u.getRefuser()), String.valueOf(u.getRefuser()));

            histo.insertToTable();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public ResultatEtSomme findVirement(String nomtable, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW, int numPage) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findVirement(nomtable, dev, caisse1, caisse2, mode, daty1, daty2, apreW, numPage);
    }

    public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        //if((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminCompta)==0))
        return fi.virer(montant, devise, caisse1, caisse2, mode, remarque, daty, u.getTuppleID());
        //else throw new Exception("Erreur de droit");
    }

    public void virerVirementMiltiple(String[] numCheque, String[] montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        fi.virerVirementMiltiple(numCheque, montant, devise, caisse1, caisse2, mode, remarque, daty, u.getTuppleID());
    }

    public Visa viserVirement(String idVir, String daty, String rem) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0)) {
            return fi.viserVirement(idVir, daty, rem, u.getTuppleID());
        } else {
            throw new Exception("Erreur de droit");
        }
    }

    public boolean virer(String daty, String caisse1, String caisse2, String montant, String remarque, String devise, String mode, String typeE, String typeS, String prj, String part, String fact, String idLigne) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            boolean flag = fi.virer(daty, caisse1, caisse2, montant, remarque, devise, mode, String.valueOf(u.getRefuser()), typeE, typeS, prj, part, fact, idLigne);
            return flag;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void ejbCreate() throws CreateException {
    }

    public EtatCaisseReste[] findEtatCaisseResteMvt(String daty1, String daty2, String caisse, String entite) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findEtatCaisseResteMvt(daty1, daty2, caisse, entite);
    }

    public EtatCaisseReste[] findEtatCaisseReportMvt(String daty1, String daty2, String caisse, String entite) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findEtatCaisseReportMvt(daty1, daty2, caisse, entite);
    }

    public ResultatEtSomme findReportPage(String daty1, String daty2, String caisse, String devise, int numP) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findReportPage(daty1, daty2, caisse, devise, numP);
    }

    public Report[] findReport(String daty1, String daty2, String caisse, String devise) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findReport(daty1, daty2, caisse, devise);
    }

    public void devaliderUnionIntraTable(UnionIntraTable[] lcc, String nomtable) throws Exception {
        for (int i = 0; i < lcc.length; i++) {
            lcc[i].setNomTable(nomtable);
            lcc[i].setEtat(0);
            lcc[i].upDateToTable();
        }
    }

    public Report reporter(String daty, String montant, String caisse, String devise) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.reporter(daty, montant, caisse, devise, u.getTuppleID());
    }

    public boolean reporter(String daty, String datyFin, String montant, String caisse, String devise, String prj, String part, String fact, String idLigne) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            boolean flag = fi.reporter(daty, datyFin, montant, caisse, devise, String.valueOf(u.getRefuser()), prj, part, fact, idLigne);
            return flag;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int updateORFacture(String idor, String montant) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            OrdonnerPayement orr = new OrdonnerPayement();
            orr.setNomTable("Ordonnerrecette");
            orr.setId(idor);
            OrdonnerPayement[] reponse = (OrdonnerPayement[]) CGenUtil.rechercher(orr, null, null, c, "");
            //public int updateOR(String nomTable,String numObjet,String ded_id,String rmq,String daty,String montant)throws Exception{

            // update OR
            LiaisonOrdrePayement temp = new LiaisonOrdrePayement();
            temp.setNomTable("LiaisonOrdrePayement");
            temp.setId1(idor);
            LiaisonOrdrePayement[] listtemp = (LiaisonOrdrePayement[]) CGenUtil.rechercher(temp, null, null, c, "");
            double montanttemp = Double.parseDouble(montant);
            if (listtemp.length > 0) {
                montanttemp += reponse[0].getMontant();
            } else {
                temp.construirePK(c);
                temp.setRemarque("-");
                temp.setDaty(Utilitaire.dateDuJourSql());
                temp.insertToTableWithHisto(u.getTuppleID(), c);
            }
            updateOR("Ordonnerrecette", idor, "", reponse[0].getRemarque(), Utilitaire.dateDuJour(), String.valueOf(montanttemp), c);

            // update Facture client
            FactureFournisseur fcc = new FactureFournisseur();
            fcc.setNomTable("factureclient");
            fcc.setIdFactureFournisseur(reponse[0].getDed_Id());
            FactureFournisseur[] listefcc = (FactureFournisseur[]) CGenUtil.rechercher(fcc, null, null, c, "");
            // listefcc[0].updateToTable(c);
            this.updateFactureFournisseur("factureclient", listefcc[0].getIdFactureFournisseur(), idor, listefcc[0].getDesignation(), listefcc[0].getDaty(), listefcc[0].getIdFournisseur(), listefcc[0].getIdTVA(), montanttemp, listefcc[0].getRemarque(), listefcc[0].getDateEmission(), listefcc[0].getIdDevise());

        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return 0;
    }

    public int updateOR(String nomTable, String numObjet, String ded_id, String rmq, String daty, String montant, Connection conn) throws Exception {
        OrdonnerPayement orr = new OrdonnerPayement();
        orr.setNomTable(nomTable);
        orr.setId(numObjet);
        try {
            OrdonnerPayement temp = ((OrdonnerPayement[]) CGenUtil.rechercher(orr, null, null, conn, ""))[0];
            temp.setEtat(temp.getEtat());
            temp.setIdLigne(temp.getIdLigne());
            temp.setDaty(Utilitaire.stringToSqlDate("dd/MM/yyyy", daty));
            temp.setMontant(Utilitaire.stringToDouble(montant));
            temp.setRemarque(rmq);
            temp.updateToTableWithHisto(u.getTuppleID(), conn);

            // mise � jour union intra table
            // redirection vers attachement LC
            
            MvtCaisse mvt = new MvtCaisse();
            mvt.setNomTable("MVTCAISSE");
            MvtCaisse[] listMvt = (MvtCaisse[]) CGenUtil.rechercher(mvt, null, null, conn, " and IDORDRE = '" + numObjet.trim() + "'");
            for (int i = 0; i < listMvt.length; i++) {
                listMvt[i].setDaty(Utilitaire.stringToSqlDate("dd/MM/yyyy", daty));
                listMvt[i].setDatyValeur(Utilitaire.stringToSqlDate("dd/MM/yyyy", daty));
                listMvt[i].updateToTableWithHisto(u.getTuppleID(), conn);
            }
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int updateOR(String nomTable, String numObjet, String ded_id, String rmq, String daty, String montant) throws Exception {
        Connection conn = null;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            int ret = updateOR(nomTable, numObjet, ded_id, rmq, daty, montant, conn);
            conn.commit();
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return 0;
    }

    public EtatFacture[] findEtatFactureResp(String idFact, String daty1, String daty2, String etat, String clien, String resp) throws Exception {
        try {
            EtatFacture ret[] = FactureEJBClient.getInterface().findEtatFactureResp(idFact, daty1, daty2, etat, clien, resp);
            EtatFacture aetatfacture[] = ret;
            return aetatfacture;
        } catch (CreateException ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureRespTypeEntite(String idFact, String daty1, String daty2, String etat, String clien, String resp, String type, String entite, String parution) throws Exception {
        try {
            EtatFacture ret[] = FactureEJBClient.getInterface().findEtatFactureRespTypeEntite(idFact, daty1, daty2, etat, clien, resp, type, entite, parution);
            EtatFacture aetatfacture[] = ret;
            return aetatfacture;
        } catch (CreateException ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureTaxeRespEntite(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise, String resp, String entite, String parution) throws Exception {
        try {
            EtatFacture ret[] = FactureEJBClient.getInterface().findEtatFactureTaxeRespEntite(idFact, daty1, daty2, etat, clien, scat, devise, resp, entite, parution);
            EtatFacture aetatfacture[] = ret;
            return aetatfacture;
        } catch (CreateException ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createEntryFacture(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String nature, String lc) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            //String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String refUser
            String s = gff.createEntiteFact(nature, numFact, designation, date, frns, tva, mTTC, rmq, datee, idDevise, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String createEntryFacture(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String nature) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            //String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String refUser
            String s = gff.createEntiteFact(nature, numFact, designation, date, frns, tva, mTTC, rmq, datee, idDevise, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String modifEntryFactureFseur(String idFct, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String nature) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            //String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String refUser
            String s = gff.modifEntiteFactFseur(idFct, nature, numFact, designation, date, frns, tva, mTTC, rmq, datee, datyEcheance, idDevise, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String createEntryFactureFseur(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String nature) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            //String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String refUser
            String s = gff.createEntiteFactFseur(nature, numFact, designation, date, frns, tva, mTTC, rmq, datee, datyEcheance, idDevise, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String createEntryFacture(String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            String s = gff.creerFactureFournisseur(numFact, designation, datee, date, frns, tva, mTTC, rmq, idDevise);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public ResultatEtSomme findFactureFournisseurPage(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW, int numPage) throws Exception {
        FactureFournisseur crt = new FactureFournisseur();
        crt.setIdFactureFournisseur(num);
        crt.setIdFournisseur(fournisseur);
        crt.setDesignation(designation);
        String colInt[] = {"daty"};
        String valInt[] = {dateDebut, dateFin};
        crt.setNomTable(nomTable);
        String[] colS = {"montantTTC"};
        return CGenUtil.rechercherPage(crt, colInt, valInt, numPage, apresW + " order by " + colonne + " " + ordre, colS);
        /*GestionFactureFournisseur gff = null;
    gff = GestionFactureFournisseurClient.getInterface();
    ResultatEtSomme ff = gff.findFactureFournisseurPage(nomTable,num, dateDebut,dateFin,fournisseur, designation, colonne,  ordre, apresW,numPage) ;
    return ff;*/
    }

    public FactureFournisseur[] findFactureFournisseur(String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception {
        FactureFournisseur crt = new FactureFournisseur();
        crt.setIdFactureFournisseur(num);
        crt.setIdFournisseur(fournisseur);
        crt.setDesignation(designation);
        String colInt[] = {"daty"};
        String valInt[] = {dateDebut, dateFin};
        //crt.setNomTable(nomTable);
        return (FactureFournisseur[]) CGenUtil.rechercher(crt, colInt, valInt, apresW + " order by " + colonne + " " + ordre);
    }

    public FactureFournisseur[] findFactureF(String num, String dateDebut, String dateFin, String fournisseur, String projet, String etat, String colonne, String ordre, String apresW) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            FactureFournisseur ff[] = gff.findFactureFournisseur(num, dateDebut, dateFin, fournisseur, projet, colonne, ordre, apresW);
            return ff;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactureFournisseur annulerFact(String nomTable, String nomTableLiaison, String id) throws Exception {
        GestionFactureFournisseur gff = null;
        gff = GestionFactureFournisseurClient.getInterface();
        if (u.getIdrole().compareToIgnoreCase("dg") == 0) {
            return gff.annulerFact(nomTable, nomTableLiaison, id, u.getTuppleID());
        } else {
            throw new Exception("Erreur de droit");
        }
    }

    public String createFournisseur(String fournisseur, String nif, String stat, String tel, String email, String adresse) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            String s = gff.createFournisseur(fournisseur, nif, stat, tel, email, adresse);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public Fournisseur[] findFournisseurF(String idF, String fournisseur, String nif, String stat, String tel, String email, String adresse, String apresW) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            Fournisseur frs[] = gff.findFournisseurF(idF, fournisseur, nif, stat, tel, email, adresse, apresW);
            return frs;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public FactureFournisseur[] lolo() {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String cloturerFactureFournisseur(String idf, String numFact, String designation, String daty, String fournisseur, String montantHT, String tva, String montantTTC, String remarque, String etat, String projet, String dateemission, String idDevise) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            String result = gff.cloturerFactureFournisseur(idf, numFact, designation, daty, fournisseur, montantHT, tva, montantTTC, remarque, "PAYEE", projet, dateemission, idDevise);
            return result;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public FactureFournisseur[] findSortieFactureFournisseur() {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String ajouterCompte(String c, String lib, String pc) throws Exception {
        GestionPlanComptable gpc = null;
        try {
            gpc = GestionPlanComptableClient.getInterface();
            String s = gpc.ajouterCompte(c, lib, pc);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
        /**
         * @todo Complete this method
         */

    }

    public String majCompte(String idCompte, String cpt, String lib, String pcpt) throws Exception {
        /**
         * @todo Complete this method
         */
        GestionPlanComptable gpc = null;
        try {
            gpc = GestionPlanComptableClient.getInterface();
            String s = gpc.majCompte(idCompte, cpt, lib, pcpt);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public Pcg[] findCompteTab(String idc, String cpt, String lib, String pcpt) throws Exception {
        GestionPlanComptable gpc = null;
        try {
            gpc = GestionPlanComptableClient.getInterface();
            Pcg pcg[] = gpc.findCompteTab(idc, cpt, lib, pcpt);
            return pcg;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String findCompteTxt(String idc, String cpt, String lib, String pcpt) throws Exception {
        GestionPlanComptable gpc = null;
        try {
            gpc = GestionPlanComptableClient.getInterface();
            String s = gpc.findCompteTxt(idc, cpt, lib, pcpt);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMereNonPaye(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            FactMere afactmere[] = fl.findFactureMereNonPaye(datyinf, datySup, idFactureMere, client, dateLimite, etatFacture, catService, sCatService);
            return afactmere;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createPointage(String user, String daty, String heure, String type, String remarque, String ip, String agence, String machine) throws Exception {
        PointageEjb pl = null;
        try {
            pl = PointageEjbClient.getInterface();
            String idPoint = pl.createPointage(user, daty, heure, type, remarque, ip, agence, machine);
            return idPoint;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Pointage[] findPointage(String idPointage, String user, String datyInf, String DateSup, String heureInf, String heureSup, String type, String rem, String ip, String agence, String machine) throws Exception {
        PointageEjb pl = null;
        try {
            pl = PointageEjbClient.getInterface();
            Pointage point[] = pl.findPointage(idPointage, user, datyInf, DateSup, heureInf, heureSup, type, rem, ip, agence, machine);
            return point;
        } catch (CreateException ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatCaisse[] findEtatCaisseDepense(String daty1, String daty2, String caisse, String benC) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            EtatCaisse aetatcaisse[] = fi.findEtatCaisseDepense(daty1, daty2, caisse, benC);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public EtatCaisse[] findEtatCaisseEntree(String daty1, String daty2, String caisse, String benC) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            EtatCaisse aetatcaisse[] = fi.findEtatCaisseEntree(daty1, daty2, caisse, benC);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public EtatCaisseReste[] findEtatCaisseReste(String dateDebut, String dateFin, String caisse, String entite) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            EtatCaisseReste aetatcaisse[] = fi.findEtatCaisseReste(dateDebut, dateFin, caisse, entite);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public SyntheseCompte[] findSyntheseCompteSortie(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            SyntheseCompte aetatcaisse[] = fi.findSyntheseCompteSortie(daty1, daty2, idCaiss, benC, compte, descComp);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public SyntheseCompte[] findSyntheseCompteEntree(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            SyntheseCompte aetatcaisse[] = fi.findSyntheseCompteEntree(daty1, daty2, idCaiss, benC, compte, descComp);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public SyntheseCompte[] findSyntheseCompteSortieType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            SyntheseCompte aetatcaisse[] = fi.findSyntheseCompteSortieType(daty1, daty2, idCaiss, benC, compte, descComp, idT, v);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public SyntheseCompte[] findSyntheseCompteEntreeType(String daty1, String daty2, String idCaiss, String benC, String compte, String descComp, String idT, String v) throws Exception {
        FinanceEjb fi = null;
        try {
            fi = FinanceEjbClient.getInterface();
            SyntheseCompte aetatcaisse[] = fi.findSyntheseCompteEntreeType(daty1, daty2, idCaiss, benC, compte, descComp, idT, v);
            return aetatcaisse;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    /**
     * ***********************************************************************
     * ETO NO MANOMBOKA NY AJOUT
     * **********************************************************************
     */
    public String createLC(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable) throws Exception {

        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
                return lci.createLC(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq, nomTable, u.getTuppleID());
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String createSortie(String daty, String designation, String montant, String idDevise, String idMode, String idCaisse, String remarque, String agence, String projet, String numpiece, String idFacture, String idLigne) {
        if (idFacture == null || (idFacture.compareToIgnoreCase("") == 0)) {

        } else {

        }
        return null;
    }

    public String updateLC(LigneCredit lc, String nomTable) throws Exception {
        try {
            lc.setNomTable(nomTable);
            lc.updateToTableWithHisto(u.getTuppleID());
            return lc.getTuppleID();
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String updateLC(String id, String designation, double creditInitial, double cm, double montEng, double montVise, double montFact, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable) throws Exception {

        try {
            LigneCredit lc = new LigneCredit(designation, creditInitial, cm, montEng, montVise, montFact,
                    idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq);
            return updateLC(lc, nomTable);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String copierLCRecette(String mois, String annee, String mois0, String annee0) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0)) {
            return lci.copierLCRecette(mois, annee, mois0, Utilitaire.stringToInt(annee0), u.getTuppleID());
        }
        return null;

    }

    public String createLCRecette(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String rmq) throws Exception {
        CompteG cpt = new CompteG();
        cpt.setId(numCompte);
        CompteG[] listeC = (CompteG[]) CGenUtil.rechercher(cpt, null, null, "");

        if (listeC.length == 0) {
            CompteG test = new CompteG();
            test.setVal(numCompte);
            CompteG[] tliste = (CompteG[]) CGenUtil.rechercher(test, null, null, "");
            if (tliste.length != 0) {
                numCompte = tliste[0].getId();
            } else {
                throw new Exception("Numero de compte non valide");
            }
        }
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        if (creditInitial.compareToIgnoreCase("0") == 0 || creditInitial.compareToIgnoreCase("") == 0) {
            throw new Exception("Entrer le montant du credit exact");
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
            return lci.createLCRecette(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq, u.getTuppleID());
        }
        return null;
    }

    public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup, String nomTable) throws Exception {
        CompteG cpt = new CompteG();
        cpt.setId(numCompte);
        CompteG[] listeC = (CompteG[]) CGenUtil.rechercher(cpt, null, null, "");
        if (listeC.length == 0) {
            CompteG test = new CompteG();
            test.setVal(numCompte);
            CompteG[] tliste = (CompteG[]) CGenUtil.rechercher(test, null, null, "");
            if (tliste.length != 0) {
                numCompte = tliste[0].getId();
            } else {
                throw new Exception("Numero de compte non valide");
            }
        }
        LCEjb lci = null;
        if (creditInitial.compareToIgnoreCase("0") == 0 || creditInitial.compareToIgnoreCase("") == 0) {
            throw new Exception("Entrer le montant du credit exact");
        }
        try {
            lci = LCEjbClient.getInterface();;
            if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
                return lci.createLcMultiple(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois, annee, paruInf, paruSup, nomTable, u.getTuppleID());
            } else {
                throw new Exception("Erreur de droit");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String createLCe(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.createLCe(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq, nomTable, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperDepenseLC(String idSortie, String idLC, String rem, String montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperDepenseLC(idSortie, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public void validerMappageLCMRecette(String nomTable, String idMappage) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            lci.validerMappageLCMFactureRecette(nomTable, idMappage, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public void validerMappageLCM(String nomTable, String idMappage) throws Exception {
        LCEjb lci = null;
        try {

            lci = LCEjbClient.getInterface();;
            lci.validerMappageLCMFacture(nomTable, idMappage, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public UnionIntraTable validerMappageLCMavecOp(String nomTable, String idMere, String idOp) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        return lci.validerMappageLCMavecOp(nomTable, idMere, idOp, u.getTuppleID());
    }

    public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageLCMOpControle(nomTable, nomTableControl, idMere, u.getTuppleID());
    }

    public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere, Connection c) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageLCMOpControle(nomTable, nomTableControl, idMere, u.getTuppleID(), c);
    }

    public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere, Connection c) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageLCMOrControle(nomTable, nomTableControl, idMere, u.getTuppleID(), c);
    }

    public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageLCMOrControle(nomTable, nomTableControl, idMere, u.getTuppleID());
    }

    public void validerMappageLCPrevRecControle(String nomTable, String idMere, String idPrev) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageLCPrevRecControle(nomTable, idMere, idPrev, u.getTuppleID());
    }

    public static double getSoldeMois(Date d) throws Exception {
        Solde s = new Solde();
        Solde[] ls = (Solde[]) CGenUtil.rechercher(new Solde(), null, null, " and daty >= '" + Utilitaire.convertDatyFormtoRealDatyFormat(d.toString()) + "' order by daty asc");
        if (ls.length > 0) {
            return ls[0].getMontant();
        }
        return 0;
    }

    public String attcherOpDepPrev(String idprev, String[] listeor) throws Exception {
        Connection c = null;
        String ret = "yes";

        try {
            c = (new UtilDB()).GetConn();
            double montantor = 0;
            for (int k = 0; k < listeor.length; k++) {
                Oppaye o = new Oppaye();
                o.setNomTable("opPayelc");
                o.setId(listeor[k]);
                Oppaye p = ((Oppaye[]) CGenUtil.rechercher(o, null, null, ""))[0];
                montantor += p.getMontant();
            }

            PrevisionDepense pde = new PrevisionDepense();
            pde.setId(idprev);
            PrevisionDepense p = ((PrevisionDepense[]) CGenUtil.rechercher(pde, null, null, ""))[0];

            System.out.println(" +++++ OP " + montantor + "  ++++++++ prev " + p.getMontant());

            if (p.getMontant() == montantor) {
                for (int i = 0; i < listeor.length; i++) {
                    PrevdejaOP prev = new PrevdejaOP(listeor[i], idprev);
                    prev.insertToTable(c);
                }
            } else {
                ret = "Somme OP et montant prevision differente";
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public String attcherOpDepPrev2(String idprev, String idor) throws Exception {
        Connection c = null;
        String ret = "yes";
        try {
            c = (new UtilDB()).GetConn();
            PrevdejaOP prev = new PrevdejaOP(idor, idprev);
            prev.insertToTable(c);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public String attcherOrRCPrev2(String idprev, String listeor) throws Exception {
        Connection c = null;
        String ret = "yes";
        try {
            c = (new UtilDB()).GetConn();

            PrevisionOr prev = new PrevisionOr(listeor, idprev);
            prev.insertToTable(c);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public String attcherOrRCPrev(String idprev, String[] listeor) throws Exception {
        Connection c = null;
        String ret = "no";
        try {
            c = (new UtilDB()).GetConn();
            for (int i = 0; i < listeor.length; i++) {
                PrevisionOr prev = new PrevisionOr(listeor[i], idprev);
                prev.insertToTableWithHisto(u.getTuppleID(), c);
            }
            ret = "yes";
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public String attcherOpRCPrev(String idprev, String[] listeor) throws Exception {
        Connection c = null;
        String ret = "no";
        try {
            c = (new UtilDB()).GetConn();
            for (int i = 0; i < listeor.length; i++) {
                PrevdejaOP prev = new PrevdejaOP(listeor[i], idprev);
                prev.insertToTableWithHisto(u.getTuppleID(), c);
            }
            ret = "yes";
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public void validerMappageLCPrevDepControle(String nomTable, String idMere) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageLCPrevDepControle(nomTable, idMere, u.getTuppleID());
    }

    public void validerMappageLCMOp(String nomTable, String idMere) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            lci.validerMappageLCMOp(nomTable, idMere, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public void validerMappageLC(String nomTable, String[] idMappage) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            lci.validerMappageLCM(nomTable, idMappage, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, Connection c) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageAvecControle(nomTable, numObjet, montObjTotal, u.getTuppleID(), c);
    }

    public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        lci.validerMappageAvecControle(nomTable, numObjet, montObjTotal, u.getTuppleID());
    }

    public String mapperRecettesLC(String idEntree, String idLC, String rem, String montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperRecettesLC(idEntree, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperFactureLC(String idFacture, String idLC, String rem, String montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperFactureLC(idFacture, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }

    }

    public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        return lci.updateMontantUnionIntraLcOp(nomTable, nomTable2, id1, id2, montant, u.getTuppleID());
    }

    public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant, Connection c) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();
        return lci.updateMontantUnionIntraLcOp(nomTable, nomTable2, id1, id2, montant, u.getTuppleID(), c);
    }

    public String updateMontantUnionIntraLcPrev(String nomTable, String id1, String[] id2, String[] montant) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        return lci.updateMontantUnionIntraLcPrev(nomTable, id1, id2, montant, u.getTuppleID());
    }

    public boolean deleteUnionIntraTableLcOp(String nomtable, String nomTable2, String id) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        return lci.deleteUnionIntraTableLcOp(nomtable, nomTable2, id, u.getTuppleID());
    }

    public int dupliquerOR(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        int s = fi.dupliquerOR(numObjet, montantTab, n_dupl, lmois, lannee, ldate, u.getTuppleID());
        return s;
    }

    public int dupliquerORLC(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        int s = fi.dupliquerORLC(numObjet, montantTab, n_dupl, lmois, lannee, ldate, u.getTuppleID());
        return s;
    }

    public int dupliquerOP(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        int s = fi.dupliquerOP(numObjet, montantTab, n_dupl, lmois, lannee, ldate, u.getTuppleID());
        return s;
    }

    public int dupliquerOPLC(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] ldate) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        int s = fi.dupliquerOPLC(numObjet, montantTab, n_dupl, lmois, lannee, ldate, u.getTuppleID());
        return s;
    }

    public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        return lci.mapperOpFactureFournisseurLCTableau(idOp, idLC, rem, montant, u.getTuppleID());
    }

    public String mapperFactureFournisseurLCTableau(String idFacture, String[] idLC, String rem, String[] montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperFactureFournisseurLCTableau(idFacture, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperFactureClientLCTableau(String idFacture, String[] idLC, String rem, String[] montant) throws Exception {
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();;
        return lci.mapperFactureClientLCTableau(idFacture, idLC, rem, montant, u.getTuppleID());
    }

    public boolean deleteUnionIntraTable(String nomtable, String id) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.deleteUnionIntraTable(nomtable, id, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String updateMontantUnionIntra(String nomTable, String id1, String[] id2, String[] montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.updateMontantUnionIntra(nomTable, id1, id2, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperFactureFournisseurLC(String idFacture, String idLC, String rem, String montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperFactureFournisseurLC(idFacture, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }

    }

    public String copierLC(String mois, String annee, String mois0, String annee0, String nomTable) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0)) {
                return lci.copierLC(mois, annee, mois0, Utilitaire.stringToInt(annee0), nomTable, u.getTuppleID());
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }

    }

    public String copierLCAvecDetail(String mois, String annee, String mois0, String annee0, String nomTable) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            return lci.copierLC(mois, annee, mois0, Utilitaire.stringToInt(annee0), nomTable, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }

    }

    public void updateLC(LigneCredit l) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            lci.updateLC(l, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }

    }

    public String copierLC(String idLigneToCopy, String idEntite, String iddirection, String mois, String rmq, String annee) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }

    }

    public String createDirection(String libelledir, String descdir, double idDirecteur, String abbrevDir) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            return lci.createDirection(libelledir, descdir, idDirecteur, abbrevDir, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String updateCreditLC(String idLigne, double newCredit, String motif) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            return lci.updateCreditLC(idLigne, newCredit, motif, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public Direction[] findDirection(String idDir, String libelledir, String descdir, String abbrevDir, String idDirecteur) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            return lci.findDirection(idDir, libelledir, descdir, abbrevDir, idDirecteur);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public LigneCredit[] findLC(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable) throws Exception {
        LCEjb lci = null;
        if ((u.getIdrole().compareTo("directeur") == 0) || (u.getIdrole().compareTo("saisie") == 0)) {
            iddirection = u.getAdruser();
        }
        try {
            lci = LCEjbClient.getInterface();
            return lci.findLC(idLigne, designation, idTypeLigne, numCompte, idEntite, iddirection, mois, nomTable);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public ResultatEtSomme findLCPage(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable, int numPage) throws Exception {
        if ((u.getIdrole().compareTo("directeur") == 0) || (u.getIdrole().compareTo("saisie") == 0)) {
            iddirection = u.getAdruser();
        }
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();
        return lci.findLCPage(idLigne, designation, idTypeLigne, numCompte, idEntite, iddirection, mois, nomTable, numPage);
    }

    public LigneCreditComplet[] findFCC(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception {
        LCEjb lci = null;
        if ((u.getIdrole().compareTo("directeur") == 0) || (u.getIdrole().compareTo("saisie") == 0)) {
            idDirection = u.getAdruser();
        }
        try {
            lci = LCEjbClient.getInterface();
            return lci.findFCC(idLigne, designation, mois1, mois2, typeLC, numCompte, descCompte, "%", "%", entite, idDirection, colonne, sens, annee, nomTable);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public LigneCreditComplet[] findFCCParution(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String paruInf, String paruSup, String nomTable) throws Exception {
        LCEjb lci = null;
        if ((u.getIdrole().compareTo("directeur") == 0) || (u.getIdrole().compareTo("saisie") == 0)) {
            idDirection = u.getAdruser();
        }
        try {
            lci = LCEjbClient.getInterface();
            return lci.findFCCParution(idLigne, designation, mois1, mois2, typeLC, numCompte, descCompte, "%", "%", entite, idDirection, colonne, sens, annee, paruInf, paruSup, nomTable);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public LigneCreditComplet[] findLCComplet(String idLigne, String designation, String mois, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception {

        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();
            if ((u.getIdrole().compareTo("directeur") == 0) || (u.getIdrole().compareTo("saisie") == 0)) {
                idDirection = u.getAdruser();
            }
            libelledir = this.getIdDirection();
            return lci.findLCComplet(idLigne, designation, mois, typeLC, numCompte, descCompte, libelledir, abbrevdir, entite, idDirection, colonne, sens, annee, nomTable);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String getIdDirection() {
        return idDirection;
    }

    public void setIdDirection(String idDirection) {
        this.idDirection = idDirection;
    }

    public String updateDirection(String idToUpdate, String libelledir, String descdir, double idDirecteur, String abbrevDir) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();

            return lci.updateDirection(idToUpdate, libelledir, descdir, idDirecteur, abbrevDir, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String createEntiteFact(String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String nature) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String viser(String nomT, String daty, String remarque, String idObjet) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String viserDed(String daty, String remarque, String idObjet) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.viserDed(daty, remarque, idObjet, u.getTuppleID());
        return s;
    }

    public String viserOr(String daty, String remarque, String idObjet) throws Exception {
        DedEjb fi = null;
        String s = null;
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareTo("assistCom") == 0)) {
            fi = DedEjbClient.getInterface();
            s = fi.viserOr(daty, remarque, idObjet, u.getTuppleID());
        } else {
            throw new Exception("Vous n avez pas le droit.");
        }
        return s;
    }

    public String viserOp(String daty, String remarque, String idObjet) throws Exception {
        DedEjb fi = null;
        String s = null;
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareTo("assistCom") == 0)) {
            fi = DedEjbClient.getInterface();
            s = fi.viserOp(daty, remarque, idObjet, u.getTuppleID());
        } else {
            throw new Exception("Vous n avez pas le droit!");
        }
        return s;
    }

    public String ventilerDed(String idDed, String[] idLcDet, String[] montant, String[] remarque, String[] eta) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String ventilerOp(String idOp, String[] idLcDet, String[] montant, String[] remarque, String[] eta) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String ventilerMvtCaisseDebit(String idMvt, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String nature) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m = fi.ventilerMvtCaisseDebit(idMvt, idLcDet, montant, remarque, eta, nature, u.getTuppleID());
        return m;
    }

    public String createDed(String desi, String daty, String mtht, String tax, String rem, String tiers, String idLigne) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.createDed(desi, daty, mtht, tax, rem, tiers, idLigne, u.getTuppleID());
        return s;
    }

    public String copierLcDetail(String idDepart, String idArrivee) throws Exception {
        return null;
    }

    public String createMvtCaisse(String daty, String datyValeur, String designation, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m = fi.createMvtCaisse(daty, datyValeur, designation, debit, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, u.getTuppleID());
        return m;
    }

    public String createMvtCaisseDirecte(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String ventilerMvtCaisseLcDetailDepenseGroupe(String idDetLc, String idMvt, String rem, String montant) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m = fi.ventilerMvtCaisseLcDetailDepenseGroupe(idDetLc, idMvt, rem, montant, u.getTuppleID());
        return m;
    }

    public String validerMvtCaisseLcDetailDepenseGroupe(String numMvtCaisse) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m = fi.validerMvtCaisseLcDetailDepenseGroupe(numMvtCaisse, u.getTuppleID());
        return m;
    }

    public String createMvtCaisseDirecteRecette(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m = fi.createMvtCaisseDirecteRecette(daty, designation, idLigne, idFacture, debit, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, u.getTuppleID());
        return m;
    }

    public int checkCloture(String listepub) throws Exception {
        String[] g = utilitaire.Utilitaire.split(listepub, ",");
        Pucomplet pub = null;
        pub = new Pucomplet();
        Pucomplet[] lpub = null;
        Pucomplet[] lpubcheck = null;
        int compt = 0;
        for (int b = 0; b < g.length; b++) {
            lpubcheck = (Pucomplet[]) bean.CGenUtil.rechercher(pub, null, null, " and id='" + g[b] + "'");
            String datycloture = utilitaire.Utilitaire.datetostring(lpubcheck[0].getDatycloture());
            finance.Cloture clo = new finance.Cloture();
            finance.Cloture[] lclo = (finance.Cloture[]) bean.CGenUtil.rechercher(clo, null, null, "  and daty='" + datycloture + "' and typeobjet='pub' and objet='" + lpubcheck[0].getIdAgence() + "'");
            if (lclo.length != 0) {
                compt++;
            }
        }
        return compt;
    }

    public String createMvtCaisseDirecteDepense(String daty, String designation, String idLigne, String idFacture, String debit, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        //java.sql.Date di=Utilitaire.string_date("dd/MM/yyyy",daty);
        Cloture cl = new Cloture();
        cl.setObjet(caisse);
        cl.setTypeObjet(utilitaire.Constante.typeCloture[0]);
        String colInt[] = {"daty"};
        String valInt[] = {daty, daty};
        Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, colInt, valInt, "");
        if (lc.length > 0) {
            throw new Exception("Caisse deja clotur�e pour cette date");
        }

        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m;
        if (Utilitaire.stringToDouble(debit) < 0) {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                m = fi.createMvtCaisseDirecteDepense(daty, designation, idLigne, idFacture, debit, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, u.getTuppleID());
            } else {
                throw new Exception("Le montant est negatif");
            }
        }
        m = fi.createMvtCaisseDirecteDepense(daty, designation, idLigne, idFacture, debit, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, u.getTuppleID());
        return m;
    }

    public String retourVola(String idMvt, String idLcDet, String montant) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.retourVola(idMvt, idLcDet, montant, u.getTuppleID());
    }

    public String annulerMvtDepense(String idMvt) throws Exception {
        if (u.getIdrole().compareTo("dg") == 0) {
            FinanceEjb fi = null;
            fi = FinanceEjbClient.getInterface();
            return fi.annulerMvtDepense(idMvt, u.getTuppleID());
        } else {
            throw new Exception("Erreur de droit");
        }
    }

    public static void updateMontantFactureElionet(String nomTable, String idfacture, String montant) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            FactureFournisseur fc = new FactureFournisseur(nomTable);
            fc.setIdFactureFournisseur(idfacture);
            FactureFournisseur[] listfc = (FactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, "");
            listfc[0].setMontantTTC(Double.parseDouble(montant));

            FactMere fm = new FactMere();
            fm.setIdFactureMere(listfc[0].getNumFact());
            FactMere[] listfm = (FactMere[]) CGenUtil.rechercher(fm, null, null, c, "");
            listfm[0].setMontantAPayer(Double.parseDouble(montant));

            listfc[0].updateToTable(c);
            listfm[0].updateToTable(c);

        } catch (Exception ex) {
            throw new Exception("erreur: " + ex.getMessage());
        }
    }

    public String createMvtCaisseDepenseRetour(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idMvt) throws Exception {
        FinanceEjb fi = null;
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminCompta) == 0)) {
            fi = FinanceEjbClient.getInterface();
        } else {
            throw new Exception("erreur de droit");
        }
        String m;
        m = fi.createMvtCaisseDepenseRetour(daty, datyValeur, designation, debit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, idMvt, u.getTuppleID());
        return m;
    }

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre) throws Exception {
        FinanceEjb fi = null;
        if (mode.compareToIgnoreCase("pay2") == 0) {
            int numPiece = Utilitaire.stringToInt(numP);
            if (numP.compareToIgnoreCase("") == 0 || numP.compareToIgnoreCase("-") == 0) {
                throw new Exception("numero piece invalide");
            }
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminCompta) == 0)) {
            fi = FinanceEjbClient.getInterface();
        } else {
            throw new Exception("erreur de droit");
        }
        String m;
        m = fi.createMvtCaisseDepense(daty, datyValeur, designation, debit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, u.getTuppleID());
        return m;
    }

    public String validerAutoAnnulation(String id) throws Exception {
        String retour = null;
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0)) {
            retour = this.createTypeObjet("VALIDATIONAA", "getSeqValidationAA", "VAA", id, "-");
        } else {
            throw new Exception("erreur de droit");
        }
        return retour;
    }

    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m;
        if (Utilitaire.stringToDouble(credit) < 0) {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                m = fi.createMvtCaisseRecette(daty, datyValeur, designation, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, u.getTuppleID());
            } else {
                throw new Exception("Le montant est negatif");
            }
        } else {
            m = fi.createMvtCaisseRecette(daty, datyValeur, designation, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, u.getTuppleID());
        }
        return m;
    }

    public MvtCaisse[] findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        MvtCaisse[] m = fi.findMvtCaisse(id, daty1, daty2, datyVal1, datyVal2, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM);
        return m;
    }

    public ResultatEtSomme findMvtCaisse(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, int numPage) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return (fi.findMvtCaisse(id, daty1, daty2, datyVal1, datyVal2, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM, numPage));

    }

    public void assocOPSociete(String idop, String societe) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            AssocOpSociete aos = new AssocOpSociete(idop, societe);
            aos.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void assocOPMvtCaisse(String idop, String idmvt, String benef, String etatpiece) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            ded.AssocOpMvtCaisse aos = new ded.AssocOpMvtCaisse(idop, idmvt, benef);
            ded.AssocEtatPieceMc aem = new ded.AssocEtatPieceMc(idop, etatpiece);
            aem.insertToTableWithHisto(u.getTuppleID(), c);
            aos.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String creerOpDirecte(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque) throws Exception {
        DedEjb fi = null;
        String s = null;
        if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
            fi = DedEjbClient.getInterface();
            s = fi.creerOpDirecte(daty, designation, idLigne, idFacture, debit, tier, remarque, u.getTuppleID());
        } else {
            throw new Exception("Vous n'avez pas le droit de creer un OP");
        }
        return s;
    }

    public String creerOpDirecteSansVisa(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.creerOpDirecteSansVisa(daty, designation, idLigne, idFacture, debit, tier, remarque, u.getTuppleID());
        return s;
    }

    public String createOp(String idDed, String daty, String montant, String rem) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.creerOp(daty, idDed, montant, "0", rem, u.getTuppleID());
        return s;
    }

    public String createOp(String idDed, String daty, String montant, String rem, Connection c) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.creerOp(daty, idDed, montant, "0", rem, u.getTuppleID(), c);
        return s;
    }

    public int attacherOpCommission(String idordre, String listeComm) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            String[] liste = Utilitaire.split(listeComm, ",");
            for (int i = 0; i < liste.length; i++) {
                Commissionfacture cmf = new Commissionfacture(liste[i], idordre, "-");
                cmf.setNomTable("Commissionfacture");
                cmf.construirePK(c);
                cmf.insertToTableWithHisto(u.getTuppleID(), c);
                System.out.println(cmf.getId() + " " + cmf.getDaty() + " " + cmf.getId1() + " " + cmf.getId2() + " " + cmf.getRemarque());
            }
            c.commit();
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String updateOrdre(String nomtable, String idordre, String sommeCommission) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.updateOrdre(nomtable, idordre, Double.parseDouble(sommeCommission), u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateOpVita(String nomtable, String nomtable2, String idornew, String idorancien) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.updateOpVita(nomtable, nomtable2, idornew, idorancien, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String[] getCommissionDetail(String[] listeComm) throws Exception {
        String[] ret = new String[3];
        String temp = Utilitaire.stringToTab(listeComm, "'", ",");
        Etatvente e = new Etatvente();
        e.setNomTable("etatvente");

        Etatvente[] liste = (Etatvente[]) CGenUtil.rechercher(e, null, null, " and ID in (" + temp + ")");
        ret[0] = liste[0].getMatricule();
        double somme = 0;
        for (int i = 0; i < liste.length; i++) {
            somme += liste[i].getTotalcommission();
        }
        ret[1] = String.valueOf(somme);
        ret[2] = Utilitaire.stringToTab(listeComm, "", ",");
        System.out.println(" ===============" + ret[2] + "===========");
        return ret;
    }

    public String createOp(String idDed, String daty, String montant, String rem, String typeprevu) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.creerOp(daty, idDed, montant, "0", rem, typeprevu, u.getTuppleID());
        return s;
    }

    public String createDetailMvtCaisse(String deb, String crd, String tiers, String rem, String paru, String idMere, String numP) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m = fi.createDetailMvtCaisse(deb, crd, tiers, rem, idMere, paru, u.getTuppleID(), numP);
        return m;
    }

    public String createDetEntFact(String idM, String desi, String qte, String puHt, String rem) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public FactureFournisseur[] findEntFact(String nomT, String id, String numFact, String designation, String frns, String montant1, String montant2, String rmq, String date1, String date2, String idDevise) throws Exception {
        return null;
    }

    public FactureFournisseur[] findFactureFournisseur(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception {
        //GestionFactureFournisseur gff = null;
        //gff = GestionFactureFournisseurClient.getInterface();
        //return (gff.findFactureFournisseur(nomTable, num, dateDebut, dateFin, fournisseur, designation, colonne, ordre, apresW));
        FactureFournisseur crt = new FactureFournisseur();
        crt.setIdFactureFournisseur(num);
        crt.setIdFournisseur(fournisseur);
        crt.setDesignation(designation);
        String colInt[] = {"daty"};
        String valInt[] = {dateDebut, dateFin};
        crt.setNomTable(nomTable);
        return (FactureFournisseur[]) CGenUtil.rechercher(crt, colInt, valInt, apresW + " order by " + colonne + " " + ordre);
    }

    public DetailFact[] findDetailFact(String id, String idM, String desi, String mont1, String mont2, String rem) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public Ded[] findDed(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String idLigne, String tiers) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        Ded[] aentree = fi.findDed(id, desi, daty1, daty2, mont1, mont2, rem, idLigne, tiers);
        return aentree;

    }

    public ResultatEtSomme findDedPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findDedPage(id, desi, daty1, daty2, mont1, mont2, rem, tiers, idLigne, numPage));

    }

    public ResultatEtSomme findDedLcPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        ResultatEtSomme aentree = fi.findDedLcPage(id, desi, daty1, daty2, mont1, mont2, rem, tiers, idLigne, typeLc, compte, ent, dir, mois1, mois2, numPage);
        return aentree;
    }

    public DedLc[] findDedLc(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        DedLc[] aentree = fi.findDedLc(id, desi, daty1, daty2, mont1, mont2, rem, tiers, idLigne, typeLc, compte, ent, dir, mois1, mois2);
        return aentree;
    }

    public OrdonnerPayement[] findOp(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        OrdonnerPayement[] op = fi.findOp(id, idDed, idLigne, daty1, daty2, montant1, mont2, rem);
        return op;
    }

    public ResultatEtSomme findOpPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findOpPage(id, idDed, idLigne, daty1, daty2, montant1, mont2, rem, numPage));
    }

    public ResultatEtSomme findOpPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findOpPage(nomTable, id, idDed, idLigne, daty1, daty2, montant1, mont2, rem, numPage));
    }

    public ResultatEtSomme findPrevPage(String nomTable, String id, String des, String idLigne, String daty1, String daty2, String montant1, String mont2, String rang, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findPrevPage(nomTable, id, des, idLigne, daty1, daty2, montant1, mont2, rang, numPage));
    }

    public ResultatEtSomme findOpLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findOpLcApayerPage(nomTable, id, idDed, idLigne, daty1, daty2, montant1, mont2, annee1, annee2, typeLc, compte, ent, dir, mois1, mois2, numPage));
    }

    public ResultatEtSomme findOrLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findOrLcApayerPage(nomTable, id, idDed, idLigne, daty1, daty2, montant1, mont2, annee1, annee2, typeLc, compte, ent, dir, mois1, mois2, numPage));
    }

    public DetailMvtCaisse[] findDetMvtCaisse(String tiers, String rem, String idMere) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        DetailMvtCaisse[] m = fi.findDetMvtCaisse(tiers, rem, idMere);
        return m;
    }

    public DetailMvtCaisse[] findDetMvtCaisseParu(String id, String tiers, String rem, String idMere, String paruInf, String paruSup) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return (fi.findDetMvtCaisseParu(id, tiers, rem, idMere, paruInf, paruSup));
    }

    public ResultatEtSomme findDetMvtCaisseParu(String id, String tiers, String rem, String idMere, String paruInf, String paruSup, int numPage) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return (fi.findDetMvtCaisseParu(tiers, rem, idMere, paruInf, paruSup, numPage));
    }

    public ResultatEtSomme findDetMvtCaisse(String tiers, String rem, String idMere, int numPage) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return (fi.findDetMvtCaisse(tiers, rem, idMere, numPage));

    }

    public String mapperMereFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String etat, Connection c) throws Exception {
        return null;
    }

    public String mapperMereFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String etat) throws Exception {
        /**
         * @todo Complete this method
         */
        return null;
    }

    public String mapperMereFille(String nomtableMappage, String idMere, String idFille, String rem, String montant, String montantTot) throws Exception {
        if (Utilitaire.stringToDouble(montant) > Utilitaire.stringToDouble(montantTot)) {
            throw new Exception("Le montant est sup au montant tot");
        }
        UnionIntraTable uit = new UnionIntraTable(nomtableMappage, idMere, idFille, rem, montant);
        uit.insertToTableWithHisto(u.getTuppleID());
        return uit.getId();
    }

    public String insertMereFille(String nomtableMappage, String[] idFille, String idMere, String rem, String montant, String montantTot) throws Exception {

        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            for (int i = 0; i < idFille.length; i++) {
                UnionIntraTable uit = new UnionIntraTable(nomtableMappage, idFille[i], idMere, rem, montant, c);
                UnionIntraTable crt = new UnionIntraTable();
                crt.setNomTable(nomtableMappage);
                crt.setId1(idFille[i]);
                crt.setId2(idMere);
                if (CGenUtil.rechercher(crt, null, null, c, "").length > 0) {
                    return "";
                }
                if (nomtableMappage.compareToIgnoreCase("venteFacture") == 0) {
                    Recette crtPub = new Recette();
                    crtPub.setId(idFille[i]);
                    Recette[] listeP = (Recette[]) CGenUtil.rechercher(crtPub, null, null, c, "");
                    uit.setMontantMere(listeP[0].getSomme());
                }
                uit.insertToTable(c);
            }
            c.commit();

            return "";
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String insertMereFille(String nomtableMappage, String idMere, String idFille, String rem, String montant, String montantTot) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTable uit = new UnionIntraTable(nomtableMappage, idMere, idFille, rem, montant, c);
            UnionIntraTable crt = new UnionIntraTable();
            crt.setNomTable(nomtableMappage);
            crt.setId1(idMere);
            crt.setId2(idFille);
            if (CGenUtil.rechercher(crt, null, null, c, "").length > 0) {
                return "";
            }
            if (nomtableMappage.compareToIgnoreCase("venteFacture") == 0) {
                Recette crtPub = new Recette();
                crtPub.setId(idMere);
                Recette[] listeP = (Recette[]) CGenUtil.rechercher(crtPub, null, null, c, "");
                uit.setMontantMere(listeP[0].getSomme());
            }
            uit.insertToTableWithHisto(u.getTuppleID());
            c.commit();
            return uit.getTuppleID();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        //if(Utilitaire.stringToDouble(montant)>Utilitaire.stringToDouble(montantTot)) throw new Exception("Le montant est sup au montant tot");
    }

    public String deleteMereFille(String nomtableMappage, String idMappage) throws Exception {
        UnionIntraTable uit = new UnionIntraTable();
        uit.setId(idMappage);
        uit.deleteToTableWithHisto(u.getTuppleID());
        return "ok";
    }

    public UnionIntraTable[] findUnionIntraTable(String nomTable, String id, String id1, String id2, String rem, String mont1, String mont2, String eta, String apresW) throws Exception {
        UnionIntraTable[] retour = null;
        UnionIntraTableUtil uti = new UnionIntraTableUtil();
        uti.setNomTable(nomTable);
        int col[] = {1, 2, 3, 4, 6};
        String[] valCol = {id, id1, id2, rem, eta};
        int colInt[] = {5};
        String valColInt[] = {mont1, mont2};
        retour = (UnionIntraTable[]) uti.rechercher(col, valCol, apresW, colInt, valColInt);
        return retour;
    }

    public EtatCaisseTableau[] findEtatCaisseTableau(String daty1, String daty2, String colonne, String ordre, String nomTable) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            EtatCaisseTableau[] lap = null;
            EtatCaisseTableau apr = new EtatCaisseTableau();
            //System.out.print("daty1:"+daty1+" daty2="+daty2);
            lap = (EtatCaisseTableau[]) CGenUtil.rechercher(apr, null, null, " and daty between '" + daty1 + "' and '" + daty2 + "' order by " + colonne + " " + ordre);
            return lap;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public AnalysePrevision[] findAnalysePrevision(String daty1, String daty2, String colonne, String ordre, String nomTable) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            AnalysePrevision[] lap = null;
            AnalysePrevision apr = new AnalysePrevision();
            apr.setNomTable(nomTable);
            lap = (AnalysePrevision[]) CGenUtil.rechercher(apr, null, null, " and daty between '" + daty1 + "' and '" + daty2 + "' order by " + colonne + " " + ordre);
            return lap;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public AnalysePrevision[] findAnalysePrevision(String daty1, String daty2, String colonne, String ordre, String nomTable, int npp) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            AnalysePrevision[] lap = null;
            AnalysePrevision apr = new AnalysePrevision();
            //System.out.print("daty1:"+daty1+" daty2="+daty2);
            //CGenUtil.rechercherPage(apr,null,null,
            lap = (AnalysePrevision[]) CGenUtil.rechercher(apr, null, null, " and daty between '" + daty1 + "' and '" + daty2 + "' order by " + colonne + " " + ordre);
            return lap;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object[] findPrevisionPage(String nomtable, String id, String ap) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            PrevisionRecette[] lp = null;
            PrevisionDepense[] listPrevDepense = null;
            if (nomtable.equalsIgnoreCase("previsionrecette")) {
                PrevisionRecette pr = new PrevisionRecette();
                pr.setNomTable(nomtable);
                pr.setId(id);
                lp = (PrevisionRecette[]) CGenUtil.rechercher(pr, null, null, ap);
                return lp;
            } // dans le cas d'une prevision depense
            else if (nomtable.equalsIgnoreCase("PrevisionDepense")) {
                PrevisionDepense pr = new PrevisionDepense();
                pr.setNomTable(nomtable);
                pr.setId(id);
                listPrevDepense = (PrevisionDepense[]) CGenUtil.rechercher(pr, null, null, ap);
                return listPrevDepense;
            }
            return lp;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String creerMvtStock(String design, String type, String debit, String credit, String compte, String unite, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerMvtStock(design, type, debit, credit, compte, unite, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String creerDossier(String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerDossier(idMvt, typeDossier, design, num, daty, tiers, qte, mont, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String creerDetailBobine(String numBob, String poids, String idMvt) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerDetailBobine(numBob, poids, idMvt, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String creerParution(String journal, String numP, String datyP, String nbpage, String nbex, String poids, String printer, String idMvt, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerParution(journal, numP, datyP, nbpage, nbex, poids, printer, idMvt, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String creerLettrageMvt(String parent, String fille, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerLettrageMvt(parent, fille, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String creerVerification(String mag, String reste, String unite, String controleur, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerVerification(mag, reste, unite, controleur, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String creerDetailVerifi(String numBob, String pourcentage, String verif, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.creerDetailVerifi(numBob, pourcentage, verif, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MvtStock[] findMvtStock(String idMvt, String datyInf, String datySup, String typeMvt, String compte) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findMvtStock(idMvt, datyInf, datySup, typeMvt, compte));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Dossier[] findDossier(String id, String idMvt, String typeDossier, String datyInf, String datySup) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findDossier(id, idMvt, typeDossier, datyInf, datySup));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public DetailBobinePoids[] findDetailBobine(String id, String numBobine, String idMvt) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findDetailBobine(id, numBobine, idMvt));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Parution[] findParution(String id, String datyInf, String datySup, String journal, String datyParInf, String datyParSup, String printer, String idMvt) throws Exception {
        /*StockEjb s = null;
    try
    {
      s = StockEjbClient.getInterface();
      return( s.findParution(id,datyInf,datySup,journal,datyParInf,datyParSup,printer,idMvt));

    }
    catch(Exception ex)
    {
      throw new Exception(ex.getMessage());
    }*/
        return null;
    }

    public LettrageMvt[] findLettrageMvt(String id, String parent, String fille) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findLettrageMvt(id, parent, fille));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Verification[] findVerification(String id, String datyInf, String datySup, String mag, String controleur) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findVerification(id, datyInf, datySup, mag, controleur));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public DetailVerif[] findDetailVerif(String id, String numBob, String idVerif) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findDetailVerif(id, numBob, idVerif));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateDossier(String id, String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.updateDossier(id, idMvt, typeDossier, design, num, daty, tiers, qte, mont, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String enleverDetailBobine(String id) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.enleverDetailBobine(id, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String enleverDossier(String idDossier) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.enleverDossier(idDossier, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String faireMvtStock(String design, String type, String debitS, String creditS, String debitD, String creditD, String compteS, String compteD, String unite, String rmq) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.faireMvtStock(design, type, debitS, creditS, debitD, creditD, compteS, compteD, unite, rmq, u.getTuppleID()));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public double calculQte(String nbPage, String nbEx, String poids) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.calculQte(nbPage, nbEx, poids));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MvtCompte[] findMvtCompte(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String val, String desce) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findMvtCompte(idMvt, datyInf, datySup, typeMvt, compte, val, desce));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public MvtBobine[] findMvtBobine(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String numB) throws Exception {
        StockEjb s = null;
        try {
            s = StockEjbClient.getInterface();
            return (s.findMvtBobine(idMvt, datyInf, datySup, typeMvt, compte, numB));

        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createDetailLc(String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return (lci.createDetailLc(idLC, compteDet, cred, montantEng, montantVis, montantFact, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String valideDetailLc(String idLC) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return (lci.valideDetailLc(idLC, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateDetailLc(String id, String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return (lci.updateDetailLc(id, idLC, compteDet, cred, montantEng, montantVis, montantFact, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public LcDetail[] findDetailLc(String id, String idLC, String compteDet, String etat) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return (lci.findDetailLc(id, idLC, compteDet, etat));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public LcDetail[] findDetailLcLigneCredit(String id, String idLC, String compteDet, String etat, String typeLc, String compte, String ent, String dir, String mois1, String mois2, String annee, String paru) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return (lci.findDetailLcLigneCredit(id, idLC, compteDet, etat, typeLc, compte, ent, dir, mois1, mois2, annee, paru));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateDed(String idDed, String desi, String daty, String mtht, String tax, String rem, String tiers) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.updateDed(idDed, desi, daty, mtht, tax, rem, tiers, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateOp(String id, String daty, String mont) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.updateOp(id, daty, mont, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateOpVita(String nomtable, String nomtable2, String idornew, String idorancien, String refUser) throws Exception {

        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.updateOpVita(nomtable, nomtable2, idornew, idorancien, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String creerOR(String daty, String ligne, String mont, String eta) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            //creerOr(String daty, String idDed, String mont, String eta, String remarque, String refU)
            //Misangojy mihitsy ty. Ny ligne=numero facture ary eta = remarque
            return (lci.creerOr(daty, ligne, mont, "0", eta, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String creerOR(String daty, String ligne, String mont, String eta, String typeprevu) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.creerOr(daty, ligne, mont, "0", eta, typeprevu, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String creerOR(String daty, String ligne, String mont, String eta, String remarque, String typeprevu, Connection c) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.creerOr(daty, ligne, mont, eta, remarque, typeprevu, u.getTuppleID(), c));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public OrdonnerPayement[] findOr(String id, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.findOr(id, idLigne, daty1, daty2, montant1, mont2, rem));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public ResultatEtSomme findOrPage(String id, String ded, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
        DedEjb lci = null;
        try {
            lci = DedEjbClient.getInterface();
            return (lci.findOrPage(id, ded, idLigne, daty1, daty2, montant1, mont2, rem, numPage));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }

    }

    public String createDetail(String nomTable, String idMere, String designation, String qte, String puHT, String rem) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            return (gff.createDetail(nomTable, idMere, designation, qte, puHT, rem, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateDetail(String nomTable, String id, String designation, String qte, String puHT, String rem) throws Exception {
        GestionFactureFournisseur gff = null;
        try {
            gff = GestionFactureFournisseurClient.getInterface();
            return (gff.updateDetail(nomTable, id, designation, qte, puHT, rem, u.getTuppleID()));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Detail[] findDetail(String nomTable, String id, String idMere, String designation, String qte1, String qte2, String puHT1, String puHT2, String rem) throws Exception {
        GestionFactureFournisseur gff = null;
        gff = GestionFactureFournisseurClient.getInterface();
        return (gff.findDetail(nomTable, id, idMere, designation, qte1, qte2, puHT1, puHT2, rem));
    }

    public OpLc[] findOpLc(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findOpLc(id, idDed, idLigne, daty1, daty2, montant1, mont2, rem, typeLc, compte, ent, dir, mois1, mois2));

    }

    public ResultatEtSomme findOpLcPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        return (fi.findOpLcPage(id, idDed, idLigne, daty1, daty2, montant1, mont2, rem, typeLc, compte, ent, dir, mois1, mois2, numPage));

    }

    public ResultatEtSomme findMvtCaisseLcPage(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return (fi.findMvtCaisseLcPage(id, daty1, daty2, datyVal1, datyVal2, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM, idLigne, typeLc, compte, ent, dir, mois1, mois2, numPage));

    }

    public MvtCaisseLc[] findMvtCaisseLc(String id, String daty1, String daty2, String datyVal1, String datyVal2, String designation, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return (fi.findMvtCaisseLc(id, daty1, daty2, datyVal1, datyVal2, designation, devise, mode, caisse, remarque, agence, tier, numP, typeM, idLigne, typeLc, compte, ent, dir, mois1, mois2));

    }

    public Cheque[] findCheque(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findCheque(id, mvt, datyS1, datyS2, datyV1, datyV2, ord, rem, numC, ca);
    }

    public Cheque createCheque(String mvt, String datyS, String datyV, String ord, String rem, String numC, String ca, String mont) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.createCheque(mvt, datyS, datyV, ord, rem, numC, ca, mont, u.getTuppleID());
    }

    public String degagerDed(String idDed) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.degagerDed(idDed, u.getTuppleID()));
    }

    public String degagerOp(String idOp) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.degagerOp(idOp, u.getTuppleID()));
    }

    public String degagerMvtCaisse(String idMvt) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.degagerMvtCaisse(idMvt, u.getTuppleID()));
    }

    public String viserFactureF(String refFact, String rem) throws Exception {
        GestionFactureFournisseur gff = null;
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
            gff = GestionFactureFournisseurClient.getInterface();
            return (gff.viserFactureF(refFact, rem, u.getTuppleID()));
        } else if (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) {
            throw new Exception("Pas le droit pour un directeur");
        } else {
            throw new Exception("pas le droit");
        }
    }

    public FactureFournisseur createOrSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String resp, String rem) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.createOrSimpleResp(daty, montant, idTva, idFrns, idDevise, resp, rem, u.getTuppleID()));
    }

    public FactureFournisseur createOrSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String resp, String rem, String typeprevu) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.createOrSimpleResp(daty, montant, idTva, idFrns, idDevise, resp, rem, typeprevu, u.getTuppleID()));
    }

    public OrdonnerPayement annulerOp(String nomTable, String nomTableLiaison, String id) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        if (u.getIdrole().compareToIgnoreCase("dg") == 0) {
            return (fi.annulerOp(nomTable, nomTableLiaison, id, u.getTuppleID()));
        } else {
            throw new Exception("Erreur de droit");
        }
    }

    public int reporterOp(String nomTable, String[] idOP, String[] rep) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        if (u.getIdrole().compareToIgnoreCase("dg") == 0) {
            return (fi.reporterOp(nomTable, idOP, rep, u.getTuppleID()));
        } else {
            throw new Exception("Erreur de droit");
        }
    }

    public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem) throws Exception {

        DedEjb fi = DedEjbClient.getInterface();
        return (fi.createOpSimple(daty, montant, idTva, idFrns, idDevise, rem, u.getTuppleID()));
    }

    public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String typeprevu, String datePaiement, String remarquePaiement) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.createOpSimple(daty, montant, idTva, idFrns, idDevise, rem, typeprevu, datePaiement, remarquePaiement, u.getTuppleID()));
    }

    public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String typeprevu) throws Exception {

        DedEjb fi = DedEjbClient.getInterface();
        return (fi.createOpSimple(daty, montant, idTva, idFrns, idDevise, rem, typeprevu, u.getTuppleID()));
    }

    public void untitledMethod1() {
    }

    public SaisieVirement[] findVirementNormale(String nomtable, String id, String dev, String caisse1, String caisse2, String mode, String daty1, String daty2, String apreW) {
        try {
            FinanceEjb fi = null;
            fi = FinanceEjbClient.getInterface();
            return fi.findVirementNormale(nomtable, id, dev, caisse1, caisse2, mode, daty1, daty2, apreW);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public String updateLC(String idLigne, String designation, String creditIni, String creditMod, String typeLigne, String numCompte, String entite, String dir, String mois, String annee, String nomTable) throws Exception {
        LCEjb lci = null;
        try {
            if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0)) {
                lci = LCEjbClient.getInterface();;
                return (lci.updateLC(idLigne, designation, creditIni, creditMod, typeLigne, numCompte, entite, dir, mois, annee, nomTable, u.getTuppleID()));
            } else {
                return null;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String copierLCRecette(String mois, String annee, String mois0, String annee0, String nomTable) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.copierLCRecette(mois, annee, mois0, Utilitaire.stringToInt(annee0), nomTable, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String viserFactureC(String idFact, String remarque) throws Exception {
        GestionFactureFournisseur gff = null;
        if ((u.getIdrole().compareTo("assistCom") == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0)) {
            gff = GestionFactureFournisseurClient.getInterface();
            return (gff.viserFactureC(idFact, remarque, u.getTuppleID()));
        } else if (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) {
            throw new Exception("Pas le droit pour un directeur");
        } else {
            throw new Exception("pas le droit");
        }
    }

    public String viserFactureCProf(String idFact, String remarque) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            FactureFournisseur crt = new FactureFournisseur();
            crt.setNomTable("FactureClientProforma");
            crt.setIdFactureFournisseur(idFact);
            FactureFournisseur[] ff = (FactureFournisseur[]) CGenUtil.rechercher(crt, null, null, "");
            if (ff.length == 0) {
                throw new Exception("pas de facture");
            }
            VisaUtil vu = new VisaUtil();
            vu.setNomTable("VISAFACTURECLIENTPROFORMA");
            Visa[] v = (Visa[]) vu.rechercher(4, idFact, c);
            if (v.length > 0) {
                throw new Exception("facture deja vise");
            }
            Visa vt = new Visa("VISAFACTURECLIENTPROFORMA", Utilitaire.dateDuJour(), remarque, idFact);
            vt.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return vt.getTuppleID();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void saveOpSolde(String idop, String solde) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            paie.OpSolde crt = new paie.OpSolde(idop, solde);
            crt.insertToTableWithHisto(u.getTuppleID(), c);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String mapperFactureClientLC(String idFacture, String idLC, String rem, String montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperFactureClientLC(idFacture, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperOrFactureClientLCTableau(idOp, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperPrevisionRecetteLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperPrevisionRecetteLCTableau(idOp, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public String mapperPrevisionDepenseLCTableau(String idOp, String[] idLC, String rem, String[] montant) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.mapperPrevisionDepenseLCTableau(idOp, idLC, rem, montant, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public ResultatEtSomme findFactureFournisseurPageLc(String nomtable, String id, String fourn, String designation, String numFact, String idLigne, String daty1, String daty2, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage, String colonne, String ordre) throws Exception {
        /*FactureFournisseur crt=new FactureFournisseur();
     crt.setIdFactureFournisseur(id);crt.setIdFournisseur(fourn);crt.setDesignation(designation);crt.setNumFact(numFact);crt.set
     String colInt[]={"daty"};
     String valInt[]={dateDebut,dateFin};
     crt.setNomTable(nomTable);
    return CGenUtil.rechercherPage(crt,colInt,valInt,numPage,apresW+" order by " +colonne+ " "+ordre,null);*/
        GestionFactureFournisseur lci = GestionFactureFournisseurClient.getInterface();
        return lci.findFactureFournisseurPageLc(nomtable, id, fourn, designation, numFact, idLigne, daty1, daty2, desiLc, mois1Lc, mois2Lc, anneeLc, dirLc, entiteLc, typeLc, compteLc, numPage, colonne, ordre);
    }

    public ResultatEtSomme findOpPageLc(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String etat, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage) throws Exception {
        DedEjb fi = DedEjbClient.getInterface();
        return (fi.findOpPageLc(nomtable, id, idDed, idLigne, daty1, daty2, etat, desiLc, mois1Lc, mois2Lc, anneeLc, dirLc, entiteLc, typeLc, compteLc, numPage));
    }

    public String creerTache(Tache t) throws Exception {
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0)) {
            t.insertToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
            t.insertToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            t.setDirection(u.getAdruser());
            testMemeDirection(t.getResp());
            t.insertToTableWithHisto(u.getTuppleID());
        } else {
            t.setDirection(u.getAdruser());
            testMemeDirection(t.getResp());
            testMemeUser(t.getResp());
            t.insertToTableWithHisto(u.getTuppleID());
        }
        /**
         * @todo Complete this method
         */
        return t.getTuppleID();
    }

    public boolean testMemeUser(int userAutres) throws Exception {
        if (u.getRefuser() != (userAutres)) {
            throw new Exception("Utilisateur different de vous");
        }
        return true;
    }

    public boolean testMemeDirection(int userAutres) throws Exception {
        boolean retour = true;
        MapUtilisateur crt = new MapUtilisateur();
        MapUtilisateur[] t = (MapUtilisateur[]) (bean.CGenUtil.rechercher(crt, null, null, " and refuser=" + userAutres));
        if (t.length == 0) {
            throw new Exception("Utilisateur finale " + userAutres + " non existante");
        }
        if (u.getAdruser().compareToIgnoreCase(t[0].getAdruser()) != 0) {
            throw new Exception("Utilisateur dans une autre direction");
        }
        return retour;
    }

    public String transfererTache(String t, String userFinal) throws Exception {
        Tache ta = new Tache();
        ta.setId(t);
        Tache[] ret = (Tache[]) bean.CGenUtil.rechercher(ta, null, null, "");
        if (ret.length == 0) {
            throw new Exception("Tache non trouv�");
        }
        testMemeDirection(Utilitaire.stringToInt(userFinal));
        ta.setResp(Utilitaire.stringToInt(userFinal));
        ta.updateToTableWithHisto(u.getTuppleID());
        return ta.getTuppleID();
    }

    public String modifierTache(Tache t) throws Exception {
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0)) {
            t.updateToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
            t.updateToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            t.setDirection(u.getAdruser());
            testMemeDirection(t.getResp());
            t.updateToTableWithHisto(u.getTuppleID());
        } else {
            t.setDirection(u.getAdruser());
            testMemeDirection(t.getResp());
            testMemeUser(t.getResp());
            t.updateToTableWithHisto(u.getTuppleID());
        }
        return t.getTuppleID();
    }

    public void effectuerTache(EffTache ef) throws Exception {
        TacheVue crt = new TacheVue();
        crt.setNomTable("TacheReste");
        crt.setId(ef.getTache());
        TacheVue[] liste = (TacheVue[]) bean.CGenUtil.rechercher(crt, null, null, "");
        if (liste.length == 0) {
            throw new Exception("Tache non existante");
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0)) {
            ef.insertToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
            ef.insertToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            if (liste[0].getDirection().compareToIgnoreCase(uVue.getAdruser()) != 0) {
                throw new Exception("Tache n appartenant pas a votre direction");
            }
            ef.insertToTableWithHisto(u.getTuppleID());
        } else {
            if (liste[0].getResp().compareToIgnoreCase(u.getLoginuser()) != 0) {
                throw new Exception("Tache n appartenant pas a vous");
            }
            ef.insertToTableWithHisto(u.getTuppleID());
        }
    }

    public String commenterTache(TypeObjet tc) throws Exception {
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0)) {
            tc.insertToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0)) {
            tc.insertToTableWithHisto(u.getTuppleID());
        } else if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            Tache crt = new Tache();
            crt.setId(tc.getVal());
            Tache[] liste = (Tache[]) bean.CGenUtil.rechercher(crt, null, null, "");
            if (liste.length == 0) {
                throw new Exception("Tache non existante");
            }
            if (liste[0].getDirection().compareToIgnoreCase(u.getAdruser()) != 0) {
                throw new Exception("Tache n appartenant pas a votre direction");
            }
            tc.insertToTableWithHisto(u.getTuppleID());
        } else {
            Tache crt = new Tache();
            crt.setId(tc.getVal());
            Tache[] liste = (Tache[]) bean.CGenUtil.rechercher(crt, null, null, "");
            if (liste.length == 0) {
                throw new Exception("Tache non existante");
            }
            if (liste[0].getResp() != u.getRefuser()) {
                throw new Exception("Tache n appartenant pas a vous");
            }
            tc.insertToTableWithHisto(u.getTuppleID());
        }
        return tc.getId();
    }

    public TacheVue[] findTache(pointage.TacheVue crt, String daty1, String daty2, String apresWher) throws Exception {

        String[] colint = {"dateFin"};
        String[] valInt = {daty1, daty2};
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            crt.setDirection(uVue.getAdruser());
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleUtilisateur) == 0)) {
            crt.setResp(u.getLoginuser());
        }
        TacheVue[] ret = (TacheVue[]) bean.CGenUtil.rechercher(crt, colint, valInt, apresWher);
        return ret;
    }

    public bean.ResultatEtSomme findTachePage(Tache crt, String daty1, String daty2, String apresWher, int numPage) throws Exception {
        String[] colint = {"dateFin"};
        String[] valInt = {daty1, daty2};
        String apresWhere = bean.CGenUtil.makeWhereIntervalle(colint, valInt);
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            crt.setDirection(u.getAdruser());
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleUtilisateur) == 0)) {
            crt.setResp(u.getRefuser());
        }
        return bean.CGenUtil.rechercherPage(crt, colint, valInt, numPage, apresWher, null);
    }

    public MapUtilisateur[] findUserSubordonnee() throws Exception {
        MapUtilisateur crt = new MapUtilisateur();
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0)) {
            crt.setAdruser(u.getAdruser());
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleUtilisateur) == 0)) {
            crt.setRefuser(u.getRefuser());
        }

        return (MapUtilisateur[]) bean.CGenUtil.rechercher(crt, null, null, "");
    }

    public Publicite updatePub(Publicite p) throws Exception {
        if (u.getIdrole().compareToIgnoreCase("dg") != 0) {
            throw new Exception("Erreur de droit");
        }
        //if(p.getPagemisyazy()>0) throw new Exception("pub deja mise en page, plus modifiable");
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Publicite crt = new Publicite();
            crt.setNomTable("pubpublie");
            crt.setId(p.getId());
            if (CGenUtil.rechercher(crt, null, null, c, "").length > 0 && u.getIdrole().compareToIgnoreCase("dg") != 0) {
                throw new Exception("pub deja paru, non modifiable");
            }
            p.updateToTableWithHisto(this.getUser().getTuppleID(), c);
            c.commit();
            return p;
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Publicite[] createPub(String parution1, String parution2, String idClient, String designation, String dimension, String couleur, String page, String journal, String bc, String rem, String cat, String resp, String numP, String formu, String remis) throws Exception {
        Connection c = null;
        Publicite pb[] = null;
        try {
            if ((u.getIdrole().compareToIgnoreCase("assistCom") == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleSaisie) == 0) && (u.getAdruser().compareToIgnoreCase("DIR000001") == 0))) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                if (parution2 == null || parution2.compareToIgnoreCase("") == 0) {
                    String[] listeParution = Utilitaire.split(parution1, ";");
                    pb = new Publicite[listeParution.length];
                    Montant m = Publicite.calculerMontant(couleur, dimension, journal, page, c);
                    for (int i = 0; i < listeParution.length; i++) {
                        pb[i] = new Publicite(idClient, cat, resp, listeParution[i], designation, bc, rem, numP, formu, couleur, dimension, journal, c);
                        pb[i].setNumPage(Utilitaire.stringToInt(page));
                        pb[i].setIdMont(m.getId());
                        pb[i].setMontant(m.getMont());
                        pb[i].setRemis(Utilitaire.stringToDouble(remis));
                        Parution tempP = Publicite.findParution(listeParution[i], journal, c);
                        pb[i].setIdParution(tempP.getTuppleID());
                        pb[i].insertToTableWithHisto(u.getTuppleID(), c);
                    }
                } else {
                    int paruInf = Utilitaire.stringToInt(parution1);
                    int paruSup = Utilitaire.stringToInt(parution2);
                    pb = new Publicite[paruSup - paruInf + 1];
                    Montant m = Publicite.calculerMontant(couleur, dimension, journal, page, c);
                    for (int i = paruInf; i <= paruSup; i++) {
                        pb[i - paruInf] = new Publicite(idClient, cat, resp, String.valueOf(i), designation, bc, rem, numP, formu, couleur, dimension, journal, c);
                        pb[i].setNumPage(Utilitaire.stringToInt(page));
                        pb[i - paruInf].setIdMont(m.getId());
                        pb[i - paruInf].setMontant(m.getMont());
                        pb[i - paruInf].setRemis(Utilitaire.stringToDouble(remis));
                        Parution tempP = Publicite.findParution(String.valueOf(i), journal, c);
                        pb[i - paruInf].setIdParution(tempP.getTuppleID());
                        pb[i - paruInf].insertToTableWithHisto(u.getTuppleID(), c);
                    }
                }
                c.commit();
            } else {
                throw new Exception("Erreur de droit");
            }
            return pb;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String mapperPrevLCTableau(String idprev, String[] idLC, String rem, String[] montant) throws Exception {
        Connection c = null;
        try {
            String retour = "";
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            for (int i = 0; i < idLC.length; i++) {
                String ref = UtilitaireMetier.mapperMereToFille("PREVDEPENSELC", "getSeqPrevisionLc", "SPL", idprev, idLC[i], rem, montant[0], u.getTuppleID(), "0", c);
                retour = "ok";
            }
            c.commit();
            return retour;
        } catch (SQLException ex) {
            c.rollback();
            throw new Exception();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String mapperPrevLCRTableau(String idprev, String[] idLC, String rem, String[] montant) throws Exception {
        Connection c = null;
        try {
            String retour = "";
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            for (int i = 0; i < idLC.length; i++) {
                String ref = UtilitaireMetier.mapperMereToFille("PREVRECETTELC", "getSeqPrevisionRecetteLc", "SPRL", idprev, idLC[i], rem, montant[0], u.getTuppleID(), "0", c);
                retour = "ok";
            }
            c.commit();
            return retour;
        } catch (SQLException ex) {
            c.rollback();
            throw new Exception();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int remiserPub(String[] idPub, String[] listePage) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int i = 0;
            for (i = 0; i < idPub.length; i++) {
                Publicite crt = new Publicite();
                crt.setId(idPub[i]);
                crt = ((Publicite) (bean.CGenUtil.rechercher(crt, null, null, c, "")[0]));
                crt.setRemis(Utilitaire.stringToDouble(listePage[i]));
                crt.updateToTableWithHisto(u.getTuppleID(), c);
            }
            c.commit();
            return i;
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int corrigerPub(String[] idPub, String[] corr) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int i = 0;
            for (i = 0; i < idPub.length; i++) {
                Publicite crt = new Publicite();
                crt.setId(idPub[i]);
                crt = ((Publicite) (bean.CGenUtil.rechercher(crt, null, null, c, "")[0]));
                if (crt.getPagemisyazy() > 0) {
                    throw new Exception("Pub deja mise en page");
                }
                if (crt.getCorrection() > 0) {
                    throw new Exception("Pub deja corrige");
                }
                crt.setCorrection(Utilitaire.stringToInt(corr[i]));
                crt.updateToTableWithHisto(u.getTuppleID(), c);
            }
            c.commit();
            return i;
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public int mettrePage(String[] idPub, String[] listePage, String[] listePageAncien) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int i = 0;
            for (i = 0; i < idPub.length; i++) {
                if (listePage[i].compareToIgnoreCase(listePageAncien[i]) == 0) {
                    continue;
                }
                Publicite crt = new Publicite();
                crt.setId(idPub[i]);
                crt = ((Publicite) (bean.CGenUtil.rechercher(crt, null, null, c, "")[0]));
                crt.setPagemisyazy(Utilitaire.stringToInt(listePage[i]));
                crt.updateToTableWithHisto(u.getTuppleID(), c);
            }
            c.commit();
            return i;
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void corrigerPub(String idP) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Publicite crt = new Publicite();
            crt.setId(idP);
            crt = ((Publicite) (bean.CGenUtil.rechercher(crt, null, null, c, "")[0]));
            if (crt.getCorrection() != 0) {
                throw new Exception("Pub deja corrige");
            }
            if (crt.getPagemisyazy() > 0) {
                throw new Exception("Pub deja mise en page");
            }
            crt.setCorrection(1);
            crt.updateToTableWithHisto(u.getTuppleID(), c);
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Publicite[] findPub(Publicite crt, String[] colInt, String[] valInt, String aW) throws Exception {
        return (Publicite[]) (bean.CGenUtil.rechercher(crt, colInt, valInt, aW));
    }

    public ResultatEtSomme getDataPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c) throws Exception {
        return getDataPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, 0);
    }

    public ResultatEtSomme getDataPage(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception {
        //if(!testerProfil(e.getNomTable(),u.getIdrole(),u.getLoginuser(),"recherche")) throw new Exception("Erreur de droit");
        return CGenUtil.rechercherPage(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, npp);
    }

    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        return CGenUtil.rechercherPageGroupe(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c);
    }

    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception {
        return CGenUtil.rechercherPageGroupe(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, npp);
    }

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        return CGenUtil.rechercherPageGroupeM(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c);
    }

    public ResultatEtSomme getDataPageGroupeMultiple(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception {
        return CGenUtil.rechercherPageGroupeM(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, npp);
    }

    public ResultatEtSomme getDataPageGroupe(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] moyenneGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c, int npp) throws Exception {
        return CGenUtil.rechercherPageGroupe(e, groupe, sommeGroupe, moyenneGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c, npp);
    }

    public boolean testerProfil(String tableRestrict, String profil, String login, String action) throws Exception {
        try {
            Restriction res = new Restriction();
            res.setTableRestrict(tableRestrict);
            res.setProfil(profil);
            res.setLogin(login);
            res.setAction(action);
            res.setNomTable("restriction_lib");
            Restriction[] listeres = (Restriction[]) CGenUtil.rechercher(res, null, null, "");
            if (listeres.length == 0) {
                return false;
            }
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public Object[] getData(ClassMAPTable e, String[] colInt, String[] valInt, Connection c, String apresWhere) throws Exception {
        //if(!testerProfil(e.getNomTable(),u.getIdrole(),u.getLoginuser(),"consulte")) throw new Exception("Profil invalide");
        if (c == null) {
            return CGenUtil.rechercher(e, colInt, valInt, apresWhere);
        }
        return CGenUtil.rechercher(e, colInt, valInt, c, apresWhere);
    }

    public Remise[] createRemise(String[] idPub, String remise) throws Exception {
        Connection c = null;
        Remise[] liste = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            liste = new Remise[idPub.length];
            for (int i = 0; i < idPub.length; i++) {
                liste[i] = new Remise(idPub[i], remise);
                liste[i].insertToTableWithHisto(u.getTuppleID(), c);
            }
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return liste;
    }

    public int getint() {
        return 0;
    }

    public void createRetourPiece(String idop, String daty, String refpiece, String rmq) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (refpiece.compareToIgnoreCase("") == 0) {
                throw new Exception("champ invalide");
            }
            java.sql.Date dat = Utilitaire.string_date("dd/mm/yyyy", daty);
            AssocOpRetourPiece a = new AssocOpRetourPiece();
            AssocOpRetourPiece[] larp = (AssocOpRetourPiece[]) CGenUtil.rechercher(a, null, null, " and idop='" + idop + "'");
            if (larp.length != 0) {
                throw new Exception("pi�ce d�j� retourn�");
            }
            AssocOpRetourPiece arp = new AssocOpRetourPiece(idop, refpiece, dat, rmq);
            arp.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public MvtCaisseTous findDetailMvt(String idmvt) throws Exception {
        MvtCaisseTous temp = new MvtCaisseTous();
        MvtCaisseTous[] list = (MvtCaisseTous[]) CGenUtil.rechercher(temp, null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(idmvt).append("'"))));
        return list[0];
    }

    public Rib findDetailRib(String idrib) throws Exception {
        Rib rb = new Rib();
        Rib[] list = (Rib[]) CGenUtil.rechercher(rb, null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(idrib).append("'"))));
        return list[0];
    }

    public String getDetailCaisse(String idcaisse) {
        Caisse c = new Caisse();
        Caisse[] list = null;
        try {
            list = (Caisse[]) CGenUtil.rechercher(c, null, null, String.valueOf(String.valueOf(new StringBuffer(" and idcaisse='").append(idcaisse).append("'"))));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list[0].getDescCaisse();
    }

    public RapprochementBancaire getDetailRappro(String idrib) throws Exception {
        RapprochementBancaire[] rappro = null;
        try {
            rappro = (RapprochementBancaire[]) CGenUtil.rechercher(new RapprochementBancaire(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and idrib = '").append(idrib).append("'"))));
        } catch (Exception e) {
            throw new Exception(" Erreur durant la recherche: ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
        return rappro[0];
    }

    public void rapprocherMvtFiche(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            RapprochementBancaire rappro = (RapprochementBancaire) o;
            Rib rb = new Rib();
            MvtCaisse m = new MvtCaisse();
            MvtCaisseTous[] lm = (MvtCaisseTous[]) CGenUtil.rechercher(new MvtCaisseTous(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(rappro.getIdmouvement()).append("'"))));

            rb.setDesignation(rappro.getDesignation());
            rb.setDaty(rappro.getDateoperation());
            rb.setRemarque(rappro.getDesignation());
            rb.setNumcheque(lm[0].getNumcheque());
            rb.setNumreference(lm[0].getNumpiece());
            rb.setDebit(lm[0].getDebit());
            rb.setCredit(lm[0].getCredit());
            if (lm[0].getDebit() > 0) {
                rb.setType("debit");
            } else {
                rb.setType("credit");
            }
            rb.setCaisse(lm[0].getIdcaisse());
            rb.construirePK(c);

            rb.insertToTableWithHisto(this.u.getTuppleID(), c);

            rappro.construirePK(c);
            rappro.setIdrib(rb.getId());
            rappro.insertToTableWithHisto(this.u.getAdruser(), c);
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(" erreur durant le rapprochement: ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void payerOPMultiple(String[] IdOP) throws Exception {
        for (int i = 0; i < IdOP.length; i++) {
            OrdonnerPayement op = ((OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(IdOP[i]).append("' ")))))[0];
            MvtCaisse m = new MvtCaisse();

            m.setDesignation(op.getRemarque());
            m.setIdDevise("");
            m.setDebit(op.getMontant());
        }
    }

    public void rapprochementRIBMultiple(String[] idrib, String idmvt) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            String req1 = Utilitaire.stringToTab(idrib, "'", ",");
            Rib[] r = (Rib[]) CGenUtil.rechercher(new Rib(), null, null, " and ID in (" + req1 + ")");
            // System.out.println(" and ID in (" + req1 + ")");

            //MvtCaisse[] rs = (MvtCaisse[])CGenUtil.rechercher(new MvtCaisse(), null, null, " and ID = '" + idmvt + "'");
            MvtCaisseTous mvt = findDetailMvt(idmvt);

            double montant = 0;
            for (int i = 0; i < r.length; i++) {
                if (r[0].getCredit() > 0) {
                    montant += r[i].getCredit();
                } else {
                    montant += r[i].getDebit();
                }
            }
            //System.out.println("montant 1 = " + montant + "  montant 2 = " + Utilitaire.formaterAr(mvt.getCredit() + mvt.getDebit()));
            if ((int) montant != (int) (mvt.getCredit() + mvt.getDebit())) {
                throw new Exception("Impossible de rapprocher, montant different");
            } else {
                for (int i = 0; i < idrib.length; i++) {
                    RapprochementBancaire rb = new RapprochementBancaire();
                    rb.construirePK(c);
                    rb.setDesignation(" RM " + r[0].getDesignation());
                    rb.setIdrib(r[i].getId());
                    rb.setIdmouvement(mvt.getId());
                    rb.setDateoperation(r[i].getDaty());
                    rb.insertToTable(c);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(" erreur durant le rapprochement ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void rapprochementRIBMultiple(String[] idrib) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            for (int i = 0; i < idrib.length; i++) {
                Rib[] r = (Rib[]) CGenUtil.rechercher(new Rib(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(idrib[i]).append("'"))));
                if (r.length > 0) {
                    MvtCaisse[] rs = (MvtCaisse[]) CGenUtil.rechercher(new MvtCaisse(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and debit = ").append(r[0].getDebit()).append(" and credit = ").append(r[0].getCredit()).append(" and idcaisse = '").append(r[0].getCaisse()).append("' and numpiece = '").append(r[0].getNumcheque()).append("'"))));
                    if (rs.length > 0) {
                        RapprochementBancaire rb = new RapprochementBancaire();
                        rb.construirePK(c);
                        rb.setDesignation(" RM ".concat(String.valueOf(String.valueOf(r[0].getDesignation()))));
                        rb.setIdrib(r[0].getId());
                        rb.setIdmouvement(rs[0].getId());
                        rb.setDateoperation(r[0].getDaty());
                        rb.insertToTable(c);
                        //System.out.println(" Rapprochement Bancaire >>>>>>> ".concat(String.valueOf(String.valueOf(rb.getId()))));
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(" erreur durant le rapprochement ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void rapprocherAndUpdateRib(String idrib, String[] idmvt) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Rib rb = ((Rib[]) CGenUtil.rechercher(new Rib(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(idrib).append("'")))))[0];
            MvtCaisse[] lm = new MvtCaisse[idmvt.length];
            double somme = 0.0D;
            for (int i = 0; i < idmvt.length; i++) {
                lm[i] = ((MvtCaisse[]) CGenUtil.rechercher(new MvtCaisse(), null, null, String.valueOf(String.valueOf(new StringBuffer(" and id = '").append(idmvt[i]).append("'")))))[0];

                if (lm[i].getIdCaisse().compareToIgnoreCase(rb.getCaisse()) != 0) {
                    throw new Exception("Rapprochement non autoris�: caisse different");
                }
                if (lm[i].getNumcheque().compareToIgnoreCase(rb.getNumcheque()) != 0) {
                    throw new Exception("Rapprochement non autoris�: cheque different");
                }
                if (rb.getDebit() > 0) {
                    somme += lm[i].getDebit();
                } else {
                    somme += lm[i].getCredit();
                }

            }

            if ((somme == rb.getDebit()) || (somme == rb.getCredit())) {
                for (int i = 0; i < lm.length; i++) {
                    RapprochementBancaire rappro = new RapprochementBancaire();
                    rappro.setDateoperation(rb.getDaty());
                    rappro.setIdrib(rb.getId());
                    rappro.setIdmouvement(lm[i].getId());
                    rappro.setDesignation(String.valueOf(String.valueOf(new StringBuffer(" rapprochement auto rib : ").append(rb.getId()).append(" mvt : ").append(lm[i].getId()))));
                    rappro.construirePK(c);
                    rappro.insertToTable(c);
                    c.commit();
                }
            } else {
                throw new Exception("Rapprochement non autoris�: montant different");
            }
        } catch (Exception ex) {

            ex.printStackTrace();
            throw new Exception(" erreur durant le rapprochement: ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void rapprocherRibFiche(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            RapprochementBancaire rappro = (RapprochementBancaire) o;
            rappro.construirePK(c);
            rappro.insertToTableWithHisto(this.u.getAdruser(), c);
            c.commit();
        } catch (Exception ex) {
            throw new Exception(" erreur durant le rapprochement: ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String rapprocherMvt(ClassMAPTable o) throws Exception {
        Connection c = null;
        String result = "";
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Rib rib = (Rib) o;
            Rib rb = new Rib();
            MvtCaisse m = new MvtCaisse();
            MvtCaisse[] lm = null;
            if (rib.getType().compareTo("debit") == 0) {
                rb.setCredit(0.0D);
                rb.setDebit(rib.getMontant());
            } else {
                rb.setDebit(0.0D);
                rb.setCredit(rib.getMontant());
            }

            rb.setDesignation(rib.getDesignation());
            rb.setDaty(rib.getDaty());
            rb.setRemarque(rib.getRemarque());
            rb.setNumcheque(rib.getNumcheque());
            Rib[] lrib = (Rib[]) CGenUtil.rechercher(new Rib(), null, null, " and debit = " + rb.getDebit() + " and credit = " + rb.getCredit() + " and upper(designation) like upper('%" + rib.getDesignation() + "%') and upper(numcheque) = upper('" + rib.getNumcheque() + "')");
            if (lrib.length != 0) {
                throw new Exception("rib deja entr�e");
            }

            lm = (MvtCaisse[]) CGenUtil.rechercher(m, null, null, String.valueOf(String.valueOf(new StringBuffer(" and upper(idcaisse) = upper('").append(rib.getCaisse()).append("') and upper(numcheque) like upper('%").append(rib.getNumcheque()).append("%') and credit = ").append(rb.getCredit()).append(" and debit = ").append(rb.getDebit()))));
            if (lm.length != 0) {
                rb.construirePK(c);
                result = rb.getId();
                for (int i = 0; i < lm.length; i++) {
                    //System.out.println(" rapprochement auto ===== ".concat(String.valueOf(String.valueOf(rb.getId()))));
                    RapprochementBancaire rappro = new RapprochementBancaire(rib.getDesignation(), rb.getId(), lm[i].getId());
                    rappro.insertToTableWithHisto(this.u.getAdruser(), c);
                }
            }

            rb.setNumreference(rib.getNumreference());
            rb.setType(rib.getType());
            rb.setCaisse(rib.getCaisse());
            rb.construirePK(c);
            rb.insertToTableWithHisto(this.u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(" erreur durant le rapprochement: ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return result;
    }

    public void annulerOP(String id, String desc) throws Exception {
        OrdonnerPayement p = new OrdonnerPayement();
        p.setId(id);
        if (desc.length() < 10) {
            throw new Exception("Designation obligatoire");
        }
        OrdonnerPayement[] lp = (OrdonnerPayement[]) CGenUtil.rechercher(p, null, null, "");
        lp[0].setRemarque(String.valueOf(String.valueOf(new StringBuffer(String.valueOf(String.valueOf(desc))).append(" ").append(lp[0].getRemarque()).append(" "))));
        lp[0].setEtat(2);
        lp[0].updateToTableWithHisto(this.u.getTuppleID());
    }

    public Object createObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            o.setMode("insert");
            System.out.println("CLASSE ======= " + o.getClassName());
            if (o.getClassName().compareToIgnoreCase("recette.ConfPrixEtudiant") == 0) {  
                System.out.println("MANAO INSERT CONF");
                ConfPrixEtudiant conf = (ConfPrixEtudiant) o;
                //new EtudiantService().saveConfigPrix(conf, c, u);
                new EtudiantService().saveConfigPrixMultiple(conf, c, u);
                c.commit();
                return conf;
            }
            if (o.getClassName().compareToIgnoreCase("etudiant.EtudiantPromo") == 0 || o.getClassName().compareToIgnoreCase("etudiant.Etudiant") == 0) {  
                System.out.println("MANAO INSERT");
                Etudiant etudiant = (Etudiant) o;
                new EtudiantService().insertEtudiant(etudiant, c, u);
                createClientComptable(etudiant.getNom()+" "+etudiant.getPrenom(), "reg3", etudiant.getContact(), "-", etudiant.getAdresse(), etudiant.getId(), "-", "-", "-", "-", "411101", "-", "-");
                c.commit();
                return etudiant;
            }
            if (o.getClassName().compareToIgnoreCase("etudiant.Edition") == 0) {  
                Edition edition = (Edition) o;
                new EtudiantService().insertEdition(edition, c, u);
                return edition;
            }
            
            if (o.getClassName().compareToIgnoreCase("etudiant.MouvementEtudiant") == 0) {  
                System.out.println("MANAO INSERT"); 
                MouvementEtudiant mouvementEtudiant = (MouvementEtudiant) o;
                new EtudiantService().insertMouvementEtudiant(mouvementEtudiant, c, u);
                c.commit();
            }
            if (o.getClassName().compareToIgnoreCase("etudiant.PaiementDetail") == 0) {  
                PaiementDetail conf = (PaiementDetail) o;
                new EtudiantService().savePaiement(conf, c, u, this);
                c.commit();
                return conf;
            }
            if (o.getClassName().compareToIgnoreCase("etudiant.PaiementDetailsanspayement") == 0) {  
                System.out.println("ici");
                PaiementDetail conf = (PaiementDetail) o;
                new EtudiantService().savePaiementsanspayement(conf, c, u, this);
                c.commit();
                return conf;
            }
             if (o.getClassName().compareToIgnoreCase("etudiant.AnneeScolaire") == 0) {  
                AnneeScolaire anneeScolaire = (AnneeScolaire) o;
                new EtudiantService().insertAnneeScolaire(anneeScolaire, c, u);
                return anneeScolaire;
            }
            if (o.getClassName().compareToIgnoreCase("etudiant.InscriptionEtudiant") == 0) {  
                InscriptionEtudiant inscriptionEtudiant = (InscriptionEtudiant) o;
                new EtudiantService().inscriptionEtudiantAnneeScolaire(inscriptionEtudiant, c, u);
                return inscriptionEtudiant;
            }
    

            if (o.getClassName().compareToIgnoreCase("paie.Solde_attache") == 0) {
                paie.Solde_attache sold = (paie.Solde_attache) o;
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("commercial.Commercial") == 0) {
                commercial.Commercial sold = (commercial.Commercial) o;
                sold.construirePK(c);
                // insertion agence
                TypeObjet obj = new TypeObjet();
                obj.setNomTable("agence");
                obj.setId(sold.getId());
                obj.setVal(sold.getVal());
                obj.setDesce(sold.getType());
                obj.insertToTableWithHisto(u.getTuppleID(), c);

                // insertion etat numcompte
                commercial.EtatNumcompte ett = new commercial.EtatNumcompte();
                ett.setNomTable("etatnumcompte");
                ett.setIdnumcompte(obj.getId());
                ett.setCategorie("3");
                ett.setEtat("1");
                ett.insertToTableWithHisto(u.getTuppleID(), c);

                // insertion responsable
                commercial.Responsable rsp = new commercial.Responsable();
                rsp.construirePK(c);
                rsp.setNom(sold.getRef());
                rsp.setCode("3");
                rsp.setDescription(sold.getDesce());
                rsp.insertToTableWithHisto(u.getTuppleID(), c);

                return sold;

            }
            if (o.getClassName().compareToIgnoreCase("pub.PubRadioPartenariat") == 0) {
                PubRadioPartenariat prf = (PubRadioPartenariat) o;

                String[] hrs = prf.getHeure().split(";");
                prf.construirePK(c);
                prf.insertToTable(c);
                
                for (int i = 0; i < hrs.length; i++) {
                    PubRadioFilleHeure nw = new PubRadioFilleHeure();
                    nw.construirePK(c);
                    nw.setHeure(hrs[i]);
                    nw.setIdpub(prf.getId());
                    nw.insertToTable(c);
                }
                return prf;
            }
            if (o.getClassName().compareToIgnoreCase("pub.PubRadioFille") == 0) {
                PubRadioFille prf = (PubRadioFille) o;

                String[] hrs = prf.getHeure().split(";");

                for (int i = 0; i < hrs.length; i++) {
                    PubRadioFille nw = new PubRadioFille();
                    nw.construirePK(c);
                    nw.setDatedebut(prf.getDatedebut());
                    nw.setDatefin(prf.getDatefin());
                    nw.setDuree(prf.getDuree());
                    nw.setEtat(1);
                    nw.setHeure(hrs[i]);
                    nw.setNature(prf.getNature());
                    nw.setMere(prf.getMere());
                    nw.setQuantite(prf.getQuantite());
                    nw.setPubtype(prf.getPubtype());
                    nw.setNomcampagne(prf.getNomcampagne());
                    nw.insertToTable(c);
                }
                return prf;
            }
            if (o.getClassName().compareToIgnoreCase("activa.Production") == 0) {
                Production v = (Production) o;

            }
            if (o.getClassName().compareToIgnoreCase("ded.OpVita") == 0) {
                OpVita op = (OpVita) o;

                //System.out.println(" =========== " + op.getIdor() + " =========== ");
                if (op.getIdor().compareToIgnoreCase("depense") == 0) {
                    op.setNomTable("OpVita");
                    op.preparePk("OPV", "getSeqOpVita");
                    op.setId(op.makePK());
                } else if (op.getIdor().compareToIgnoreCase("recette") == 0) {
                    op.setNomTable("OrVita");
                    op.preparePk("ORV", "getSeqOrVita");
                    op.setId(op.makePK());
                }
                op.setIdor("");
                op.setEtat(0);
                op.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("activa.LiaisonCommandeActiva") == 0) {
                LiaisonCommandeActiva liaison = (LiaisonCommandeActiva) o;
                String idcmd1 = liaison.getIdcommande();
                LiaisonCommandeActiva liaison2 = new LiaisonCommandeActiva();
                liaison2.setIdcommande(idcmd1);
                LiaisonCommandeActiva[] lcmd = (LiaisonCommandeActiva[]) CGenUtil.rechercher(liaison2, null, null, "");
                if (lcmd.length != 0) {
                    throw new Exception("commande deja li�");
                }
                String daty = Utilitaire.convertDatyFormtoRealDatyFormat(liaison.getDaty().toString());
                String datylivraison = Utilitaire.convertDatyFormtoRealDatyFormat(liaison.getDatyLivraison().toString());
                Tva tva = loadTva(Utilitaire.dateDuJour());

                Commande cd = new Commande();
                cd.setIdcmd(liaison.getIdcommande());
                Commande[] listeCmd = (Commande[]) CGenUtil.rechercher(cd, null, null, "");
                DemandeDevis de = new DemandeDevis();
                de.setIdDevis(listeCmd[0].getIddevis());
                DemandeDevis[] listeDev = (DemandeDevis[]) CGenUtil.rechercher(de, null, null, "");
                liaison.setReduction((int) listeDev[0].getRemise());

                DemandeDevisRecto dem = new DemandeDevisRecto();
                dem.setIdDevis(listeCmd[0].getIddevis());

                Article art = new Article();
                art.setIdArticle(listeDev[0].getIdArticle());
                Article[] listeArt = (Article[]) CGenUtil.rechercher(art, null, null, "");
                String punitaire = new String();
                DemandeDevisRecto[] listeDem = new DemandeDevisRecto[1];
                if (listeDev[0].getIdCodeRV().compareToIgnoreCase("CODE1") == 0) {//recto
                    dem.setNomTable("demandedevisarticlerecto");
                } else {

                    dem.setNomTable("demandedevisarticlerv");
                }
                listeDem = (DemandeDevisRecto[]) CGenUtil.rechercher(dem, null, null, "");
                double test = listeDem[0].getCout() * listeDem[0].getNombreimpression();
                punitaire = String.valueOf((listeDem[0].getCout() * listeDem[0].getNombreimpression()) / listeDem[0].getNombre());
                //public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution)
                //System.out.println("ty l� reduction "+String.valueOf(liaison.getReduction()));
                String idfactmere = createFactureMere(daty, daty, datylivraison, listeDev[0].getIdClient(), listeCmd[0].getRemarque(), String.valueOf(tva.getValTva()), "Ar", "Ar", String.valueOf(liaison.getReduction()), "scat14", "typ02", "agb24", "BE000060", "");
                //System.out.println("vita ny mere");
                // public String createFactureFille(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF)
                createFactureFille(idfactmere, "scat14", listeDem[0].getArticle(), String.valueOf(listeDem[0].getNombre()), "unt5", punitaire, String.valueOf(liaison.getReduction()));
                //System.out.println("vita ny fille");
                //public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim)
                String idfact = finaliseFactureUpdate(idfactmere, daty, daty, datylivraison, listeDev[0].getIdClient(), listeCmd[0].getRemarque(), String.valueOf(tva.getValTva()), "Ar", "Ar", String.valueOf(liaison.getReduction()), "scat14", "typ02");
                System.out.println("vita ny rehetra");
                /**
                 * Insertion de la liaison facture *
                 */
                liaison.construirePK(c);
                liaison.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;

            }
            if (o.getClassName().compareToIgnoreCase("activa.Marge") == 0) {
                Marge m = (Marge) o;
                if (String.valueOf(m.getValeur()).compareToIgnoreCase("") == 0) {
                    throw new Exception("Veuillez saisir la valeur de la marge");
                }
                Marge[] mm = (Marge[]) CGenUtil.rechercher(m, null, null, "");
                if (mm.length != 0) {
                    throw new Exception("Marge deja existant");
                }
            }
            if (o.getClassName().compareToIgnoreCase("ladies.Publicity") == 0) {
                Publicity pub = (Publicity) o;
                try {
                    Publicity[] listepub = (Publicity[]) CGenUtil.rechercher(pub, null, null, "");
                    if (listepub.length != 0) {
                        throw new Exception("Pub deja existant");
                    }
                    TarifPub tarifPub = getTarifPubEncours(pub.getFormat());
                    pub.setMontant(tarifPub.getMontant());
                    int length = pub.getNombre();
                    for (int i = 0; i < length; i++) {
                        pub.setNombre(1);
                        pub.construirePK(c);
                        pub.insertToTable();
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("activa.NombreRame") == 0) {
                NombreRame n = (NombreRame) o;
                if (String.valueOf(n.getValeur()).compareToIgnoreCase("") == 0) {
                    throw new Exception("Veuillez saisir la valeur du nombre rame");
                }
                NombreRame[] nn = (NombreRame[]) CGenUtil.rechercher(n, null, null, "");
                if (nn.length != 0) {
                    throw new Exception("nombre de rame deja existant");
                }
            }
            if (o.getClassName().compareToIgnoreCase("activa.Tirage") == 0) {
                Tirage t = (Tirage) o;
                if (String.valueOf(t.getNbTirageCouleur()).compareToIgnoreCase("") == 0 || String.valueOf(t.getNbTirageCouleur()).compareToIgnoreCase("") == 0
                        || String.valueOf(t.getPrixEncreCouleur()).compareToIgnoreCase("") == 0 || String.valueOf(t.getPrixEncreCouleur()).compareToIgnoreCase("") == 0) {
                    throw new Exception("Veuillez saisir tous les champs");
                }
                Tirage[] tt = (Tirage[]) CGenUtil.rechercher(t, null, null, "");
                if (tt.length != 0) {
                    throw new Exception("tirage deja existant");
                }
            }

            if (o.getClassName().compareToIgnoreCase("activa.Article") == 0) {
                Article a = (Article) o;
                if (a.getLibelle().compareToIgnoreCase("") == 0 || a.getFormat().compareToIgnoreCase("") == 0) {
                    throw new Exception("tous les champs sont obligatoires");
                }
                Article[] aa = (Article[]) CGenUtil.rechercher(a, null, null, "");
                if (aa.length != 0) {
                    throw new Exception("article deja existant");
                }
            }

            if (o.getClassName().compareToIgnoreCase("activa.DemandeDevis") == 0) {
                DemandeDevis d = (DemandeDevis) o;
                DemandeDevis[] dd = (DemandeDevis[]) CGenUtil.rechercher(d, null, null, "");
                if (dd.length != 0) {
                    throw new Exception("Demande deja existante");
                }
                if (d.getIdArticle().compareToIgnoreCase("") == 0 || d.getIdClient().compareToIgnoreCase("") == 0 || d.getDesignation().compareToIgnoreCase("") == 0
                        || String.valueOf(d.getMargeBenefice()).compareToIgnoreCase("") == 0 || String.valueOf(d.getNbExemplaireA3()).compareToIgnoreCase("") == 0
                        || String.valueOf(d.getMargeBenefice()).compareToIgnoreCase("") == 0) {
                    throw new Exception("tous les champs sont obligatoires");
                }
                /* String max3=UserEJBBean.getMaxIdGestion(); */
                String idArticle = d.getIdArticle();
                GestionPrix gp = new GestionPrix();
                gp.setIdArticle(idArticle);
                GestionPrix[] gpt = (GestionPrix[]) CGenUtil.rechercher(gp, null, null, "");
                if (gpt.length == 0) {
                    throw new Exception("veuillez saisir un prix pour cet article");
                }
                GestionPrix w = new GestionPrix();
                w.setIdArticle(d.getIdArticle());
                GestionPrix[] gg = (GestionPrix[]) CGenUtil.rechercher(w, null, null, "");
                String[] ss = new String[gg.length];
                Utilitaire uu = new Utilitaire();
                for (int i = 0; i < gg.length; i++) {
                    ss[i] = gg[i].getIdGestion();
                }
                int taille = ss.length;
                int[] listeInt = new int[taille];
                for (int i = 0; i < taille; i++) {
                    String[] rep = uu.split(ss[i], "T");
                    listeInt[i] = Integer.parseInt(rep[1]);
                }
                int indicemax = indiceMax(listeInt, taille);
                d.setIdGestion(ss[indicemax]);
            }

            if (o.getClassName().compareToIgnoreCase("activa.Commande") == 0) {
                Commande co = (Commande) o;
                if (co.getIddevis().compareToIgnoreCase("") == 0 || co.getRemarque().compareToIgnoreCase("") == 0 || Utilitaire.datetostring(co.getDateLivraisonCmd()).compareToIgnoreCase("") == 0) {
                    throw new Exception("Champs obligatoires");
                }
                Commande[] cc = (Commande[]) CGenUtil.rechercher(co, null, null, "");
                if (cc.length != 0) {
                    throw new Exception("Commande deja existant");
                }

                Commande c1 = new Commande();
                c1.setIddevis(co.getIddevis());
                Commande[] ccc = (Commande[]) CGenUtil.rechercher(c1, null, null, "");
                if (ccc.length != 0) {
                    throw new Exception("Commande deja existant");
                }
            }

            if (o.getClassName().compareToIgnoreCase("activa.Production") == 0) {
                Production p = (Production) o;
                if (p.getIdcmd().compareToIgnoreCase("") == 0 || String.valueOf(p.getDebutCompteur()).compareToIgnoreCase("") == 0) {
                    throw new Exception("tous les champs sont obligatoires");
                }
                if (p.getFinCompteur() < p.getDebutCompteur()) {
                    throw new Exception("Erreur de saisie fin compteur");
                }
                Production[] pp = (Production[]) CGenUtil.rechercher(p, null, null, "");
                if (pp.length != 0) {
                    throw new Exception("Production deja existant");
                }
                Production p1 = new Production();
                p1.setIdcmd(p.getIdcmd());
                Production[] ppp = (Production[]) CGenUtil.rechercher(p1, null, null, "");
                if (ppp.length != 0) {
                    throw new Exception("Production deja existant");
                }
            }

            if (o.getClassName().compareToIgnoreCase("activa.Maintenance") == 0) {
                Maintenance m = (Maintenance) o;
                if (m.getRemarque().compareToIgnoreCase("") == 0 || String.valueOf(m.getPrix()).compareToIgnoreCase("") == 0
                        || String.valueOf(m.getPrixMO()).compareToIgnoreCase("") == 0) {
                    throw new Exception("tous les champs sont obligatoires");
                }
            }

            if (o.getClassName().compareToIgnoreCase("activa.VisaDevis") == 0) {
                VisaDevis v = (VisaDevis) o;
                if (v.getIdDevis().compareToIgnoreCase("") == 0 || v.getRemarque().compareToIgnoreCase("") == 0) {
                    throw new Exception("champ obligatoire");
                }
                VisaDevis[] vv = (VisaDevis[]) CGenUtil.rechercher(v, null, null, "");
                if (vv.length != 0) {
                    throw new Exception("Visa devis deja existant");
                }
                //if(v.ge)
            }

            if (o.getClassName().compareToIgnoreCase("activa.TypeArticle") == 0) {
                TypeArticle t = (TypeArticle) o;;
                if (t.getVal().compareToIgnoreCase("") == 0) {
                    throw new Exception("Veuillez saisir la valeur du type article");
                }
            }
            if (o.getClassName().compareToIgnoreCase("restriction.Restriction") == 0) {
                Restriction res = (Restriction) o;
            }
            if (o.getClassName().compareToIgnoreCase("ded.BenefPiece") == 0) {
                BenefPiece bp = (BenefPiece) o;
                BenefPiece ben = new BenefPiece();
                BenefPiece[] lben = (BenefPiece[]) CGenUtil.rechercher(ben, null, null, " and UPPER(nom) like UPPER('%" + bp.getNom() + "%')");
                if (lben.length != 0) {
                    throw new Exception("nom existante");
                }
                ben.setNom(bp.getNom());
                ben.setTel(bp.getTel());
                ben.setPoste(bp.getPoste());
                ben.construirePK(c);
                ben.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("facturefournisseur.FactureFournisseurPrevisionLc") == 0) {
                FactureFournisseurPrevisionLc factplc = (FactureFournisseurPrevisionLc) o;
                FactureFournisseurPrevision factp = new FactureFournisseurPrevision();
                factp.setDateemission(factplc.getDateemission());
                factp.setDaty(factplc.getDaty());
                factp.setDesignation(factplc.getDesignation());
                factp.setIddevise(factplc.getIddevise());
                factp.setIdfournisseur(factplc.getIdfournisseur());
                factp.setTva(factplc.getTva());
                factp.setMontantttc(factplc.getMontantttc());
                factp.setRemarque(factplc.getRemarque());
                factp.setResp(u.getTuppleID());
                factp.setNumfact(factplc.getNumfact());
                factp.construirePK(c);
                factp.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                LiaisonFFPrevisionLc liaison = new LiaisonFFPrevisionLc();
                liaison.setIdff(Utilitaire.getMaxId("facturefournisseurprevision"));
                liaison.setIdlc(factplc.getLc());
                liaison.setEtat(1);
                liaison.setMontantmere(factplc.getMontantttc());
                liaison.setRemarque(factplc.getRemarque());
                liaison.construirePK(c);
                liaison.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("compte.CompteG") == 0) {
                CompteG cpt = (CompteG) o;
                if (cpt.getVal().compareToIgnoreCase("") == 0) {
                    throw new Exception("Valeur de compte non valide");
                }
            }
            if (o.getClassName().compareToIgnoreCase("pub.Publication") == 0) {
                Publication p = (Publication) o;
                Publication crt = new Publication();
                Parution pa = new Parution();
                pa.setJournal(p.getJournal());
                Parution[] par = (Parution[]) CGenUtil.rechercher(pa, null, null, c, " and numParution=" + p.getNumParution());
                if (par.length == 0) {
                    throw new Exception("Pas de parution existante");
                }
                p.setNumParution(par[0].getId());
                crt.setNumParution(p.getNumParution());
                if (CGenUtil.rechercher(crt, null, null, c, "").length > 0) {
                    throw new Exception("Publication deja existante");
                }
            }
            if (o.getClassName().compareToIgnoreCase("pub.Rubrique") == 0) {
                Rubrique r = (Rubrique) o;
                if (r.getLibelle().compareToIgnoreCase("") == 0) {
                    throw new Exception("Rubrique vide");
                }
                Rubrique rub = new Rubrique();
                //rub.setJournal(r.getJournal());
                Rubrique[] rr = (Rubrique[]) CGenUtil.rechercher(rub, null, null, c, " and journal='" + r.getJournal() + "' and libelle='" + r.getLibelle() + "'");
                if (rr.length != 0) {
                    throw new Exception("Rubrique deja existante");
                }
            }
            if (o.getClassName().compareToIgnoreCase("finance.ClotureAff") == 0) {

                ClotureAff cca = (ClotureAff) o;
                //if(cca.getObjet().compareToIgnoreCase("")==0) throw new Exception("Veuillez saisir l objet a cloturer");
                if (cca.getTypeObjet().compareToIgnoreCase("invendu") == 0) {
                    Publication ptemp = new Publication();
                    String[] jp = Utilitaire.split(cca.getObjet(), " ");
                    if (jp.length < 2) {
                        throw new Exception("veuiller saisir libJournal et parution");
                    }
                    //pj.setIdPrix(tempp.getIdPrix());
                    ptemp.setJournal(jp[0]);
                    ptemp.setNumParution(jp[1]);
                    ptemp.setNomTable("PublicationLibelle");
                    Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                    if (pb.length == 0) {
                        throw new Exception("publication non existante");
                    }
                    // pj.setPublicat(pb[0].getId());
                    cca.setObjet(pb[0].getId());
                }
                if (cca.getDatySup().toString().compareToIgnoreCase("") == 0) {
                    cca.setDatySup(cca.getDaty());
                }

                java.sql.Date[] listeD = Utilitaire.convertIntervaleToListDate(cca.getDaty(), cca.getDatySup());

                Cloture[] liste = new Cloture[listeD.length];
                for (int i = 0; i < listeD.length; i++) {
                    liste[i] = new Cloture(cca.getObjet(), listeD[i], cca.getRemarque(), cca.getDatySaisie(), cca.getTypeObjet());
                    liste[i].construirePK(c);
                    liste[i].insertToTableWithHisto(u.getTuppleID(), c);
                }

                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("pub.Montant") == 0) {
                if (u.getIdrole().compareToIgnoreCase("dg") != 0 && u.getIdrole().compareToIgnoreCase("controle") != 0 && u.getIdrole().compareToIgnoreCase("directeur") != 0) {
                    throw new Exception("Erreur de droit");
                }

            }
            if (o.getClassName().compareToIgnoreCase("pub.Statpub") == 0) {
                if (u.getIdrole().compareToIgnoreCase("dg") != 0 && u.getIdrole().compareToIgnoreCase("controle") != 0) {
                    throw new Exception("Erreur de droit");
                }
                Statpub temp = (Statpub) o;
                Publication crtP = new Publication();
                crtP.setNomTable("publicationLibelle");
                crtP.setJournal(temp.getJournal());
                crtP.setNumParution(String.valueOf(temp.getNumparution()));
                Publication[] liste = (Publication[]) CGenUtil.rechercher(crtP, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Pas de publication correspondante");
                }
                Statpub crts = new Statpub();
                crts.setNomTable("statPubsaisieLibelle");
                crts.setFormat(temp.getFormat());
                crts.setJournal(temp.getJournal());
                if (CGenUtil.rechercher(crts, null, null, c, " and couleur=" + temp.getCouleur() + " and numparution= " + temp.getNumparution()).length > 0) {
                    throw new Exception("saisie deja effectue");
                }
                temp.setJournal(liste[0].getId());
            }

            if (o.getClassName().compareToIgnoreCase("crieur.InvenducLib") == 0) {
                InvenducLib is = (InvenducLib) o;

                Prisecrieur pbl = new Prisecrieur();
                pbl.setNomTable("PrisecrieurVue");
                pbl.setVendeur(is.getNom());
                pbl.setPublicat(is.getJournal() + " " + is.getParution());
                Prisecrieur[] liste = (Prisecrieur[]) CGenUtil.rechercher(pbl, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Prise non existante");
                }
                Publication pub = new Publication();
                pub.setNomTable("PublicationLibelle");
                pub.setJournal(is.getJournal());
                pub.setNumParution(is.getParution());
                Publication[] listeP = (Publication[]) CGenUtil.rechercher(pub, null, null, "");
                if (listeP.length == 0) {
                    throw new Exception("publication inexistante");
                }

                /*
        Test si la date de l'invendu est deja clotur�e ou pas
                 */
                java.sql.Date di = is.getDaty();
                Cloture cl = new Cloture();
                String colInt[] = {"daty"};
                cl.setTypeObjet(utilitaire.Constante.typeCloture[1]);
                cl.setObjet(listeP[0].getId());
                Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, null, null, c, "");
                if (lc.length > 0) {
                    throw new Exception("Prise deja clotur�e");
                }

                Invenducrieur crtLi = new Invenducrieur();
                crtLi.setIdprise(liste[0].getId());
                Invenducrieur[] listeInv = (Invenducrieur[]) CGenUtil.rechercher(crtLi, null, null, c, "");
                double totInv = bean.AdminGen.calculSommeDouble(listeInv, "nombreinvendu");
                if (is.getNombreinvendu() + totInv > liste[0].getNbreprise()) {
                    throw new Exception("nombre invendu superieur au nombre prise");
                }
                Invenducrieur ains = new Invenducrieur();
                ains.setDaty(is.getDaty());
                ains.setIdprise(liste[0].getId());
                ains.setNombreinvendu(is.getNombreinvendu());
                ains.setRemarque(is.getRemarque());
                ains.construirePK(c);
                ains.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return ains;
            }

            if (o.getClassName().compareToIgnoreCase("ventegazety.InvenduLibelle") == 0) {
                InvenduLibelle is = (InvenduLibelle) o;

                Prisejournal pbl = new Prisejournal();
                pbl.setNomTable("PriseJournalVue");
                //pbl.setJournal(is.getJournal());
                pbl.setVendeur(is.getNom());
                pbl.setPublicat(is.getJournal() + " " + is.getParution());
                Prisejournal[] liste = (Prisejournal[]) CGenUtil.rechercher(pbl, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Prise non existante");
                }
                Publication pub = new Publication();
                pub.setNomTable("PublicationLibelle");
                pub.setJournal(is.getJournal());
                pub.setNumParution(is.getParution());
                Publication[] listeP = (Publication[]) CGenUtil.rechercher(pub, null, null, "");
                if (listeP.length == 0) {
                    throw new Exception("publication inexistante");
                }

                /*d
        Test si la date de l'invendu est deja clotur�e ou pas
                 */
//                java.sql.Date di = is.getDaty();
//                Cloture cl = new Cloture();
//                String colInt[] = {"daty"};
//                cl.setTypeObjet(utilitaire.Constante.typeCloture[1]);
//                cl.setObjet(listeP[0].getId());
//                Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, null, null, c, "");
//                if (lc.length > 0) {
//                    throw new Exception("Prise deja clotur�e");
//                }
//                // test date invendu
//                // date prise, vendeur, type vendeur
//                // tana une semaine, province un mois
//
//                ControleInvendu inv = new ControleInvendu();
//                String aprw = "AND ID = '" + liste[0].getId() + "'";
//                //System.out.println("aprw = " + aprw);
//                ControleInvendu[] listivc = (ControleInvendu[]) CGenUtil.rechercher(inv, null, null, c, aprw);
//                if (listivc[0].getProvince().compareToIgnoreCase("tana") == 0) {
//                    Date dt = Utilitaire.ajoutJourDate(listivc[0].getDateprise(), 10);
//                    //System.out.println("dt = " + dt);
//                    if (is.getDaty().after(dt)) {
//                        throw new Exception("Prise deja clotur�e: date de publication plus d une semaine");
//                    }
//                } else if (listivc[0].getProvince().compareToIgnoreCase("province") == 0) {
//                    Date dt = Utilitaire.ajoutJourDate(listivc[0].getDateprise(), 45);
//                    //System.out.println("dt = " + dt);
//                    if (is.getDaty().after(dt)) {
//                        throw new Exception("Prise deja clotur�e: date de publication plus d un mois");
//                    }
//                }
                Cloture cl = new Cloture();
                cl.setTypeObjet(utilitaire.Constante.typeCloture[2]);
                cl.setObjet(liste[0].getId());
                Cloture[] lc = (Cloture[]) CGenUtil.rechercher(cl, null, null, c, "");
                if (lc.length > 0) {
                    throw new Exception("Prise d�j� clotur�e");
                }   
                Invendu crtLi = new Invendu();
                crtLi.setIdprise(liste[0].getId());
                Invendu[] listeInv = (Invendu[]) CGenUtil.rechercher(crtLi, null, null, c, "");
                double totInv = bean.AdminGen.calculSommeDouble(listeInv, "nombreinvendu");
                //System.out.println("nombre invendu anterieur = " + totInv);
                if (is.getNombreinvendu() + totInv > liste[0].getNbreprise()) {
                    throw new Exception("nombre invendu superieur au nombre prise");
                }
                Invendu ains = new Invendu();
                ains.setDaty(is.getDaty());
                ains.setIdprise(liste[0].getId());
                ains.setNombreinvendu(is.getNombreinvendu());
                ains.setRemarque(is.getRemarque());
                ains.construirePK(c);
                ains.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return ains;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.Vendeur") == 0) {
                Vendeur vendeur = (Vendeur) o;
                Vendeur v = new Vendeur();
                Vendeur[] lve = (Vendeur[]) CGenUtil.rechercher(v, null, null, " and nummatricule='" + vendeur.getNummatricule() + "'");
                if (lve.length != 0) {
                    throw new Exception("Num matricule existant :" + lve[0].getNom() + "");
                }
                v.setSurnom(vendeur.getSurnom());
                v.setType(vendeur.getType());
                v.setDateembauche(vendeur.getDateembauche());
                v.setTaux(vendeur.getTaux());
                v.setEtat("1");
                v.setNom(vendeur.getNom());
                v.setPrenom(vendeur.getPrenom());
                v.setNummatricule(vendeur.getNummatricule());
                v.setIdplace(vendeur.getIdplace());
                v.setGrossiste(vendeur.getGrossiste());
                v.construirePK(c);
                v.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.PrixjournalLibelle") == 0) {
                if (u.getIdrole().compareToIgnoreCase("dg") != 0 && u.getIdrole().compareToIgnoreCase("controle") != 0) {
                    throw new Exception("Erreur de droit");
                }
                System.out.println("mandalo bean = " );
                PrixjournalLibelle pxl = (PrixjournalLibelle) o;
                Journal journ = new Journal();
                journ.setVal(pxl.getJournal());
                journ.setDesce(pxl.getNom());
                TypeObjet obj = new TypeObjet();
                obj.setNomTable("journal");
                TypeObjet[] j = (TypeObjet[]) CGenUtil.rechercher(obj, null, null, c, " and (upper(val)=upper('" + pxl.getJournal() + "') or upper(desce)=upper('" + pxl.getNom() + "')) ");
                if (j.length > 0) {
                    throw new Exception("Journal d�j� existant");
                }
                journ.construirePK(c);
                journ.insertToTableWithHisto(u.getTuppleID(), c);
                
                Prixjournal pjr = new Prixjournal();
                pjr.setJournal(journ.getId());
                pjr.setPrix(pxl.getPrix());
                pjr.construirePK(c);
                pjr.insertToTableWithHisto(u.getTuppleID(), c);
                
                return journ;

            }

            if (o.getClassName().compareToIgnoreCase("crieur.Prisecrieur") == 0) {
                Prisecrieur tempp = (Prisecrieur) o;
                Prisecrieur pj = new Prisecrieur();
                pj.setDaty(tempp.getDaty());
                pj.setNbreprise(tempp.getNbreprise());
                Vendeur ven = new Vendeur();
                ven.setId(tempp.getVendeur());
                Vendeur[] lv = (Vendeur[]) bean.CGenUtil.rechercher(ven, null, null, c, "");
                if (lv.length == 0) {
                    throw new Exception("Vendeur invalide");
                }
                pj.setVendeur(lv[0].getId());

                Publication ptemp = new Publication();
                String[] jp = Utilitaire.split(tempp.getPublicat(), " ");
                if (jp.length < 2) {
                    throw new Exception("veuiller saisir libJournal et parution");
                }
                ptemp.setJournal(jp[0]);
                ptemp.setNumParution(jp[1]);
                ptemp.setNomTable("PublicationLibelle");
                Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                if (pb.length == 0) {
                    throw new Exception("publication non existante");
                }
                pj.setPublicat(pb[0].getId());

                Prixjournalvendeur pjv = new Prixjournalvendeur();
                pjv.setNomTable("PRIXJOURNALVENDEURLIBELLE");
                pjv.setVendeur(lv[0].getSurnom());
                pjv.setJournal(ptemp.getJournal());
                Prixjournalvendeur[] lpjv = (Prixjournalvendeur[]) CGenUtil.rechercher(pjv, null, null, c, "");

                Prisecrieur crtp = new Prisecrieur();
                crtp.setNomTable("Prisecrieurvue");
                crtp.setPublicat(tempp.getPublicat());
                crtp.setVendeur(pj.getVendeur());
                if (CGenUtil.rechercher(crtp, null, null, c, "").length > 0) {
                    throw new Exception("possible double saisie de prise");
                }
                if (lpjv.length == 0) {
                    Prixjournal pjrn = new Prixjournal();
                    pjrn.setNomTable("prixJournalLibelle");
                    pjrn.setJournal(ptemp.getJournal());
                    Prixjournal[] lpj = (Prixjournal[]) CGenUtil.rechercher(pjrn, null, null, c, "");
                    if (lpj.length == 0) {
                        throw new Exception("Pas de prix de journal correspondant");
                    }
                    pj.setIdPrix(lpj[0].getPrix() * lv[0].getTaux());
                } else {
                    pj.setIdPrix(lpjv[0].getPrix());
                }
                pj.construirePK(c);
                int g = pj.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return pj;
            }

            if (o.getClassName().compareToIgnoreCase("ventegazety.Prisejournal") == 0) {
                Prisejournal tempp = (Prisejournal) o;

                Prisejournal pj = new Prisejournal();
                pj.setDaty(tempp.getDaty());
                pj.setNbreprise(tempp.getNbreprise());
                Vendeur ven = new Vendeur();
                ven.setId(tempp.getVendeur());
                Vendeur[] lv = (Vendeur[]) bean.CGenUtil.rechercher(ven, null, null, c, "");
                if (lv.length == 0) {
                    throw new Exception("Vendeur invalide");
                }
                pj.setVendeur(lv[0].getId());

                Publication ptemp = new Publication();
                String[] jp = Utilitaire.split(tempp.getPublicat(), " ");
                if (jp.length < 2) {
                    throw new Exception("veuiller saisir libJournal et parution");
                }
                //pj.setIdPrix(tempp.getIdPrix());
                ptemp.setJournal(jp[0]);
                ptemp.setNumParution(jp[1]);
                ptemp.setNomTable("PublicationLibelle");
                Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                if (pb.length == 0) {
                    throw new Exception("publication non existante");
                }
                pj.setPublicat(pb[0].getId());

                Prixjournalvendeur pjv = new Prixjournalvendeur();
                pjv.setNomTable("PRIXJOURNALVENDEURLIBELLE");
                pjv.setVendeur(lv[0].getSurnom());
                pjv.setJournal(ptemp.getJournal());
                Prixjournalvendeur[] lpjv = (Prixjournalvendeur[]) CGenUtil.rechercher(pjv, null, null, c, " and upper(DATEEFFECTIVE) <=  TO_DATE ('" + Utilitaire.convertDatyFormtoRealDatyFormat(tempp.getDaty() + "") + "', 'dd/MM/yyyy')  order by dateeffective desc");
                System.out.println(" and upper(DATEEFFECTIVE) <= TO_DATE ('" + Utilitaire.convertDatyFormtoRealDatyFormat(tempp.getDaty() + "") + "', 'dd/MM/yyyy') order by dateeffective desc");
                Prisejournal crtp = new Prisejournal();
                crtp.setNomTable("PriseJournalvue");
                crtp.setPublicat(tempp.getPublicat());
                crtp.setVendeur(pj.getVendeur());
                if (CGenUtil.rechercher(crtp, null, null, c, "").length > 0) {
                    throw new Exception("possible double saisie de prise");
                }
                if (lpjv.length == 0) {
                    Prixjournal pjrn = new Prixjournal();
                    pjrn.setNomTable("prixJournalLibelle");
                    pjrn.setJournal(ptemp.getJournal());
                    Prixjournal[] lpj = (Prixjournal[]) CGenUtil.rechercher(pjrn, null, null, c, "");
                    if (lpj.length == 0) {
                        throw new Exception("Pas de prix de journal correspondant");
                    }
                    pj.setIdPrix(lpj[0].getPrix() * lv[0].getTaux());
                } else {
                    pj.setIdPrix(lpjv[0].getPrix());
                }
                pj.construirePK(c);
                int g = pj.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return pj;
            }

            if (o.getClassName().compareToIgnoreCase("crieur.RecettecLib") == 0) {
                RecettecLib rl = (RecettecLib) o;
                Recettecrieur r = new Recettecrieur();
                Publication p = new Publication();
                Prisecrieur pbl = new Prisecrieur();
                pbl.setNomTable("PrisecrieurVue");
                //pbl.setJournal(is.getJournal());
                pbl.setVendeur(rl.getNom());
                pbl.setPublicat(rl.getJournal() + " " + rl.getNumparution());
                Prisecrieur[] liste = (Prisecrieur[]) CGenUtil.rechercher(pbl, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Prise non existante");
                }
                if (liste[0].getMontantTheorique() < rl.getMontant()) {
                    throw new Exception("Montant superieur a la prise correspondante");
                }
                r.setPrise(liste[0].getId());
                r.setSomme(rl.getMontant());
                r.setDaty(rl.getDaty());
                r.controler(c);
                r.construirePK(c);
                r.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return r;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.RecetteLibelle") == 0) {

                RecetteLibelle rl = (RecetteLibelle) o;
                Recette r = new Recette();
                Publication p = new Publication();
                Prisejournal pbl = new Prisejournal();
                pbl.setNomTable("PriseJournalVue");
                pbl.setVendeur(rl.getNom());
                pbl.setPublicat(rl.getJournal() + " " + rl.getNumparution());
                Prisejournal[] liste = (Prisejournal[]) CGenUtil.rechercher(pbl, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Prise non existante");
                }
                if (liste[0].getMontantTheorique() < rl.getMontant()) {
                    throw new Exception("Montant superieur a la prise correspondante");
                }

                Recette r2 = new Recette();
                r2.setPrise(liste[0].getId());
                Recette[] lister = (Recette[]) CGenUtil.rechercher(r2, null, null, c, "");

                if (lister.length > 0) {
                    double sommer = 0;
                    for (int i = 0; i < lister.length; i++) {
                        sommer += lister[i].getSomme();
                    }
                    sommer = sommer + rl.getMontant();
                    System.out.println(" == montant theorique " + liste[0].getMontantTheorique() + " == somme montant recette " + sommer + " ");
                    if (liste[0].getMontantTheorique() < sommer) {
                        throw new Exception("Montant superieur a la prise correspondante");
                    }
                }

                r.setPrise(liste[0].getId());
                r.setSomme(rl.getMontant());
                r.setDaty(rl.getDaty());
                r.controler(c);
                r.construirePK(c);
                r.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return r;

            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.Prixjournalvendeur") == 0) {
                if (u.getIdrole().compareToIgnoreCase("dg") != 0 && u.getIdrole().compareToIgnoreCase("controle") != 0 && u.getIdrole().compareToIgnoreCase("directeur") != 0) {
                    throw new Exception("Erreur de droit");
                }
                Prixjournalvendeur temp = (Prixjournalvendeur) o;

                TypeObjet journ = new TypeObjet();
                journ.setVal(temp.getJournal());
                journ.setNomTable("journal");
                TypeObjet[] listej = (TypeObjet[]) CGenUtil.rechercher(journ, null, null, c, "");
                if (listej.length == 0) {
                    throw new Exception("journal non valide");
                }

                Prixjournalvendeur crt = new Prixjournalvendeur();
                crt.setJournal(listej[0].getId());
                crt.setVendeur(temp.getVendeur());
                //if(CGenUtil.rechercher(crt,null,null,c,"").length>0)throw new Exception("existance de doublons de prix");
                temp.setJournal(listej[0].getId());
            }
            if (o.getClassName().compareToIgnoreCase("actualite.Actualite") == 0) {

                if (u.getIdrole().compareToIgnoreCase("dg") != 0 && u.getIdrole().compareToIgnoreCase("controle") != 0 && u.getIdrole().compareToIgnoreCase("admin") != 0 && u.getIdrole().compareToIgnoreCase("directeur") != 0) {
                    throw new Exception("Erreur de droit");
                }
                Actualite temp = (Actualite) o;
                temp.setHeure(utilitaire.Utilitaire.heureCouranteHMS());
            }
            if (o.getClassName().compareToIgnoreCase("exportation.Parametre") == 0) {
                exportation.Parametre param = (exportation.Parametre) o;
                int valeurCp = Utilitaire.compareDaty(param.getDateSup(), param.getDateInf());
                int valeurAjr = Utilitaire.compareDaty(Utilitaire.dateDuJourSql(), param.getDateSup());
                if (valeurCp < 0) {
                    throw new Exception("La valeur dateSup  doit etre superieur a dateInf ");
                }
                if (valeurAjr < 0) {
                    throw new Exception("La valeur dateSup  doit etre inferieur a la daty aujourdhui");
                }
                exportation.Parametre paramSearch = new exportation.Parametre();
                String sup = Utilitaire.datetostring(param.getDateSup());
                String inf = Utilitaire.datetostring(param.getDateInf());
                exportation.Parametre[] paramList = (exportation.Parametre[]) CGenUtil.rechercher(paramSearch, null, null, "and DATEINF  BETWEEN '" + inf + "' and '" + sup + "'");
                if (paramList.length != 0) {
                    o.controler(c);
                    o.construirePK(c);
                    o.insertToTableWithHisto(u.getTuppleID(), c);
                    c.commit();
                    String dateImport = "";
                    for (int i = 0; i < paramList.length; i++) {
                        dateImport += "DATEINF " + Utilitaire.formatterDatySql(paramList[i].getDateInf()) + " DateSup " + Utilitaire.formatterDatySql(paramList[i].getDateSup()) + "\n";
                    }
                    throw new Exception("Information : vous avez deja fait import de la bdd sur les dates suivantes " + dateImport);
                }
            }
            if (o.getClassName().compareToIgnoreCase("finance.Rib") == 0) {

                Rib rib = (Rib) o;
                Rib rb = new Rib();
                MvtCaisse m = new MvtCaisse();
                MvtCaisse[] lm = null;
                if (rib.getType().compareTo("debit") == 0) {
                    rb.setCredit(0.0);
                    rb.setDebit(rib.getMontant());

                    m.setNumPiece(rib.getNumcheque());
                    lm = (MvtCaisse[]) CGenUtil.rechercher(m, null, null, " and credit = 0");
                    if (lm.length != 0) {
                        for (int i = 0; i < lm.length; i++) {
                            System.out.println("lm[i].getIdCaisse()" + lm[i].getIdCaisse() + "rib.getCaisse()" + rib.getCaisse());
                            if (lm[i].getIdCaisse().compareToIgnoreCase(rib.getCaisse()) != 0) {
                                throw new Exception("caisse different au caisse mvt caisse");
                            }
                        }
                    }
                } else {
                    rb.setDebit(0.0);
                    rb.setCredit(rib.getMontant());
                    m.setNumPiece(rib.getNumcheque());
                    lm = (MvtCaisse[]) CGenUtil.rechercher(m, null, null, " and debit = 0");
                    if (lm.length != 0) {
                        for (int i = 0; i < lm.length; i++) {
                            if (lm[i].getIdCaisse().compareToIgnoreCase(rib.getCaisse()) != 0) {
                                throw new Exception("caisse different au caisse mvt caisse");
                            }
                        }
                    }
                }
                rb.setDesignation(rib.getDesignation());
                rb.setDaty(rib.getDaty());
                rb.setRemarque(rib.getRemarque());
                rb.setNumcheque(rib.getNumcheque());
                Rib[] lrib = (Rib[]) CGenUtil.rechercher(rb, null, null, "");
                if (lrib.length != 0) {
                    throw new Exception("rib deja entr�e");
                }
                rb.setNumreference(rib.getNumreference());
                rb.setType(rib.getType());
                rb.setCaisse(rib.getCaisse());
                rb.construirePK(c);
                rb.insertToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.Offre") == 0) {
                ventegazety.Offre ofr = (ventegazety.Offre) o;
                ofr.construirePK(c);
                ofr.insertToTableWithHisto(u.getTuppleID(), c);

                return ofr;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.AbonneComplet") == 0) {

                AbonneComplet complet = (AbonneComplet) o;

                String typeAbonne = "tv19";
                Vendeur vendeur = new Vendeur(complet.getNom(), complet.getPrenom(), complet.getNom(), typeAbonne, "p1", "1", c);
                vendeur.setEtat("1");
                vendeur.insertToTableWithHisto(u.getTuppleID(), c);

                Abonne abonne = new Abonne(vendeur.getId(), complet.getIdcivilite(), complet.getDatenaissance(), complet.getCin(), complet.getTelephone(), complet.getAdresse(), complet.getIdquartier());
                abonne.construirePK(c);
                abonne.insertToTableWithHisto(u.getTuppleID(), c);

                c.commit();
                return null;
            }
            
            o.controler(c);
            o.construirePK(c);
            o.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return o;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertPubFact(String[] idpub, String idfact) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            String req = Utilitaire.stringToTab(idpub, "'", ",");
            Pucomplet pub = new Pucomplet();
            Pucomplet[] lpub = (Pucomplet[]) CGenUtil.rechercher(pub, null, null, c, " and id in (" + req + ")");

            for (int i = 0; i < lpub.length; i++) {
                insertPubFact(lpub[i].getId(), idfact, "-", lpub[i].getMontant(), 1, c);
            }

            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertPubFact(String idpub, String idfact, String rem, double montant, int etat, Connection c) throws Exception {
        try {
            PubFacture er = new PubFacture();
            er.setNomTable("PubFacture");
            er.preparePk("PBF", "getSEQPUBFACTURE");
            er.setId(er.makePK(c));
            er.setId1(idpub);
            er.setId2(idfact);
            er.setRemarque(rem);
            er.setMontantmere(montant);
            er.setEtat(etat);
            int ret = er.insertToTable(c);

        } catch (Exception ex) {

            ex.printStackTrace();
            throw ex;
        }
    }

    public void insertPubFact(String idpub, String idfact, String rem, double montant, int etat) throws Exception {
        Connection c = null;
        try {
            PubFacture er = new PubFacture(idpub, idfact, rem, montant, etat);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertPrevisionOp(FactureFournisseur facture, String prevision) throws Exception {
        Connection c = null;
        try {
            OrdonnerPayement orp = new OrdonnerPayement();
            orp.setNomTable("OrdonnerPayement");
            orp.setDed_Id(facture.getIdFactureFournisseur());
            OrdonnerPayement[] lorp = (OrdonnerPayement[]) CGenUtil.rechercher(orp, null, null, "");
            if (lorp.length == 0) {
                throw new Exception("or inexistante");
            }
            PrevisionOr er = new PrevisionOr(lorp[0].getId(), prevision);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertPrevisionOr(FactureFournisseur facture, String prevision) throws Exception {
        Connection c = null;
        try {
            OrdonnerPayement orp = new OrdonnerPayement();
            orp.setNomTable("ordonnerrecette");
            orp.setDed_Id(facture.getIdFactureFournisseur());
            OrdonnerPayement[] lorp = (OrdonnerPayement[]) CGenUtil.rechercher(orp, null, null, "");
            if (lorp.length == 0) {
                throw new Exception("or inexistante");
            }
            PrevisionOr er = new PrevisionOr(lorp[0].getId(), prevision);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertCommissionOp(String facture, String idordre, String pourcentage) throws Exception {
        Connection c = null;
        try {
            CommissionOp er = new CommissionOp(facture, idordre, pourcentage);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertCommissionOp(String facture, String idordre) throws Exception {
        Connection c = null;
        try {
            CommissionOp er = new CommissionOp(facture, idordre);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

//  public static String getMaxIdGestion(){
//  }
//public static String getMaxIdMaintenance(){
//  }
//  public static String getMaxIdTirage(){
//  }
    public void createPayementCommissionMultiple(String factclient, String client, String numcompte, String pourcentage) throws Exception {
        Connection c = null;
        try {
            CommissionPubPaye er = new CommissionPubPaye(factclient, client, numcompte, pourcentage);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String insertEtatRapprochement(String idmax, String etat) throws Exception {
        Connection c = null;
        try {
            EtatRapprochement er = new EtatRapprochement(idmax, etat);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return null;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object updateTypeVente2(String type, String daty, String nbre, String id, String publicat, String vendeur) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (type.compareToIgnoreCase("invendu") == 0) {
                Invenducrieur i = new Invenducrieur();
                i.setNomTable("Invenducrieur");
                i.setId(id);
                i.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                i.setNombreinvendu(Utilitaire.stringToInt(nbre));
                i.setIdprise(publicat);
                i.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            if (type.compareToIgnoreCase("prise") == 0) {
                Prisecrieur p = new Prisecrieur();
                p.setId(id);
                p.setNbreprise(Utilitaire.stringToInt(nbre));

                Publication ptemp = new Publication();
                String[] jp = Utilitaire.split(publicat, " ");
                if (jp.length < 2) {
                    throw new Exception("veuiller saisir libJournal et parution");
                }
                ptemp.setJournal(jp[0]);
                ptemp.setNumParution(jp[1]);
                ptemp.setNomTable("PublicationLibelle");
                Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                if (pb.length == 0) {
                    throw new Exception("publication non existante");
                }
                p.setPublicat(pb[0].getId());

                Prisecrieur crtp = new Prisecrieur();
                crtp.setNomTable("Prisecrieurvue");
                crtp.setPublicat(publicat);
                crtp.setVendeur(vendeur);
                if (CGenUtil.rechercher(crtp, null, null, c, " and id not like '" + id + "'").length > 0) {
                    throw new Exception("possible double saisie de prise");
                }

                /*fin*/
                p.setVendeur(vendeur);
                p.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                p.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            if (type.compareToIgnoreCase("recette") == 0) {
                Recettecrieur r = new Recettecrieur();
                r.setId(id);
                r.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                r.setSomme(Utilitaire.stringToDouble(nbre));
                r.setPrise(publicat);

                Prisecrieur pbl = new Prisecrieur();
                pbl.setNomTable("PrisecrieurVue");
                pbl.setId(publicat);
                Prisejournal[] liste = (Prisejournal[]) CGenUtil.rechercher(pbl, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Prise non existante");
                }
                if (liste[0].getMontantTheorique() < r.getSomme()) {
                    throw new Exception("Montant superieur a la prise correspondante");
                }
                r.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            return null;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object updateTypeVente(String type, String daty, String nbre, String id, String publicat, String vendeur) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (type.compareToIgnoreCase("invendu") == 0) {
                Invendu i = new Invendu();
                i.setId(id);
                i.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                i.setNombreinvendu(Utilitaire.stringToInt(nbre));
                i.setIdprise(publicat);
                i.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            if (type.compareToIgnoreCase("prise") == 0) {
                Prisejournal p = new Prisejournal();
                p.setId(id);
                p.setNbreprise(Utilitaire.stringToInt(nbre));

                Publication ptemp = new Publication();
                String[] jp = Utilitaire.split(publicat, " ");
                if (jp.length < 2) {
                    throw new Exception("veuiller saisir libJournal et parution");
                }
                ptemp.setJournal(jp[0]);
                ptemp.setNumParution(jp[1]);
                ptemp.setNomTable("PublicationLibelle");
                Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                if (pb.length == 0) {
                    throw new Exception("publication non existante");
                }
                p.setPublicat(pb[0].getId());

                Prisejournal crtp = new Prisejournal();
                crtp.setNomTable("Prisecrieurvue");
                crtp.setPublicat(publicat);
                crtp.setVendeur(vendeur);
                if (CGenUtil.rechercher(crtp, null, null, c, " and id not like '" + id + "'").length > 0) {
                    throw new Exception("possible double saisie de prise");
                }

                /*fin*/
                p.setVendeur(vendeur);
                p.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                p.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            if (type.compareToIgnoreCase("recette") == 0) {
                Recette r = new Recette();
                r.setId(id);
                r.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                r.setSomme(Utilitaire.stringToDouble(nbre));
                r.setPrise(publicat);

                Prisejournal pbl = new Prisejournal();
                pbl.setNomTable("PrisejournalVue");
                pbl.setId(publicat);
                Prisejournal[] liste = (Prisejournal[]) CGenUtil.rechercher(pbl, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Prise non existante");
                }
                if (liste[0].getMontantTheorique() < r.getSomme()) {
                    throw new Exception("Montant superieur a la prise correspondante");
                }
                r.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            return null;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
//  public static String getMaxIdProduction(){

//  }
    public Object updateObject(ClassMAPTable o, String t) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (o.getClassName().compareToIgnoreCase("pub.Publication") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
            }
            if (o.getClassName().compareToIgnoreCase("pub.Montant") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
            }
            if (o.getClassName().compareToIgnoreCase("pub.Statpub") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
            }

            if (o.getClassName().compareToIgnoreCase("activa.DemandeDevis") == 0) {
                DemandeDevis d = (DemandeDevis) o;
                d.setStatut(Integer.parseInt(t));
            }

            if (o.getClassName().compareToIgnoreCase("ventegazety.Vendeur") == 0) {
                Vendeur v = (Vendeur) o;
                Vendeur crt = new Vendeur();
                crt.setId(v.getId());
                Vendeur[] liste = (Vendeur[]) CGenUtil.rechercher(crt, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Vendeur non existant");
                }
                String datysortie = v.getDatesortie();
                String etat = null;
                if (datysortie != null || datysortie.compareTo("") != 0) {
                    liste[0].setDatesortie(datysortie);
                    liste[0].setEtat("0");
                }
                liste[0].setId(v.getId());
                liste[0].setIdplace(v.getIdplace());
                liste[0].setNom(v.getNom());
                liste[0].setPrenom(v.getPrenom());
                liste[0].setSurnom(v.getSurnom());
                liste[0].setType(v.getType());
                liste[0].setTaux(v.getTaux());
                liste[0].setDatesortie(datysortie);
                liste[0].setDateembauche(v.getDateembauche());
                liste[0].setNummatricule(v.getNummatricule());
                liste[0].controlerUpdate(c);
                liste[0].updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            o.controlerUpdate(c);
            o.updateToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return o;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object updateObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (o.getClassName().compareToIgnoreCase("pub.Publication") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
            }
            
            if (o.getClassName().compareToIgnoreCase("recette.RubriquePrixEntite") == 0) {  
                System.out.println("MANAO INSERT"); 
                RubriquePrixEntite rubriquePrixEntite = (RubriquePrixEntite) o;
                new EtudiantService().updateRubriquePrixEntite(rubriquePrixEntite, c, u);
                c.commit();
            }
            
            if (o.getClassName().compareToIgnoreCase("pub.Montant") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
            }
            if (o.getClassName().compareToIgnoreCase("pub.Statpub") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
            }

            if (o.getClassName().compareToIgnoreCase("finance.MvtCaisseTous") == 0) {
                if (u.isSuperUser() == false) {
                    throw new Exception("Erreur de droit");
                }
                MvtCaisseTous m = (MvtCaisseTous) o;
                System.out.println("daty=" + m.getDaty() + " " + m.getDatyvaleur());
                OrdonnerPayement op = new OrdonnerPayement();
                FactureFournisseur ff = new FactureFournisseur();
                UnionIntraTable un = new UnionIntraTable();
                UnionIntraTable unf = new UnionIntraTable();
                unf.setNomTable("FACTUREFOURNISSEURLC");
                un.setNomTable("opfflc");
                double valeur = m.getDebit();
                if (m.getDebit() == 0 && m.getCredit() != 0) {
                    op.setNomTable("ordonnerRecette");
                    ff.setNomTable("factureClient");
                    un.setNomTable("orfclc");
                    unf.setNomTable("FactureClientLc");
                    valeur = m.getCredit();
                    unf.setNomTable("factureclientlc");
                }
                op.setId(m.getIdordre());
                OrdonnerPayement[] lop = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, "");
                if (lop.length == 0) {
                    throw new Exception("Mvt sans op");
                }
                lop[0].setMontant(valeur);
                lop[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                un.setId1(lop[0].getTuppleID());
                UnionIntraTable[] lun = (UnionIntraTable[]) CGenUtil.rechercher(un, null, null, c, "");
                if (lun.length == 0) {
                    throw new Exception("Mvt sans liaison avec facture");
                }
                if (lun.length > 1) {
                    throw new Exception("plusieurs ligne cr�dit");
                }
                lun[0].setMontantMere(valeur);
                lun[0].updateToTableWithHisto(u.getTuppleID(), c);
                ff.setIdFactureFournisseur(op.getDed_Id());
                FactureFournisseur[] lff = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, c, "");
                if (lff.length == 0) {
                    throw new Exception("Mvt sans facture");
                }
                lff[0].setMontantTTC(valeur);
                lff[0].updateToTableWithHisto(u.getTuppleID(), c);
                lun = (UnionIntraTable[]) CGenUtil.rechercher(unf, null, null, c, "");
                if (lun.length == 0) {
                    throw new Exception("Mvt sans liaison avec facture");
                }
                if (lun.length > 1) {
                    throw new Exception("plusieurs ligne cr�dit");
                }
                lun[0].setMontantMere(valeur);
                lun[0].updateToTableWithHisto(u.getTuppleID(), c);
                MvtCaisse temp = new MvtCaisse();
                temp.setId(m.getId());
                temp = ((MvtCaisse[]) CGenUtil.rechercher(temp, null, null, c, ""))[0];
                temp.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return m;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.Vendeur") == 0) {
                Vendeur v = (Vendeur) o;
                Vendeur crt = new Vendeur();
                crt.setId(v.getId());
                Vendeur[] liste = (Vendeur[]) CGenUtil.rechercher(crt, null, null, c, "");
                if (liste.length == 0) {
                    throw new Exception("Vendeur non existant");
                }
                String datysortie = v.getDatesortie();
                String etat = null;
                if (datysortie != null || datysortie.compareTo("") != 0) {
                    liste[0].setDatesortie(datysortie);
                    liste[0].setEtat("2");
                }
                liste[0].setId(v.getId());
                liste[0].setIdplace(v.getIdplace());
                liste[0].setNom(v.getNom());
                liste[0].setPrenom(v.getPrenom());
                liste[0].setSurnom(v.getSurnom());
                liste[0].setType(v.getType());
                liste[0].setTaux(v.getTaux());
                liste[0].setDatesortie(datysortie);
                liste[0].setDateembauche(v.getDateembauche());
                liste[0].setNummatricule(v.getNummatricule());
                liste[0].controlerUpdate(c);
                liste[0].updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("ded.OpVita") == 0) {
                //eto ah zao
                OpVita op = (OpVita) o;
                if (op.getIdor().compareToIgnoreCase("ded.OpVita") == 0) {
                    OpVita orv = new OpVita(op.getId(), op.getDed_Id(), op.getDaty(), op.getMontant(), op.getRemarque(), op.getIdor());
                    orv.setEtat(0);
                    orv.updateToTableWithHisto(u.getTuppleID(), c);
                    c.commit();
                    return null;
                }
                OpVita opv = new OpVita();
                opv.setId(op.getId());
                opv.setDaty(op.getDaty());
                opv.setDed_Id(op.getDed_Id());
                opv.setIdor(op.getIdor());
                opv.setMontant(op.getMontant());
                opv.setRemarque(op.getRemarque());
                opv.setEtat(0);
                opv.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("ventegazety.AbonneComplet") == 0) {
                AbonneComplet complet = (AbonneComplet) o;

                Vendeur crt = new Vendeur();
                crt.setId(complet.getId());
                Vendeur[] vendeurs = (Vendeur[]) CGenUtil.rechercher(crt, null, null, c, "");
                if (vendeurs.length == 0) {
                    throw new Exception("Vendeur non existant");
                }

                Vendeur vendeur = vendeurs[0];
                vendeur.setNom(complet.getNom());
                vendeur.setPrenom(complet.getPrenom());
                vendeur.setSurnom(complet.getNom());
                vendeur.updateToTableWithHisto(u.getTuppleID(), c);

                Abonne crt2 = new Abonne();
                crt2.setIdvendeur(vendeur.getId());
                Abonne[] abonnes = (Abonne[]) CGenUtil.rechercher(crt2, null, null, c, "");
                if (abonnes.length == 0) {
                    throw new Exception("Abonne non existant");
                }

                Abonne abonne = abonnes[0];
                abonne.setIdcivilite(complet.getIdcivilite());
                abonne.setDatenaissance(complet.getDatenaissance());
                abonne.setCin(complet.getCin());
                abonne.setTelephone(complet.getTelephone());
                abonne.setAdresse(complet.getAdresse());
                abonne.setIdquartier(complet.getIdquartier());
                abonne.updateToTableWithHisto(u.getTuppleID(), c);

                c.commit();
                return null;
            }
            if (o.getClassName().compareToIgnoreCase("recette.ConfPrixEtudiant") == 0) {
                ConfPrixEtudiant conf = (ConfPrixEtudiant)o;
                new EtudiantService().updateConfPrix(conf, c, u);
                c.commit();
                return conf;
            }
            o.controlerUpdate(c);
            o.updateToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return o;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void deleteObject(ClassMAPTable o) throws Exception {
        Connection c = null;
        try {
            if (u.isSuperUser() == false) {
                throw new Exception("Pas de droit");
            }
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (o.getClassName().compareToIgnoreCase("pub.Publicite") == 0) {
                Publicite crt = new Publicite();
                crt.setId(o.getTuppleID());
                crt.setNomTable("pubdejafacture");
                if (CGenUtil.rechercher(crt, null, null, c, "").length > 0) {
                    throw new Exception("Le pub a deja ete facture");
                }
            }
            o.deleteToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    //u.creerParution(request.getParameter("parution1"),request.getParameter("parution2"),request.getParameter("journal"));

    public Parution creerParution(String par1, String dateP, String journ, String nbpage, String remarque) throws Exception {
        Connection c = null;
        Parution u = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int paru1 = Utilitaire.stringToInt(par1);
            Parution crt = new Parution();
            crt.setJournal(journ);
            Date datysql = utilitaire.Utilitaire.dateDuJourSql();
            String[] colInt = {"numparution"};
            String[] valInt = {par1};
            Parution[] list = (Parution[]) CGenUtil.rechercher(crt, null, null, c, " and numparution = " + par1);
            if (list.length > 0) {
                throw new Exception(list.length + " parution deja existante");
            }

            u = new Parution(dateP, journ, par1, datysql, nbpage, "10000", remarque);
            u.insertToTableWithHisto(this.getUser().getTuppleID(), c);

            c.commit();
            return u;
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String viserPrevision(String nomtable, String idPrev, String remarque) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String ret = viserPrevision(nomtable, idPrev, remarque, c, u.getTuppleID());
            c.commit();
            return ret;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            return null;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String viserPrevision(String nomtable, String idPrev, String remarque, Connection c, String refU) throws Exception {
        Visa vt = new Visa(nomtable, Utilitaire.dateDuJour(), remarque, idPrev, 0);
        vt.insertToTableWithHisto(refU, c);
        return vt.getTuppleID();
    }

    public void facturerPub(String idFacture, String idPub) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTable[] liste = UnionIntraTable.getMemeId1(idPub, "pubfactureValide", c);
            if (liste.length > 0) {
                throw new Exception("pub deja facture");
            }

            Publicite crtPub = new Publicite();
            crtPub.setId(idPub);
            Publicite[] listeP = (Publicite[]) CGenUtil.rechercher(crtPub, null, null, c, "");

            if (listeP.length == 0) {
                throw new Exception("Pas de pub corrspondant");
            }
            FactureFournisseur ff = new FactureFournisseur();
            ff.setIdFactureFournisseur(idFacture);
            ff.estPub(c);
            double montantRemise = listeP[0].getMontant() * (1 - (listeP[0].getRemis() / 100));
            utilitaire.UtilitaireMetier.mapperMereToFille("pubFacture", "getSEQPUBFACTURE", "PBF", idPub, idFacture, "-", String.valueOf(montantRemise), getUser().getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    /*
  public void createOrPrevisionLC(String nomtable, String nomtable1, String nomtable2, String[] temps, OrdonnerPayement[] lop, FactureFournisseur ff) throws Exception {
  Connection c=null;
  try {
    c=new utilitaire.UtilDB().GetConn();
    c.setAutoCommit(false);
    UnionIntraTableUtil uti=new UnionIntraTableUtil();
    for(int i=0;i<temps.length;i++){
        uti.setNomTable(nomtable);
        UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,temps[i],c);
        String[] idLC=new String[1];String[] montant=new String[1];String[] montantLC=new String[ui.length];
        idLC[0]=ui[0].getId2();montant[0]="0";montantLC[0]=""+ui[0].getMontantMere();
        if(lop.length!=0) mapperOrFactureClientLCTableau(lop[0].getId(),idLC , "-", montant);// insertion dans factureclientlc sy orfclc
        uti.setNomTable(nomtable2);
        UnionIntraTable[] uif=(UnionIntraTable[])uti.rechercher(2,ff.getIdFactureFournisseur(),c);
        if(uif.length!=0){
          String[] idfclc=new String[uif.length];
          for(int k=0;k<idfclc.length;k++){
            idfclc[k]=uif[k].getId();
          }
          updateMontantUnionIntraLcOp(nomtable1,nomtable2,lop[0].getId(),idfclc,montantLC);
        }
        validerMappageLCMOrControle(nomtable1,nomtable2,lop[0].getId());
        insertPrevisionOr(ff,temps[i]);
      }
    c.commit();
  }
  catch (Exception ex) {
    ex.printStackTrace();
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally
  {
    if(c!=null) c.close();
  }
  }
     */
    public void createOrPrevisionLC(String nomtable, String nomtable1, String nomtable2, String[] temps, FactureFournisseur ff) throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTableUtil uti = new UnionIntraTableUtil();

            for (int i = 0; i < temps.length; i++) {
                uti.setNomTable(nomtable);
                UnionIntraTable[] ui = (UnionIntraTable[]) uti.rechercher(2, temps[i], c);

                String[] idLC = new String[ui.length];
                String[] montant = new String[ui.length];
                for (int j = 0; j < ui.length; j++) {
                    idLC[j] = ui[j].getId2();
                    montant[j] = "" + ui[j].getMontantMere();
                }
                OrdonnerPayement op = new OrdonnerPayement();
                op.setNomTable("ordonnerrecette");
                op.setDed_Id(ff.getIdFactureFournisseur());
                OrdonnerPayement[] lop = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, "");
                if (lop.length != 0) {
                    mapperOrFactureClientLCTableau(lop[0].getId(), idLC, "-", montant);// insertion dans factureclientlc sy orfclc
                }
                uti.setNomTable(nomtable2);
                UnionIntraTable[] uif = (UnionIntraTable[]) uti.rechercher(2, ff.getIdFactureFournisseur(), c);
                if (uif.length != 0) {
                    String[] idfclc = new String[uif.length];
                    for (int k = 0; k < idfclc.length; k++) {
                        idfclc[k] = uif[k].getId();
                    }
                    updateMontantUnionIntraLcOp(nomtable1, nomtable2, lop[0].getId(), idfclc, montant);
                }
                // validerMappageLCMOrControle(nomtable1,nomtable2,lop[0].getId());
                for (int s = 0; s < temps.length; s++) {
                    //validerMappageLCPrevRecControle(nomtable1,temps[s]);
                    validerMappageLCPrevRecControle(nomtable1, lop[0].getId(), temps[s]);
                }
                insertPrevisionOr(ff, temps[i]);
            }
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void createOpPrevisionLC(String nomtable, String nomtable1, String nomtable2, String[] temps, OrdonnerPayement[] lop, FactureFournisseur ff) throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTableUtil uti = new UnionIntraTableUtil();
            for (int i = 0; i < temps.length; i++) {
                uti.setNomTable(nomtable);
                UnionIntraTable[] ui = (UnionIntraTable[]) uti.rechercher(2, temps[i], c);

                String[] idLC = new String[ui.length];
                String[] montant = new String[ui.length];
                for (int j = 0; j < ui.length; j++) {
                    idLC[j] = ui[j].getId2();
                    montant[j] = "" + ui[j].getMontantMere();
                }

                if (lop.length != 0) {
                    mapperOpFactureFournisseurLCTableau(lop[0].getId(), idLC, "-", montant);// insertion dans factureclientlc sy orfclc
                }
                uti.setNomTable(nomtable2);
                UnionIntraTable[] uif = (UnionIntraTable[]) uti.rechercher(2, ff.getIdFactureFournisseur(), c);
                if (uif.length != 0) {
                    String[] idfclc = new String[uif.length];
                    for (int k = 0; k < idfclc.length; k++) {
                        idfclc[k] = uif[k].getId();
                    }
                    updateMontantUnionIntraLcOp(nomtable1, nomtable2, lop[0].getId(), idfclc, montant);
                }
                validerMappageLCMOpControle(nomtable1, nomtable2, lop[0].getId());
                //insertPrevisionOp(ff,temps[i]);
            }
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void createOpPrevisionLCD(String nomtable, String nomtable1, String nomtable2, String[] temps, OrdonnerPayement[] lop, FactureFournisseur ff) throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTableUtil uti = new UnionIntraTableUtil();
            for (int i = 0; i < temps.length; i++) {
                uti.setNomTable(nomtable);
                UnionIntraTable[] ui = (UnionIntraTable[]) uti.rechercher(2, temps[i], c);
                String[] idLC = new String[1];
                String[] montant = new String[1];
                String[] montantLC = new String[ui.length];
                idLC[0] = ui[0].getId2();
                montant[0] = "0";
                montantLC[0] = "" + lop[0].getMontant();
                if (lop.length != 0) {
                    mapperOpFactureFournisseurLCTableau(lop[0].getId(), idLC, "-", montant);// insertion dans factureclientlc sy orfclc
                }
                uti.setNomTable(nomtable2);
                UnionIntraTable[] uif = (UnionIntraTable[]) uti.rechercher(2, ff.getIdFactureFournisseur(), c);
                if (uif.length != 0) {
                    String[] idfclc = new String[uif.length];
                    for (int k = 0; k < idfclc.length; k++) {
                        idfclc[k] = uif[k].getId();
                    }
                    updateMontantUnionIntraLcOp(nomtable1, nomtable2, lop[0].getId(), idfclc, montantLC);
                }
                validerMappageLCMOpControle(nomtable1, nomtable2, lop[0].getId());
                insertPrevisionOp(ff, temps[i]);
            }
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void validerFacturerPub(String idFacture) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTable[] liste2 = UnionIntraTable.getMemeId2(idFacture, "pubfacture", c);
            if (liste2.length == 0) {
                throw new Exception("Pas de facture a valider");
            }
            UnionIntraTable[] liste3 = UnionIntraTable.getMemeId2(idFacture, "pubfactureValide", c);
            if (liste3.length > 0) {
                throw new Exception("Facture deja attache");
            }
            FactureFournisseur crt = new FactureFournisseur();
            crt.setNomTable("factureClientVise");
            crt.setIdFactureFournisseur(idFacture);
            FactureFournisseur[] listeF = (FactureFournisseur[]) CGenUtil.rechercher(crt, null, null, c, "");
            if (listeF.length == 0) {
                throw new Exception("Pas de facture correspondante");
            }
            if (bean.AdminGen.calculSommeDouble(liste2, 4) != listeF[0].getMontantTTC()) {
                throw new Exception("Montant de pub non corr a la facture");
            }
            FactureFournisseur ff = new FactureFournisseur();
            ff.setIdFactureFournisseur(idFacture);
            ff.estPub(c);
            for (int i = 0; i < liste2.length; i++) {
                if (liste2[i].getEtat() == 1) {
                    throw new Exception("deja valide");
                }
                liste2[i].setEtat(1);
                liste2[i].updateToTableWithHisto(getUser().getTuppleID(), c);
            }
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void validerMappage(String idFacture, String nomTable) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            UnionIntraTable[] liste2 = null;
            liste2 = UnionIntraTable.getMemeId2(idFacture, nomTable, c);
            if (liste2.length == 0) {
                throw new Exception("Pas de mere a valider");
            }
            if (nomTable.compareToIgnoreCase("venteFacture") == 0) {
                FactureFournisseur crt = new FactureFournisseur();
                crt.setNomTable("factureClient");
                crt.setIdFactureFournisseur(idFacture);
                FactureFournisseur[] listeF = (FactureFournisseur[]) CGenUtil.rechercher(crt, null, null, c, "");
                if (listeF.length == 0) {
                    throw new Exception("Pas de facture correspondante");
                }
                if (bean.AdminGen.calculSommeDouble(liste2, 4) != listeF[0].getMontantTTC()) {
                    throw new Exception("Montant non correspondante");
                }
                FactureFournisseur ff = new FactureFournisseur();
                ff.setIdFactureFournisseur(idFacture);
                ff.estVente(c);
            }
            for (int i = 0; i < liste2.length; i++) {
                if (liste2[i].getEtat() == 1) {
                    throw new Exception("deja valide");
                }
                liste2[i].setEtat(1);
                liste2[i].updateToTableWithHisto(getUser().getTuppleID(), c);
            }
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public boolean isSuperUser() {
        return u.isSuperUser();
    }

    public static int indiceMax(int[] tableau, int taille) {
        int max = tableau[0];
        int indicemax = 0;
        for (int i = 0; i < taille; i++) {
            if (tableau[i] >= max) {
                max = tableau[i];
                indicemax = i;
            }
        }
        return indicemax;
    }

    public String createMvtCaisseRecette(String daty, String datyValeur, String designation, String credit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String numCheque, String etabliss, String idmvtor) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        String m;
        if (Utilitaire.stringToDouble(credit) < 0) {
            if (u.getIdrole().compareTo("admin") == 0 || u.getIdrole().compareTo("dg") == 0) {
                m = fi.createMvtCaisseRecette(daty, datyValeur, designation, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, numCheque, etabliss, idmvtor, u.getTuppleID());
            } else {
                throw new Exception("Le montant est negatif");
            }
        } else {
            m = fi.createMvtCaisseRecette(daty, datyValeur, designation, credit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, numCheque, etabliss, idmvtor, u.getTuppleID());
        }
        return m;
    }

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idmvtor) throws Exception {
        FinanceEjb fi = null;
        if (mode.compareToIgnoreCase("pay2") == 0) {
            int numPiece = Utilitaire.stringToInt(numP);
            if (numP.compareToIgnoreCase("") == 0 || numP.compareToIgnoreCase("-") == 0) {
                throw new Exception("numero piece invalide");
            }
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminCompta) == 0)) {
            fi = FinanceEjbClient.getInterface();
        } else {
            throw new Exception("erreur de droit");
        }
        String m;
        m = fi.createMvtCaisseDepense(daty, datyValeur, designation, debit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, idmvtor, u.getTuppleID());
        return m;
    }

    public String createMvtCaisseDepense(String daty, String datyValeur, String designation, String debit, String debitinitial, String devise, String mode, String caisse, String remarque, String agence, String tier, String numP, String typeM, String idOrdre, String idmvtor) throws Exception {
        FinanceEjb fi = null;
        if (mode.compareToIgnoreCase("pay2") == 0) {
            int numPiece = Utilitaire.stringToInt(numP);
            if (numP.compareToIgnoreCase("") == 0 || numP.compareToIgnoreCase("-") == 0) {
                throw new Exception("numero piece invalide");
            }
        }
        double debitD = Utilitaire.stringToDouble(debit);
        double debitInitD = Utilitaire.stringToDouble(debitinitial);
        if (debitD == 0) {
            throw new Exception("Montant invalide");
        }
        if (debitInitD < debitD) {
            throw new Exception("Montant doit etre inferieur ou egal au a " + debitinitial);
        }
        if ((u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDg) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdmin) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleDirecteur) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminFacture) == 0) || (u.getIdrole().compareToIgnoreCase(utilitaire.Constante.idRoleAdminCompta) == 0)) {
            fi = FinanceEjbClient.getInterface();
        } else {
            throw new Exception("erreur de droit");
        }
        String m;
        m = fi.createMvtCaisseDepense(daty, datyValeur, designation, debit, devise, mode, caisse, remarque, agence, tier, numP, typeM, idOrdre, idmvtor, u.getTuppleID());
        return m;
    }

    public Cheque[] findChequeEtat(String id, String mvt, String datyS1, String datyS2, String datyV1, String datyV2, String ord, String rem, String numC, String ca, String etat) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.findChequeEtat(id, mvt, datyS1, datyS2, datyV1, datyV2, ord, rem, numC, ca, etat);
    }

    public String saveMvtOr(String idmvtor, String idmvt, String numObjets) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            MvtOr crt = new MvtOr(idmvtor, idmvt, numObjets);
            c.setAutoCommit(false);
            crt.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String saveMvtOr(String idmvtor, String idmvt, String numObjets, Connection conn) throws Exception {
        try {
            MvtOr crt = new MvtOr(idmvtor, idmvt, numObjets);
            crt.insertToTableWithHisto(u.getTuppleID(), conn);
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public SaisieVirement virer(String montant, String devise, String caisse1, String caisse2, String mode, String remarque, String daty, String numCheuqe) throws Exception {
        FinanceEjb fi = null;
        fi = FinanceEjbClient.getInterface();
        return fi.virer(montant, devise, caisse1, caisse2, mode, remarque, daty, u.getTuppleID(), numCheuqe);
    }

    public OrdonnerPayement[] getListeOrdre(String tableName, String[] idmontant) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            String id = Utilitaire.stringToTab(idmontant, "'", ",");
            OrdonnerPayement op = new OrdonnerPayement();
            op.setNomTable(tableName);
            OrdonnerPayement[] list = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, " and id in (" + id + ")");
            return list;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String[] getSommeMontant(OrdonnerPayement[] ordre, String tableName, String idprev) throws Exception {
        String[] ret = new String[2];

        double m = 0;
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();

            OpVita op = new OpVita();
            op.setNomTable(tableName);
            OpVita[] list = (OpVita[]) CGenUtil.rechercher(op, null, null, c, " and id = '" + idprev + "'");
            for (int k = 0; k < ordre.length; k++) {
                m += ordre[k].getMontant();
            }
            ret[0] = m + "";
            ret[1] = list[0].getMontant() + "";
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return ret;
    }

    public String getSommeMontant(String idmontant) throws Exception {
        String ret = "";
        double m = 0;
        String etat = "PUBCOMPLETNONOR";
        try {
            String[] idpub = Utilitaire.split(idmontant, ",");
            for (int k = 0; k < idpub.length; k++) {
                Pucomplet p = new Pucomplet();
                p.setId(idpub[k]);

                Pucomplet[] list = (Pucomplet[]) CGenUtil.rechercher(p, null, null, "");
                m += list[0].getMontantVal();
            }
            ret = m + "";
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return ret;
    }

    public void attacherORPUB(String[] temp, String idor) throws Exception {
        try {
            for (int i = 0; i < temp.length; i++) {
                PubliciteAvecOR p = new PubliciteAvecOR(temp[i], idor, " - ", Utilitaire.dateDuJourSql());
                p.insertToTable();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void insertInvFact(String[] idinv, String idfact) throws Exception {
        Connection c = null;
        try {
            Invendu inv = new Invendu();
            String req = Utilitaire.stringToTab(idinv, "'", ",");
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            Invendu[] li = (Invendu[]) CGenUtil.rechercher(inv, null, null, c, " and id in (" + req + ")");

            for (int i = 0; i < li.length; i++) {
                InvenduFacture er = new InvenduFacture();
                er.setNomTable("InvenduFacture");
                er.preparePk("IVF", "getSeqInvenduFacture");
                er.setId(er.makePK(c));
                er.setId1(li[i].getId());
                er.setId2(idfact);
                er.setRemarque("-");
                er.setNbreinvendu(li[i].getNombreinvendu());
                er.setEtat(1);
                er.insertToTable(c);
            }

            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void insertPubRadioFact(String[] idinv, String idfact) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            
            for (int i = 0; i < idinv.length; i++) {
                PubRadioOR er = new PubRadioOR();
                er.setNomTable("pub_radio_or");
                er.construirePK(c);
                er.setIdpub(idinv[i]);
                er.setIdfacture(idfact);
                er.setRemarque("-");
                er.setEtat("1");
                er.insertToTable(c);
            }

            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    
    public void insertInvFact(String idinv, String idfact, String rem, int nbre, int etat) throws Exception {
        Connection c = null;
        try {
            InvenduFacture er = new InvenduFacture(idinv, idfact, rem, nbre, etat);
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int ret = er.insertToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void attacherRecetteFacture(String idrec, String idor, String montant, String daty) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            String[] g = Utilitaire.split(idrec, ",");
            OrdonnerPayement orr = new OrdonnerPayement();
            orr.setNomTable("ordonnerrecette");
            orr.setId(idor);
            OrdonnerPayement[] l = (OrdonnerPayement[]) CGenUtil.rechercher(orr, null, null, "");
            FactureFournisseur ff = new FactureFournisseur();
            ff.setNomTable("factureclient");
            ff.setNumFact(l[0].getId());
            FactureFournisseur[] lff = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, "");
            for (int i = 0; i < g.length; i++) {
                insertMereFille("venteFacture", g[i], l[0].getDed_Id(), "-", "", "0");
            }
            LiaisonOrdrePayement temp = new LiaisonOrdrePayement();
            temp.setNomTable("LiaisonOrdrePayement");
            temp.setId1(idor);
            LiaisonOrdrePayement[] listtemp = (LiaisonOrdrePayement[]) CGenUtil.rechercher(temp, null, null, c, "");
            double montanttemp = Double.parseDouble(montant);
            if (listtemp.length > 0) {
                montanttemp += l[0].getMontant();
            } else {
                temp.construirePK(c);
                temp.setRemarque("-");
                temp.setDaty(Utilitaire.dateDuJourSql());
                temp.insertToTableWithHisto(u.getTuppleID(), c);
            }
            this.updateOR("ordonnerrecette", idor, l[0].getDed_Id(), l[0].getRemarque(), daty, String.valueOf(montanttemp), c);
            UnionIntraTableUtil uit = new UnionIntraTableUtil();
            uit.setNomTable("ORFCLC");
            UnionIntraTable[] lcc = (UnionIntraTable[]) uit.rechercher(2, idor);
            this.devaliderUnionIntraTable(lcc, "ORFCLC");
            uit.setNomTable("FACTURECLIENTLC");
            lcc = (UnionIntraTable[]) uit.rechercher(2, l[0].getDed_Id());
            this.devaliderUnionIntraTable(lcc, "FACTURECLIENTLC");
            this.updateFactureFournisseur("factureclient", l[0].getDed_Id(), lff[0].getNumFact(), lff[0].getDesignation(), Utilitaire.stringToSqlDate("dd/MM/yyyy", daty), lff[0].getIdFournisseur(), lff[0].getIdTVA(), montanttemp, lff[0].getRemarque(), Utilitaire.stringToSqlDate("dd/MM/yyyy", daty), lff[0].getIdDevise());
        } catch (Exception ex) {
            ex.printStackTrace();
            // throw new Exception("ERREUR==>"+ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object updateTypeVente(String type, String daty, String nbre, String id, String publicat, String vendeur, String idPrix) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (type.compareToIgnoreCase("prise") == 0) {
                Prisejournal p = new Prisejournal();
                p.setId(id);
                p.setNbreprise(Utilitaire.stringToInt(nbre));

                Publication ptemp = new Publication();
                String[] jp = Utilitaire.split(publicat, " ");
                if (jp.length < 2) {
                    throw new Exception("veuiller saisir libJournal et parution");
                }
                ptemp.setJournal(jp[0]);
                ptemp.setNumParution(jp[1]);
                ptemp.setNomTable("PublicationLibelle");
                Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                if (pb.length == 0) {
                    throw new Exception("publication non existante");
                }
                p.setPublicat(pb[0].getId());

                Prisejournal crtp = new Prisejournal();
                crtp.setNomTable("PriseJournalvue");
                crtp.setPublicat(publicat);
                crtp.setVendeur(vendeur);
                if (CGenUtil.rechercher(crtp, null, null, c, " and id not like '" + id + "'").length > 0) {
                    throw new Exception("possible double saisie de prise");
                }

                /*fin*/
                p.setVendeur(vendeur);
                p.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                p.setIdPrix(Utilitaire.stringToDouble(idPrix));
                p.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            return null;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Object updateTypeVente2(String type, String daty, String nbre, String id, String publicat, String vendeur, String idPrix) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            if (type.compareToIgnoreCase("prise") == 0) {
                Prisecrieur p = new Prisecrieur();
                p.setId(id);
                p.setNbreprise(Utilitaire.stringToInt(nbre));

                Publication ptemp = new Publication();
                String[] jp = Utilitaire.split(publicat, " ");
                if (jp.length < 2) {
                    throw new Exception("veuiller saisir libJournal et parution");
                }
                ptemp.setJournal(jp[0]);
                ptemp.setNumParution(jp[1]);
                ptemp.setNomTable("PublicationLibelle");
                Publication[] pb = (Publication[]) bean.CGenUtil.rechercher(ptemp, null, null, c, "");
                if (pb.length == 0) {
                    throw new Exception("publication non existante");
                }
                p.setPublicat(pb[0].getId());

                Prisecrieur crtp = new Prisecrieur();
                crtp.setNomTable("Prisecrieurvue");
                crtp.setPublicat(publicat);
                crtp.setVendeur(vendeur);
                if (CGenUtil.rechercher(crtp, null, null, c, " and id not like '" + id + "'").length > 0) {
                    throw new Exception("possible double saisie de prise");
                }

                /*fin*/
                p.setVendeur(vendeur);
                p.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
                p.setIdPrix(Utilitaire.stringToDouble(idPrix));
                p.updateToTableWithHisto(u.getTuppleID(), c);
                c.commit();
            }
            return null;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public ResultatEtSomme getDataPageMultiple(ClassMAPTable e, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, Connection c, int npp) throws Exception {
        return CGenUtil.rechercherPageMultiple(e, colInt, valInt, numPage, apresWhere, nomColSomme, c, npp);
    }

    public LigneCreditDatee[] findLCEntreDeuxDates(java.sql.Date dsup, java.sql.Date dinf, Connection c) throws Exception {
        try {
            LigneCreditDatee[] listelc = null;
            LigneCreditDatee lc = new LigneCreditDatee();
            listelc = (LigneCreditDatee[]) CGenUtil.rechercher(lc, null, null, c, " and daty between '" + dinf + "' and '" + dsup + "'");
            return listelc;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public String verifLCPrev(String idprev) throws Exception {
        LCEjb lci = null;
        Connection c = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.verifLCPrev(idprev, u.getTuppleID());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public int reporterPrevision(String nomTable, String[] idPrev, String[] rep) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int i = 0;
            for (i = 0; i < idPrev.length; i++) {
                PrevisionDepense crt = new PrevisionDepense();
                crt.setNomTable(nomTable);
                crt.setId(idPrev[i]);
                crt = ((PrevisionDepense) (bean.CGenUtil.rechercher(crt, null, null, c, "")[0]));
                crt.setDaty(Utilitaire.stringDate(rep[i]));
                crt.updateToTableWithHisto(u.getTuppleID(), c);
            }
            c.commit();
            return i;
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void deletePrevision(String nomTable, String no) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            int i = 0;
            PrevisionDepense crt = new PrevisionDepense();
            crt.setNomTable(nomTable);
            crt.setId(no);
            crt.deleteToTableWithHisto(u.getTuppleID(), c);
            c.commit();
        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public java.sql.Date[] getListDateDuplication(String dinf, String dsup, String[] jour, String rec) throws Exception {
        java.sql.Date datyinf = Utilitaire.stringToSqlDate("dd/MM/yyyy", dinf);
        java.sql.Date datysup = Utilitaire.stringToSqlDate("dd/MM/yyyy", dsup);
        int reccurrecne = Utilitaire.stringToInt(rec);
        Vector vect = new Vector();
        int[] jours = Utilitaire.stringToInt(jour);
        Date[] list = Utilitaire.getListDateDebutDuplication(datyinf, jours);
        Date[] retour = null;
        try {
            for (int i = 0; i < list.length; i++) {
                java.sql.Date dtemp = list[i];
                while (dtemp.before(datysup)) {
                    vect.add(dtemp);
                    dtemp = Utilitaire.ajoutJourDate(dtemp, reccurrecne);
                }
            }
            retour = new java.sql.Date[vect.size()];

            vect.copyInto(retour);
        } catch (Exception ex) {
            throw ex;
        }
        return retour;
    }

    public double getMontantRecette(String id) throws Exception {
        Connection c = null;
        double montant = 0;
        try {
            c = new UtilDB().GetConn();

            Recette r = new Recette();
            Recette[] lu = (Recette[]) CGenUtil.rechercher(r, null, null, c, " and id in (" + id + ")");
            if (lu.length != 0) {
                for (int i = 0; i < lu.length; i++) {
                    montant = montant + lu[i].getSomme();
                }
            }
            return montant;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public double[][] calculResultat(LigneCreditNature[] lcs) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.calculResultat(lcs);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public double[][] calculResultatRD(LigneCreditNature[] lcs) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            return lci.calculResultatRD(lcs);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
    }

    public Object[] getAllDataNoPagination(ClassMAPTable e, String[] groupe, String[] sommeGroupe, String[] colInt, String[] valInt, int numPage, String apresWhere, String[] nomColSomme, String ordre, Connection c) throws Exception {
        return CGenUtil.getAllDataNoPagination(e, groupe, sommeGroupe, colInt, valInt, numPage, apresWhere, nomColSomme, ordre, c);
    }

    public String retournerMouvementDeCaisse(String idMvt) throws Exception {
        Connection conn = null;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            MvtCaisse mvt = new MvtCaisse();
            MvtCaisse[] liste = (MvtCaisse[]) CGenUtil.rechercher(mvt, null, null, " AND ID = '" + idMvt + "'");
            String idM = liste[0].getId();
            if (liste != null && liste.length > 0) {
                double montantDebit = liste[0].getDebit();
                double montantCredit = liste[0].getCredit();
                MvtCaisse mvt2 = new MvtCaisse();
                mvt2.setNomTable("mvtcaisse");
                mvt2.setIndicePk("MVT");
                mvt2.setNomProcedureSequence("getSeqMvt");
                mvt2.setId(mvt2.makePK(conn));
                mvt2.setDebit(montantCredit);
                mvt2.setCredit(montantDebit);
                mvt2.setAgence(liste[0].getAgence());
                mvt2.setDaty(Utilitaire.dateDuJourSql());
                mvt2.setDatyValeur(Utilitaire.dateDuJourSql());
                mvt2.setDesignation(liste[0].getDesignation());
                mvt2.setEtablissement(liste[0].getEtablissement());
                mvt2.setIdCaisse(liste[0].getIdCaisse());
                mvt2.setIdDevise(liste[0].getIdDevise());
                mvt2.setIdMode(liste[0].getIdMode());
                mvt2.setIdmvtor(liste[0].getIdmvtor());
                mvt2.setIdOrdre(liste[0].getIdOrdre());
                mvt2.setNumcheque(liste[0].getNumcheque());
                mvt2.setNumPiece(liste[0].getNumPiece());
                mvt2.setRemarque(liste[0].getRemarque());
                mvt2.setTiers(liste[0].getTiers());
                mvt2.setTypeMvt("2");

                mvt2.insertToTableWithHisto(u.getTuppleID(), conn);

                liste[0].setTypeMvt("2");
                liste[0].updateToTable(conn);

                UnionIntraTable uit = new UnionIntraTable("RETOURMONNAIEMVTCAISSE", liste[0].getId(), mvt2.getId(), "", liste[0].getDebit() + "", "RMT");
                uit.setNomProcedureSequence("getseqRetourMvtCaisse");
                uit.setId(uit.makePK(conn));
                uit.insertToTableWithHisto(u.getTuppleID(), conn);
                //comptabilite
                ComptabiliteEjbClient.getInterface().ecrireMvt(mvt2.getTuppleID(), "", conn, u.getTuppleID());
                conn.commit();
                return mvt2.getId();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public Integer[] getListMoisDuplication(String mois1, String mois2, String recurrence) throws Exception {
        int m1 = Integer.valueOf(mois1).intValue();
        int m2 = Integer.valueOf(mois2).intValue();
        int rec = Integer.valueOf(recurrence).intValue();
        if (m1 > m2) {
            throw new Exception("Le mois fin doit etre superieur au mois debut");
        }

        Integer[] result = null;
        Vector vect = new Vector();

        int value = m1;
        while (value <= m2) {
            vect.add(new Integer(value));
            value = value + rec;
        }
        result = new Integer[vect.size()];
        vect.copyInto(result);
        return result;
    }

    public void dupliquerLC(String numObjet, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            lci.dupliquerLC(numObjet, montantTab, n_dupl, lmois, lannee, remarque, nomtable, u.getTuppleID());
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public void dupliquerLCMultiple(String[] ids, String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable) throws Exception {
        LCEjb lci = null;
        try {
            lci = LCEjbClient.getInterface();;
            lci.dupliquerLCMultiple(ids, montantTab, n_dupl, lmois, lannee, remarque, nomtable, u.getTuppleID());
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public java.sql.Date generateDateLimiteFactureClient(String periodeDebut, String daty, String idSCatService) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            java.sql.Date s = fl.generateDateLimiteFactureClient(periodeDebut, daty, idSCatService);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFactureMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, respe, entite, parution, modepaiement, dateLimite, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    //, String ttva, String datyparu
    public String createFactureMereRadio(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String[] g, String ttva, String datyparu) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFactureMereRadio(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, respe, entite, parution, modepaiement, dateLimite, u.getTuppleID(), g, ttva, datyparu);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureMereRadio2(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String[] g, String ttva, String datyparu) throws Exception {
        FactureEjb fl = null;
        try {
            fl = FactureEJBClient.getInterface();
            String s = fl.createFactureMereRadio2(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, respe, entite, parution, modepaiement, dateLimite, u.getTuppleID(), g, ttva, datyparu);
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }
    
    public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String modepaiement, String datelimite) throws Exception {
        try {
            String s = FactureEJBClient.getInterface().finaliseFactureUpdate(idFact, daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, modepaiement, datelimite, u.getTuppleID());
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void payerRibMultiple(String listeRib, String remarque, String typeprevu, String fournisseur, String dateDePaiement, String typelc, String mois, String annee, String[] entitee) throws Exception {
        Connection conn = null;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            // recherche liste rib
            String req = listeRib;
            Rib crtRib = new Rib();
            Rib[] listRib = (Rib[]) CGenUtil.rechercher(crtRib, null, null, conn, " and ID in (" + req + ")");

            String entite = Utilitaire.stringToTab(entitee, "'", ",");

            LigneCredit lc = new LigneCredit();
            String apw = " and mois = '" + mois + "' and idtypeligne = '" + typelc + "' and annee = " + annee + " and identite in (" + entite + ")";
            System.out.println(apw);
            LigneCredit[] llc = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, conn, apw);
            if (llc == null || llc.length == 0) {
                throw new Exception("aucune LC trouv�e");
            }

            for (int i = 0; i < listRib.length; i++) {

                // creation facture
                FactureFournisseur ff = new FactureFournisseur();
                ff.setNomTable("FACTUREFOURNISSEUR");
                ff.setIndicePk("FF");
                ff.setNomProcedureSequence("getSEQFACTUREfournisseur");
                ff.setDateEmission(Utilitaire.dateDuJourSql());
                ff.setDatyecheance(Utilitaire.dateDuJourSql());
                ff.setDaty(Utilitaire.dateDuJourSql());
                ff.setIdFournisseur(fournisseur);
                ff.setIdFactureFournisseur(ff.makePK(conn));
                ff.insertToTableWithHisto(u.getTuppleID(), conn);

                // attachement facture & LC
                String ref = UtilitaireMetier.mapperMereToFille("FACTUREFOURNISSEURLC", "getSeqFactLigneF", "SFF", ff.getIdFactureFournisseur(), llc[0].getIdLigne(), "-", listRib[i].getDebit() + "", u.getTuppleID(), "1", conn);
                // creation OP + creation op type payement (boucle)
                OrdonnerPayement op = new OrdonnerPayement();
                op.setNomTable("ORDONNERPAYEMENT");
                op.setDed_Id(ff.getIdFactureFournisseur());
                op.setDaty(Utilitaire.stringToSqlDate("dd/MM/yyyy", dateDePaiement));
                op.setEtat(1);
                op.setMontant(listRib[i].getDebit());
                op.setRemarque(listRib[i].getDesignation() + " " + remarque);
                op.setNomTable("OrdonnerPayement");
                op.preparePk("ORP", "getSeqOp");
                op.setId(op.makePK());
                op.setId(op.makePK(conn));
                op.insertToTableWithHisto(u.getTuppleID(), conn);

                // attachement LC & OP
                String retour = UtilitaireMetier.mapperMereToFille("opFFlc", "getSeqOpFFlc", "OFL", op.getId(), ref, remarque, listRib[i].getDebit() + "", u.getTuppleID(), "1", conn);
                OpTypeDatePaiement tdp = new OpTypeDatePaiement();
                tdp.setDate_paiement(Utilitaire.stringToSqlDate("dd/MM/yyyy", dateDePaiement));
                tdp.setIdop(op.getId());
                tdp.setRemarque(remarque);
                tdp.setTypee(typeprevu);
                tdp.construirePK(conn);
                tdp.insertToTableWithHisto(u.getTuppleID(), conn);
                // creation mouvement de caisse (=nombre OP)

                String mvmax = Utilitaire.getMaxId("mvtcaisse");
                String[] g = Utilitaire.split(mvmax, "MVT");
                String idmvtor = "SMOR" + g[0] + 1;
                //String mvt = createMvtCaisseDepense(dateDePaiement, "",listRib[i].getDesignation(), listRib[i].getDebit()+"" ,"Ar", "pay2", listRib[i].getCaisse() , remarque, "ag017", fournisseur, listRib[i].getNumcheque() ,"1", op.getId(),idmvtor);
                MvtCaisse m = new finance.MvtCaisse(dateDePaiement, dateDePaiement, listRib[i].getDesignation(), listRib[i].getDebit() + "", "0", "Ar", "pay2", listRib[i].getCaisse(), remarque, "ag017", fournisseur, listRib[i].getNumcheque(), "1", op.getId());
                String etatpiece = "non";
                m.setIdmvtor(idmvtor);
                m.insertToTableWithHisto(u.getTuppleID(), conn);

                ded.AssocOpMvtCaisse aos = new ded.AssocOpMvtCaisse(op.getId(), m.getId(), fournisseur);
                ded.AssocEtatPieceMc aem = new ded.AssocEtatPieceMc(op.getId(), etatpiece);
                aem.insertToTableWithHisto(u.getTuppleID(), conn);
                aos.insertToTableWithHisto(u.getTuppleID(), conn);
                saveMvtOr(idmvtor, m.getId(), op.getId(), conn);

                RapprochementBancaire rp = new RapprochementBancaire();
                rp.setDateoperation(Utilitaire.dateDuJourSql());
                rp.setDesignation(listRib[i].getDesignation());
                rp.setIdmouvement(m.getId());
                rp.setIdrib(listRib[i].getId());
                rp.construirePK(conn);
                rp.insertToTableWithHisto(u.getTuppleID(), conn);

                conn.commit();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public String createOp(String idDed, String daty, String montant, String rem, String typePrevu, String datePaiement, String remarquePaiement) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.creerOp(daty, idDed, montant, "0", rem, typePrevu, datePaiement, remarquePaiement, u.getTuppleID());
        return s;
    }

    public String createOp(String idDed, String daty, String montant, String rem, String typePrevu, String datePaiement, String remarquePaiement, Connection c) throws Exception {
        DedEjb fi = null;
        fi = DedEjbClient.getInterface();
        String s = fi.creerOp(daty, idDed, montant, "0", rem, typePrevu, datePaiement, remarquePaiement, u.getTuppleID(), c);
        return s;
    }

    public String updateDateOp(String[] id, Date date_payement, Connection c) throws Exception {
        String ids = Utilitaire.stringToTab(id, "'", ",");
        OpTypeDatePaiement op = new OpTypeDatePaiement();
        //System.out.println(" and id in(" + ids + ")" + date_payement);
        OpTypeDatePaiement[] aupd = (OpTypeDatePaiement[]) CGenUtil.rechercher(op, null, null, c, " and idop in(" + ids + ")");
        for (int i = 0; i < aupd.length; i++) {
            aupd[i].setDate_paiement(date_payement);
            
            aupd[i].upDateToTable();
        }
        return ids;
    }

    public String updateDateOp(String[] id, java.sql.Date date_payement) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return updateDateOp(id, date_payement, c);

        } catch (Exception e) {
            throw new Exception("erreur de mise a jour des date de paiement:" + e.getMessage());
        }
    }

    public void modifEtatAbonne(String idvendeur) throws Exception {
        Connection conn = null;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);

            Vendeur vendeur = new Vendeur();
            vendeur.setId(idvendeur);
            Vendeur[] vendeurs = (Vendeur[]) CGenUtil.rechercher(vendeur, null, null, conn, "");
            if (vendeurs.length < 0) {
                throw new Exception("Abonn&eacute; inexistant");
            }

            String etat = vendeur.getEtat();
            if (etat.compareToIgnoreCase("0") == 0) {
                vendeur.setEtat("1");
            } else {
                vendeur.setEtat("0");
            }

            vendeur.updateToTableWithHisto(u.getTuppleID(), conn);

            conn.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public String validerAbonnement(String idvendeur) throws Exception {
        Connection conn = null;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);

            Vendeur vendeur = new Vendeur();
            vendeur.setId(idvendeur);
            Vendeur[] vendeurs = (Vendeur[]) CGenUtil.rechercher(vendeur, null, null, conn, "");
            if (vendeurs.length < 0) {
                throw new Exception("Abonn&eacute; inexistant");
            }

            String etat = vendeur.getEtat();
            vendeur.setEtat("11");

            // dur�e abonnement
            Abonnement abnmt = new Abonnement();
            abnmt.setNomTable("abonnement_abonnee");
            Abonnement[] labnmt = (Abonnement[]) CGenUtil.rechercher(abnmt, null, null, conn, " and idabonne = '" + idvendeur + "'");
            // compter nombre jour
            Date[] listeDaty = Utilitaire.getIntervalleDateNonFerie(labnmt[0].getDatefin(), labnmt[0].getDatedebut());
            double nbJour = listeDaty.length;
            // calculer montant a payer
            AbonnementJournalVue abj = new AbonnementJournalVue();
            abj.setNomTable("abonnement_journal_vue");
            AbonnementJournalVue[] listJournal = (AbonnementJournalVue[]) CGenUtil.rechercher(abj, null, null, conn, " and idabonnement = '" + labnmt[0].getId() + "'");

            double montant = 0;
            for (int i = 0; i < listJournal.length; i++) {
                montant += listJournal[i].getQuantite() * listJournal[i].getPu();
            }
            // cr�ation facture

            String idFmere = createFactureMere(Utilitaire.dateDuJour(), Utilitaire.dateDuJour(), Utilitaire.dateDuJour(), "clt003623", "-", "0", "Ar", "Ar", "0", "scat10", "typ02", "ag003", "BE011", "-");
            // String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF
            String idFfille = createFactureFille(idFmere, "scat10", labnmt[0].getObservation(), "1", "unt", montant + "", "0");

            FactureFournisseur fc = new FactureFournisseur();
            fc.setNomTable("factureclient");
            fc.setDaty(Utilitaire.dateDuJourSql());
            fc.setDateEmission(Utilitaire.dateDuJourSql());
            fc.setDatyecheance(Utilitaire.dateDuJourSql());
            fc.setMontantTTC(montant);
            fc.setIdDevise("Ar");
            fc.setIdTVA(0);
            fc.setNumFact(idFmere);
            fc.setDesignation("abonnement journal");
            fc.setRemarque(labnmt[0].getId());
            fc.setResp("ag003");
            fc.setIdFournisseur("clt003623");

            fc.setNomProcedureSequence("getSeqFactureClient");
            fc.setIndicePk("FCC");
            fc.setIdFactureFournisseur(fc.makePK(conn));
            fc.construirePK(conn);

            System.out.println(" u.getTuppleID() ======= " + u.getTuppleID() + " conn ===== " + conn);
            fc.insertToTableWithHisto(u.getTuppleID(), conn);

            vendeur.updateToTableWithHisto(u.getTuppleID(), conn);

            conn.commit();
            return "lc/listeLcRecetteChoix.jsp&numObjet=" + fc.getIdFactureFournisseur() + "&montantObjet0=" + montant;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public void livraisonMultipleAbonne(String[] idabonne, String idcoursier) throws Exception {
        try {
            for (int i = 0; i < idabonne.length; i++) {
                livraisonJournalAbonnement(idcoursier, idabonne[i]);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void livraisonJournalAbonnement(String idcoursier, String idAbonne) throws Exception {
        Connection conn = null;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            //find abonne dans abonnement
            Abonnement[] listeAbonnement = (Abonnement[]) CGenUtil.rechercher(new Abonnement(), null, null, conn, " AND IDABONNE = '" + idAbonne + "' ORDER BY ID DESC");
            if (listeAbonnement.length > 0) {
                //find idoffre dans offre
                Offre[] offre = (Offre[]) CGenUtil.rechercher(new Offre(), null, null, conn, " AND ID = '" + listeAbonnement[0].getIdoffre() + "'");
                if (offre.length > 0) {
                    OffreJournal[] offreJournal = (OffreJournal[]) CGenUtil.rechercher(new OffreJournal(), null, null, conn, " AND IDOFFRE = '" + offre[0].getId() + "'");
                    if (offreJournal.length > 0) {
                        // insertion dans la table livraison
                        ventegazety.Livraison livraison = new ventegazety.Livraison();
                        livraison.setDatelivraison(Utilitaire.dateDuJourSql());
                        livraison.setIdcoursier(idcoursier);
                        livraison.setIdabonnement(listeAbonnement[0].getId());
                        livraison.construirePK(conn);
                        livraison.insertToTableWithHisto(u.getTuppleID(), conn);

                        // insertion dans la table prisejournal
                        Abonne[] abonne = (Abonne[]) CGenUtil.rechercher(new Abonne(), null, null, conn, " AND ID = '" + idAbonne + "'");
                        Prisejournal pr = new Prisejournal();
                        for (int i = 0; i < offreJournal.length; i++) {
                            Publication[] publication = (Publication[]) CGenUtil.rechercher(new Publication(), null, null, conn, " AND JOURNAL = '" + offreJournal[0].getIdjournal() + "' AND DATY ='" + Utilitaire.dateDuJour() + "'");
                            AbonnementJournal[] abonnementJournal = (AbonnementJournal[]) CGenUtil.rechercher(new AbonnementJournal(), null, null, conn, " AND IDABONNEMENT = '" + listeAbonnement[0].getId() + "' AND IDOFFREJOURNAL ='" + offreJournal[i].getId() + "'");
                            if (publication.length > 0) {
                                pr.setVendeur(abonne[0].getIdvendeur());
                                pr.setDaty(Utilitaire.dateDuJourSql());
                                pr.setIdPrix(offreJournal[i].getMontant()); // prix anaty table offre journal
                                pr.setNbreprise(Utilitaire.doubleToInt(String.valueOf(abonnementJournal[0].getQuantite())));
                                pr.setPlace(livraison.getId());
                                pr.setPublicat(publication[0].getId());
                                pr.setPlace(livraison.getId());
                                pr.construirePK(conn);
                                pr.insertToTableWithHisto(u.getTuppleID(), conn);

                                // insertion dans la table recette
                                Recette rct = new Recette();
                                rct.setPrise(pr.getId());
                                double montant = offreJournal[i].getMontant() * abonnementJournal[0].getQuantite();
                                rct.setSomme(montant);// prix anaty table offre journal
                                rct.setDaty(Utilitaire.dateDuJourSql());
                                rct.construirePK(conn);
                                rct.insertToTableWithHisto(u.getTuppleID(), conn);

                                // insertion dans la table ventefacture
                                FactureFournisseur ff = new FactureFournisseur();
                                ff.setNomTable("FACTURECLIENT");
                                FactureFournisseur[] listeFacture = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, conn, " AND REMARQUE = '" + listeAbonnement[0].getId() + "'");
                                if (listeFacture.length == 0) {
                                    throw new Exception("Pas de facture correspondante");
                                }
                                UnionIntraTable vf = new UnionIntraTable("VENTEFACTURE", "getseqVentefacture", "VF", rct.getId(), listeFacture[0].getIdFactureFournisseur(), "-", montant, 1);
                                vf.insertToTableWithHisto(u.getTuppleID(), conn);
                            }
                        }

                    }
                }

            }
            conn.commit();
        } catch (Exception exc) {
            exc.printStackTrace();
            throw new Exception(exc.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    @Override
    public EJBHome getEJBHome() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object getPrimaryKey() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void remove() throws RemoteException, RemoveException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Handle getHandle() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isIdentical(EJBObject obj) throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getMaxId(String table) {
        String retour = "---";
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(id) from " + table);
            res.next();
            retour = res.getString(1);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return retour;
    }

    @Override
    public String getMaxIdMarge() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getMaxIdGestion() {
        String retour = "---";
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(idGestion) from gestionprix");
            res.next();
            retour = res.getString(1);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return retour;
    }

    @Override
    public String getMaxIdMaintenance() {
        String retour = "---";
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(idMaintenance) from maintenance");
            res.next();
            retour = res.getString(1);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return retour;
    }

    @Override
    public String getMaxIdTirage() {
        String retour = "---";
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(idTirage) from tirage");
            res.next();
            retour = res.getString(1);
            if (c != null) {
                c.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return retour;
    }

    @Override
    public String getMaxIdProduction() {
        String retour = "---";
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            java.sql.Statement sta = c.createStatement();
            java.sql.ResultSet res = sta.executeQuery("select max(idproduction) from production");
            res.next();
            retour = res.getString(1);
            if (c != null) {
                c.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return retour;
    }

    public comptabilite.Societe[] findSociete(String idSociete, String nom, String regime, String tel, String fax,
            String email, String gerant, String nif, String numstat, String rc, String capital, String quittance) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            comptabilite.Societe aclient[] = fl.findSociete(idSociete, nom, regime, tel, fax, email, gerant, nif, numstat, rc, capital, quittance);
            return aclient;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int insertMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
            java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.insertMultipleEcriture(daty, societe, journal, numpiece, compte, tiers, echeance, libelle, montantcredit, montantdebit, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void viserMultipleEcriture(String[] temp) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.viserMultipleEcriture(temp, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void viserEcriture(String temp) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.viserEcriture(temp, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void extournerEcriture(String num) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.extournerEcriture(num, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void updateMultipleEcriture(java.sql.Date[] daty, String[] societe, String[] journal, String[] numpiece, String[] compte, String[] tiers,
            java.sql.Date[] echeance, String[] libelle, double[] montantcredit, double[] montantdebit, String[] id, int numero, int tailleInit) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.updateMultipleEcriture(daty, societe, journal, numpiece, compte, tiers, echeance, libelle, montantcredit, montantdebit,
                    id, numero, tailleInit, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void lettrerEcriture(String[] ecritures) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.lettrerEcriture(ecritures, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Balance[] setInitSoldeBalance(Balance[] liste, String daty) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.setInitSoldeBalance(liste, daty);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public BalanceTiers[] setInitSoldeBalanceTiers(BalanceTiers[] liste, String daty) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.setInitSoldeBalanceTiers(liste, daty);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void transcrireClientFournisseur() throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.transcrireClientFournisseur(u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void transcrireDepense() throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.transcrireDepense(2017, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void transcrireVente() throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.transcrireVente(2017, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void transcrireTresorerie() throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.transcrireTresorerie(2017, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public double[] calculSommeInit(Balance[] listeR) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.calculSommeInit(listeR);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void reporter(String exercice, Date daty) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.reporter(exercice, daty, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Exercice cloturerExercice(String exercice, Date daty) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.cloturerExercice(exercice, daty, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void lettrageAutomatique() throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.lettrageAutomatique(u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void cloturerEtReporter(String exercice, java.sql.Date daty) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.cloturerEtReporter(exercice, daty, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public comptabilite.Ecriture[] getPrevDeclaration(String[] debitD, String[] creditD, String[] debitU, String[] creditU) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.getPrevDeclaration(debitD, creditD, debitU, creditU);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void lettrerDeclaration(int numE, String debitD, String creditD, String debitU, String creditU) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.lettrerDeclaration(numE, debitD, creditD, debitU, creditU, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void transcrireEmployeMultiple(String ids, String entites, String noms, String prenoms, String telephones,
            String adresses, String fonctions, String postes, String matricules) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.transcrireEmployeMultiple(ids, entites, noms, prenoms, telephones, adresses, fonctions, postes, matricules, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] genererActifs(String exercice) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.genererActifs(exercice);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] genererPassifs(String exercice) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.genererPassifs(exercice);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] genererCompteResultat(String exercice) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.genererCompteResultat(exercice);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] genererResultat(String exercice, int annee) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.genererResultat(exercice, annee);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] getResultatAvecFormule(String exercice, int annee) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.getResultatAvecFormule(exercice, annee);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] getResultatPassifFinal(String exercice, int annee) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.getResultatPassifFinal(exercice, annee);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] getResultatActifFinal(String exercice, int annee) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.getResultatActifFinal(exercice, annee);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] getResultatPassifs(String exercice, int annee) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.getResultatPassifs(exercice, annee);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Bilan[] getResultatActifs(String exercice, int annee) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            return fl.getResultatActifs(exercice, annee);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void rapprocher(String[] idRappro, String[] idGrandLivre, String idcaisse) throws Exception {
        Connection c = null;
        Rib[] releve = new Rib[idRappro.length];
        MvtCaisseTous[] grandLivre = new MvtCaisseTous[idGrandLivre.length];
        try {
            c = (new UtilDB()).GetConn();
            String[] idreleve = null;
            String val = Utilitaire.stringToTab(idRappro, "'", ",");;
            Rib rr = new Rib();
            rr.setNomTable("RIBNONRAPPROCHE");
            String apreswhere = " and caisse='" + idcaisse + "' and ID in (" + val + ")";
            releve = (Rib[]) CGenUtil.rechercher(rr, null, null, c, apreswhere);
            String sqlIdgranLivre = Utilitaire.stringToTab(idGrandLivre, "'", ",");
            MvtCaisseTous rapproGL = new MvtCaisseTous();
            rapproGL.setNomTable("MVTNONRAPPROCHE");
            String apw = " and idcaisse='" + idcaisse + "' and ID in (" + sqlIdgranLivre + ")";
            grandLivre = (MvtCaisseTous[]) CGenUtil.rechercher(rapproGL, null, null, c, apw);
            RapprochementService service = new RapprochementService();
            service.rapprocher(releve, grandLivre, u.getTuppleID(), c);
            
            // mise a jour date de mouvement
            service.updateDateMvtCaisseRib (grandLivre, releve[0].getDaty(), u.getTuppleID(), c);
            
            
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void rapprochementAutomatique(String idcaisse) throws Exception {
        Connection connection = null;
        UtilDB util = new UtilDB();
        connection = util.GetConn();
        try {
            MvtCaisseTous rapproGL = new MvtCaisseTous();
            rapproGL.setNomTable("MVTNONRAPPROCHE");
            String apw = " and idcaisse ='" + idcaisse + "'";
            MvtCaisseTous[] grandLivre = (MvtCaisseTous[]) CGenUtil.rechercher(rapproGL, null, null, connection, apw);
            Rib rr = new Rib();
            rr.setNomTable("RIBNONRAPPROCHE");
            String apreswhere = " and caisse='" + idcaisse + "'";
            Rib[] releve = (Rib[]) CGenUtil.rechercher(rr, null, null, connection, apreswhere);
            RapprochementService service = new RapprochementService();
            if (releve != null && grandLivre != null) {
                service.lettrerAuto(releve, grandLivre, u.getTuppleID(), connection);
                // mise a jour date de mouvement
                service.updateDateMvtCaisseRib (grandLivre, releve[0].getDaty(), u.getTuppleID(), connection);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    public double calculmontantApresCommission(double montant) {
        double com = (montant * 20) / 100;
        double montantpaye = montant - com;
        return montantpaye;
    }

    public void insertEmploye(String id, String entite, String nom, String prenom, String telephone,
            String adresse, String fonction, String poste, String matricule) throws Exception {
        ComptabiliteEjb fl = null;
        try {
            fl = ComptabiliteEjbClient.getInterface();
            fl.insertEmploye(id, entite, nom, prenom, telephone, adresse, fonction, poste, matricule, u.getTuppleID());
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public void annulerOPReste(String[] idop, HashMap<String, String> remarque) throws Exception {
        Connection c = null;
        UtilDB util = new UtilDB();
        c = util.GetConn();
        try {
            c.setAutoCommit(false);
            OrdonnerPayementReste[] aAnnuler = null;
            String aWhere = Utilitaire.stringToTab(idop, "'", ",");
            aAnnuler = (OrdonnerPayementReste[]) this.getData(new OrdonnerPayementReste(), null, null, c, " and id in (" + aWhere + ")");
            for (int i = 0; i < aAnnuler.length; i++) {
                String rmq = remarque.get(aAnnuler[i].getId());
                OrdonnerPayement[] opMaj = (OrdonnerPayement[]) this.getData(new OrdonnerPayement(), null, null, c, " and id = '" + aAnnuler[i].getId() + "'");
                if (aAnnuler[i].getPaye() > 0) {//cas 1
                    //MAJ OP - reste
                    if (opMaj.length > 0) {
                        //FactureFournisseur - reste
                        double reste = aAnnuler[i].getReste();
                        double opMajMontant = opMaj[0].getMontant() - reste;
                        opMaj[0].setMontant(opMajMontant);
                        FactureFournisseur[] facMaj = (FactureFournisseur[]) this.getData(new FactureFournisseur(), null, null, c, " and idFactureFournisseur = '" + opMaj[0].getDed_Id() + "'");
                        if (facMaj.length > 0) {
                            double montantFac = facMaj[0].getMontantTTC();
                            double facMajMontant = montantFac - reste;
                            facMaj[0].setMontantTTC(facMajMontant);
                            facMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            //LC et OP repartie - reste
                            UnionIntraTable crit = new UnionIntraTable();
                            crit.setNomTable("FACTUREFOURNISSEURLC");
                            UnionIntraTable[] unionFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + facMaj[0].getIdFactureFournisseur() + "'");
                            crit.setNomTable("OPFFLC");
                            UnionIntraTable[] unionOPFFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + opMaj[0].getId() + "'");
                            for (int j = 0; j < unionFLC.length; j++) {
                                double montanttmp = unionFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (reste * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionFLC[j].setMontantMere(montanttmp);
                                unionFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                            for (int j = 0; j < unionOPFFLC.length; j++) {
                                double montanttmp = unionOPFFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (reste * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionOPFFLC[j].setMontantMere(montanttmp);
                                unionOPFFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                        }
                        opMaj[0].setRemarque(opMaj[0].getRemarque() + " " + rmq);
                        opMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                    }

                } else { //Cas 2
                    if (opMaj.length > 0) {
                        double opMontant = opMaj[0].getMontant();
                        opMaj[0].setEtat(0);
                        opMaj[0].setMontant(0);
                        FactureFournisseur[] facMaj = (FactureFournisseur[]) this.getData(new FactureFournisseur(), null, null, c, " and idFactureFournisseur = '" + opMaj[0].getDed_Id() + "'");
                        if (facMaj.length > 0) {
                            double montantFac = facMaj[0].getMontantTTC();
                            double facMajMontant = montantFac - opMontant;
                            facMaj[0].setMontantTTC(facMajMontant);
                            facMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            //LC et OP repartie - reste
                            UnionIntraTable crit = new UnionIntraTable();
                            crit.setNomTable("FACTUREFOURNISSEURLC");
                            UnionIntraTable[] unionFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + facMaj[0].getIdFactureFournisseur() + "'");
                            crit.setNomTable("OPFFLC");
                            UnionIntraTable[] unionOPFFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + opMaj[0].getId() + "'");
                            for (int j = 0; j < unionFLC.length; j++) {
                                double montanttmp = unionFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (opMontant * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionFLC[j].setMontantMere(montanttmp);
                                unionFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                            for (int j = 0; j < unionOPFFLC.length; j++) {
                                double montanttmp = unionOPFFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (opMontant * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionOPFFLC[j].setMontantMere(montanttmp);
                                unionOPFFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                        }
                        opMaj[0].setRemarque(opMaj[0].getRemarque() + " " + rmq);
                        opMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                    }

                }
            }

        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void annulerORReste(String[] idop, HashMap<String, String> remarque) throws Exception {
        Connection c = null;
        UtilDB util = new UtilDB();
        c = util.GetConn();
        try {
            c.setAutoCommit(false);
            OrdonnerPayementReste[] aAnnuler = null;
            String aWhere = Utilitaire.stringToTab(idop, "'", ",");
            OrdonnerPayementReste or = new OrdonnerPayementReste();
            or.setNomTable("ordonnerrecettereste");
            aAnnuler = (OrdonnerPayementReste[]) this.getData(or, null, null, c, " and id in (" + aWhere + ")");
            for (int i = 0; i < aAnnuler.length; i++) {
                String rmq = remarque.get(aAnnuler[i].getId());
                OrdonnerPayement recette = new OrdonnerPayement();
                recette.setNomTable("ORDONNERRECETTE");
                OrdonnerPayement[] opMaj = (OrdonnerPayement[]) this.getData(recette, null, null, c, " and id = '" + aAnnuler[i].getId() + "'");
                if (aAnnuler[i].getPaye() > 0) {//cas 1
                    //MAJ OP - reste
                    if (opMaj.length > 0) {
                        //FactureFournisseur - reste
                        double reste = aAnnuler[i].getReste();
                        //double opMajMontant = opMaj[0].getMontant() - reste;
                        opMaj[0].setMontant(aAnnuler[i].getPaye());
                        FactureFournisseur fact = new FactureFournisseur();
                        fact.setNomTable("FACTURECLIENT");
                        FactureFournisseur[] facMaj = (FactureFournisseur[]) this.getData(fact, null, null, c, " and idFactureFournisseur = '" + opMaj[0].getDed_Id() + "'");
                        if (facMaj.length > 0) {
                            double montantFac = facMaj[0].getMontantTTC();
                            double facMajMontant = montantFac - reste;
                            facMaj[0].setMontantTTC(facMajMontant);
                            facMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            //LC et OR repartie - reste
                            UnionIntraTable crit = new UnionIntraTable();
                            crit.setNomTable("FACTURECLIENTLC");
                            UnionIntraTable[] unionFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + facMaj[0].getIdFactureFournisseur() + "'");
                            crit.setNomTable("orFClc");
                            UnionIntraTable[] unionOPFFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + opMaj[0].getId() + "'");
                            for (int j = 0; j < unionFLC.length; j++) {
                                double montanttmp = unionFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (reste * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionFLC[j].setMontantMere(montanttmp);
                                unionFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                            for (int j = 0; j < unionOPFFLC.length; j++) {
                                double montanttmp = unionOPFFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (reste * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionOPFFLC[j].setMontantMere(montanttmp);
                                unionOPFFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                            if (unionFLC.length > 0) {
                                LigneCredit credit = new LigneCredit();
                                credit.setNomTable("lignecreditrecette");
                                credit.setIdLigne(unionFLC[0].getId2());
                                LigneCredit[] lignecredit = (LigneCredit[]) CGenUtil.rechercher(credit, null, null, c, "");
                                if (lignecredit.length > 0) {
                                    double montantcredit = lignecredit[0].getCreditModifier() - reste;
                                    if (lignecredit[0].getMontantFac() > 0) {
                                        double montantfact = lignecredit[0].getMontantFac() - reste;
                                        lignecredit[0].setMontantFac(montantfact);
                                    }
                                    lignecredit[0].setCreditModifier(montantcredit);
                                    lignecredit[0].updateToTableWithHisto(u.getTuppleID(), c);
                                } else {
                                    throw new Exception("cette ligne de credit n existe pas");
                                }
                            }
                        }
                        opMaj[0].setRemarque(opMaj[0].getRemarque() + " " + rmq);
                        opMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                    }

                } else { //Cas 2
                    if (opMaj.length > 0) {
                        double opMontant = aAnnuler[i].getReste();
                        opMaj[0].setEtat(0);
                        opMaj[0].setMontant(0);
                        FactureFournisseur[] facMaj = (FactureFournisseur[]) this.getData(new FactureFournisseur(), null, null, c, " and idFactureFournisseur = '" + opMaj[0].getDed_Id() + "'");
                        if (facMaj.length > 0) {
                            double montantFac = facMaj[0].getMontantTTC();
                            double facMajMontant = montantFac - opMontant;
                            facMaj[0].setMontantTTC(facMajMontant);
                            facMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            //LC et OP repartie - reste
                            UnionIntraTable crit = new UnionIntraTable();
                            crit.setNomTable("FACTURECLIENTLC");
                            UnionIntraTable[] unionFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + facMaj[0].getIdFactureFournisseur() + "'");
                            crit.setNomTable("orFClc");
                            UnionIntraTable[] unionOPFFLC = (UnionIntraTable[]) CGenUtil.rechercher(crit, null, null, c, " and id1 = '" + opMaj[0].getId() + "'");
                            for (int j = 0; j < unionFLC.length; j++) {
                                double montanttmp = unionFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (opMontant * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionFLC[j].setMontantMere(montanttmp);
                                unionFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                            for (int j = 0; j < unionOPFFLC.length; j++) {
                                double montanttmp = unionOPFFLC[j].getMontantMere();
                                double pourcentage = (montanttmp * 100) / montantFac;
                                double resteEnPourcentage = (opMontant * pourcentage) / 100;
                                montanttmp = -resteEnPourcentage;
                                unionOPFFLC[j].setMontantMere(montanttmp);
                                unionOPFFLC[j].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                            }
                            if (unionFLC.length > 0) {
                                LigneCredit credit = new LigneCredit();
                                credit.setNomTable("lignecreditrecette");
                                credit.setIdLigne(unionFLC[0].getId2());
                                LigneCredit[] lignecredit = (LigneCredit[]) CGenUtil.rechercher(credit, null, null, c, "");
                                if (lignecredit.length > 0) {
                                    double montantcredit = lignecredit[0].getCreditModifier() - opMontant;
                                    if (lignecredit[0].getMontantFac() > 0) {
                                        double montantfact = lignecredit[0].getMontantFac() - opMontant;
                                        lignecredit[0].setMontantFac(montantfact);
                                    }
                                    lignecredit[0].setCreditModifier(montantcredit);
                                    lignecredit[0].updateToTableWithHisto(u.getTuppleID(), c);
                                } else {
                                    throw new Exception("cette ligne de credit n existe pas");
                                }
                            }
                        }
                        opMaj[0].setRemarque(opMaj[0].getRemarque() + " " + rmq);
                        opMaj[0].updateToTableWithHisto(this.getUser().getTuppleID(), c);
                    }

                }
            }

        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void decalerOP(String[] id, String[] daty) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String idop = Utilitaire.stringToTab(id, "'", ",");
            OpAAnnuler[] listeop = (OpAAnnuler[]) CGenUtil.rechercher(new OpAAnnuler(), null, null, c, " and id in(" + idop + ")");
            OrdonnerPayement[] op = (OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, " and id in(" + idop + ")");
            OpTypeDatePaiement[] typepaiement = (OpTypeDatePaiement[]) CGenUtil.rechercher(new OpTypeDatePaiement(), null, null, c, " and idop in(" + idop + ")");

            // update montant paye any op sy creation op pour le reste montant(montant non payer)
            UnionIntraTable ff = new UnionIntraTable();
            ff.setNomTable("facturefournisseurlc");
            String opvao = "";
            for (int i = 0; i < op.length; i++) {

                UnionIntraTable[] factureFF = (UnionIntraTable[]) CGenUtil.rechercher(ff, null, null, c, " and id1='" + op[i].getDed_Id() + "'");
                String[] idfact = new String[factureFF.length];
                String[] montant = new String[factureFF.length];

                if (listeop[i].getMontant_paye() > 0) {
                    op[i].setMontant(listeop[i].getMontant_paye());
                    op[i].setDaty(Utilitaire.stringDate(daty[i]));
                    op[i].updateToTableWithHisto(u.getTuppleID(), c);
                    for (int j = 0; j < factureFF.length; j++) {
                        double pourc = factureFF[j].getMontantMere() * 100 / listeop[i].getMontant();
                        idfact[j] = factureFF[j].getId();
                        montant[j] = String.valueOf(listeop[i].getReste() * (pourc / 100));

                    }
                    if (typepaiement != null && typepaiement.length > 0) {
                        opvao = this.createOp(op[i].getDed_Id(), Utilitaire.datetostring(op[i].getDaty()), String.valueOf(listeop[i].getReste()), op[i].getRemarque(), typepaiement[i].getTypee(), daty[i], typepaiement[i].getRemarque(), c);
                    } else {
                        opvao = this.createOp(op[i].getDed_Id(), Utilitaire.datetostring(op[i].getDaty()), String.valueOf(listeop[i].getReste()), op[i].getRemarque(), c);
                    }
                    this.updateMontantUnionIntraLcOp(Constante.tableOpFfLc, "FACTUREFOURNISSEURLC", opvao, idfact, montant, c);
                    this.validerMappageLCMOpControle(Constante.tableOpFfLc, "FACTUREFOURNISSEURLC", opvao, c);
                    this.viserOp(Utilitaire.dateDuJour(), "", opvao);
                    c.commit();
                } else {
                    op[i].setDaty(Utilitaire.stringDate(daty[i]));
                    op[i].updateToTableWithHisto(u.getTuppleID(), c);
                    c.commit();
                }
            }

        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void decalerOR(String[] id, String[] daty) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String idop = Utilitaire.stringToTab(id, "'", ",");
            OpAAnnuler orAnnuler = new OpAAnnuler();
            orAnnuler.setNomTable("or_a_annuler");
            OpAAnnuler[] listeop = (OpAAnnuler[]) CGenUtil.rechercher(orAnnuler, null, null, c, " and id in(" + idop + ")");
            OrdonnerPayement or = new OrdonnerPayement();
            or.setNomTable("ordonnerrecette");
            OrdonnerPayement[] op = (OrdonnerPayement[]) CGenUtil.rechercher(or, null, null, c, " and id in(" + idop + ")");

            // update montant paye any op sy creation op pour le reste montant(montant non payer)
            UnionIntraTable ff = new UnionIntraTable();
            ff.setNomTable("FACTURECLIENTLC");
            String opvao = "";
            for (int i = 0; i < op.length; i++) {

                UnionIntraTable[] factureFF = (UnionIntraTable[]) CGenUtil.rechercher(ff, null, null, c, " and id1='" + op[i].getDed_Id() + "'");
                String[] idfact = new String[factureFF.length];
                String[] montant = new String[factureFF.length];

                if (listeop[i].getMontant_paye() > 0) {
                    op[i].setMontant(listeop[i].getMontant_paye());
                    op[i].setDaty(Utilitaire.stringDate(daty[i]));
                    op[i].updateToTableWithHisto(u.getTuppleID(), c);
                    for (int j = 0; j < factureFF.length; j++) {
                        double pourc = factureFF[j].getMontantMere() * 100 / listeop[i].getMontant();
                        idfact[j] = factureFF[j].getId();
                        montant[j] = String.valueOf(listeop[i].getReste() * (pourc / 100));

                    }
                    opvao = this.creerOR(daty[i], op[i].getDed_Id(), String.valueOf(listeop[i].getReste()), "0", "-", "", c);
                    this.updateMontantUnionIntraLcOp(Constante.tableOrFcLc, "FACTURECLIENTLC", opvao, idfact, montant, c);
                    this.validerMappageLCMOrControle(Constante.tableOrFcLc, "FACTURECLIENTLC", opvao, c);
                    this.viserOr(Utilitaire.dateDuJour(), "", opvao);
                    c.commit();
                } else {
                    op[i].setDaty(Utilitaire.stringDate(daty[i]));
                    op[i].updateToTableWithHisto(u.getTuppleID(), c);
                    c.commit();
                }
            }

        } catch (Exception ex) {
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void remplacerOP(String idop) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            OpAAnnuler test[] = (OpAAnnuler[]) CGenUtil.rechercher(new OpAAnnuler(), null, null, c, " and id='" + idop + "'");
            if (test.length > 0) {
                //OrdonnerPayement [] liste=(OrdonnerPayement [])CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, " and id='"+idop+"'");
                annulerOp("ORDONNERPAYEMENT", "OPFFLC", idop);
            } else {
                throw new Exception("op deja payer");
            }

        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public void cloturerPrise(String idprise) throws Exception {
        Connection c = null;     
        try{
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            System.out.println("ICIIIIIIIII");
            Cloture cl = new Cloture();
            cl.construirePK(c);
            cl.setTypeObjet(utilitaire.Constante.typeCloture[2]);
            cl.setObjet(idprise);
            cl.setDaty(Utilitaire.dateDuJourSql());
            cl.setDatySaisie(Utilitaire.dateDuJourSql());
            cl.insertToTable(c);            
            c.commit();            
        }
        catch(Exception e){           
           if(c != null)c.rollback();
           throw e;
        }
        finally{
            if(c != null)    c.close();            
        }            
    }
    public int annulationFactureClient(String idFactureClient) throws Exception{
        FactureEjbBean factureEjbBean = new FactureEjbBean();
        return factureEjbBean.annulationFactureClient(idFactureClient, u.getTuppleID());        
    }
    public int annulationPub(String idPub) throws Exception{
        FactureEjbBean factureEjbBean = new FactureEjbBean();
        return factureEjbBean.annulationPub(idPub, u.getTuppleID());        
    }
     public void modifierFacture(String idfm, String[] idfactureFille, double[] prixUnitaire, double[] quantite, int[] reduction, double tva) throws Exception {
        FactureEjbBean factureEjbBean = new FactureEjbBean();
        factureEjbBean.modifierFacture(idfm, idfactureFille, prixUnitaire, quantite, reduction, tva, u.getTuppleID());
     }
}
