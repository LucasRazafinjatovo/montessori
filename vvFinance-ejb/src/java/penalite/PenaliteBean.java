// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   PenaliteBean.java

package penalite;

import bean.*;
import facture.*;
import finance.*;
import historique.MapHistorique;
import historique.MapUtilisateur;
import java.io.PrintStream;
import java.rmi.RemoteException;
import java.sql.*;
import java.util.Vector;
import javax.ejb.*;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

// Referenced classes of package penalite:
//            Accident, AccidentUtil, DommageConteneur, DommageConteneurUtil,
//            ParametrePenalite, ParametrePenaliteUtil, Penalite, PenaliteUtil,
//            VolConteneur, VolConteneurUtil, ChiffreAffTac, ChiffreAffTAcUtil,
//            TraficConteneur, TraficConteneurUtil, DetPenRetard, DetailTraficConteneurUtil,
//            SynthesePointageUtil, OccupJournalierUtil, DetPenRetardUtil, RecuperePenaliteLocale,
//            PenaliteLocalHome, PenaliteEjbLocal, AdminDommageConteneur, AdminOccupJournalier,
//            AdminPointage, SynthesePointage, OccupJournalier

@Stateful
@AccessTimeout(0)
public class PenaliteBean
    implements PenaliteEjb, PenaliteEjbRemote, SessionBean
{

    public PenaliteBean()
    {
    }

    public void ejbCreate() throws CreateException {
    }

    public void ejbRemove()
    {
    }

    public void ejbActivate()
    {
    }

    public void ejbPassivate()
    {
    }

    public void setSessionContext(SessionContext sessionContext)
    {
        this.sessionContext = sessionContext;
    }

    public String createAccident(String datySaisie, String datyAccident, String description, String nomEmploye, String rem, String refUser) throws ErreurDAO {
        try
        {
            Accident acc = new Accident(datySaisie, datyAccident, description, nomEmploye, "-");
            MapHistorique h = new MapHistorique("Accident", "insert", refUser, acc.getTuppleID());
            acc.insertToTable(h);
            String s = acc.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateAccident(String idAccident, String datySaisie, String datyAccident, String description, String nomEmploye, String rem, String refUser) throws ErreurDAO {
        try
        {
            Accident acc = new Accident(idAccident, Utilitaire.string_date("dd/MM/yyyy", datySaisie), Utilitaire.string_date("dd/MM/yyyy", datyAccident), description, nomEmploye, rem);
            MapHistorique h = new MapHistorique("Accident", "update", refUser, acc.getTuppleID());
            acc.updateToTableWithHisto(h);
            String s = acc.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteAccident(String idAccident, String refUser) throws ErreurDAO {
        try
        {
            Accident acc = new Accident(idAccident, null, null, "-", "-", "-");
            MapHistorique h = new MapHistorique("Accident", "delete", refUser, acc.getTuppleID());
            acc.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public Accident[] findAccident(String idAccident, String datyDebut, String datyFin, String description, String nomEmploye) throws ErreurDAO {
        try
        {
            int a[] = {
                1, 4, 5
            };
            String val[] = new String[a.length];
            val[0] = idAccident;
            val[1] = description;
            val[2] = nomEmploye;
            AccidentUtil au = new AccidentUtil();
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0))
            {
                Accident aaccident[] = (Accident[])au.rechercher(a, val, " order by idAccident desc");
                return aaccident;
            }
            if((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0))
            {
                Accident aaccident1[] = (Accident[])au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyaccident>='")).append(datyDebut).append("' order by idAccident desc"))));
                return aaccident1;
            }
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0))
            {
                Accident aaccident2[] = (Accident[])au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyaccident<='")).append(datyFin).append("' order by idAccident desc"))));
                return aaccident2;
            }
            if((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0))
            {
                Accident aaccident3[] = (Accident[])au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyaccident>='")).append(datyDebut).append("' and datyaccident<='").append(datyFin).append("' order by idAccident desc"))));
                return aaccident3;
            } else
            {
                throw new ErreurDAO("Erreur dans la recherche!");
            }
        }
        catch(Exception ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String createDommageConteneur(String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire, String refUser) throws ErreurDAO {
        try
        {
            DommageConteneur dom = new DommageConteneur(datySaisie, datyDommage, designation, montant, idDossier, nomProprietaire);
            MapHistorique h = new MapHistorique("DommageConteneur", "insert", refUser, dom.getTuppleID());
            dom.insertToTable(h);
            String s = dom.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateDommageConteneur(String idDommage, String datySaisie, String datyDommage, String designation, String montant, String idDossier, String nomProprietaire, String refUser) throws ErreurDAO {
        try
        {
            DommageConteneur dom = new DommageConteneur(idDommage, Utilitaire.string_date("dd/MM/yyyy", datySaisie), Utilitaire.string_date("dd/MM/yyyy", datyDommage), designation, Utilitaire.stringToDouble(montant), idDossier, nomProprietaire);
            MapHistorique h = new MapHistorique("DommageConteneur", "update", refUser, dom.getTuppleID());
            dom.updateToTableWithHisto(h);
            String s = dom.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteDommageConteneur(String idDommage, String refUser) throws ErreurDAO {
        try
        {
            DommageConteneur dom = new DommageConteneur(idDommage, null, null, "-", 0.0D, "-", "-");
            MapHistorique h = new MapHistorique("DommageConteneur", "delete", refUser, dom.getTuppleID());
            dom.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public DommageConteneur[] findDommageConteneur(String idDommage, String datyDebut, String datyFin, String designation, String montant, String idDossier, String nomProprietaire) throws ErreurDAO {
        try
        {
            int a[] = {
                1, 4, 5, 6, 7
            };
            String val[] = new String[a.length];
            val[0] = idDommage;
            val[1] = designation;
            val[2] = montant;
            val[3] = idDossier;
            val[4] = nomProprietaire;
            DommageConteneurUtil domu = new DommageConteneurUtil();
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0))
            {
                DommageConteneur adommageconteneur[] = (DommageConteneur[])domu.rechercher(a, val, " order by datyDommage desc");
                return adommageconteneur;
            }
            if((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0))
            {
                DommageConteneur adommageconteneur1[] = (DommageConteneur[])domu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDommage>='")).append(datyDebut).append("' order by datyDommage desc"))));
                return adommageconteneur1;
            }
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0))
            {
                DommageConteneur adommageconteneur2[] = (DommageConteneur[])domu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDommage<='")).append(datyFin).append("' order by datyDommage desc"))));
                return adommageconteneur2;
            }
            if((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0))
            {
                DommageConteneur adommageconteneur3[] = (DommageConteneur[])domu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDommage>='")).append(datyDebut).append("' and datyDommage<='").append(datyFin).append("' order by datyDommage desc"))));
                return adommageconteneur3;
            } else
            {
                throw new ErreurDAO("Problème dans la recherche");
            }
        }
        catch(Exception ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String updateParametrePenalite(String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String dateDebutValid, String refUser) throws ErreurDAO {
        try
        {
            ParametrePenalite parp = new ParametrePenalite(tauxDirBcEurop, majorBcEurop, delaiPaiementPenalit, performAnnuel, slTauxOccup, majorTauxOccup, slRappPerteAnnu, slNbPerteAnnu, pxUnitVol, slRappDommagTotal, pxPourcExc, valLimitcont, nbLimitAccAnnu, pxAccExc, dateDebutValid);
            MapHistorique h = new MapHistorique("ParametrePenalite", "create", refUser, parp.getTuppleID());
            parp.insertToTable(h);
            String s = parp.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public ParametrePenalite[] findParametrePenalite(String idParametrePenalite, String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String date1) throws ErreurDAO {
        try
        {
            int a[] = {
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                11, 12, 13, 14, 15
            };
            String val[] = new String[a.length];
            val[0] = idParametrePenalite;
            val[1] = tauxDirBcEurop;
            val[2] = majorBcEurop;
            val[3] = delaiPaiementPenalit;
            val[4] = performAnnuel;
            val[5] = slTauxOccup;
            val[6] = majorTauxOccup;
            val[7] = slRappPerteAnnu;
            val[8] = slNbPerteAnnu;
            val[9] = pxUnitVol;
            val[10] = slRappDommagTotal;
            val[11] = pxPourcExc;
            val[12] = idParametrePenalite;
            val[13] = valLimitcont;
            val[14] = nbLimitAccAnnu;
            val[15] = pxAccExc;
            ParametrePenaliteUtil ppu = new ParametrePenaliteUtil();
            if(date1.compareTo("") == 0)
            {
                ParametrePenalite aparametrepenalite[] = (ParametrePenalite[])ppu.rechercher(a, val, " order by datySaisie desc");
                return aparametrepenalite;
            }
            if(date1.compareTo("") != 0)
            {
                ParametrePenalite aparametrepenalite1[] = (ParametrePenalite[])ppu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dateDebut<='")).append(date1).append("' order by datyDebut desc"))));
                return aparametrepenalite1;
            } else
            {
                ParametrePenalite aparametrepenalite2[] = null;
                return aparametrepenalite2;
            }
        }
        catch(Exception ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String createPenalite(String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4, String refUser) throws ErreurDAO {
        try
        {
            Penalite pen = new Penalite(dateDebut, dateFin, designation, montant, idSCatService, champ1, champ2, champ3, champ4);
            MapHistorique h = new MapHistorique("Penalite", "update", refUser, pen.getTuppleID());
            pen.insertToTable(h);
            String s = pen.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updatePenalite(String idPenalite, String dateDebut, String dateFin, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4, String refUser) throws ErreurDAO {
        try
        {
            Penalite pen = new Penalite(idPenalite, Utilitaire.string_date("dd/MM/yyyy", dateDebut), Utilitaire.string_date("dd/MM/yyyy", dateFin), designation, Utilitaire.stringToDouble(montant), idSCatService, champ1, Utilitaire.stringToFloat(champ2), Utilitaire.stringToFloat(champ3), Utilitaire.stringToFloat(champ4));
            MapHistorique h = new MapHistorique("Penalite", "update", refUser, pen.getTuppleID());
            pen.updateToTableWithHisto(h);
            String s = pen.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deletePenalite(String idPenalite, String refUser) throws ErreurDAO {
        try
        {
            Penalite pen = new Penalite(idPenalite, null, null, "-", 0.0D, "-", "-", 0.0F, 0.0F, 0.0F);
            MapHistorique h = new MapHistorique("Penalite", "delete", refUser, pen.getTuppleID());
            pen.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception e)
        {
            throw new ErreurDAO(e.getMessage());
        }
    }

    public Penalite[] findPenalite(String idPenalite, String daty1, String daty2, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws ErreurDAO {
        try
        {
            Penalite pen[] = null;
            int a[] = {
                1, 4, 5, 6, 7, 8, 9, 10
            };
            String val[] = new String[a.length];
            val[0] = idPenalite;
            val[1] = designation;
            val[2] = montant;
            val[3] = idSCatService;
            val[4] = champ1;
            val[5] = champ2;
            val[6] = champ3;
            val[7] = champ4;
            PenaliteUtil sup = new PenaliteUtil();
            if((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0))
            {
                Penalite apenalite[] = (Penalite[])sup.rechercher(a, val, " order by dateFin desc");
                return apenalite;
            }
            if((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0))
            {
                Penalite apenalite1[] = (Penalite[])sup.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dateDebut>='")).append(daty1).append("' order by dateFin desc"))));
                return apenalite1;
            }
            if((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0))
            {
                Penalite apenalite2[] = (Penalite[])sup.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dateFin<='")).append(daty2).append("' order by dateFin desc"))));
                return apenalite2;
            }
            if((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0))
            {
                Penalite apenalite3[] = (Penalite[])sup.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dateDebut>='")).append(daty1).append("' and dateFin<='").append(daty2).append("' order by dateFin desc"))));
                return apenalite3;
            } else
            {
                Penalite apenalite4[] = null;
                return apenalite4;
            }
        }
        catch(Exception ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public int annulerPenaliteDirect(String idPenalite, String refUser) throws Exception {
        Connection c = null;
        Penalite pen[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        DetPenRetard dpr[] = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            pen = findPenalite(idPenalite, "", "", "%", "%", "%", "%", "%", "%", "%");
            if(pen.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            if(pen[0].getIdSCatService().compareTo("scat3") == 0)
            {
                dpr = findDetPenRetard("%", idPenalite, "", "", "%", "%");
                for(int i = 0; i < dpr.length; i++)
                    deleteDetPenRetard(dpr[i].getTuppleID(), refUser);

            }
            deletePenalite(idPenalite, refUser);
            c.commit();
            int j = 1;
            return j;
        }
        catch(Exception ex)
        {
            try
            {
                ex.printStackTrace();
                c.rollback();
                throw new Exception(ex.getMessage());
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public int annulerPenalite(String idPenalite, String refUser) throws Exception {
        Connection c = null;
        Penalite pen[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        DetPenRetard dpr[] = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idPenalite, "%", "", "", "%", "typOb6");
            if(aut.length < 1)
                throw new Exception("Vérifiez l'autorisation d'annulation");
            pen = findPenalite(idPenalite, "", "", "%", "%", "%", "%", "%", "%", "%");
            if(pen.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            if(pen[0].getIdSCatService().compareTo("scat3") == 0)
            {
                dpr = findDetPenRetard("%", idPenalite, "", "", "%", "%");
                for(int i = 0; i < dpr.length; i++)
                    deleteDetPenRetard(dpr[i].getTuppleID(), refUser);

            }
            deletePenalite(idPenalite, refUser);
            c.commit();
            int j = 1;
            return j;
        }
        catch(Exception ex)
        {
            try
            {
                ex.printStackTrace();
                c.rollback();
                throw new Exception(ex.getMessage());
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    String verifieChevauchementRetard(String idFacture, String daty1, String daty2) throws Exception {
        try
        {
            PenaliteUtil pu = new PenaliteUtil();
            Penalite p[] = null;
            Penalite pPrime[] = null;
            int moisLimite = 0;
            int anLimite = 0;
            pPrime = findPenalite("%", "", "", "%", "%", "scat3", idFacture, "%", "%", "%");
            SCatService sc = FactureEJBClient.getInterface().findSCatService("scat3", "%", "%", "%")[0];
            Date d1 = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date d2 = Utilitaire.string_date("dd/MM/yyyy", daty2);
            if(pPrime.length == 0)
            {
                FactMere tempf[] = FactureEJBClient.getInterface().findFactureMere("", "", idFacture, "%", "", "%", "%", "%");
                if(tempf.length == 0)
                {
                    String s = "1";
                    return s;
                }
                FactMere fm = tempf[0];
                Date limite = fm.getDateLimitePaiement();
                moisLimite = Utilitaire.getMois(limite);
                anLimite = Utilitaire.getAnnee(limite);
                int moisVerif = Utilitaire.getMois(d2);
                int anVerif = Utilitaire.getAnnee(d2);
                if(moisLimite == moisVerif && anLimite == anVerif)
                {
                    String s6 = null;
                    return s6;
                } else
                {
                    String s7 = "1";
                    return s7;
                }
            }
            Date datySupTh = Utilitaire.ajoutMoisDate(pPrime[0].getDateFin(), sc.getPeriodeFacturation());
            int diffDate2 = Utilitaire.compareDaty(d2, datySupTh);
            if(diffDate2 == 0)
            {
                String s1 = null;
                return s1;
            }
            if(diffDate2 > 0)
            {
                String s2 = "1";
                return s2;
            }
            if(diffDate2 < 0)
            {
                p = findPenalite("%", daty1, daty2, "%", "%", "scat3", idFacture, "%", "%", "%");
                if(p.length > 0)
                {
                    String s3 = p[0].getTuppleID();
                    return s3;
                } else
                {
                    String s4 = "1";
                    return s4;
                }
            } else
            {
                String s5 = "1";
                return s5;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createVolCont(String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant, String refUser) throws ErreurDAO {
        try
        {
            VolConteneur vol = new VolConteneur(datySaisie, datyVol, numCont, designation, idDossier, proprietaire, montant);
            MapHistorique h = new MapHistorique("VolConteneur", "insert", refUser, vol.getTuppleID());
            vol.insertToTable(h);
            String s = vol.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateVolCont(String idVol, String datySaisie, String datyVol, String numCont, String designation, String idDossier, String proprietaire, String montant, String refUser) throws ErreurDAO {
        try
        {
            VolConteneur vol = new VolConteneur(idVol, Utilitaire.string_date("dd/MM/yyyy", datySaisie), Utilitaire.string_date("dd/MM/yyyy", datyVol), numCont, designation, idDossier, proprietaire, Utilitaire.stringToDouble(montant));
            MapHistorique h = new MapHistorique("VolConteneur", "update", refUser, vol.getTuppleID());
            vol.updateToTableWithHisto(h);
            String s = vol.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteVolCont(String idVol, String refUser) throws ErreurDAO {
        try
        {
            VolConteneur vol = new VolConteneur(idVol, null, null, "-", "-", "-", "-", 0.0D);
            MapHistorique h = new MapHistorique("VolConteneur", "delete", refUser, vol.getTuppleID());
            vol.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public VolConteneur[] findVolCont(String idVol, String datyDebut, String datyFin, String numCont, String designation, String idDossier, String proprietaire, String montant) throws ErreurDAO {
        try
        {
            int a[] = {
                1, 4, 5, 6, 7, 8
            };
            String val[] = new String[a.length];
            val[0] = idVol;
            val[1] = numCont;
            val[2] = designation;
            val[3] = idDossier;
            val[4] = proprietaire;
            val[5] = montant;
            VolConteneurUtil vcu = new VolConteneurUtil();
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0))
            {
                VolConteneur avolconteneur[] = (VolConteneur[])vcu.rechercher(a, val, " order by datyVol desc");
                return avolconteneur;
            }
            if((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0))
            {
                VolConteneur avolconteneur1[] = (VolConteneur[])vcu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyVol>='")).append(datyDebut).append("' order by datyVol desc"))));
                return avolconteneur1;
            }
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0))
            {
                VolConteneur avolconteneur2[] = (VolConteneur[])vcu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyVol<='")).append(datyFin).append("' order by datyVol desc"))));
                return avolconteneur2;
            }
            if((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0))
            {
                VolConteneur avolconteneur3[] = (VolConteneur[])vcu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyVol>='")).append(datyDebut).append("' and datyVol<='").append(datyFin).append("' order by datyVol desc"))));
                return avolconteneur3;
            } else
            {
                throw new ErreurDAO("Erreur dans la recherche!");
            }
        }
        catch(Exception ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public String createChiffreAffTac(String mois, String annee, String montant, String refUser) throws ErreurDAO {
        ChiffreAffTac c[] = null;
        try
        {
            c = findChiffreAffTac("%", mois, annee, "%");
            if(c.length > 0)
            {
                throw new Exception("Chiffre d'affaire déjà enregistré pour le mois");
            } else
            {
                ChiffreAffTac ca = new ChiffreAffTac(mois, annee, montant);
                MapHistorique h = new MapHistorique("ChiffreAffTac", "update", refUser, ca.getTuppleID());
                ca.insertToTable(h);
                String s = ca.getTuppleID();
                return s;
            }
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateChiffreAffTac(String idChiffre, String mois, String annee, String montant, String refUser) throws ErreurDAO {
        try
        {
            ChiffreAffTac ca = new ChiffreAffTac(idChiffre, Utilitaire.stringToInt(mois), Utilitaire.stringToInt(annee), Utilitaire.stringToInt(montant));
            MapHistorique h = new MapHistorique("ChiffreAffTac", "update", refUser, ca.getTuppleID());
            ca.updateToTableWithHisto(h);
            String s = ca.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteChiffreAffTac(String idChiffre, String refUser) throws ErreurDAO {
        try
        {
            ChiffreAffTac ca = new ChiffreAffTac(idChiffre, 0, 0, 0.0D);
            MapHistorique h = new MapHistorique("ChiffreAffTac", "delete", refUser, ca.getTuppleID());
            ca.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public ChiffreAffTac[] findChiffreAffTac(String idChiffre, String mois, String annee, String montant) throws ErreurDAO {
        try
        {
            int a[] = {
                1, 2, 3, 4
            };
            String val[] = new String[a.length];
            val[0] = idChiffre;
            val[1] = mois;
            val[2] = annee;
            val[3] = montant;
            ChiffreAffTAcUtil au = new ChiffreAffTAcUtil();
            ChiffreAffTac achiffreafftac[] = (ChiffreAffTac[])au.rechercher(a, val);
            return achiffreafftac;
        }
        catch(Exception ex)
        {
            throw new ErreurDAO(ex.getMessage());
        }
    }

    public int annulerChiffreAffTac(String idChifffre, String refUser) throws Exception {
        Connection c = null;
        ChiffreAffTac chaf[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idChifffre, "%", "", "", "%", "typOb12");
            if(aut.length < 1)
                throw new Exception("Vérifiez l'autorisation d'annulation");
            chaf = findChiffreAffTac(idChifffre, "%", "%", "%");
            if(chaf.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            deleteChiffreAffTac(idChifffre, refUser);
            c.commit();
            int i = 1;
            return i;
        }
        catch(Exception ex)
        {
            try
            {
                c.rollback();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public String createTrafic(String daty, String datyDebut, String datyFin, String nb, String rem, String idserv, String refUser) throws ErreurDAO {
        TraficConteneur trc[] = null;
        try
        {
            trc = findTrafic("%", datyDebut, datyFin, "%");
            if(trc.length > 0)
            {
                throw new ErreurDAO("Trafic déjà enregistré pour la période.");
            } else
            {
                TraficConteneur trf = new TraficConteneur(daty, datyDebut, datyFin, nb, rem, idserv);
                MapHistorique h = new MapHistorique("TraficConteneur", "insert", refUser, trf.getTuppleID());
                trf.insertToTable(h);
                String s = trf.getTuppleID();
                return s;
            }
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public String updateTrafic(String idTrafic, String daty, String datyDebut, String datyFin, String nb, String rem, String idserv, String refUser) throws ErreurDAO {
        try
        {
            TraficConteneur trf = new TraficConteneur(idTrafic, Utilitaire.string_date("dd/MM/yyyy", daty), Utilitaire.string_date("dd/MM/yyyy", datyDebut), Utilitaire.string_date("dd/MM/yyyy", datyFin), Utilitaire.stringToDouble(nb), rem, idserv);
            MapHistorique h = new MapHistorique("TraficConteneur", "update", refUser, trf.getTuppleID());
            trf.updateToTableWithHisto(h);
            String s = trf.getTuppleID();
            return s;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public int deleteTrafic(String idTrafic, String refUser) throws ErreurDAO {
        try
        {
            TraficConteneur trf = new TraficConteneur(idTrafic, null, null, null, 0.0D, "-", "-");
            MapHistorique h = new MapHistorique("TraficConteneur", "delete", refUser, trf.getTuppleID());
            trf.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
            throw new ErreurDAO(e.getMessage());
        }
    }

    public TraficConteneur[] findTrafic(String idTrafic, String datyDebut, String datyFin, String idserv) throws ErreurDAO {
        Connection c = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(true);
            int a[] = {
                1, 7
            };
            String val[] = new String[a.length];
            val[0] = idTrafic;
            val[1] = idserv;
            TraficConteneurUtil au = new TraficConteneurUtil();
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0))
            {
                TraficConteneur atraficconteneur[] = (TraficConteneur[])au.rechercher(a, val, " order by idTrafic desc", c);
                return atraficconteneur;
            }
            if((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0))
            {
                TraficConteneur atraficconteneur1[] = (TraficConteneur[])au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and periodeDebut>='")).append(datyDebut).append("' order by idTrafic desc"))), c);
                return atraficconteneur1;
            }
            if((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0))
            {
                TraficConteneur atraficconteneur2[] = (TraficConteneur[])au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and periodeFin<='")).append(datyFin).append("' order by idTrafic desc"))), c);
                return atraficconteneur2;
            }
            if((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0))
            {
                TraficConteneur atraficconteneur3[] = (TraficConteneur[])au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and periodeDebut>='")).append(datyDebut).append("' and periodeFin<='").append(datyFin).append("' order by idTrafic desc"))), c);
                return atraficconteneur3;
            }
            TraficConteneur atraficconteneur4[] = null;
            return atraficconteneur4;
        }
        catch(Exception ex)
        {
            throw new ErreurDAO("Pas de trafic trouvé : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException sqlexception) { }
        }
    }

    public int annulerTrafic(String idTrafic, String refUser) throws Exception {
        Connection c = null;
        TraficConteneur trf[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idTrafic, "%", "", "", "%", "typOb4");
            if(aut.length < 1)
                throw new Exception("Vérifiez l'autorisation d'annulation");
            trf = findTrafic(idTrafic, "", "", "%");
            if(trf.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            deleteTrafic(idTrafic, refUser);
            c.commit();
            int i = 1;
            return i;
        }
        catch(Exception ex)
        {
            try
            {
                c.rollback();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public float calculPenalite(String datyDebut, String datyFin, String idSCatService, String s) throws ErreurDAO {
        return 0.0F;
    }

    public String createFacturePenalite(String[] idPenalite, String refUser)
    {
        return null;
    }

    public int verifPenalite(String daty1, String daty2, String user) throws Exception {
        verifPenaliteAccident(daty1, daty2, user);
        verifPenaliteDommage(daty1, daty2, user);
        verifPenaliteVol(daty1, daty2, user);
        verifPenaliteRetard(daty1, daty2, user);
        verifPenaliteTrafic(daty1, daty2, user);
        verifPenliteQuai(daty1, daty2, user);
        return 1;
    }

    public int verifPenaliteRetard(String daty1, String daty2, String user)
    {
        FactMere factValide[] = null;
        Entree entreeParFact[] = null;
        ParametrePenalite pp = null;
        try
        {
            pp = loadParametrePenalite(daty1);
            factValide = FactureEJBClient.getInterface().findFactureValide("", "", "%", "%", "%", "%");
            for(int i = 0; i < factValide.length; i++)
                if(factValide[i].getMontantAPayer() > (double)0)
                    verifPenaliteRetardFacture(factValide[i], daty1, daty2, user);

            int j = 1;
            return j;
        }
        catch(Exception ex)
        {
            int k = 0;
            return k;
        }
    }

    public int verifPenaliteRetardFacture(FactMere f, String daty1, String daty2, String user)
    {
        Entree entreeParFact[] = null;
        Entree entreeAvantParFact[] = null;
        int nbJourMois = Utilitaire.getNombreJourMois(daty2);
        ParametrePenalite pp = null;
        double montantP = 0.0D;
        String idpen = null;
        Vector dprV = new Vector();
        int tailleVecteur = 0;
        int nbJourRetard2 = 0;
        double montantPartiel2 = 0.0D;
        try
        {
            if(verifChevauchFacturePenaliteRetard(f.getTuppleID(), daty1, daty2, "scat3") != 0)
            {
                int j = 0;
                return j;
            }
            String pen = verifieChevauchementRetard(f.getTuppleID(), daty1, daty2);
            if(pen != null)
            {
                if(pen.compareToIgnoreCase("1") == 0)
                {
                    int k = 0;
                    return k;
                }
                annulerPenaliteDirect(pen, user);
            }
            PenaliteUtil pu = new PenaliteUtil();
            pp = loadParametrePenalite(daty2);
            Date borneInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date borneSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            double nbJourRetard = 0.0D;
            double RAP = FactureEJBClient.getInterface().getRAPFacture(f, Utilitaire.formatterDaty(f.getDateLimitePaiement()));
            if(Utilitaire.compareDaty(f.getDateLimitePaiement(), borneInf) < 0)
                RAP = FactureEJBClient.getInterface().getRAPFacture(f, daty1);
            entreeAvantParFact = FinanceEjbClient.getInterface().findEntreePenalite("%", "", daty1, "%", "tEnt1", "%", "%", f.getTuppleID(), "%", "%", "eta2");
            boolean reglementTalou = f.getIdEtat().compareTo("eta3") == 0 && entreeAvantParFact.length > 0;
            if(reglementTalou)
            {
                int i1 = 0;
                return i1;
            }
            if(Utilitaire.compareDaty(f.getDateLimitePaiement(), borneInf) < 0)
                entreeParFact = FinanceEjbClient.getInterface().findEntreePenalite("%", daty1, daty2, "%", "tEnt1", "%", "%", f.getTuppleID(), "%", "%", "eta2");
            else
                entreeParFact = FinanceEjbClient.getInterface().findEntreePenalite("%", Utilitaire.formatterDaty(f.getDateLimitePaiement()), daty2, "%", "tEnt1", "%", "%", f.getTuppleID(), "%", "%", "eta2");
            Entree entreeParFactSup[] = FinanceEjbClient.getInterface().findEntreePenalite("%", daty1, "", "%", "tEnt1", "%", "%", f.getTuppleID(), "%", "%", "eta2");
            Date dInf = null;
            boolean reglement = f.getIdEtat().compareTo("eta3") == 0 && entreeParFactSup.length > 0;
            if(reglement || f.getIdEtat().compareTo("eta4") == 0)
            {
                for(int i = 0; i < entreeParFact.length; i++)
                {
                    int teste = Utilitaire.compareDaty(f.getDateLimitePaiement(), borneInf);
                    if(teste > 0)
                    {
                        dInf = Utilitaire.ajoutJourDate(f.getDateLimitePaiement(), 1);
                        nbJourRetard = Utilitaire.diffJourDaty(entreeParFact[i].getDaty(), dInf);
                    } else
                    {
                        dInf = Utilitaire.ajoutJourDate(borneInf, 0);
                        nbJourRetard = Utilitaire.diffJourDaty(entreeParFact[i].getDaty(), dInf);
                    }
                    if(nbJourRetard < (double)0)
                        nbJourRetard = 0.0D;
                    if(nbJourRetard > (double)0)
                    {
                        double mult = RAP * nbJourRetard;
                        double montantPartiel = (mult * (pp.getMajorBanqueCentrale() + pp.getTauxDirBanqCentrEurop())) / (double)(100 * nbJourMois);
                        dprV.add(tailleVecteur, new DetPenRetard("-", Utilitaire.formatterDaty(dInf), Utilitaire.formatterDaty(entreeParFact[i].getDaty()), String.valueOf(RAP), String.valueOf((int)nbJourRetard), entreeParFact[i].getTuppleID(), String.valueOf(montantPartiel)));
                        tailleVecteur++;
                        RAP -= entreeParFact[i].getMontant();
                        montantP += montantPartiel;
                    }
                    borneInf = Utilitaire.ajoutJourDate(entreeParFact[i].getDaty(), 1);
                }

                if(Utilitaire.compareDaty(f.getDateLimitePaiement(), borneInf) > 0)
                {
                    nbJourRetard2 = Utilitaire.diffJourDaty(borneSup, f.getDateLimitePaiement()) - 1;
                    Date tempDate = Utilitaire.ajoutJourDate(f.getDateLimitePaiement(), 1);
                    if(nbJourRetard2 < 0)
                        nbJourRetard2 = 0;
                    double mult = RAP * (double)nbJourRetard2;
                    montantPartiel2 = (mult * (pp.getMajorBanqueCentrale() + pp.getTauxDirBanqCentrEurop())) / (double)(nbJourMois * 100);
                    montantP += montantPartiel2;
                    if(RAP > (double)0)
                    {
                        dprV.add(tailleVecteur, new DetPenRetard("-", Utilitaire.formatterDaty(tempDate), daty2, String.valueOf(RAP), String.valueOf(nbJourRetard2), "-", String.valueOf(montantPartiel2)));
                        tailleVecteur++;
                    }
                } else
                {
                    nbJourRetard2 = Utilitaire.diffJourDaty(borneSup, borneInf);
                    if(nbJourRetard2 < 0)
                        nbJourRetard2 = 0;
                    double mult = RAP * (double)nbJourRetard2;
                    montantPartiel2 = (mult * (pp.getMajorBanqueCentrale() + pp.getTauxDirBanqCentrEurop())) / (double)(nbJourMois * 100);
                    montantP += montantPartiel2;
                    if(RAP > (double)0)
                    {
                        dprV.add(tailleVecteur, new DetPenRetard("-", Utilitaire.formatterDaty(borneInf), daty2, String.valueOf(RAP), String.valueOf(nbJourRetard2), "-", String.valueOf(montantPartiel2)));
                        tailleVecteur++;
                    }
                }
            }
            if(montantP < (double)0)
                montantP = 0.0D;
            idpen = createPenalite(daty1, daty2, "Penalite retard sur facture num ".concat(String.valueOf(String.valueOf(f.getTuppleID()))), String.valueOf(montantP), "scat3", f.getTuppleID(), String.valueOf(pp.getTauxDirBanqCentrEurop()), String.valueOf(pp.getMajorBanqueCentrale()), "0", user);
            if(tailleVecteur > 0)
            {
                DetPenRetard dpr[] = new DetPenRetard[tailleVecteur];
                for(int i = 0; i < tailleVecteur; i++)
                {
                    dpr[i] = (DetPenRetard)dprV.elementAt(i);
                    String s = createDetPenRetard(idpen, Utilitaire.formatterDaty(dpr[i].getDatyInf()), Utilitaire.formatterDaty(dpr[i].getDatySup()), String.valueOf(dpr[i].getReste()), String.valueOf(dpr[i].getNbJourRetard()), dpr[i].getNumPiece(), String.valueOf(dpr[i].getMontant()), user);
                }

            }
            int j1 = 1;
            return j1;
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        int l = 0;
        return l;
    }

    public String verifChevauchPenalite(String datyDeb, String datyDeFin, String typePen) throws Exception {
        try
        {
            ParametrePenalite pp = loadParametrePenalite(datyDeb);
            Penalite dernier = null;
            Penalite temp[] = null;
            PenaliteUtil pu = new PenaliteUtil();
            int a[] = {
                6
            };
            String val[] = new String[a.length];
            val[0] = typePen;
            String apres = String.valueOf(String.valueOf((new StringBuffer(" and dateDebut='")).append(calculDebut(datyDeFin, typePen)).append("' and dateFin='").append(datyDeFin).append("' order by dateFin desc")));
            pu.setNomTable("Penalite");
            temp = (Penalite[])pu.rechercher(a, val, apres);
            if(temp.length > 0)
            {
                dernier = temp[0];
            } else
            {
                String s = null;
                return s;
            }
            SCatService sc = FactureEJBClient.getInterface().findSCatService(typePen, "%", "%", "%")[0];
            Date datyFinNouveau = Utilitaire.string_date("dd/MM/yyyy", datyDeFin);
            Date datyFinAncien = dernier.getDateFin();
            Date datyFinNouveauTheorique = Utilitaire.ajoutMoisDate(datyFinAncien, sc.getPeriodeFacturation());
            System.out.println("datyFinNouveau=".concat(String.valueOf(String.valueOf(datyFinNouveau))));
            System.out.println("datyFinNouveauTheorique=".concat(String.valueOf(String.valueOf(datyFinNouveauTheorique))));
            if(Utilitaire.compareDaty(datyFinNouveau, datyFinNouveauTheorique) != 0)
            {
                String s1 = dernier.getTuppleID();
                return s1;
            } else
            {
                String s2 = null;
                return s2;
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public int verifChevauchFacturePenaliteRetard(String idFact, String datyDeb, String datyDeFin, String typePen) throws Exception {
        try
        {
            ParametrePenalite pp = loadParametrePenalite(datyDeb);
            FactureRetard dernier = null;
            FactureRetard temp[] = null;
            FactureRetard ret[] = null;
            PenaliteUtil pu = new PenaliteUtil();
            int a[] = {
                6
            };
            String val[] = new String[a.length];
            val[0] = typePen;
            temp = FactureEJBClient.getInterface().findFactureRetard(datyDeb, datyDeFin, "", "", idFact);
            if(temp.length > 0)
            {
                int i = 1;
                return i;
            } else
            {
                int j = 0;
                return j;
            }
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public int verifChevauchFacturePenalite(String datyDeb, String datyDeFin, String typePen) throws Exception {
        try
        {
            ParametrePenalite pp = loadParametrePenalite(datyDeb);
            FactMere dernier = null;
            FactMere temp[] = null;
            PenaliteUtil pu = new PenaliteUtil();
            int a[] = {
                6
            };
            String val[] = new String[a.length];
            val[0] = typePen;
            temp = FactureEJBClient.getInterface().findFactureValide("", "", "", "", "", typePen);
            if(temp.length > 0)
            {
                dernier = temp[0];
            } else
            {
                int i = 0;
                return i;
            }
            SCatService sc = FactureEJBClient.getInterface().findSCatService(typePen, "%", "%", "%")[0];
            Date datyFinNouveau = Utilitaire.string_date("dd/MM/yyyy", datyDeFin);
            Date datyFinAncien = dernier.getPeriodeFin();
            Date datyFinNouveauTheorique = Utilitaire.ajoutMoisDate(datyFinAncien, sc.getPeriodeFacturation());
            if(Utilitaire.compareDaty(datyFinNouveau, datyFinNouveauTheorique) != 0)
            {
                int j = 1;
                return j;
            } else
            {
                int k = 0;
                return k;
            }
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public String calculDebut(String dateFin, String idScat)
    {
        try
        {
            SCatService sc = FactureEJBClient.getInterface().findSCatService(idScat, "%", "%", "%")[0];
            Date retour = null;
            retour = Utilitaire.ajoutMoisDate(Utilitaire.string_date("dd/MM/yyyy", dateFin), -1 * sc.getPeriodeFacturation());
            retour = Utilitaire.ajoutJourDate(retour, 1);
            String s1 = Utilitaire.formatterDaty(retour);
            return s1;
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        String s = null;
        return s;
    }

    public double caculMontantVol(String daty1, String daty2)
    {
        double d;
        try
        {
            Date dateInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date dateSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            Date dateInfAncien = Utilitaire.ajoutMoisDate(dateInf, -12);
            Date dateSupAncien = Utilitaire.ajoutMoisDate(dateSup, -12);
            VolConteneur enCours[] = PenaliteEjbClient.getInterface().findVolCont("%", daty1, daty2, "%", "%", "%", "%", "%");
            VolConteneur precedent[] = PenaliteEjbClient.getInterface().findVolCont("%", String.valueOf(dateInfAncien), String.valueOf(dateSupAncien), "%", "%", "%", "%", "%");
            ParametrePenalite pp = loadParametrePenalite(daty1);
            double montant = 0.0D;
            if(enCours.length <= pp.getSlNbPerteAnnuel())
            {
                double d1 = 0.0D;
                return d1;
            }
            double difference = enCours.length - precedent.length * pp.getSlRapPerteAnnuel();
            if(difference < (double)0)
            {
                double d2 = 0.0D;
                return d2;
            } else
            {
                double d3 = difference * (double)pp.getPxUnVol();
                return d3;
            }
        }
        catch(Exception ex)
        {
            d = 0.0D;
        }
        return d;
    }

    public int verifPenaliteVol(String daty1, String daty2, String user)
    {
        try
        {
            if(verifChevauchFacturePenalite(daty1, daty2, "scat6") != 0)
            {
                int i = 0;
                return i;
            }
            double montant = 0.0D;
            ParametrePenalite pp = loadParametrePenalite(daty1);
            Date dateInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date dateSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            Date dateSupAncien = Utilitaire.ajoutMoisDate(dateSup, -12);
            Date dateInfEncours = Utilitaire.ajoutJourDate(dateSupAncien, 1);
            Date dateInfAncien = Utilitaire.ajoutMoisDate(dateInfEncours, -12);
            VolConteneur enCours[] = findVolCont("%", Utilitaire.formatterDaty(dateInfEncours), daty2, "%", "%", "%", "%", "%");
            VolConteneur precedent[] = findVolCont("%", Utilitaire.formatterDaty(dateInfAncien), Utilitaire.formatterDaty(dateSupAncien), "%", "%", "%", "%", "%");
            if(enCours.length > pp.getSlNbPerteAnnuel())
            {
                double difference = enCours.length - (precedent.length * pp.getSlRapPerteAnnuel()) / 100;
                if(difference < (double)0)
                {
                    montant = 0.0D;
                } else
                {
                    facture.Change ch = FactureEJBClient.getInterface().loadChangeValide("Eur", daty2);
                    montant = difference * (double)pp.getPxUnVol() * ch.getValeurEnAriary();
                }
            } else
            {
                montant = 0.0D;
            }
            String verifPen = null;
            verifPen = verifChevauchPenalite(daty1, daty2, "scat6");
            if(verifPen == null)
                createPenalite(Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite sur Vol du ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" au ").append(daty2))), String.valueOf(montant), "scat6", String.valueOf(enCours.length), String.valueOf(precedent.length), String.valueOf(pp.getPxUnVol()), String.valueOf(pp.getSlRapPerteAnnuel()), user);
            else
                updatePenalite(verifPen, Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite sur Vol du ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" au ").append(daty2))), String.valueOf(montant), "scat6", String.valueOf(enCours.length), String.valueOf(precedent.length), String.valueOf(pp.getPxUnVol()), String.valueOf(pp.getSlRapPerteAnnuel()), user);
            int k = 1;
            return k;
        }
        catch(Exception ex)
        {
            int j = 0;
            return j;
        }
    }

    public int verifPenaliteAccident(String daty1, String daty2, String user)
    {
        try
        {
            double montant = 0.0D;
            int verifPenalite = verifChevauchFacturePenalite(daty1, daty2, "scat7");
            if(verifChevauchFacturePenalite(daty1, daty2, "scat7") != 0)
            {
                int j = 0;
                return j;
            }
            Date dateInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date dateSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            Date dateSupAncien = Utilitaire.ajoutMoisDate(dateSup, -12);
            Date dateInfEncours = Utilitaire.ajoutJourDate(dateSupAncien, 1);
            Accident acc[] = findAccident("%", Utilitaire.formatterDaty(dateInfEncours), daty2, "%", "%");
            ParametrePenalite pp = loadParametrePenalite(daty1);
            facture.Change ch = FactureEJBClient.getInterface().loadChangeValide("Eur", daty2);
            int diff = acc.length - pp.getNbLimAccAnnuel();
            if(diff >= 0)
                montant = (double)(diff * pp.getPxAccExc()) * ch.getValeurEnAriary();
            else
                montant = 0.0D;
            String verifPen = null;
            verifPen = verifChevauchPenalite(daty1, daty2, "scat7");
            if(verifPen == null)
                createPenalite(Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite Accident entre ")).append(daty1).append(" et ").append(daty2))), String.valueOf(montant), "scat7", "1", String.valueOf(acc.length), String.valueOf(pp.getPxAccExc()), String.valueOf(pp.getNbLimAccAnnuel()), user);
            else
                updatePenalite(verifPen, Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite Accident entre ")).append(daty1).append(" et ").append(daty2))), String.valueOf(montant), "scat7", "1", String.valueOf(acc.length), String.valueOf(pp.getPxAccExc()), String.valueOf(pp.getNbLimAccAnnuel()), user);
            int k = 1;
            return k;
        }
        catch(Exception ex)
        {
            int i = 0;
            return i;
        }
    }

    public int verifPenaliteDommage(String daty1, String daty2, String user)
    {
        try
        {
            double montant = 0.0D;
            if(verifChevauchFacturePenalite(daty1, daty2, "scat9") != 0)
            {
                int j = 0;
                return j;
            }
            Date dateInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date dateSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            Date dateSupAncien = Utilitaire.ajoutMoisDate(dateSup, -12);
            Date dateInfEncours = Utilitaire.ajoutJourDate(dateSupAncien, 1);
            DommageConteneur domm[] = findDommageConteneur("%", Utilitaire.formatterDaty(dateInfEncours), daty2, "%", "%", "%", "%");
            ParametrePenalite pp = loadParametrePenalite(daty1);
            DetailTraficConteneur manutentionne[] = null;
            DetailTraficConteneurUtil dtu = new DetailTraficConteneurUtil();
            int a[] = {
                1
            };
            String val[] = new String[a.length];
            val[0] = "%";
            manutentionne = (DetailTraficConteneur[])dtu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and minDtOpt>='")).append(Utilitaire.formatterDaty(dateInfEncours)).append("' and maxDtOpt<='").append(daty2).append("'"))));
            int nbManut = manutentionne.length;
            int nbDommage = AdminDommageConteneur.getDommageSurMontant(domm, pp.getValLimCont()).length;
            if(nbDommage <= 0)
            {
                montant = 0.0D;
            } else
            {
                facture.Change ch = FactureEJBClient.getInterface().loadChangeValide("Eur", daty2);
                int raport = (nbDommage * 100) / nbManut;
                if(raport <= pp.getSlRapEnDomTotal())
                    montant = 0.0D;
                else
                    montant = (double)((raport - pp.getSlRapEnDomTotal()) * pp.getPxPtageExc()) * ch.getValeurEnAriary();
            }
            String verifPen = null;
            verifPen = verifChevauchPenalite(daty1, daty2, "scat9");
            if(verifPen == null)
                createPenalite(Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite Dommage entre ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" et ").append(daty2))), String.valueOf(montant), "scat9", String.valueOf(pp.getValLimCont()), String.valueOf(nbDommage), String.valueOf(nbManut), String.valueOf(pp.getPxPtageExc()), user);
            else
                updatePenalite(verifPen, Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite Dommage entre ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" et ").append(daty2))), String.valueOf(montant), "scat9", String.valueOf(pp.getValLimCont()), String.valueOf(nbDommage), String.valueOf(nbManut), String.valueOf(pp.getPxPtageExc()), user);
            int k = 1;
            return k;
        }
        catch(Exception ex)
        {
            int i = 0;
            return i;
        }
    }

    public int verifPenliteQuai(String daty1, String daty2, String user)
    {
        try
        {
            if(verifChevauchFacturePenalite(daty1, daty2, "scat4") != 0)
            {
                int i = 0;
                return i;
            }
            double montant = 0.0D;
            double CA = calculCA(daty1, daty2);
            ParametrePenalite pp = loadParametrePenalite(daty1);
            SCatService sc = FactureEJBClient.getInterface().findSCatService("scat4", "%", "%", "%")[0];
            double tempsOccup = 0.0D;
            double temps6Mois = 0.0D;
            double taux = 0.0D;
            Date dateInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date dateSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            Date dateSupAncien = Utilitaire.ajoutMoisDate(dateSup, -1 * sc.getPeriodeFacturation());
            Date dateInfEncours = Utilitaire.ajoutJourDate(dateSupAncien, 1);
            tempsOccup = AdminOccupJournalier.getSommeOcuppation(findOccup(Utilitaire.formatterDaty(dateInfEncours), daty2, "%"));
            temps6Mois = (Utilitaire.diffJourDaty(dateSup, dateSupAncien) - 1) * 24;
            taux = Utilitaire.arrondir((tempsOccup * (double)100) / temps6Mois + (double)pp.getMajorTauxOccupation(), 2);
            if(taux - (double)pp.getSeuilTauxOccupation() > (double)0)
                montant = ((taux - (double)pp.getSeuilTauxOccupation()) * CA) / (double)pp.getSeuilTauxOccupation();
            String verifPen = null;
            verifPen = verifChevauchPenalite(daty1, daty2, "scat4");
            if(verifPen == null)
                createPenalite(Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite sur Quai du ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" au ").append(daty2))), String.valueOf(montant), "scat4", String.valueOf(tempsOccup), String.valueOf(temps6Mois), String.valueOf(pp.getMajorTauxOccupation()), String.valueOf(pp.getSeuilTauxOccupation()), user);
            else
                updatePenalite(verifPen, Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite sur Quai du ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" au ").append(daty2))), String.valueOf(montant), "scat4", String.valueOf(tempsOccup), String.valueOf(temps6Mois), String.valueOf(pp.getMajorTauxOccupation()), String.valueOf(pp.getSeuilTauxOccupation()), user);
            int k = 1;
            return k;
        }
        catch(Exception ex)
        {
            int j = 0;
            return j;
        }
    }

    public double calculCA(String datyInf, String datySup) throws Exception {
        ChiffreAffTac c[] = null;
        String mois = Utilitaire.getMois(datyInf);
        String annee = Utilitaire.getAnnee(datyInf);
        try
        {
            c = findChiffreAffTac("%", mois, annee, "%");
            if(c.length > 0)
            {
                double d = c[0].getMontant();
                return d;
            } else
            {
                double d1 = 0.0D;
                return d1;
            }
        }
        catch(ErreurDAO ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public double calculMontantTrafic(String daty1, String daty2)
    {
        return 0.0D;
    }

    public int verifPenaliteTrafic(String daty1, String daty2, String user)
    {
        try
        {
            if(verifChevauchFacturePenalite(daty1, daty2, "scat5") != 0)
            {
                int i = 0;
                return i;
            }
            double montant = 0.0D;
            double CA = calculCA(daty1, daty2);
            ParametrePenalite pp = loadParametrePenalite(daty1);
            SCatService sc = FactureEJBClient.getInterface().findSCatService("scat5", "%", "%", "%")[0];
            double sommeNombreManut = 0.0D;
            double sommeDureeManut = 0.0D;
            double diff = 0.0D;
            SynthesePointage sp[] = findSynthese(daty1, daty2);
            sommeNombreManut = AdminPointage.getNombreConteneur(sp);
            sommeDureeManut = AdminPointage.getNombreDuree(sp);
            double moyenne;
            if(sommeDureeManut == (double)0)
                moyenne = 0.0D;
            else
                moyenne = sommeNombreManut / sommeDureeManut;
            if((double)pp.getPerformanceAnnuel() - moyenne >= (double)0)
                montant = CA * (((double)pp.getPerformanceAnnuel() - moyenne) / (double)pp.getPerformanceAnnuel());
            Date dateInf = Utilitaire.string_date("dd/MM/yyyy", daty1);
            Date dateSup = Utilitaire.string_date("dd/MM/yyyy", daty2);
            Date dateSupAncien = Utilitaire.ajoutMoisDate(dateSup, -1 * sc.getPeriodeFacturation());
            Date dateInfEncours = Utilitaire.ajoutJourDate(dateSupAncien, 1);
            String verifPen = null;
            verifPen = verifChevauchPenalite(daty1, daty2, "scat5");
            if(verifPen == null)
                createPenalite(Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite sur Trafic du ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" au ").append(daty2))), String.valueOf(montant), "scat5", String.valueOf(sommeDureeManut), String.valueOf(sommeNombreManut), String.valueOf(pp.getPerformanceAnnuel()), String.valueOf(CA), user);
            else
                updatePenalite(verifPen, Utilitaire.formatterDaty(dateInfEncours), daty2, String.valueOf(String.valueOf((new StringBuffer("Penalite sur Trafic du ")).append(Utilitaire.formatterDaty(dateInfEncours)).append(" au ").append(daty2))), String.valueOf(montant), "scat5", String.valueOf(sommeDureeManut), String.valueOf(sommeNombreManut), String.valueOf(pp.getPerformanceAnnuel()), String.valueOf(CA), user);
            int k = 1;
            return k;
        }
        catch(Exception ex)
        {
            int j = 0;
            return j;
        }
    }

    public SynthesePointage[] findSynthese(String datyinf, String datySup) throws Exception {
        Connection c = null;
        try
        {
            //c = (new UtilDB()).getConnMaurice();
            c.setAutoCommit(true);
            int a[] = {
                2
            };
            String val[] = new String[a.length];
            val[0] = "%";
            SynthesePointageUtil sup = new SynthesePointageUtil(c);
            if((datyinf.compareTo("") == 0) & (datySup.compareTo("") == 0))
            {
                SynthesePointage asynthesepointage[] = (SynthesePointage[])sup.rechercher(a, val, " order by dtOpt desc", c);
                return asynthesepointage;
            }
            if((datyinf.compareTo("") > 0) & (datySup.compareTo("") == 0))
            {
                SynthesePointage asynthesepointage1[] = (SynthesePointage[])sup.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dtOpt>='")).append(datyinf).append("' order by dtOpt desc"))), c);
                return asynthesepointage1;
            }
            if((datyinf.compareTo("") == 0) & (datySup.compareTo("") > 0))
            {
                SynthesePointage asynthesepointage2[] = (SynthesePointage[])sup.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dtOpt<='")).append(datySup).append("' order by dtOpt desc"))), c);
                return asynthesepointage2;
            }
            if((datyinf.compareTo("") != 0) & (datySup.compareTo("") != 0))
            {
                SynthesePointage asynthesepointage3[] = (SynthesePointage[])sup.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dtOpt>='")).append(datyinf).append("' and dtOpt<='").append(datySup).append("' order by dtOpt desc"))), c);
                return asynthesepointage3;
            }
            SynthesePointage asynthesepointage4[] = null;
            return asynthesepointage4;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException sqlexception) { }
        }
    }

    public OccupJournalier[] findOccup(String datyinf, String datySup, String idQuai) throws Exception {
        Connection c = null;
        try
        {
            //c = (new UtilDB()).getConnMaurice();
            c.setAutoCommit(true);
            int a[] = {
                1
            };
            String val[] = new String[a.length];
            val[0] = idQuai;
            OccupJournalierUtil oju = new OccupJournalierUtil(c);
            if((datyinf.compareTo("") == 0) & (datySup.compareTo("") == 0))
            {
                OccupJournalier aoccupjournalier[] = (OccupJournalier[])oju.rechercher(a, val, " order by daty desc", c);
                return aoccupjournalier;
            }
            if((datyinf.compareTo("") > 0) & (datySup.compareTo("") == 0))
            {
                OccupJournalier aoccupjournalier1[] = (OccupJournalier[])oju.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyinf).append("' order by daty desc"))), c);
                return aoccupjournalier1;
            }
            if((datyinf.compareTo("") == 0) & (datySup.compareTo("") > 0))
            {
                OccupJournalier aoccupjournalier2[] = (OccupJournalier[])oju.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(datySup).append("' order by daty desc"))), c);
                return aoccupjournalier2;
            }
            if((datyinf.compareTo("") != 0) & (datySup.compareTo("") != 0))
            {
                OccupJournalier aoccupjournalier3[] = (OccupJournalier[])oju.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyinf).append("' and daty<='").append(datySup).append("' order by daty desc"))), c);
                return aoccupjournalier3;
            }
            OccupJournalier aoccupjournalier4[] = null;
            return aoccupjournalier4;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException sqlexception) { }
        }
    }

    public ParametrePenalite loadParametrePenalite(String daty1) throws Exception {
        try
        {
            ParametrePenaliteUtil pu = new ParametrePenaliteUtil();
            int a[] = {
                1
            };
            String val[] = new String[1];
            val[0] = "%";
            ParametrePenalite parametrepenalite = (ParametrePenalite)pu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebut<='")).append(daty1).append("' order by datyDebut desc,idParametrePenalite desc"))))[0];
            return parametrepenalite;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public Penalite[] findPenaliteNonFacture(String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4) throws Exception {
        try
        {
            Penalite pen[] = null;
            int a[] = {
                1, 4, 5, 6, 7, 8, 9, 10
            };
            String val[] = new String[a.length];
            val[0] = idPenalite;
            val[1] = designation;
            val[2] = montant;
            val[3] = idSCatService;
            val[4] = champ1;
            val[5] = champ2;
            val[6] = champ3;
            val[7] = champ4;
            PenaliteUtil au = new PenaliteUtil();
            au.setNomTable("PenaliteNonFacture");
            pen = (Penalite[])au.rechercher(a, val);
            Penalite apenalite[] = pen;
            return apenalite;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public String createDetPenRetard(String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat, String user) throws Exception {
        try
        {
            DetPenRetard dr = new DetPenRetard(idPenalit, datyIn, datySu, rest, nbJourRetar, numPiec, montat);
            MapHistorique h = new MapHistorique("DetPenRetard", "insert", user, dr.getTuppleID());
            dr.insertToTable(h);
            String s = dr.getTuppleID();
            return s;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateDetPenRetard(String id, String idPenalit, String datyIn, String datySu, String rest, String nbJourRetar, String numPiec, String montat, String user) throws Exception {
        try
        {
            DetPenRetard dr = new DetPenRetard(id, idPenalit, datyIn, datySu, rest, nbJourRetar, numPiec, montat);
            MapHistorique h = new MapHistorique("DetPenRetard", "update", user, dr.getTuppleID());
            dr.updateToTableWithHisto(h);
            String s = dr.getTuppleID();
            return s;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteDetPenRetard(String id, String user) throws Exception {
        try
        {
            DetPenRetard dr = new DetPenRetard(id, "-", "", "", "-", "-", "-", "-");
            MapHistorique h = new MapHistorique("DetPenRetard", "delete", user, dr.getTuppleID());
            dr.deleteToTable(h);
            int i = 1;
            return i;
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public DetPenRetard[] findDetPenRetard(String id, String idPen, String daty1, String daty2, String nbJour, String numPiece) throws Exception {
        try
        {
            int a[] = {
                1, 2, 6, 7
            };
            String val[] = new String[a.length];
            val[0] = id;
            val[1] = idPen;
            val[2] = nbJour;
            val[3] = numPiece;
            DetPenRetardUtil dpu = new DetPenRetardUtil();
            if((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0))
            {
                DetPenRetard adetpenretard[] = (DetPenRetard[])dpu.rechercher(a, val, " order by id desc");
                return adetpenretard;
            }
            if((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0))
            {
                DetPenRetard adetpenretard1[] = (DetPenRetard[])dpu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyInf>='")).append(daty1).append("' order by id desc"))));
                return adetpenretard1;
            }
            if((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0))
            {
                DetPenRetard adetpenretard2[] = (DetPenRetard[])dpu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datySup<='")).append(daty2).append("' order by id desc"))));
                return adetpenretard2;
            }
            if((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0))
            {
                DetPenRetard adetpenretard3[] = (DetPenRetard[])dpu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyInf>='")).append(daty1).append("' and datySup<='").append(daty2).append("' order by id desc"))));
                return adetpenretard3;
            } else
            {
                throw new Exception("Erreur dans la recherche!");
            }
        }
        catch(Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerAccident(String idAcc, String refUser) throws Exception {
        Connection c = null;
        Accident acc[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idAcc, "%", "", "", "%", "typOb9");
            if(aut.length < 1)
                throw new Exception("Vérifiez l'autorisation d'annulation");
            acc = findAccident(idAcc, "", "", "%", "%");
            if(acc.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            deleteAccident(idAcc, refUser);
            c.commit();
            int i = 1;
            return i;
        }
        catch(Exception ex)
        {
            try
            {
                c.rollback();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public int annulerVol(String idVol, String refUser) throws Exception {
        Connection c = null;
        VolConteneur vol[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idVol, "%", "", "", "%", "typOb10");
            if(aut.length < 1)
                throw new Exception("Vérifiez l'autorisation d'annulation");
            vol = findVolCont(idVol, "", "", "%", "%", "%", "%", "%");
            if(vol.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            deleteVolCont(idVol, refUser);
            c.commit();
            int i = 1;
            return i;
        }
        catch(Exception ex)
        {
            try
            {
                c.rollback();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    public int annulerDommage(String idDommage, String refUser) throws Exception {
        Connection c = null;
        DommageConteneur dom[] = null;
        facture.AutorisationAnnulation aut[] = null;
        FactureEjb fl = null;
        try
        {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fl = FactureEJBClient.getInterface();
            aut = fl.findAutorisationAnnulation("%", idDommage, "%", "", "", "%", "typOb11");
            if(aut.length < 1)
                throw new Exception("Vérifiez l'autorisation d'annulation");
            dom = findDommageConteneur(idDommage, "", "", "%", "%", "%", "%");
            if(dom.length < 1)
                throw new Exception("Vérifiez le numéro d'objet!");
            deleteDommageConteneur(idDommage, refUser);
            c.commit();
            int i = 1;
            return i;
        }
        catch(Exception ex)
        {
            try
            {
                c.rollback();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
            throw new ErreurDAO(ex.getMessage());
        }
        finally
        {
            try
            {
                c.close();
            }
            catch(SQLException exsq)
            {
                throw new ErreurDAO(exsq.getMessage());
            }
        }
    }

    SessionContext sessionContext;

    @Override
    public int create(ClassMAPTable value1, MapUtilisateur value2) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int update(ClassMAPTable value1, MapUtilisateur value2) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int delete(ClassMAPTable value1, MapUtilisateur value2) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
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
}
