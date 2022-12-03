

// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   FactureEjbBean.java
package facture;

import bean.*;
import comptabilite.*;
import ded.OrdonnerPayement;
import finance.*;
import historique.*;
import java.io.PrintStream;
import java.rmi.RemoteException;
import java.sql.*;
import javax.ejb.*;
import penalite.*;
import pub.PubFacture;
import pub.PubRadioPartenariatMontant;
import pub.PubTarif;
import pub.PubTopRadio;
import pub.Pucomplet;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import ventegazety.VenteFacture;

@Stateful
@AccessTimeout(0)
public class FactureEjbBean implements FactureEjb, FactureEJBRemote, SessionBean {

    public FactureEjbBean() {
    }

    public void ejbCreate() throws CreateException {
    }

    public void ejbRemove() {
    }

    public void ejbActivate() {
    }

    public void ejbPassivate() {
    }

    public void setSessionContext(SessionContext sessionContext) {
        this.sessionContext = sessionContext;
    }

    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String refUser) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            retour = createFactureMereConnection(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, respe, entite, parution, refUser, c);
            c.commit();
            String s = retour;
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

    public int deleteFactureMere(String idFactureMere, String refUser) throws Exception {
        try {
            FactMere fm = new FactMere(idFactureMere, null, null, null, "-", "-", 0, "-", "-", 0, 0.0D, "-", null, 0.0D, "", "", null, null, null);
            MapHistorique h = new MapHistorique("FactureMere", "delete", refUser, fm.getTuppleID());
            fm.deleteToTable(h);
            int i = 1;
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateFactureMere(String idFactureMere, String daty, String idClient, String periodeDebut, String periodefin, String noteExplicative, String idTva, String idDeviseEn, String reduction, String idFactureEn, String idCoursChange, String dateLimite, String idEtat, String montantAPayer, String idSCatServic, String refUser) throws Exception {
        try {
            Date datelimitepaiement = null;
            Date periodeFin = null;
            String idcoursChange = null;
            idEtat = null;
            FactMere fm = null;
            MapHistorique h = new MapHistorique("FactureMere", "update", refUser, fm.getTuppleID());
            fm.updateToTableWithHisto(h);
            String s = fm.getTuppleID();
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMereDevise(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise) throws Exception {
        try {
            int a[] = {
                1, 5, 12, 15, 8
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etatFacture;
            val[3] = sCatService;
            val[4] = devise;
            FactureMereUtil fmu = new FactureMereUtil();
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
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMereDeviseResp(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp) throws Exception {
        try {
            int a[] = {
                1, 5, 12, 15, 8, 17
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etatFacture;
            val[3] = sCatService;
            val[4] = devise;
            val[5] = resp;
            FactureMereUtil fmu = new FactureMereUtil();
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
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMereDeviseRespEntite(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String devise, String resp, String entite) throws Exception {
        try {
            int a[] = {
                1, 5, 12, 15, 8, 17, 18
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etatFacture;
            val[3] = sCatService;
            val[4] = devise;
            val[5] = resp;
            val[6] = entite;
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("facturemerelettreclient");
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
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public FactureRetard[] findFactureRetard(String datyinf, String datySup, String idFactureMere, String refObjet, String fact) throws Exception {
        try {
            int a[] = {
                1, 2, 3
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = refObjet;
            val[2] = fact;
            FactureRetardUtil fmu = new FactureRetardUtil();
            if ((datyinf.compareTo("") == 0) & (datySup.compareTo("") == 0)) {
                FactureRetard afactureretard[] = (FactureRetard[]) fmu.rechercher(a, val, " order by periodeDebut desc");
                return afactureretard;
            }
            if ((datyinf.compareTo("") > 0) & (datySup.compareTo("") == 0)) {
                FactureRetard afactureretard1[] = (FactureRetard[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and periodeDebut='")).append(datyinf).append("' order by periodeDebut desc"))));
                return afactureretard1;
            }
            if ((datyinf.compareTo("") == 0) & (datySup.compareTo("") > 0)) {
                FactureRetard afactureretard2[] = (FactureRetard[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and periodeFin='")).append(datySup).append("' order by periodeDebut desc"))));
                return afactureretard2;
            }
            if ((datyinf.compareTo("") != 0) & (datySup.compareTo("") != 0)) {
                FactureRetard afactureretard3[] = (FactureRetard[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and periodeDebut='")).append(datyinf).append("' and periodeFin='").append(datySup).append("' order by periodeDebut desc"))));
                return afactureretard3;
            } else {
                FactureRetard afactureretard4[] = null;
                return afactureretard4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, String idType) throws Exception {
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
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception {
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
            ex.printStackTrace();
            throw new Exception("Facture non trouvée : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
    }

    public FactMere[] findFactureMere(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService, Connection c) throws Exception {
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
            ex.printStackTrace();
            throw new Exception("Facture non trouvée : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
    }

    public String createClientComptable(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String comptable, String typecontact, String soustypecontact, String refUser) throws Exception, RemoteException{
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);

            if (tel == null || tel.compareTo("-") == 0 || tel.compareTo("") == 0) {
                throw new Exception("Numero de telephone obligatoire");
            }

            Client cl = new Client(nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit);
			cl.setType_contact(typecontact);
			cl.setSoustype_contact(soustypecontact);

            if (comptable.compareToIgnoreCase("-") == 0) {
                comptable = "411101;401101;411102;401102;";
            }
            //createCompteConnection(comptable, cl.getTuppleID(), Utilitaire.formatterDaty(Utilitaire.dateDuJourSql()), refUser, c);
            MapHistorique h = new MapHistorique("Client", "insert", refUser, cl.getTuppleID());
            cl.insertToTable(c);
            h.insertToTable(c);
            String s = cl.getTuppleID();
            //comptabilite

            //============= insertion telephone
            String[] _tel = tel.split(";");
            TypeObjet to = new TypeObjet();
            to.setNomTable("TELEPHONE");
            for (int i = 0; i < _tel.length; i++) {
                to.setId(String.valueOf(Utilitaire.getMaxSeq("GETSEQ_TELEPHONE", c)));
                to.setVal(s);//idclient
                to.setDesce(_tel[i]);//telephone
                to.insertToTable(c);
            }
            //============= insertion telephone

            ComptabiliteEjbClient.getInterface().insertTiersMultipleCompte(s, comptable, c, refUser);

            c.commit();
            return s;
        } catch (Exception e) {
            e.printStackTrace();
            c.rollback();
            throw new Exception(e.getMessage());
        } finally {
            c.close();
        }
    }

    public String createClient(String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String refUser) throws Exception {
        try {
            Client cl = new Client(nomClient, idregime, tel, fax, adr, numStat, nif, rc, tp, quit);
            MapHistorique h = new MapHistorique("Client", "insert", refUser, cl.getTuppleID());
            cl.insertToTable(h);
            String s = cl.getTuppleID();
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    public String updateClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, String refUser) throws Exception {
        try {
            if (tel == null || tel.compareTo("") == 0 || tel.compareTo("-") == 0) {
                throw new Exception("Numero de telephone obligatoire");
            }
            Client cl = new Client(idClient, nomClient, idregime, adr, tel, fax, numStat, nif, rc, tp, quit);
            MapHistorique h = new MapHistorique("Client", "update", refUser, cl.getTuppleID());
            cl.updateToTableWithHisto(h);
            String s = cl.getTuppleID();
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteClient(String idClient, String refUser, Connection conn) throws Exception {
        try {
            Client cl = new Client(idClient, "-", "-", "-", "-", "-", "-", "-", "-", "-", "-");
            MapHistorique h = new MapHistorique("Caisse", "delete", refUser, cl.getTuppleID());
            cl.deleteToTable(conn);
            int i = 1;
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteClient(String idClient, String refUser) throws Exception {
        try {
            Client cl = new Client(idClient, "-", "-", "-", "-", "-", "-", "-", "-", "-", "-");
            MapHistorique h = new MapHistorique("Caisse", "delete", refUser, cl.getTuppleID());
            cl.deleteToTable(h);
            int i = 1;
            return i;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Client[] findClientConn(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, Connection c) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                11
            };
            String val[] = new String[a.length];
            val[0] = idClient;
            val[1] = nomClient;
            val[2] = idregime;
            val[3] = adr;
            val[4] = tel;
            val[5] = fax;
            val[6] = numStat;
            val[7] = nif;
            val[8] = rc;
            val[9] = tp;
            val[10] = quit;
            ClientUtil cu = new ClientUtil();
            Client aclient[] = (Client[]) cu.rechercher(a, val, " order by nom asc", c);
            return aclient;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Client[] findClient(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                11
            };
            String val[] = new String[a.length];
            val[0] = idClient;
            val[1] = nomClient;
            val[2] = idregime;
            val[3] = adr;
            val[4] = tel;
            val[5] = fax;
            val[6] = numStat;
            val[7] = nif;
            val[8] = rc;
            val[9] = tp;
            val[10] = quit;
            ClientUtil cu = new ClientUtil();
            Client aclient[] = (Client[]) cu.rechercher(a, val, " order by nom asc");
            return aclient;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ResultatEtSomme findClientPage(String idClient, String nomClient, String idregime, String tel, String fax, String adr, String numStat, String nif, String rc, String tp, String quit, int numPage) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
            String val[] = new String[a.length];
            val[0] = idClient;
            val[1] = nomClient;
            val[2] = idregime;
            val[3] = adr;
            val[4] = tel;
            val[5] = fax;
            val[6] = numStat;
            val[7] = nif;
            val[8] = rc;
            val[9] = tp;
            val[10] = quit;
            ClientUtil cu = new ClientUtil();
            Client aclient[] = (Client[]) cu.rechercher(a, val, " order by nom asc", c, null, null, numPage);
            String nomColSom[] = null;
            double[] sommeNombre = cu.calculSommeNombre(a, val, "", c, null, null, nomColSom);
            return new ResultatEtSomme(aclient, sommeNombre);
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public String createfacturefilleMultiple(String[] g, String idfactureMere, String refUser, String ttva) throws Exception {
        Connection conn = null;
        String retour;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            String idP = Utilitaire.stringToTab(g, "'", ",");
            Pucomplet pub = new Pucomplet();
            Pucomplet[] lpub = (Pucomplet[]) CGenUtil.rechercher(pub, null, null, conn, " and id in (" + idP + ")");
            //System.out.println("lpub eto=="+lpub[0].getRemis());
            String couleur = "";

            for (int i = 0; i < lpub.length; i++) {
                if (lpub[i].getCouleur() == 1 && lpub[i].getNumPage() == 0) {
                    couleur = "N&B";
                } else if (lpub[i].getCouleur() == 4 && lpub[i].getNumPage() == 0) {
                    couleur = "quadri";
                } else if (lpub[i].getCouleur() == 1 && lpub[i].getNumPage() == 1) {
                    couleur = "N&B 1er page";
                } else if (lpub[i].getCouleur() == 4 && lpub[i].getNumPage() == 1) {
                    couleur = "quadri 1er page";
                }

                String des = "insertion pub dans " + lpub[i].getLibJournal() + " d'un format de " + lpub[i].getIdMont() + " de page " + couleur + ", parution " + lpub[i].getNumParution();

                if (ttva.compareToIgnoreCase("ttva3") == 0) {
                    retour = createFactureFilleConnection(idfactureMere, "scat10", des, "1", "unt", lpub[i].getMontantVal() + "", lpub[i].getRemis() + "", refUser, conn);
                } else {
                    retour = createFactureFilleConnection(idfactureMere, "scat10", des, "1", "unt", lpub[i].getMontantht() + "", lpub[i].getRemis() + "", refUser, conn);
                }
            }
            conn.commit();

            return idfactureMere;
        } catch (Exception exc) {
            exc.printStackTrace();
            conn.rollback();
            throw new Exception(exc.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public String createfacturefilleMultiple(String[] g, String idfactureMere, String refUser, String ttva, String dateParu) throws Exception {
        Connection conn = null;
        String retour;
        try {
            conn = (new UtilDB()).GetConn();
            conn.setAutoCommit(false);
            String idP = Utilitaire.stringToTab(g, "'", ",");
            Pucomplet pub = new Pucomplet();
            Pucomplet[] lpub = (Pucomplet[]) CGenUtil.rechercher(pub, null, null, conn, " and id in (" + idP + ")");
            //System.out.println("lpub eto=="+lpub[0].getRemis());
            String couleur = "";

            for (int i = 0; i < lpub.length; i++) {
                if (lpub[i].getCouleur() == 1 && lpub[i].getNumPage() == 0) {
                    couleur = "N&B";
                } else if (lpub[i].getCouleur() == 4 && lpub[i].getNumPage() == 0) {
                    couleur = "quadri";
                } else if (lpub[i].getCouleur() == 1 && lpub[i].getNumPage() == 1) {
                    couleur = "N&B 1er page";
                } else if (lpub[i].getCouleur() == 4 && lpub[i].getNumPage() == 1) {
                    couleur = "quadri 1er page";
                }

                String des = "insertion pub dans " + lpub[i].getLibJournal() + " d'un format de " + lpub[i].getIdMont() + " de page " + couleur + ", parution " + lpub[i].getNumParution();

                if (dateParu.compareToIgnoreCase("1") == 0) {
                    des += " le " + lpub[i].getDatyParution();
                }

                //System.out.println("reduction  = " + lpub[i].getRemis() + " id = " + lpub[i].getId());
                if (ttva.compareToIgnoreCase("ttva3") == 0) {
                    retour = createFactureFilleConnection(idfactureMere, "scat10", des, "1", "unt", lpub[i].getMontantVal() + "", lpub[i].getRemis() + "", refUser, conn);
                } else {
                    retour = createFactureFilleConnection(idfactureMere, "scat10", des, "1", "unt", lpub[i].getMontantht() + "", lpub[i].getRemis() + "", refUser, conn);
                }
            }
            conn.commit();

            return idfactureMere;
        } catch (Exception exc) {
            exc.printStackTrace();
            conn.rollback();
            throw new Exception(exc.getMessage());
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }

    public String createFactureFilleConnection(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF, String refUser, Connection c) throws Exception {
        try {
            FactMere temp[] = findFactureMere("", "", idFactureMere, "%", "", "%", "%", "%", c);
            FactMere mr = null;
            if (temp.length > 0) {
                mr = temp[0];
                if (mr.idEtat.compareToIgnoreCase("eta4") == 0 || mr.idEtat.compareToIgnoreCase("eta3") == 0) {
                    throw new Exception("Facture déja finalisée ou reglée");
                }
            }

            System.out.println("reduction 2 = " + Utilitaire.stringToInt(reductionF) + " double = " + Utilitaire.stringToDouble(reductionF));
            FactureFille ff = new FactureFille();
            ff.setIndicePk("FF");
            ff.setNomProcedureSequence("getSeqFactureFille");
            ff.setNomTable("factureFille");
            ff.setIdFactureMere(idFactureMere);
            ff.setNomProcedureSequence("getSeqFactureFille");
            ff.setDesignation(des);
            ff.setIdUnite(unite);
            ff.setReduction((int) Utilitaire.stringToDouble(reductionF));
            ff.setQuantite(Utilitaire.stringToDouble(qte));
            ff.setPrixUnitaire(Utilitaire.stringToDouble(pu));
            ff.setRefObj(refObj);
            ff.setIdFactureFille(ff.makePK(c));

            ff.insertToTable(c);
            //h.insertToTable(c);
            String s = ff.getTuppleID();
            return s;

        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureFille(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF, String refUser) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            retour = createFactureFilleConnection(idFactureMere, refObj, des, qte, unite, pu, reductionF, refUser, c);
            c.commit();
            String s = retour;
            return s;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                throw new Exception(ex.getMessage());
            }
        }
    }

    public int deleteFactureFille(String idFactureFille, String refUser) throws Exception {
        try {
            MapUtilisateur u = HistoriqueClient.getInterface().findUtilisateurs(refUser, "%", "%", "%", "%", "%", "%")[0];
            FactureFille ff = new FactureFille(idFactureFille, "-", "-", "-", 0.0D, "-", 0.0D, 0);
            FactureFille ff2 = findFactureFille(idFactureFille, "%", "%", "%")[0];
            FactMere fm = findFactureMere("", "", ff2.getIdFactureMere(), "%", "", "%", "%", "%")[0];
            if (fm.getIdEtat().compareToIgnoreCase("eta4") == 0) {
                throw new Exception("Facture déjà finalisée");
            } else {
                MapHistorique h = new MapHistorique("FactureFille", "delete", refUser, ff.getTuppleID());
                ff.deleteToTable();
                h.insertToTable();
                int i = 1;
                return i;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String updateFactureFille(String idFactureFille, String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF, String refUser) throws Exception {
        try {
            FactureFille ff = new FactureFille(idFactureFille, idFactureMere, refObj, des, Utilitaire.stringToFloat(qte), unite, Utilitaire.stringToFloat(pu), Utilitaire.stringToInt(reductionF));
            MapHistorique h = new MapHistorique("FactureFille", "update", refUser, ff.getTuppleID());
            ff.updateToTableWithHisto(h);
            String s = null;
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateFactureFournisseur(String nomTable, String idf, String numFact, String designation, java.sql.Date daty, String fournisseur, double tva, double montantTTC, String remarque, java.sql.Date dateemission, String idDevise, String refUser) throws Exception {
        try {
            facturefournisseur.FactureFournisseur ff = new facturefournisseur.FactureFournisseur(nomTable, idf, numFact, designation, daty, fournisseur, tva, montantTTC, remarque, dateemission, idDevise);
            MapHistorique h = new MapHistorique("FactureFournisseur", "update", refUser, ff.getTuppleID());
            ff.updateToTableWithHisto(h);
            String s = null;
            return s;
        } catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactureFille[] findFactureFille(String idFactureFille, String refObj, String idSCatService, String idFactureMere) throws Exception {
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
            FactureFille afacturefille1[] = (FactureFille[]) ffu.rechercher(a, val);
            return afacturefille1;
        } catch (Exception ex) {
            afacturefille = null;
        }
        return afacturefille;
    }

    public FactureFille[] findFactureFille(String idFactureFille, String refObj, String idSCatService, String idFactureMere, Connection c) throws Exception {
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
            FactureFille afacturefille1[] = (FactureFille[]) ffu.rechercher(a, val, c);
            return afacturefille1;
        } catch (Exception ex) {
            afacturefille = null;
        }
        return afacturefille;
    }

    public FactureFille[] findFactureFilleConn(String idFactureFille, String refObj, String idSCatService, String idFactureMere, Connection c) throws Exception {
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
            ffu.setNomTable("facture_fille_libelle");
            FactureFille afacturefille1[] = (FactureFille[]) ffu.rechercher(a, val, c);
            return afacturefille1;
        } catch (Exception ex) {
            afacturefille = null;
        }
        return afacturefille;
    }

    public String createFactureRedevance(String idClient, String daty, String dateDebut, String dateFin, String idScatService, String refUser) throws Exception {
        //System.out.println("scat".concat(String.valueOf(String.valueOf(idScatService))));
        try {
            if (idScatService.compareToIgnoreCase("scat1") == 0) {
                String s = createFactureRedevanceFixe(idClient, daty, dateDebut, dateFin, refUser);
                return s;
            }
            if (idScatService.compareToIgnoreCase("scat2") == 0) {
                String s1 = createFactureRedevanceVariable(idClient, daty, dateDebut, dateFin, refUser);
                return s1;
            } else {
                String s2 = null;
                return s2;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFactureRedevanceFixe(String idClient, String daty, String dateDebut, String dateFin, String refUser) throws Exception {
        Connection c = null;
        String idFactMere = null;
        Service sv = null;
        MapHistorique h3 = null;
        SCatService scs = (SCatService) (new SCatServiceUtil()).rechercher(1, "scat1")[0];
        ParametreFacture pf = loadParametreFacture(dateDebut);
        double qte = 0.0D;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            if (verifChevauch(dateDebut, dateFin, "scat1") != 0) {
                //System.out.println("verif".concat(String.valueOf(String.valueOf(verifChevauch(dateDebut, dateFin, "scat1")))));
                throw new Exception("Existence de chevauchemnt");
            }
            sv = loadServiceValide(dateDebut, "redevance fixe", idClient);
            idFactMere = createFactureMereConnection(daty, dateDebut, dateFin, idClient, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(sv.getDesignation())))).append(" du ").append(dateDebut).append(" au ").append(dateFin))), String.valueOf(sv.getIdTva()), scs.getFactureEn(), sv.getIdDevise(), "0", scs.getTuppleID(), "typ01", null, "ent", "parution", refUser, c);
            String moisDebut = Utilitaire.getMois(dateDebut);
            String moisFin = Utilitaire.getMois(dateFin);
            int jourDebut = Utilitaire.stringToInt(Utilitaire.getJour(dateDebut));
            int jourFin = Utilitaire.stringToInt(Utilitaire.getJour(dateFin));
            if (moisDebut.compareTo("01") == 0 && moisFin.compareTo("06") == 0 && jourDebut == 1 && jourFin == 30 || moisDebut.compareTo("07") == 0 && moisFin.compareTo("12") == 0 && jourDebut == 1 && jourFin == 31) {
                qte = 0.5D;
            } else {
                qte = (double) Utilitaire.diffJourDaty(dateFin, dateDebut) / 365D;
            }
            if (qte < (double) 0) {
                qte = 0.0D;
            }
            createFactureFilleConnection(idFactMere, scs.getTuppleID(), String.valueOf(String.valueOf((new StringBuffer("Redevance Fixe entre ")).append(dateDebut).append(" et ").append(dateFin))), String.valueOf(qte), sv.getIdUnite(), String.valueOf(sv.getPrixUnitaire()), "0", refUser, c);
            c.commit();
            String s = idFactMere;
            return s;
        } catch (Exception ex) {
            try {
                c.rollback();
            } catch (SQLException sqlexception) {
            }
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException sqlexception1) {
            }
        }
    }

    public double calculNombreActionTac(String daty1, String daty2, String typeAction) throws Exception {
        try {
            double retour = 0.0D;
            PenaliteEjb pl = PenaliteEjbClient.getInterface();
            TraficConteneur tc[] = null;
            tc = pl.findTrafic("%", daty1, daty2, typeAction);
//            System.out.println("daty1=".concat(String.valueOf(String.valueOf(daty1))));
//            System.out.println("daty2=".concat(String.valueOf(String.valueOf(daty2))));
//            System.out.println("typeAction=".concat(String.valueOf(String.valueOf(typeAction))));
//            System.out.println("tc.length=".concat(String.valueOf(String.valueOf(tc.length))));
            for (int i = 0; i < tc.length; i++) {
                //System.out.println("tc[i].getNombre()=".concat(String.valueOf(String.valueOf(tc[i].getNombre()))));
                retour += tc[i].getNombre();
            }

            double d1 = retour;
            return d1;
        } catch (CreateException ex) {
            double d = 0.0D;
            return d;
        }
    }

    public boolean testPerfTrafic(String dateDebut, String dateFin) throws Exception {
        try {
            Date dateF = Utilitaire.string_date("dd/MM/yyyy", dateFin);
            Date debutMoins12 = Utilitaire.ajoutMoisDate(Utilitaire.string_date("dd/MM/yyyy", dateFin), -12);
            String d1 = Utilitaire.formatterDaty(debutMoins12);
            String d2 = Utilitaire.formatterDaty(dateF);
            double nbTraffic = AdminTrafic.calculSommeFacture(PenaliteEjbClient.getInterface().findTrafic("%", d1, d2, "%"));
            ParametreFacture pf = loadParametreFacture(dateDebut);
            if (nbTraffic > pf.getBonusEVP()) {
                boolean flag1 = true;
                return flag1;
            } else {
                boolean flag2 = false;
                return flag2;
            }
        } catch (CreateException ex) {
            ex.printStackTrace();
        }
        boolean flag = false;
        return flag;
    }

    public String createFactureRedevanceVariable(String idClient, String daty, String dateDebut, String dateFin, String refUser) throws Exception {
        Connection c = null;
        String idFactMere = null;
        Service sv = null;
        Service svTab[] = null;
        MapHistorique h3 = null;
        String reduction = "0";
        if (testPerfTrafic(dateDebut, dateFin)) {
            reduction = "20";
        }
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            SCatService scs = (SCatService) (new SCatServiceUtil()).rechercher(1, "scat2")[0];
            ParametreFacture pf = loadParametreFacture(dateDebut);
            if (verifChevauch(dateDebut, dateFin, "scat2") > 0) {
                throw new Exception("Existence de chevauchemnt");
            }
            sv = loadServiceValide(dateDebut, "trafic", idClient);
            idFactMere = createFactureMereConnection(daty, dateDebut, dateFin, idClient, String.valueOf(String.valueOf((new StringBuffer("Redevance variable sur ")).append(sv.getDesignation()).append(" du ").append(dateDebut).append(" au ").append(dateFin))), String.valueOf(sv.getIdTva()), scs.getFactureEn(), sv.getIdDevise(), reduction, scs.getTuppleID(), "typ01", null, "ent1", "parution", refUser, c);
            double qte = calculNombreActionTac(dateDebut, dateFin, "%");
            createFactureFilleConnection(idFactMere, scs.getTuppleID(), String.valueOf(String.valueOf((new StringBuffer("Redevance variable du ")).append(dateDebut).append(" au ").append(dateFin))), String.valueOf(qte), sv.getIdUnite(), String.valueOf(sv.getPrixUnitaire()), "0", refUser, c);
            c.commit();
            String s = idFactMere;
            return s;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            //System.out.println(ex.getMessage());
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException sqlexception) {
            }
        }
    }

    public String createAutorisationAnnulation(String idObjet, String responsable, String daty, String motif, String idTypeObjet, String refUser) throws Exception {
        try {
            //if(verifExistTypObj(idObjet, idTypeObjet) == 0)
            //  throw new Exception("Vérifiez le numéro de l'objet");
            AutorisationAnnulation aaTab[] = findAutorisationAnnulation("%", idObjet, "%", "", "", "%", idTypeObjet);
            if (aaTab.length > 0) {
                throw new Exception("Autorisation déjà existante!");
            } else {
                AutorisationAnnulation aa = new AutorisationAnnulation(idObjet, responsable, Utilitaire.string_date("dd/MM/yyyy", daty), motif, idTypeObjet);
                MapHistorique h = new MapHistorique("AutorisationAnnulation", "insert", refUser, aa.getTuppleID());
                aa.insertToTable(h);
                String s = aa.getTuppleID();
                return s;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteAutorisationAnnulation(String idAutorisation, String refUser) throws ErreurDAO {
        AutorisationAnnulation aa = new AutorisationAnnulation(idAutorisation, "-", "-", null, "-", "-");
        MapHistorique h = new MapHistorique("Caisse", "delete", refUser, aa.getTuppleID());
        aa.deleteToTable(h);
        return 1;
    }

    public String updateAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty, String motif, String idTypeObjet, String refUser) throws ErreurDAO {
        AutorisationAnnulation aa = new AutorisationAnnulation(idAutorisation, idObjet, responsable, Utilitaire.string_date("dd/MM/yyyy", daty), motif, idTypeObjet);
        MapHistorique h = new MapHistorique("Caisse", "update", refUser, aa.getTuppleID());
        aa.updateToTableWithHisto(h);
        return aa.getTuppleID();
    }

    public AutorisationAnnulation[] findAutorisationAnnulation(String idAutorisation, String idObjet, String responsable, String daty1, String daty2, String motif, String idTypeObjet) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 5, 6
            };
            String val[] = new String[a.length];
            val[0] = idAutorisation;
            val[1] = idObjet;
            val[2] = responsable;
            val[3] = motif;
            val[4] = idTypeObjet;
            AutorisationAnnulationUtil aau = new AutorisationAnnulationUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                AutorisationAnnulation aautorisationannulation[] = (AutorisationAnnulation[]) aau.rechercher(a, val, " order by idAutorisation desc");
                return aautorisationannulation;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                AutorisationAnnulation aautorisationannulation1[] = (AutorisationAnnulation[]) aau.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' order by idAutorisation desc"))));
                return aautorisationannulation1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                AutorisationAnnulation aautorisationannulation2[] = (AutorisationAnnulation[]) aau.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(daty2).append("' order by idAutorisation desc"))));
                return aautorisationannulation2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                AutorisationAnnulation aautorisationannulation3[] = (AutorisationAnnulation[]) aau.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(daty1).append("' and daty<='").append(daty2).append("' order by idAutorisation desc"))));
                return aautorisationannulation3;
            } else {
                AutorisationAnnulation aautorisationannulation4[] = null;
                return aautorisationannulation4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createService(String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient, String refUser) throws Exception {
        Service s = new Service(sCatService, Utilitaire.string_date("dd/MM/yyyy", datyDebutValid), unite, des, Utilitaire.stringToDouble(pu), devise, Utilitaire.stringToInt(tva), idClient);
        MapHistorique h = new MapHistorique("Service", "insert", refUser, s.getTuppleID());
        s.insertToTable(h);
        return s.getTuppleID();
    }

    public int deleteService(String idService, String refUser) throws ErreurDAO {
        Service s = new Service(idService, "-", null, "-", "-", 0.0D, "-", 0, "-");
        MapHistorique h = new MapHistorique("Service", "delete", refUser, s.getTuppleID());
        s.deleteToTable(h);
        return 1;
    }

    public String updateService(String idService, String sCatService, String datyDebutValid, String unite, String des, String pu, String devise, String tva, String idClient, String refUser) throws ErreurDAO {
        Service s = new Service(idService, sCatService, Utilitaire.string_date("dd/MM/yyyy", datyDebutValid), unite, des, Utilitaire.stringToDouble(pu), devise, Utilitaire.stringToInt(tva), idClient);
        MapHistorique h = new MapHistorique("Service", "update", refUser, s.getTuppleID());
        s.updateToTableWithHisto(h);
        return s.getTuppleID();
    }

    public Service[] findService(String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient) throws Exception {
        try {
            int a[] = {
                1, 2, 4, 5, 7, 9
            };
            String val[] = new String[a.length];
            val[0] = idService;
            val[1] = idSCatService;
            val[2] = unite;
            val[3] = des;
            val[4] = devise;
            val[5] = idClient;
            ServiceUtil su = new ServiceUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Service aservice[] = (Service[]) su.rechercher(a, val, " order by datyDebutValid desc");
                return aservice;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Service aservice1[] = (Service[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutValid>='")).append(daty1).append("' order by datyDebutValid desc"))));
                return aservice1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Service aservice2[] = (Service[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutValid<='")).append(daty2).append("' order by datyDebutValid desc"))));
                return aservice2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Service aservice3[] = (Service[]) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutValid>='")).append(daty1).append("' and datyDebutValid<='").append(daty2).append("' order by datyDebutValid desc"))));
                return aservice3;
            } else {
                Service aservice4[] = null;
                return aservice4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createSCatService(String nomSCat, String cat, String periodeFacturation, String factureEn, String refUser) throws Exception {
        SCatService sc = new SCatService(nomSCat, cat, periodeFacturation, factureEn);
        MapHistorique h = new MapHistorique("SCatService", "insert", refUser, sc.getTuppleID());
        sc.insertToTable(h);
        return sc.getTuppleID();
    }

    public int deleteSCatService(String idSCatService, String refUser) throws ErreurDAO {
        SCatService sc = new SCatService(idSCatService, "-", "_", 0, "_");
        MapHistorique h = new MapHistorique("SCatService", "delete", refUser, sc.getTuppleID());
        sc.deleteToTable(h);
        return 1;
    }

    public String updateSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, String factureEn, String refUser) throws ErreurDAO {
        SCatService sc = new SCatService(idSCatService, nomSCat, cat, Utilitaire.stringToInt(periodeFacturation), factureEn);
        MapHistorique h = new MapHistorique("SCatService", "update", refUser, sc.getTuppleID());
        sc.updateToTableWithHisto(h);
        return sc.getTuppleID();
    }

    public int annulationFactureAvoir(String idFactureMere, String idAvoir, String refUser) throws Exception {
        Connection c = null;
        FactMere fm1 = null;
        FactMere fm2[] = null;
        MapHistorique h3 = null;
        AutorisationAnnulation aut[] = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fm2 = findFactureMere("", "", idFactureMere, "%", "", "%", "%", "%");
            if (fm2[0].getIdEtat().compareTo("eta1") == 0) {
                throw new ErreurDAO("La facture a déjà été annulée!");
            } else {
                fm1 = fm2[0];
                fm1.setIdEtat("eta1");
                fm1.updateToTable(c);
                HistoriqueEtat he = new HistoriqueEtat(idFactureMere, refUser, "eta1", Utilitaire.dateDuJourSql());
                MapHistorique mh = new MapHistorique("Facture", "Annulation", refUser, fm1.getTuppleID());
                mh.insertToTable(c);
                he.insertToTable(c);
                Compte compteFact = findCompte("%", "%", fm1.getIdSCatService(), Utilitaire.dateDuJour())[0];
                Compte compteClient = findCompte("%", "%", fm1.getIdClient(), Utilitaire.dateDuJour())[0];
                Compte compteTva = findCompte("%", "%", "TVA", Utilitaire.dateDuJour())[0];
                createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Annulation facture num ".concat(String.valueOf(String.valueOf(fm1.getTuppleID()))), String.valueOf(fm1.getMontantHTva()), "0", idAvoir, refUser, c);
                createEcritureConnection(Utilitaire.dateDuJour(), compteTva.getId(), "Annulation TVA sur facture num ".concat(String.valueOf(String.valueOf(fm1.getTuppleID()))), String.valueOf(fm1.getMontantTva()), "0", idAvoir, refUser, c);
                createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Annulation facture num ".concat(String.valueOf(String.valueOf(fm1.getTuppleID()))), "0", String.valueOf(fm1.getMontantTtc()), idAvoir, refUser, c);
                c.commit();
                int i = 1;
                return i;
            }
        } catch (Exception ex) {
            try {
                c.rollback();
                throw new Exception(ex.getMessage());
            } catch (Exception ef) {
                ef.printStackTrace();
                throw new Exception(ef.getMessage());
            } finally {
                try {
                    c.close();
                } catch (SQLException exsq) {
                    throw new Exception(exsq.getMessage());
                }
            }
        }
    }

    public int annulationFacture(String idFactureMere, String refUser) throws Exception {
        Connection c = null;
        FactMere fm1 = null;
        FactMere fm2[] = null;
        MapHistorique h3 = null;
        AutorisationAnnulation aut[] = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            fm2 = findFactureMere("", "", idFactureMere, "%", "", "%", "%", "%");
            if (fm2[0].getIdEtat().compareTo("eta1") == 0) {
                throw new ErreurDAO("La facture a déjà été annulée!");
            } else {
                fm1 = fm2[0];
                fm1.setIdEtat("eta1");
                fm1.updateToTable(c);
                HistoriqueEtat he = new HistoriqueEtat(idFactureMere, refUser, "eta1", Utilitaire.dateDuJourSql());
                MapHistorique mh = new MapHistorique("Facture", "Annulation", refUser, fm1.getTuppleID());
                mh.insertToTable(c);
                he.insertToTable(c);
                Compte compteFact = findCompte("%", "%", fm1.getIdSCatService(), Utilitaire.dateDuJour())[0];
                Compte compteClient = findCompte("%", "%", fm1.getIdClient(), Utilitaire.dateDuJour())[0];
                Compte compteTva = findCompte("%", "%", "TVA", Utilitaire.dateDuJour())[0];
                createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Annulation facture num ".concat(String.valueOf(String.valueOf(fm1.getTuppleID()))), String.valueOf(fm1.getMontantHTva()), "0", fm1.getTuppleID(), refUser, c);
                createEcritureConnection(Utilitaire.dateDuJour(), compteTva.getId(), "Annulation TVA sur facture num ".concat(String.valueOf(String.valueOf(fm1.getTuppleID()))), String.valueOf(fm1.getMontantTva()), "0", fm1.getTuppleID(), refUser, c);
                createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Annulation facture num ".concat(String.valueOf(String.valueOf(fm1.getTuppleID()))), "0", String.valueOf(fm1.getMontantTtc()), fm1.getTuppleID(), refUser, c);
                c.commit();
                int i = 1;
                return i;
            }
        } catch (Exception ex) {
            try {
                c.rollback();
                throw new Exception(ex.getMessage());
            } catch (Exception ef) {
                ef.printStackTrace();
                throw new Exception(ef.getMessage());
            } finally {
                try {
                    c.close();
                } catch (SQLException exsq) {
                    throw new Exception(exsq.getMessage());
                }
            }
        }
    }

    public String updateParametreFacture(String dateLimite, String bonusEvp, String red, String dateDebutValid, String refUser) throws Exception {
        try {
            ParametreFacture pf = new ParametreFacture(dateLimite, bonusEvp, red, dateDebutValid);
            MapHistorique h = new MapHistorique("ParametreFacture", "create", refUser, pf.getTuppleID());
            pf.insertToTable(h);
            String s = pf.getTuppleID();
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public ParametreFacture[] findParametreFacture(String idParametreFacture, String dateLimite, String bonusEvp, String red, String daty1, String daty2) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 4
            };
            String val[] = new String[a.length];
            val[0] = idParametreFacture;
            val[1] = dateLimite;
            val[2] = bonusEvp;
            val[3] = red;
            ParametreFactureUtil pfu = new ParametreFactureUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                ParametreFacture aparametrefacture[] = (ParametreFacture[]) pfu.rechercher(a, val, " order by datedebutvalid desc");
                return aparametrefacture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                ParametreFacture aparametrefacture1[] = (ParametreFacture[]) pfu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datedebutvalid>='")).append(daty1).append("' order by datedebutvalid desc"))));
                return aparametrefacture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                ParametreFacture aparametrefacture2[] = (ParametreFacture[]) pfu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datedebutvalid<='")).append(daty2).append("' order by datedebutvalid desc"))));
                return aparametrefacture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                ParametreFacture aparametrefacture3[] = (ParametreFacture[]) pfu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datedebutvalid>='")).append(daty1).append("' and datedebutvalid<='").append(daty2).append("' order by datedebutvalid desc"))));
                return aparametrefacture3;
            } else {
                ParametreFacture aparametrefacture4[] = null;
                return aparametrefacture4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int verifChevauch(String datyDebut, String datyFin, String idSCatService) throws Exception {
        try {
            int a[] = {
                15
            };
            String val[] = new String[a.length];
            val[0] = idSCatService;
            FactureMereUtil fu = new FactureMereUtil();
            fu.setNomTable("Facturevalide");
            FactMere ftm[] = (FactMere[]) fu.rechercher(a, val, " order by periodeFin desc");
            if (ftm.length == 0) {
                int i = 0;
                return i;
            } else {
                FactMere fm = ftm[0];
                SCatService sc = findSCatService(idSCatService, "%", "%", "%")[0];
                Date factPlus = Utilitaire.ajoutJourDate(fm.getPeriodeFin(), 1);
                Date debutTh = Utilitaire.ajoutMoisDate(factPlus, sc.getPeriodeFacturation());
                Date nouv = Utilitaire.string_date("dd/MM/yyyy", datyDebut);
                int j = Utilitaire.compareDaty(factPlus, nouv);
                return j;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation, Connection c) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 4
            };
            String val[] = new String[a.length];
            val[0] = idSCatService;
            val[1] = nomSCat;
            val[2] = cat;
            val[3] = periodeFacturation;
            SCatServiceUtil cu = new SCatServiceUtil();
            SCatService ascatservice[] = (SCatService[]) cu.rechercher(a, val, c);
            return ascatservice;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public SCatService[] findSCatService(String idSCatService, String nomSCat, String cat, String periodeFacturation) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 4
            };
            String val[] = new String[a.length];
            val[0] = idSCatService;
            val[1] = nomSCat;
            val[2] = cat;
            val[3] = periodeFacturation;
            SCatServiceUtil cu = new SCatServiceUtil();
            SCatService ascatservice[] = (SCatService[]) cu.rechercher(a, val);
            return ascatservice;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createTva(String val, String daty, String refUser) throws Exception {
        try {
            Tva tv = new Tva(val, daty);
            MapHistorique h = new MapHistorique("Tva", "insert", refUser, tv.getTuppleID());
            tv.insertToTable(h);
            String s = tv.getTuppleID();
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateTva(String idTva, String val, String daty, String refUser) throws Exception {
        try {
            Tva tv = new Tva(Utilitaire.stringToInt(val), Utilitaire.string_date("dd/MM/yyyy", daty));
            MapHistorique h = new MapHistorique("Tva", "update", refUser, tv.getTuppleID());
            tv.updateToTableWithHisto(h);
            String s = tv.getTuppleID();
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int deleteTva(String idTva, String refUser) throws ErreurDAO {
        Tva tv = new Tva(idTva, 0, null);
        MapHistorique h = new MapHistorique("Tva", "delete", refUser, tv.getTuppleID());
        tv.deleteToTable(h);
        return 1;
    }

    public Tva[] findTva(String idTva, String val, String daty1, String daty2) throws Exception {
        try {
            int a[] = {
                1, 2
            };
            String vala[] = new String[a.length];
            vala[0] = idTva;
            vala[1] = val;
            TvaUtil su = new TvaUtil();
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Tva atva[] = (Tva[]) su.rechercher(a, vala, " order by datydebutvalid desc");
                return atva;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Tva atva1[] = (Tva[]) su.rechercher(a, vala, String.valueOf(String.valueOf((new StringBuffer(" and datydebutvalid>='")).append(daty1).append("' order by datydebutvalid desc"))));
                return atva1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Tva atva2[] = (Tva[]) su.rechercher(a, vala, String.valueOf(String.valueOf((new StringBuffer(" and datydebutvalid<='")).append(daty2).append("' order by datydebutvalid desc"))));
                return atva2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Tva atva3[] = (Tva[]) su.rechercher(a, vala, String.valueOf(String.valueOf((new StringBuffer(" and datydebutvalid>='")).append(daty1).append("' and datydebutvalid<='").append(daty2).append("' order by datydebutvalid desc"))));
                return atva3;
            } else {
                Tva atva4[] = null;
                return atva4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Societe findMaSociete(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit) throws Exception {
        try {
            int a[] = {
                1, 2, 13, 4, 5, 9, 10, 11, 16, 17
            };
            String val[] = new String[a.length];
            val[0] = idMaSociete;
            val[1] = nomMaSociete;
            val[2] = numCompte;
            val[3] = adr;
            val[4] = tel;
            val[5] = numStat;
            val[6] = nif;
            val[7] = rc;
            val[8] = tp;
            val[9] = quit;
            SocieteUtil cu = new SocieteUtil();
            Societe societe = (Societe) cu.rechercher(a, val)[0];
            Societe societe1 = societe;
            return societe1;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Societe[] findMaSocieteTab(String idMaSociete, String nomMaSociete, String numCompte, String tel, String adr, String numStat, String nif, String rc, String tp, String quit, String entite) throws Exception {
        try {
            int a[] = {
                1, 2, 13, 4, 5, 9, 10, 11, 16, 17, 18
            };
            String val[] = new String[a.length];
            val[0] = idMaSociete;
            val[1] = nomMaSociete;
            val[2] = numCompte;
            val[3] = adr;
            val[4] = tel;
            val[5] = numStat;
            val[6] = nif;
            val[7] = rc;
            val[8] = tp;
            val[9] = quit;
            val[10] = entite;
            SocieteUtil cu = new SocieteUtil();
            Societe[] societe = (Societe[]) cu.rechercher(a, val);
            return societe;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String updateMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty, String refUser) throws Exception {
        try {
            Societe s = new Societe(d, no, reg, adr, phone, fa, mai, ger, ni, sta, r, cap, b1, b2, log, t, q, entite);
            MapHistorique h = new MapHistorique("Société", "update", refUser, s.getTuppleID());
            s.updateToTableWithHisto(h);
            String s1 = s.getTuppleID();
            return s1;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createMaSociete(String d, String no, String reg, String adr, String phone, String fa, String mai, String ger, String ni, String sta, String r, String cap, String b1, String b2, String log, String t, String q, String entite, String daty, String refUser) throws Exception {
        try {
            Societe s = new Societe(no, reg, adr, phone, fa, mai, ger, ni, sta, r, cap, b1, b2, log, t, q, entite);
            if (findMaSocieteTab("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", entite).length > 0) {
                throw new Exception("Conflit avec l'entité");
            }
            MapHistorique h = new MapHistorique("Société", "insert", refUser, s.getTuppleID());
            s.insertToTable(h);
            String s1 = s.getTuppleID();
            return s1;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public ParametreFacture findParametreFactureEnCours(String daty) {
        return null;
    }

    public ParametreFacture loadParametreFacture(String daty1) throws Exception {
        try {
            if (String.valueOf(daty1).compareTo("") == 0 || daty1 == null) {
                daty1 = Utilitaire.formatterDaty(Utilitaire.dateDuJourSql());
            }
            ParametreFactureUtil pu = new ParametreFactureUtil();
            int a[] = {
                1
            };
            String val[] = new String[1];
            val[0] = "%";
            ParametreFacture parametrefacture = (ParametreFacture) pu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dateDebutValid<='")).append(daty1).append("' order by dateDebutValid desc,idParametreFacture desc"))))[0];
            return parametrefacture;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public ParametreFacture loadParametreFacture(String daty1, Connection c) throws Exception {
        try {
            if (String.valueOf(daty1).compareTo("") == 0 || daty1 == null) {
                daty1 = Utilitaire.formatterDaty(Utilitaire.dateDuJourSql());
            }
            ParametreFactureUtil pu = new ParametreFactureUtil();
            int a[] = {
                1
            };
            String val[] = new String[1];
            val[0] = "%";
            ParametreFacture parametrefacture = (ParametreFacture) pu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and dateDebutValid<='")).append(daty1).append("' order by dateDebutValid desc,idParametreFacture desc"))), c)[0];
            return parametrefacture;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public Service loadServiceValide(String datyInf, String designation, String idClient) throws Exception {
        try {
            ServiceUtil su = new ServiceUtil();
            int a[] = {
                5, 9
            };
            String val[] = new String[2];
            val[0] = designation;
            val[1] = idClient;
            Service service = (Service) su.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutvalid<='")).append(datyInf).append("' order by datyDebutvalid desc,idService desc"))))[0];
            return service;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public FactMere[] findFactMereNonReglee(String datyinf, String datySup, String idFactureMere, String s, String s1, String s2) {
        return null;
    }

    public FactMere[] findFactureValide(String datyinf, String datySup, String idFactureMere, String client, String etat, String sCatService) throws Exception {
        try {
            int a[] = {
                1, 5, 12, 15
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etat;
            val[3] = sCatService;
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("FACTUREVALIDE");
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
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public double getRAPFacture(FactMere f, String daty) {
        try {
            finance.Entree e[] = FinanceEjbClient.getInterface().findEntree("%", "", daty, "%", "tEnt1", "%", "%", f.getTuppleID(), "%", "%", "eta2");
            double paye = AdminEntree.getSommeEntree(e);
            double avoir = AdminAvoir.getSommeMontantAvoir(findAvoir("%", f.getTuppleID(), "%", "", "", "%", "%"));
            double d1 = f.getMontantTtc() - paye - avoir;
            return d1;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        double d = 0.0D;
        return d;
    }

    public Change[] findChange(String idChange, String idDevise, String datyInf) throws Exception {
        try {
            ChangeUtil cu = new ChangeUtil();
            Change c = null;
            int a[] = {
                1, 2
            };
            String val[] = new String[a.length];
            val[0] = idChange;
            val[1] = idDevise;
            if (datyInf.compareTo("") == 0) {
                Change achange[] = (Change[]) cu.rechercher(a, val, "  order by datyDebutvalid desc");
                return achange;
            }
            if (datyInf.compareTo("") > 0) {
                Change achange1[] = (Change[]) cu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutvalid<='")).append(datyInf).append("' order by datyDebutvalid desc"))));
                return achange1;
            } else {
                Change achange2[] = null;
                return achange2;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public double calculMontantFactureTTC(FactMere fm) throws Exception {
        try {
            Change ch = null;
            FactureFille fille[] = findFactureFille("%", "%", "%", fm.getTuppleID());
            double montantDevise = AdminFacture.calculSommeFacture(fille);
            double montantHT = 0.0D;
            montantHT = montantDevise * fm.getChange(fm.getIdDeviseEn(), fm.getIdFactureEn());
            //System.out.println("getchange=".concat(String.valueOf(String.valueOf(fm.getChange(fm.getIdDeviseEn(), fm.getIdFactureEn())))));
            double montantRe = (montantHT * (double) fm.getReduction()) / (double) 100;
            double retour = (montantHT - montantRe) * ((double) 1 + (double) fm.getTva().getValTva() / (double) 100);
            double d = retour;
            return d;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String makeIndiceFacture(Date daty1, String modePaye, String idScat) {
        String retour = null;
        String daty = Utilitaire.formatterDaty(daty1);
        if (modePaye.compareToIgnoreCase("typ01") == 0) {
            retour = "1";
        }
        if (modePaye.compareToIgnoreCase("typ02") == 0) {
            retour = "2";
        }
        String an = Utilitaire.getAnnee(daty);
        String mois = Utilitaire.getMois(daty);
        retour = String.valueOf(retour) + String.valueOf(String.copyValueOf(an.toCharArray(), 2, 2));
        retour = String.valueOf(retour) + String.valueOf(mois);
        retour = String.valueOf(retour) + String.valueOf(idScat);
        return retour;
    }

    public String makeIndiceFactureEntite(Date daty1, String modePaye, String idScat, String entite) {
        String retour = null;
        String daty = Utilitaire.formatterDaty(daty1);
        if (modePaye.compareToIgnoreCase("typ01") == 0) {
            retour = "1";
        }
        if (modePaye.compareToIgnoreCase("typ02") == 0) {
            retour = "2";
        }
        String an = Utilitaire.getAnnee(daty);
        String mois = Utilitaire.getMois(daty);
        retour = String.valueOf(retour) + String.valueOf(String.copyValueOf(an.toCharArray(), 2, 2));
        retour = String.valueOf(retour) + String.valueOf(mois);
        retour = String.valueOf(retour) + String.valueOf(idScat);
        retour = String.valueOf(retour) + String.valueOf(entite);
        return retour;
    }

    public String finaliseFactureConnection(String idFacture, String user, Connection c) throws Exception {
        try {
            FactMere fm = findFactureMere("", "", idFacture, "%", "", "%", "%", "%")[0];
            FactMere ffin = new FactMere(fm.getTuppleID(), fm.getDaty(), fm.getPeriodeDebut(), fm.getPeriodeFin(), fm.getIdClient(), fm.getNoteExplicative(), fm.getIdTva(), fm.getIdFactureEn(), fm.getIdDeviseEn(), fm.getReduction(), fm.getIdCoursChange(), fm.getIdEtat(), fm.getDateLimitePaiement(), fm.getMontantAPayer(), fm.getIdSCatService(), fm.getIdTypePaiement(), fm.getResp(), fm.getEntite(), fm.getParution());
            FactureFille ff[] = null;
            ff = fm.getFactureFille();
            double montantAP = fm.getMontantTtc();
            if (fm.getIdEtat().compareToIgnoreCase("eta4") == 0) {
                throw new Exception("Facture déjà finalisée");
            }
            if (montantAP <= (double) 0) {
                throw new Exception("Facture de montant égal à 0");
            }
            ffin.setNomProcedureSequence("getSeqFactureFinalise");
            SCatService scc = findSCatService(ffin.getIdSCatService(), "", "", "")[0];
            ffin.setIndicePk(makeIndiceFacture(ffin.getDaty(), ffin.getIdTypePaiement(), Utilitaire.getDebutmot(scc.getNomSCatService())));
            ffin.setIdEtat("eta4");
            ffin.setIdFactureMere(ffin.makePK());
            ffin.setMontantAPayer(montantAP);
            ffin.insertToTable(c);
            for (int g = 0; g < ff.length; g++) {
                ff[g].setIdFactureMere(ffin.getTuppleID());
                ff[g].updateToTable(c);
            }

            MapHistorique hfm = new MapHistorique("factureMere", "finalise", user, ffin.getTuppleID());
            hfm.insertToTable(c);
            fm.deleteToTable(c);
            HistoriqueEtat he = new HistoriqueEtat(idFacture, user, "eta4", Utilitaire.dateDuJourSql());
            MapHistorique hhe = new MapHistorique("HistoriqueEtat", "create", user, he.getTuppleID());
            he.insertToTable(c);
            hhe.insertToTable(c);
            Compte compteFact = findCompte("%", "%", ffin.getIdSCatService(), Utilitaire.dateDuJour())[0];
            Compte compteClient = findCompte("%", "%", ffin.getIdClient(), Utilitaire.dateDuJour())[0];
            Compte compteTva = findCompte("%", "%", "TVA", Utilitaire.dateDuJour())[0];
            Compte compteVirement = findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
            createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantHTva()), ffin.getTuppleID(), user, c);
            createEcritureConnection(Utilitaire.dateDuJour(), compteTva.getId(), "TVA sur facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantTva()), ffin.getTuppleID(), user, c);
            if (ffin.getIdTypePaiement().compareTo("typ01") == 0) {
                createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtc()), "0", ffin.getTuppleID(), user, c);
            } else {
                createEcritureConnection(Utilitaire.dateDuJour(), compteVirement.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtc()), "0", ffin.getTuppleID(), user, c);
            }
            String s = ffin.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String finaliseFacture(String idFacture, String user) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            String retour = finaliseFactureConnection(idFacture, user, c);
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

    public String finaliseFactureUpdateConn(String idFacture, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String user, Connection c) throws Exception {
        try {
            Date dte = Utilitaire.string_date("dd/MM/yyyy", daty);
            Date periodeF = Utilitaire.string_date("dd/MM/yyyy", periodeFin);
            if ((idSCatService.compareToIgnoreCase("scat2") == 0 || idSCatService.compareToIgnoreCase("scat1") == 0) && verifChevauch(periodeDebut, periodeFin, idSCatService) != 0) {
                throw new Exception("Existance de chevauchement");
            }
            //
            ParametreFacture pf = loadParametreFacture(periodeDebut, c);
            int duree = pf.getDelaiPaiement();
            ParametrePenalite ppen = PenaliteEjbClient.getInterface().loadParametrePenalite(periodeDebut);
            int dureePen = ppen.getDelaiPaiementPenalite();
            //
            FactMere fm = findFactureMere("", "", idFacture, "%", "", "%", "%", "%")[0];
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

            //
            if (fm.getIdSCatService().compareToIgnoreCase("scat3") == 0) {
                fm.setDateLimitePaiement(Utilitaire.ajoutMoisDate(fm.getDaty(), dureePen));
            } else {
                fm.setDateLimitePaiement(Utilitaire.ajoutJourDate(fm.getDaty(), duree));
            }
            //
            FactMere ffin = new FactMere(fm.getTuppleID(), fm.getDaty(), fm.getPeriodeDebut(), fm.getPeriodeFin(), fm.getIdClient(), fm.getNoteExplicative(), fm.getIdTva(), fm.getIdFactureEn(), fm.getIdDeviseEn(), fm.getReduction(), fm.getIdCoursChange(), fm.getIdEtat(), fm.getDateLimitePaiement(), fm.getMontantAPayer(), fm.getIdSCatService(), fm.getIdTypePaiement(), fm.getResp(), fm.getEntite(), fm.getParution());
            FactureFille ff[] = null;
            ff = fm.getFactureFille(c);
            double montantAP = fm.getMontantTtc();
            if (fm.getIdEtat().compareToIgnoreCase("eta4") == 0) {
                throw new Exception("Facture déjà finalisée");
            }
            if (montantAP <= (double) 0) {
                throw new Exception("Facture de montant égal à 0");
            }
            ffin.setNomProcedureSequence("getSeqFactureFinalise");
            SCatService scc = findSCatService(ffin.getIdSCatService(), "", "", "")[0];
            TypeObjetUtil tu = new TypeObjetUtil();
            tu.setNomTable("beneficiaire");
            bean.TypeObjet ben = (TypeObjet) tu.rechercher(1, ffin.getEntite())[0];
            ffin.setIndicePk(makeIndiceFactureEntite(ffin.getDaty(), ffin.getIdTypePaiement(), Utilitaire.getDebutmot(scc.getNomSCatService()), Utilitaire.getDebutMots(ben.getDesce())));

            ffin.setIdEtat("eta4");
            ffin.setIdFactureMere(ffin.makePKCFinEntite(daty, ffin.getEntite()));
            ffin.setMontantAPayer(montantAP);
            ffin.insertToTable(c);
            for (int g = 0; g < ff.length; g++) {
                ff[g].setIdFactureMere(ffin.getTuppleID());
                ff[g].updateToTable(c);
            }

            MapHistorique hfm = new MapHistorique("factureMere", "finalise", user, ffin.getTuppleID());
            hfm.insertToTable(c);
            fm.deleteToTable(c);
            HistoriqueEtat he = new HistoriqueEtat(idFacture, user, "eta4", Utilitaire.dateDuJourSql());
            MapHistorique hhe = new MapHistorique("HistoriqueEtat", "create", user, he.getTuppleID());
            he.insertToTable(c);
            hhe.insertToTable(c);
            Compte compteFact = findCompte("%", "%", ffin.getIdSCatService(), Utilitaire.dateDuJour())[0];
            Compte compteClient = findCompte("%", "%", ffin.getIdClient(), Utilitaire.dateDuJour())[0];
            Compte compteTva = findCompte("%", "%", "TVA", Utilitaire.dateDuJour())[0];
            Compte compteVirement = findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
            createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantHTva()), ffin.getTuppleID(), user, c);
            createEcritureConnection(Utilitaire.dateDuJour(), compteTva.getId(), "TVA sur facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantTva()), ffin.getTuppleID(), user, c);
            if (ffin.getIdTypePaiement().compareTo("typ01") == 0) {
                createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtc()), "0", ffin.getTuppleID(), user, c);
            } else {
                createEcritureConnection(Utilitaire.dateDuJour(), compteVirement.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtc()), "0", ffin.getTuppleID(), user, c);
            }
            ffin.makePK();
            String s = ffin.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String finaliseFactureUpdate(String idFacture, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String user) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            String retour = finaliseFactureUpdateConn(idFacture, daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, user, c);
            FactMere[] fm = (FactMere[]) new FactureMereUtil().rechercher(1, retour, c);
            if (fm.length == 0) {
                throw new Exception("Facture mere " + retour + " non existante");
            }
            //public FactureFournisseur(String nomTable,String numFact,String designation,String dE, String dR, String idFrns,String idTVA,String mTTC,String rmq, String idDevise)
            facturefournisseur.FactureFournisseur fc = new facturefournisseur.FactureFournisseur(utilitaire.Constante.factureClient, retour, "facture client auto selon " + retour, daty, daty, fm[0].getIdClient(), String.valueOf(fm[0].getMontantTva()), String.valueOf(fm[0].getMontantTtc()), fm[0].getResp(), fm[0].getIdDeviseEn());
            fc.setResp(fm[0].getResp());
            fc.insertToTableWithHisto(user, c);
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

    public Tva loadTva(String daty1) throws Exception {
        try {
            TvaUtil tvu = new TvaUtil();
            int a[] = {
                1
            };
            String val[] = new String[a.length];
            val[0] = "%";
            Tva tva = (Tva) tvu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutValid<='")).append(daty1).append("' order by datyDebutValid desc,idTva desc"))))[0];
            return tva;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createFacturePenalite(String idPenalite, String refUser) throws Exception {
        Penalite pen = null;
        Tva tvaaa = null;
        String daty_anio = Utilitaire.dateDuJour();
        try {
            tvaaa = loadTva(daty_anio);
            PenaliteEjb pl = null;
            pl = PenaliteEjbClient.getInterface();
            pen = pl.findPenalite(idPenalite, "", "", "%", "", "%", "%", "", "", "")[0];
            String idfm = createFactureMere(daty_anio, Utilitaire.formatterDaty(pen.getDateDebut()), Utilitaire.formatterDaty(pen.getDateFin()), "clt1", pen.getDesignation(), String.valueOf(tvaaa.getValTva()), "Ar", "Ar", "0", pen.getIdSCatService(), "typ01", null, "ent1", "parution", refUser);
            String retour = createFactureFille(idfm, idPenalite, pen.getDesignation(), "1", "unt5", String.valueOf(pen.getMontant()), "0", refUser);
            String s = idfm;
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFacture(String idFact, String daty1, String daty2, String etat, String clien) throws Exception {
        try {
            int a[] = {
                1, 3
            };
            String val[] = new String[a.length];
            val[0] = idFact;
            val[1] = clien;
            EtatFactureUtil fmu = new EtatFactureUtil();
            String chaine = "";
            if (etat.compareTo("oui") == 0) {
                chaine = " and reste=0";
            }
            if (etat.compareTo("non") == 0) {
                chaine = " and reste>0";
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf(chaine)).concat(" order by daty desc"));
                return aetatfacture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture1[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty>= '").append(daty1).append("'  order by daty desc"))));
                return aetatfacture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                EtatFacture aetatfacture2[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty<= '").append(daty2).append("'  order by daty desc"))));
                return aetatfacture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                EtatFacture aetatfacture3[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty>= '").append(daty1).append("'  and daty<= '").append(daty2).append("'  order by daty desc"))));
                return aetatfacture3;
            } else {
                EtatFacture aetatfacture4[] = null;
                return aetatfacture4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureResp(String idFact, String daty1, String daty2, String etat, String clien, String resp) throws Exception {
        try {
            int a[] = {
                1, 3, 14
            };
            String val[] = new String[a.length];
            val[0] = idFact;
            val[1] = clien;
            val[2] = resp;
            EtatFactureUtil fmu = new EtatFactureUtil();
            fmu.setNomTable("etatFactureResp");
            String chaine = "";
            if (etat.compareTo("oui") == 0) {
                chaine = " and reste=0";
            }
            if (etat.compareTo("non") == 0) {
                chaine = " and reste>0";
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf(chaine)).concat(" order by daty desc"));
                return aetatfacture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture1[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty>= '").append(daty1).append("'  order by daty desc"))));
                return aetatfacture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                EtatFacture aetatfacture2[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty<= '").append(daty2).append("'  order by daty desc"))));
                return aetatfacture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                EtatFacture aetatfacture3[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty>= '").append(daty1).append("'  and daty<= '").append(daty2).append("'  order by daty desc"))));
                return aetatfacture3;
            } else {
                EtatFacture aetatfacture4[] = null;
                return aetatfacture4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureRespTypeEntite(String idFact, String daty1, String daty2, String etat, String clien, String resp, String type, String entite, String parution) throws Exception {
        try {
            int a[] = {
                1, 3, 14, 12, 15, 16
            };
            String val[] = new String[a.length];
            val[0] = idFact;
            val[1] = clien;
            val[2] = resp;
            val[3] = type;
            val[4] = entite;
            val[5] = parution;
            EtatFactureUtil fmu = new EtatFactureUtil();
            fmu.setNomTable("etatFactureRespEntite");
            fmu.utiliserChampBase();
            String chaine = "";
            if (etat.compareTo("oui") == 0) {
                chaine = " and reste=0";
            }
            if (etat.compareTo("non") == 0) {
                chaine = " and reste>0";
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf(chaine)).concat(" order by daty desc"));
                return aetatfacture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture1[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty>= '").append(daty1).append("'  order by daty desc"))));
                return aetatfacture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                EtatFacture aetatfacture2[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty<= '").append(daty2).append("'  order by daty desc"))));
                return aetatfacture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                EtatFacture aetatfacture3[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(chaine)))).append(" and daty>= '").append(daty1).append("'  and daty<= '").append(daty2).append("'  order by daty desc"))));
                return aetatfacture3;
            } else {
                EtatFacture aetatfacture4[] = null;
                return aetatfacture4;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureTaxe(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise) throws Exception {
        try {
            int a[] = {
                1, 3, 11, 12, 5
            };
            String val[] = new String[a.length];
            val[0] = idFact;
            val[1] = clien;
            val[2] = etat;
            val[3] = scat;
            val[4] = devise;
            EtatFactureUtil fmu = new EtatFactureUtil();
            fmu.setNomTable("ETATFACTURERESPENTITE");
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture[] = (EtatFacture[]) fmu.rechercher(a, val, " order by idFactureMere desc");
                return aetatfacture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture1[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>= '")).append(daty1).append("'  order by idFactureMere desc"))));
                return aetatfacture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                EtatFacture aetatfacture2[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<= '")).append(daty2).append("'  order by idFactureMere desc"))));
                return aetatfacture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                EtatFacture aetatfacture3[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>= '")).append(daty1).append("'  and daty<= '").append(daty2).append("'  order by idFactureMere desc"))));
                return aetatfacture3;
            } else {
                EtatFacture aetatfacture4[] = null;
                return aetatfacture4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public EtatFacture[] findEtatFactureTaxeRespEntite(String idFact, String daty1, String daty2, String etat, String clien, String scat, String devise, String resp, String entite, String parution) throws Exception {
        try {
            int a[] = {
                1, 3, 11, 12, 5, 14, 15, 16
            };
            String val[] = new String[a.length];
            val[0] = idFact;
            val[1] = clien;
            val[2] = etat;
            val[3] = scat;
            val[4] = devise;
            val[5] = resp;
            val[6] = entite;
            val[7] = parution;
            EtatFactureUtil fmu = new EtatFactureUtil();
            fmu.setNomTable("ETATFACTURERESPENTITE");
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture[] = (EtatFacture[]) fmu.rechercher(a, val, " order by idFactureMere desc");
                return aetatfacture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                EtatFacture aetatfacture1[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>= '")).append(daty1).append("'  order by idFactureMere desc"))));
                return aetatfacture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                EtatFacture aetatfacture2[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<= '")).append(daty2).append("'  order by idFactureMere desc"))));
                return aetatfacture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                EtatFacture aetatfacture3[] = (EtatFacture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>= '")).append(daty1).append("'  and daty<= '").append(daty2).append("'  order by idFactureMere desc"))));
                return aetatfacture3;
            } else {
                EtatFacture aetatfacture4[] = null;
                return aetatfacture4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Change[] findChange(String idChange, String etat) throws Exception {
        try {
            ChangeUtil cu = new ChangeUtil();
            Change c = null;
            int a[] = {
                1, 4
            };
            String val[] = new String[a.length];
            val[0] = idChange;
            val[1] = etat;
            Change achange[] = (Change[]) cu.rechercher(a, val, " order by datydebutvalid desc");
            return achange;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createEcritureConnection(String daty, String compte, String libelle, String debit, String credit, String piece, String refUser, Connection c) throws Exception {
        try {
            Ecriture e = new Ecriture(Utilitaire.string_date("dd/MM/yyyy", daty), compte, libelle, Utilitaire.stringToDouble(debit), Utilitaire.stringToDouble(credit), piece);
            MapHistorique h = new MapHistorique("Ecriture", "insert", refUser, e.getTuppleID());
            e.insertToTable(c);
            h.insertToTable(c);
            String s = e.getTuppleID();
            return s;
        } catch (ErreurDAO ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public String createEcriture(String daty, String compte, String libelle, String debit, String credit, String piece, String refUser) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(true);
            retour = createEcritureConnection(daty, compte, libelle, debit, credit, piece, refUser, c);
            String s = retour;
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                throw new Exception(ex.getMessage());
            }
        }
    }

    public String createCompteConnection(String val, String desc, String datyDebutVal, String refUser, Connection c) throws Exception {
        Compte temp[] = null;
        try {
            //temp = findCompte("%", val, "%", "");
            Compte crt = new Compte();
            crt.setVal(val);
            temp = (Compte[]) (CGenUtil.rechercher(crt, null, null, c, ""));
            //System.out.println("Nombre de temp "+temp.length+ "val=========="+val);
            if (temp.length > 0) {
                //System.out.println("temp[0]=========" + temp[0].getVal());
                throw new Exception("Compte déjà existante!");
            } else {
                Compte cmpte = new Compte(val, desc, Utilitaire.string_date("dd/MM/yyyy", datyDebutVal));
                MapHistorique h = new MapHistorique("Compte", "insert", refUser, cmpte.getTuppleID());
                cmpte.insertToTable(c);
                h.insertToTable(c);
                String s = cmpte.getTuppleID();
                return s;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createCompte(String val, String desc, String datyDebutVal, String refUser) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            retour = createCompteConnection(val, desc, datyDebutVal, refUser, c);
            c.commit();
            String s = retour;
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            try {
                c.close();
            } catch (SQLException ex) {
                throw new Exception(ex.getMessage());
            }
        }
    }

    public Ecriture[] findEcriture(String idEcriture, String daty1, String daty2, String libelle, String compte, String piece) throws Exception {
        try {
            int a[] = {
                3, 4, 7, 1
            };
            String val[] = new String[a.length];
            val[0] = compte;
            val[1] = libelle;
            val[2] = piece;
            val[3] = idEcriture;
            EcritureUtil fmu = new EcritureUtil();
            Ecriture retour[] = null;
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") == 0)) {
                Ecriture aecriture[] = (Ecriture[]) fmu.rechercher(a, val, " order by idEcriture desc");
                return aecriture;
            }
            if ((daty1.compareTo("") > 0) & (daty2.compareTo("") == 0)) {
                Ecriture aecriture1[] = (Ecriture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>= '")).append(daty1).append("'  order by idEcriture desc"))));
                return aecriture1;
            }
            if ((daty1.compareTo("") == 0) & (daty2.compareTo("") > 0)) {
                Ecriture aecriture2[] = (Ecriture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<= '")).append(daty2).append("'  order by idEcriture desc"))));
                return aecriture2;
            }
            if ((daty1.compareTo("") != 0) & (daty2.compareTo("") != 0)) {
                Ecriture aecriture3[] = (Ecriture[]) fmu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>= '")).append(daty1).append("'  and daty<= '").append(daty2).append("'  order by idEcriture desc"))));
                return aecriture3;
            } else {
                Ecriture aecriture4[] = null;
                return aecriture4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Compte[] findCompte(String id, String type, String desc, String daty) throws Exception {
        try {
            int a[] = {
                1, 2, 3
            };
            String val[] = new String[a.length];
            val[0] = id;
            val[1] = type;
            val[2] = desc;
            CompteUtil cu = new CompteUtil();
            if (daty.compareTo("") == 0) {
                Compte acompte[] = (Compte[]) cu.rechercher(a, val, "  order by datyDebutvalid desc");
                if (acompte.length == 0) {
                    acompte = new Compte[1];
                    acompte[0] = new Compte(desc);
                }
                return acompte;
            }
            if (daty.compareTo("") > 0) {
                Compte acompte1[] = (Compte[]) cu.rechercher(a, val, " and datyDebutvalid<='" + daty + "' order by datyDebutvalid desc");
                if (acompte1.length == 0) {
                    acompte1 = new Compte[1];
                    acompte1[0] = new Compte(desc);
                }
                return acompte1;
            } else {
                Compte acompte2[] = null;
                return acompte2;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createAvoir(String idFact, String resp, String da, String mot, String mont, String typ, String refUser) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            Avoir av = new Avoir(idFact, resp, da, mot, mont, typ);
            MapHistorique h = new MapHistorique("Avoir", "insert", refUser, av.getTuppleID());
            double montD = 0.0D;
            FactMere temp[] = findFactureValide("", "", idFact, "%", "%", "%");
            FactMere fm = null;
            if (temp.length == 0) {
                throw new Exception("Facture non existante ou annulée");
            }
            fm = temp[0];
            montD = Utilitaire.stringToDouble(mont);
            if (montD > fm.getMontantAPayer()) {
                throw new Exception("Montant non valide");
            }
            Compte compteFact = findCompte("%", "%", fm.getIdSCatService(), Utilitaire.dateDuJour())[0];
            Compte compteClient = findCompte("%", "%", fm.getIdClient(), Utilitaire.dateDuJour())[0];
            Compte compteAvoirExt = findCompte("%", "%", "Avoir externe", Utilitaire.dateDuJour())[0];
            if (typ.compareTo("interne") == 0) {
                if (da.compareTo(Utilitaire.formatterDaty(fm.getDaty())) != 0) {
                    throw new Exception("Ne peut créer avoir interne: date invalide.");
                }
                av.setMontant(fm.getMontantAPayer());
                annulationFactureAvoir(idFact, av.getTuppleID(), refUser);
            } else if (typ.compareTo("externe") == 0) {
                if (montD - fm.getMontantAPayer() == (double) 0) {
                    annulationFacture(idFact, refUser);
                }
                if (montD - fm.getRAP() == (double) 0) {
                    fm.setIdEtat("eta3");
                    fm.updateToTable(c);
                }
                createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Avoir sur facture num ".concat(String.valueOf(String.valueOf(fm.getTuppleID()))), mont, "0", av.getTuppleID(), refUser, c);
                createEcritureConnection(Utilitaire.dateDuJour(), compteAvoirExt.getId(), "Avoir externe facture num ".concat(String.valueOf(String.valueOf(fm.getTuppleID()))), "0", mont, av.getTuppleID(), refUser, c);
            } else {
                throw new Exception("Type non valide");
            }
            av.insertToTable(c);
            h.insertToTable(c);
            c.commit();
            String s = av.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw new Exception(ex.getMessage());
        } finally {
            c.close();
        }
    }

    public String updateAvoir(String idAv, String idFact, String resp, String da, String mot, String mont, String refUser) throws Exception {
        try {
            Avoir av = new Avoir(idAv, idFact, resp, da, mot, mont);
            MapHistorique h = new MapHistorique("Avoir", "update", refUser, av.getTuppleID());
            av.updateToTableWithHisto(h);
            String s = av.getTuppleID();
            return s;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Avoir[] findAvoir(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 5, 7
            };
            String val[] = new String[a.length];
            val[0] = idAv;
            val[1] = idFact;
            val[2] = resp;
            val[3] = mot;
            val[4] = typ;
            AvoirUtil avu = new AvoirUtil();
            if ((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0)) {
                Avoir aavoir[] = (Avoir[]) avu.rechercher(a, val, " order by IDFACTUREMERE asc");
                return aavoir;
            }
            if ((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0)) {
                Avoir aavoir1[] = (Avoir[]) avu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyDebut).append("' order by IDFACTUREMERE asc"))));
                return aavoir1;
            }
            if ((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0)) {
                Avoir aavoir2[] = (Avoir[]) avu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(datyFin).append("' order by IDFACTUREMERE asc"))));
                return aavoir2;
            }
            if ((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0)) {
                Avoir aavoir3[] = (Avoir[]) avu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyDebut).append("' and daty<='").append(datyFin).append("' order by IDFACTUREMERE asc"))));
                return aavoir3;
            } else {
                Avoir aavoir4[] = null;
                return aavoir4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Avoir[] findAvoirValide(String idAv, String idFact, String resp, String datyDebut, String datyFin, String mot, String typ) throws Exception {
        try {
            int a[] = {
                1, 2, 3, 5, 7
            };
            String val[] = new String[a.length];
            val[0] = idAv;
            val[1] = idFact;
            val[2] = resp;
            val[3] = mot;
            val[4] = typ;
            AvoirUtil avu = new AvoirUtil();
            avu.setNomTable("Avoirvalide");
            if ((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0)) {
                Avoir aavoir[] = (Avoir[]) avu.rechercher(a, val, " order by IDFACTUREMERE asc");
                return aavoir;
            }
            if ((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0)) {
                Avoir aavoir1[] = (Avoir[]) avu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyDebut).append("' order by IDFACTUREMERE asc"))));
                return aavoir1;
            }
            if ((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0)) {
                Avoir aavoir2[] = (Avoir[]) avu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(datyFin).append("' order by IDFACTUREMERE asc"))));
                return aavoir2;
            }
            if ((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0)) {
                Avoir aavoir3[] = (Avoir[]) avu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyDebut).append("' and daty<='").append(datyFin).append("' order by IDFACTUREMERE asc"))));
                return aavoir3;
            } else {
                Avoir aavoir4[] = null;
                return aavoir4;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulationAvoir(String idAvoir, String refUser) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            AnnulationAvoir aau = new AnnulationAvoir(idAvoir, Utilitaire.dateDuJour());
            FactMere fm = null;
            Avoir av[] = findAvoir(idAvoir, "%", "%", "", "", "%", "%");
            if (av.length == 0) {
                throw new Exception("Avoir non existante");
            }
            AutorisationAnnulation aut[] = findAutorisationAnnulation("%", idAvoir, "%", "", "", "%", "typOb5");
            if (aut.length == 0) {
                throw new Exception("Vérifiez l'autorisation d'annulation");
            }
            fm = av[0].getFacture();
            //System.out.println("AZO FACTURE ".concat(String.valueOf(String.valueOf(fm.getTuppleID()))));
            MapHistorique h = new MapHistorique("Avoir", "annule", refUser, idAvoir);
            Compte compteFact = findCompte("%", "%", fm.getIdSCatService(), Utilitaire.dateDuJour())[0];
            Compte compteClient = findCompte("%", "%", fm.getIdClient(), Utilitaire.dateDuJour())[0];
            //System.out.println("AZO COMPTE FACT ".concat(String.valueOf(String.valueOf(fm.getIdSCatService()))));
            createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Annulation Avoir sur facture num ".concat(String.valueOf(String.valueOf(fm.getTuppleID()))), "0", String.valueOf(av[0].getMontant()), av[0].getTuppleID(), refUser, c);
            createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Annulation Avoir facture num ".concat(String.valueOf(String.valueOf(fm.getTuppleID()))), String.valueOf(av[0].getMontant()), "0", av[0].getTuppleID(), refUser, c);
            aau.insertToTable(c);
            h.insertToTable(c);
            c.commit();
            int i = 1;
            return i;
        } catch (Exception ex) {
            c.rollback();
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        } finally {
            c.close();
        }
    }

    public int verifExistTypObj(String id, String typ) throws Exception {
        FactureEjb fl = null;
        FinanceEjb fnl = null;
        FactMere fm6[] = null;
        Avoir av6[] = null;
        Compte com6[] = null;
        TypeObjet dev6[] = null;
        finance.Entree en6[] = null;
        finance.Sortie so6[] = null;
        TraficConteneur trf6[] = null;
        Penalite pen6[] = null;
        penalite.Accident ac6[] = null;
        penalite.VolConteneur vo6[] = null;
        penalite.DommageConteneur do6[] = null;
        penalite.ChiffreAffTac chaf6[] = null;
        try {
            if (typ.compareTo("typOb1") == 0) {
                fm6 = findFactureValide("", "", id, "%", "%", "%");
                if (fm6.length > 0) {
                    int i = 1;
                    return i;
                } else {
                    int j = 0;
                    return j;
                }
            }
            if (typ.compareTo("typOb5") == 0) {
                av6 = findAvoirValide(id, "%", "%", "", "", "%", "%");
                if (av6.length > 0) {
                    int k = 1;
                    return k;
                }
            } else if (typ.compareTo("typOb2") == 0) {
                en6 = FinanceEjbClient.getInterface().findEntree(id, "", "", "%", "%", "%", "%", "%", "%");
                if (en6.length > 0) {
                    int l = 1;
                    return l;
                }
            } else if (typ.compareTo("typOb3") == 0) {
                so6 = FinanceEjbClient.getInterface().findSortie(id, "", "", "%", "%", "%", "%", "%", "%", "%");
                if (so6.length > 0) {
                    int i1 = 1;
                    return i1;
                }
            } else if (typ.compareTo("typOb4") == 0) {
                trf6 = PenaliteEjbClient.getInterface().findTrafic(id, "", "", "%");
                if (trf6.length > 0) {
                    int j1 = 1;
                    return j1;
                }
            } else if (typ.compareTo("typOb6") == 0) {
                pen6 = PenaliteEjbClient.getInterface().findPenalite(id, "", "", "%", "%", "%", "%", "%", "%", "%");
                if (pen6.length > 0) {
                    int k1 = 1;
                    return k1;
                }
            } else if (typ.compareTo("typOb7") == 0) {
                dev6 = findDevise(id, "%", "%");
                if (dev6.length > 0) {
                    int l1 = 1;
                    return l1;
                }
            } else if (typ.compareTo("typOb8") == 0) {
                com6 = findCompte(id, "%", "%", "");
                if (com6.length > 0) {
                    int i2 = 1;
                    return i2;
                }
            } else if (typ.compareTo("typOb9") == 0) {
                ac6 = PenaliteEjbClient.getInterface().findAccident(id, "", "", "%", "%");
                if (ac6.length > 0) {
                    int j2 = 1;
                    return j2;
                }
            } else if (typ.compareTo("typOb10") == 0) {
                vo6 = PenaliteEjbClient.getInterface().findVolCont(id, "", "", "%", "%", "%", "%", "%");
                if (vo6.length > 0) {
                    int k2 = 1;
                    return k2;
                }
            } else if (typ.compareTo("typOb11") == 0) {
                do6 = PenaliteEjbClient.getInterface().findDommageConteneur(id, "", "", "%", "%", "%", "%");
                if (do6.length > 0) {
                    int l2 = 1;
                    return l2;
                }
            } else if (typ.compareTo("typOb12") == 0) {
                chaf6 = PenaliteEjbClient.getInterface().findChiffreAffTac(id, "%", "%", "%");
                if (chaf6.length > 0) {
                    int i3 = 1;
                    return i3;
                }
            }
            int j3 = 0;
            return j3;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public Change loadChangeValide(String devise, String datyInf) throws Exception {
        try {
            int a[] = {
                2
            };
            ChangeUtil chu = new ChangeUtil();
            String val[] = new String[a.length];
            val[0] = devise;
            Change change = (Change) chu.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and datyDebutValid<='")).append(datyInf).append("' order by datyDebutValid desc,idChange desc"))))[0];
            return change;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public String createChange(String idDevise, String valeurEnAriary, String datyDebutValid, String refUser) throws Exception {
        try {
            Change ch = new Change(idDevise, Utilitaire.stringToFloat(valeurEnAriary), Utilitaire.string_date("dd/MM/yyyy", datyDebutValid));
            MapHistorique h = new MapHistorique("Change", "insert", refUser, ch.getTuppleID());
            ch.insertToTable(h);
            String s = ch.getTuppleID();
            return s;
        } catch (Exception e) {
            System.out.print(e.getMessage());
            throw new Exception(e.getMessage());
        }
    }

    public String updateChange(String idChange, String idDevise, String valeurEnAriary, String s, String s1) {
        return null;
    }

    public Date generateDateLimiteFactureClient(String periodeDebut, String daty, String idSCatService) throws Exception {
        Date limite = null;
        ParametreFacture pf = loadParametreFacture(periodeDebut);
        ParametrePenalite ppen = PenaliteEjbClient.getInterface().loadParametrePenalite(periodeDebut);
        Date dat = Utilitaire.string_date("dd/MM/yyyy", daty);
        limite = Utilitaire.ajoutJourDate(daty, pf.getDelaiPaiement());
        if (idSCatService.compareToIgnoreCase("scat3") == 0) {
            limite = Utilitaire.ajoutMoisDate(dat, ppen.getDelaiPaiementPenalite());
        }
        return limite;
    }

    public String createFactureMereConnection(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String refUser, Connection c) throws Exception {
        try {
            String idEtat = null;
            Date limite = generateDateLimiteFactureClient(periodeDebut, daty, idSCatService);
            FactMere fm = new FactMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, "eta2", String.valueOf(Utilitaire.formatterDaty(limite)), "0", idSCatService, idTypePaim, respe, entite, parution);
            MapHistorique h = new MapHistorique("FactureMere", "insert", refUser, fm.getTuppleID());
            fm.insertToTable(c);
            h.insertToTable(c);
            String s = fm.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public double calculChange(String valeur, String devise1, String devise2, String daty) throws Exception {
        try {
            Change ch1 = null;
            Change ch2 = null;
            double rapport = 1.0D;
            ch1 = (new ChangeUtil()).loadChangeValide(devise1, daty);
            ch2 = (new ChangeUtil()).loadChangeValide(devise2, daty);
            if (ch2.getValeurEnAriary() == (double) 0) {
                throw new Exception("Taux invalide ou nul!");
            } else {
                rapport = ch1.getValeurEnAriary() / ch2.getValeurEnAriary();
                double d = Utilitaire.stringToDouble(valeur) * rapport;
                return d;
            }
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public int annulerDevise(String idDevise, String refUser) throws Exception {
        Connection c = null;
        TypeObjet to[] = null;
        AutorisationAnnulation aut[] = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            aut = findAutorisationAnnulation("%", idDevise, "%", "", "", "%", "typOb7");
            if (aut.length < 1) {
                throw new ErreurDAO("Vérifiez l'autorisation d'annulation");
            }
            to = findDevise(idDevise, "%", "%");
            if (to.length < 1) {
                throw new ErreurDAO("Vérifiez le numéro d'objet!");
            } else {
                MapHistorique h = new MapHistorique("Devise", "delete", refUser, idDevise);
                to[0].setNomTable("Devise");
                to[0].deleteToTable(h);
                c.commit();
                int i = 1;
                return i;
            }
        } catch (Exception ex) {
            try {
                c.rollback();
                throw new Exception(ex.getMessage());
            } catch (Exception ef) {
                ef.printStackTrace();
                throw new Exception(ef.getMessage());
            } finally {
                try {
                    c.close();
                } catch (SQLException exsq) {
                    throw new Exception(exsq.getMessage());
                }
            }
        }
    }

    public int annulerCompte(String idCompte, String refUser) throws Exception {
        Connection c = null;
        Ecriture ecr[] = null;
        Compte to[] = null;
        AutorisationAnnulation aut[] = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            aut = findAutorisationAnnulation("%", idCompte, "%", "", "", "%", "typOb8");
            if (aut.length < 1) {
                throw new ErreurDAO("Vérifiez l'autorisation d'annulation");
            }
            to = findCompte(idCompte, "%", "%", "");
            if (to.length < 1) {
                throw new ErreurDAO("Vérifiez le numéro d'objet!");
            }
            ecr = findEcriture("%", "", "", "%", to[0].getVal(), "%");
            if (ecr.length > 0) {
                throw new Exception("Vous ne pouvez pas annuler ce compte car il est utilisé.");
            } else {
                MapHistorique h = new MapHistorique("Compte", "delete", refUser, idCompte);
                to[0].deleteToTable(h);
                c.commit();
                int i = 1;
                return i;
            }
        } catch (Exception ex) {
            try {
                c.rollback();
                throw new Exception(ex.getMessage());
            } catch (Exception ef) {
                throw new Exception(ef.getMessage());
            } finally {
                try {
                    c.close();
                } catch (SQLException exsq) {
                    throw new Exception(exsq.getMessage());
                }
            }
        }
    }

    public TypeObjet[] findDevise(String id, String typ, String desc) throws Exception {
        try {
            TypeObjetUtil to = new TypeObjetUtil();
            to.setNomTable("Devise");
            int a[] = {
                1, 2, 3
            };
            String val[] = new String[a.length];
            val[0] = id;
            val[1] = typ;
            val[2] = desc;
            TypeObjet atypeobjet[] = (TypeObjet[]) to.rechercher(a, val);
            return atypeobjet;
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
    }

    public SyntheseEVP[] findSyntheseEVP(String daty1, String daty2) throws Exception {
        Connection c = null;
        String datyDebut = daty1;
        String datyFin = daty2;
        try {
            //c = (new UtilDB()).getConnMaurice();
            c.setAutoCommit(true);
            int a[] = {
                2
            };
            String val[] = new String[a.length];
            val[0] = "%";
            SyntheseEVPUtil au = new SyntheseEVPUtil(c);
            if ((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") == 0)) {
                SyntheseEVP asyntheseevp[] = (SyntheseEVP[]) au.rechercher(a, val, " order by daty desc", c);
                return asyntheseevp;
            }
            if ((datyDebut.compareTo("") > 0) & (datyFin.compareTo("") == 0)) {
                SyntheseEVP asyntheseevp1[] = (SyntheseEVP[]) au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyDebut).append("' order by daty desc"))), c);
                return asyntheseevp1;
            }
            if ((datyDebut.compareTo("") == 0) & (datyFin.compareTo("") > 0)) {
                SyntheseEVP asyntheseevp2[] = (SyntheseEVP[]) au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(datyFin).append("' order by daty desc"))), c);
                return asyntheseevp2;
            }
            if ((datyDebut.compareTo("") != 0) & (datyFin.compareTo("") != 0)) {
                SyntheseEVP asyntheseevp3[] = (SyntheseEVP[]) au.rechercher(a, val, String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(datyDebut).append("' and daty<='").append(datyFin).append("' order by daty desc"))), c);
                return asyntheseevp3;
            }
            SyntheseEVP asyntheseevp4[] = null;
            return asyntheseevp4;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception("Pas de synthese trouvé : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        } finally {
            try {
                c.close();
            } catch (SQLException sqlexception) {
            }
        }
    }

    public FactMere[] findFactureMereNonPaye(String datyinf, String datySup, String idFactureMere, String client, String dateLimite, String etatFacture, String catService, String sCatService) throws Exception {
        try {
            int a[] = {
                1, 20, 12, 15
            };
            String val[] = new String[a.length];
            val[0] = idFactureMere;
            val[1] = client;
            val[2] = etatFacture;
            val[3] = sCatService;
            FactureMereUtil fmu = new FactureMereUtil();
            fmu.setNomTable("FactureMereNonPaye");
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
            throw new Exception("Facture non trouvée : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
    }

    public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String refUser) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            //modepaiement
            FactMere fm = new FactMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, "eta2", dateLimite, "0", idSCatService, idTypePaim, respe, entite, parution);
            fm.setModepaiement(modepaiement);
            MapHistorique h = new MapHistorique("FactureMere", "insert", refUser, fm.getTuppleID());
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

    public String createFactureMereRadio(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String refUser, String[] g, String ttva, String datyparu) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            //modepaiement
            FactMere fm = new FactMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, "eta2", dateLimite, "0", idSCatService, idTypePaim, respe, entite, parution);
            fm.setModepaiement(modepaiement);
            MapHistorique h = new MapHistorique("FactureMere", "insert", refUser, fm.getTuppleID());
            fm.insertToTable(c);
            h.insertToTable(c);
            String s = fm.getTuppleID();

            // creation facture fille multiple 
            String idP = Utilitaire.stringToTab(g, "'", ",");

            PubTopRadio lv = new PubTopRadio();
            lv.setNomTable("pub_topradio_nonor");
            PubTopRadio[] lpub = (PubTopRadio[]) CGenUtil.rechercher(lv, null, null, c, " and id in (" + idP + ")");
            //System.out.println("lpub eto=="+lpub[0].getRemis());
            String couleur = "";

            for (int i = 0; i < lpub.length; i++) {
                String des = lpub[i].getNature() + " " + lpub[i].getDuree() + " secondes - " + lpub[i].getPubtype() + " du " + lpub[i].getDatedebut() + " au " + lpub[i].getDatefin() + " " + lpub[i].getHeure();

                //calculer montant facture;
                double montant = calculerMontantPubRadio(lpub[i].getDuree(), lpub[i].getPubtype(), lpub[i].getNature(), lpub[i].getDatedebut(), lpub[i].getDatefin(), lpub[i].getQuantite(), c);
                if (ttva.compareToIgnoreCase("0") == 0) {
                    retour = createFactureFilleConnection(s, "scat10", des, "1", "unt", montant + "", lpub[i].getRemise() + "", refUser, c);
                } else {
                    retour = createFactureFilleConnection(s, "scat10", des, "1", "unt", montant + "", lpub[i].getRemise() + "", refUser, c);
                }
            }

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

    public String createFactureMereRadio2(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution, String modepaiement, String dateLimite, String refUser, String[] g, String ttva, String datyparu) throws Exception {
        Connection c = null;
        try {
            String retour = null;
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            //modepaiement
            FactMere fm = new FactMere(daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, "eta2", dateLimite, "0", idSCatService, idTypePaim, respe, entite, parution);
            fm.setModepaiement(modepaiement);
            MapHistorique h = new MapHistorique("FactureMere", "insert", refUser, fm.getTuppleID());
            fm.insertToTable(c);
            h.insertToTable(c);
            String s = fm.getTuppleID();

            // creation facture fille multiple 
            String idP = Utilitaire.stringToTab(g, "'", ",");

            PubRadioPartenariatMontant lv = new PubRadioPartenariatMontant();
            lv.setNomTable("pub_radiopart_montant");
            PubRadioPartenariatMontant[] lpub = (PubRadioPartenariatMontant[]) CGenUtil.rechercher(lv, null, null, c, " and id in (" + idP + ")");
            //System.out.println("lpub eto=="+lpub[0].getRemis());
            String couleur = "";

            for (int i = 0; i < lpub.length; i++) {
                String des = lpub[i].getPubtype() + " " + lpub[i].getNature() + " " + lpub[i].getDuree() + " secondes du " + Utilitaire.convertDatyFormtoRealDatyFormat(lpub[i].getDatedebut() + "") + " au " + Utilitaire.convertDatyFormtoRealDatyFormat(lpub[i].getDatefin() + "") + ":" + lpub[i].getHeure();

                //calculer montant facture;
                double montant = lpub[i].getMontant();
                if (lpub[i].getPubtype().compareToIgnoreCase("PARTENARIAT") != 0) {
                    montant = calculerMontantPubRadio2(lpub[i].getDatedebut(), lpub[i].getDatefin(), lpub[i].getHeure().split(";").length, lpub[i].getMontant());
                }
                if (ttva.compareToIgnoreCase("0") == 0) {
                    retour = createFactureFilleConnection(s, "scat10", des, "1", "unt", montant + "", lpub[i].getRemise() + "", refUser, c);
                } else {
                    retour = createFactureFilleConnection(s, "scat10", des, "1", "unt", montant + "", lpub[i].getRemise() + "", refUser, c);
                }
            }

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

    public double calculerMontantPubRadio2(Date dateDebut, Date dateFin, int qtejour, double montantPUB) throws Exception {

        int nombreJour = Utilitaire.diffJourDaty(dateFin, dateDebut); // nombre de jour de diffusion

        // get Montant pub enregistré:
        double montant = 0;
        try {
            int temp = nombreJour * qtejour;
            montant = temp * montantPUB;
            return montant;
        } catch (Exception exc) {
            exc.printStackTrace();
            throw new Exception(exc.getMessage());
        }
    }

    public double calculerMontantPubRadio(String duree, String type, String nature, Date dateDebut, Date dateFin, int qtejour, Connection conection) throws Exception {

        int nombreJour = Utilitaire.diffJourDaty(dateFin, dateDebut); // nombre de jour de diffusion

        // get Montant pub enregistré:
        double montant = 0;
        try {
            PubTarif trf = new PubTarif();
            trf.setNomTable("pub_tarif_libelle");
            PubTarif[] ltrf = (PubTarif[]) CGenUtil.rechercher(trf, null, null, conection, " AND IDTYPE = '" + nature + "' AND DUREE = " + duree + " AND ID_PLAGE_HORAIRE = '" + type + "' ");

            if (ltrf == null || ltrf.length == 0) {
                throw new Exception("Tarif non enregistré");
            } else {
                int temp = nombreJour * qtejour;
                montant = temp * ltrf[0].getMontant();
            }
            return montant;
        } catch (Exception exc) {
            exc.printStackTrace();
            throw new Exception(exc.getMessage());
        }

    }

    public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String modepaiement, String datelimite, String user) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            String retour = finaliseFactureUpdateConn(idFact, daty, periodeDebut, periodeFin, idClient, noteExplicative, idTva, idFactureEn, idDeviseEn, reduction, idSCatService, idTypePaim, modepaiement, datelimite, user, c);
            FactMere[] fm = (FactMere[]) new FactureMereUtil().rechercher(1, retour, c);
            if (fm.length == 0) {
                throw new Exception("Facture mere " + retour + " non existante");
            }
            facturefournisseur.FactureFournisseur fc = new facturefournisseur.FactureFournisseur();
            CaractTable ct = (CaractTable) new bean.CaractTableUtil().rechercher(2, utilitaire.Constante.factureClient, c)[0];
            fc.setIdFournisseur(Client.getIdDyn(fm[0].getIdClient(), c));
            fc.setIndicePk(ct.getNomSeq());
            fc.setNomProcedureSequence(ct.getNomProc());
            fc.setIdFactureFournisseur(fc.makePK(c));
            fc.setMontantTTC(fm[0].getMontantTtc());
            fc.setNumFact(retour);
            if (String.valueOf(daty).compareTo("") == 0 || daty == null) {
                fc.setDateEmission(Utilitaire.dateDuJourSql());
            } else {
                fc.setDateEmission((Utilitaire.string_date("dd/MM/yyyy", daty)));
            }
            fc.setDaty(Utilitaire.string_date("dd/MM/yyyy", daty));
            fc.setIdTVA(fm[0].getMontantTva(c));
            fc.setRemarque(fm[0].getResp());
            fc.setIdDevise(fm[0].getIdDeviseEn());
            fc.setDesignation("facture client auto selon " + retour);

            fc.setNomTable(utilitaire.Constante.factureClient);
            fc.setResp(fm[0].getResp());
            fc.insertToTableWithHisto(user, c);
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

    public String finaliseFactureUpdateConn(String idFacture, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String modepaiement, String datelimite, String user, Connection c) throws Exception {
        try {
            Date dte = Utilitaire.string_date("dd/MM/yyyy", daty);
            Date periodeF = Utilitaire.string_date("dd/MM/yyyy", periodeFin);
            if ((idSCatService.compareToIgnoreCase("scat2") == 0 || idSCatService.compareToIgnoreCase("scat1") == 0) && verifChevauch(periodeDebut, periodeFin, idSCatService) != 0) {
                throw new Exception("Existance de chevauchement");
            }

            FactMere fm = findFactureMere("", "", idFacture, "%", "", "%", "%", "%", c)[0];
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
            fm.setModepaiement(modepaiement);
            fm.setDateLimitePaiement(Utilitaire.string_date("dd/MM/yyyy", datelimite));

            FactMere ffin = new FactMere(fm.getTuppleID(), fm.getDaty(), fm.getPeriodeDebut(), fm.getPeriodeFin(), fm.getIdClient(), fm.getNoteExplicative(), fm.getIdTva(), fm.getIdFactureEn(), fm.getIdDeviseEn(), fm.getReduction(), fm.getIdCoursChange(), fm.getIdEtat(), fm.getDateLimitePaiement(), fm.getMontantAPayer(), fm.getIdSCatService(), fm.getIdTypePaiement(), fm.getResp(), fm.getEntite(), fm.getParution());
            ffin.setModepaiement(fm.getModepaiement());
            FactureFille ff[] = null;
            ff = fm.getFactureFille();
            double montantAP = fm.getMontantTtc();
            if (fm.getIdEtat().compareToIgnoreCase("eta4") == 0) {
                throw new Exception("Facture déjà finalisée");
            }
            if (montantAP <= (double) 0) {
                throw new Exception("Facture de montant égal à 0");
            }
            ffin.setNomProcedureSequence("getSeqFactureFinalise");
            SCatService scc = findSCatService(ffin.getIdSCatService(), "", "", "", c)[0];
            TypeObjetUtil tu = new TypeObjetUtil();
            tu.setNomTable("beneficiaire");
            bean.TypeObjet ben = (TypeObjet) tu.rechercher(1, ffin.getEntite())[0];
            ffin.setIndicePk(makeIndiceFactureEntite(ffin.getDaty(), ffin.getIdTypePaiement(), Utilitaire.getDebutmot(scc.getNomSCatService()), Utilitaire.getDebutMots(ben.getDesce())));

            ffin.setIdEtat("eta4");
            ffin.setIdFactureMere(ffin.makePKCFinEntite(daty, ffin.getEntite(), c));
            ffin.setMontantAPayer(montantAP);
            ffin.insertToTable(c);
            for (int g = 0; g < ff.length; g++) {
                ff[g].setIdFactureMere(ffin.getTuppleID());
                ff[g].updateToTable(c);
            }

            MapHistorique hfm = new MapHistorique("factureMere", "finalise", user, ffin.getTuppleID());
            hfm.insertToTable(c);
            fm.deleteToTable(c);
            HistoriqueEtat he = new HistoriqueEtat(idFacture, user, "eta4", Utilitaire.dateDuJourSql());
            MapHistorique hhe = new MapHistorique("HistoriqueEtat", "create", user, he.getTuppleID());
            he.insertToTable(c);
            hhe.insertToTable(c);
            Compte compteFact = findCompte("%", "%", ffin.getIdSCatService(), Utilitaire.dateDuJour())[0];
            Compte compteClient = findCompte("%", "%", ffin.getIdClient(), Utilitaire.dateDuJour())[0];
            Compte compteTva = findCompte("%", "%", "TVA", Utilitaire.dateDuJour())[0];
            Compte compteVirement = findCompte("%", "%", "Compte de virement", Utilitaire.dateDuJour())[0];
            createEcritureConnection(Utilitaire.dateDuJour(), compteFact.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantHTva()), ffin.getTuppleID(), user, c);
            createEcritureConnection(Utilitaire.dateDuJour(), compteTva.getId(), "TVA sur facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), "0", String.valueOf(ffin.getMontantTva()), ffin.getTuppleID(), user, c);
            if (ffin.getIdTypePaiement().compareTo("typ01") == 0) {
                createEcritureConnection(Utilitaire.dateDuJour(), compteClient.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtc()), "0", ffin.getTuppleID(), user, c);
            } else {
                createEcritureConnection(Utilitaire.dateDuJour(), compteVirement.getId(), "Edition facture num ".concat(String.valueOf(String.valueOf(ffin.getTuppleID()))), String.valueOf(ffin.getMontantTtc()), "0", ffin.getTuppleID(), user, c);
            }
            ffin.makePK();
            String s = ffin.getTuppleID();
            return s;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new Exception(ex.getMessage());
        }
    }

    public int annulationFactureClient(String idFactureClient, String mapUser) throws Exception {
        Connection c = null;
        VisaFactureClient[] visaFact = null;
        UnionIntraTable[] orfclc = null;
        UnionIntraTable[] factureclientlc = null;
        OrdonnerPayement[] ordonnerrecette = null;
        FactureClient[] factureclient = null;
       
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            OrdonnerPayement or = new OrdonnerPayement(); //misy
            or.setNomTable("ordonnerrecette");
            ordonnerrecette = (OrdonnerPayement[]) CGenUtil.rechercher(or, null, null, c, " and ded_id='" + idFactureClient + "'");
            if (ordonnerrecette.length > 0) {
                MvtCaisse mC = new MvtCaisse();
                MvtCaisse[] mvtCaisse = (MvtCaisse[]) CGenUtil.rechercher(mC, null, null, c, " and idordre='" + ordonnerrecette[0].getId() + "'");
                if (mvtCaisse.length > 0) {
                    throw new Exception("OR déjà attaché à un mouvement de caisse.");
                }
            }
            VisaFactureClient vF = new VisaFactureClient(); //tsy misy
            visaFact = (VisaFactureClient[]) CGenUtil.rechercher(vF, null, null, c, " and idobjet='" + idFactureClient + "'");
            if (visaFact.length > 0) {
                visaFact[0].deleteToTable(c); //delete dans VisaFactureClient
            }
            UnionIntraTable of = new UnionIntraTable(); //of.getMontantMere(); of.getMontantMereLettre()
            of.setNomTable("orfclc");
            if (ordonnerrecette.length > 0) {
                orfclc = (UnionIntraTable[]) CGenUtil.rechercher(of, null, null, c, " and id1='" + ordonnerrecette[0].getId() + "'");
                if (orfclc.length > 0) {
                    for (int i = 0; i < orfclc.length; i++) {
                        orfclc[i].deleteToTable(c);//delete dans orfclc
                    }
                }
                ordonnerrecette[0].deleteToTable(c);//delete dans ordonnerrecette
            }
            of.setNomTable("factureclientlc");
            //of.getMontantMere(); of.getMontantMereLettre()
            factureclientlc = (UnionIntraTable[]) CGenUtil.rechercher(of, null, null, c, " and id1 = '" + idFactureClient + "'");
            if (factureclientlc.length > 0) {
                for (int i = 0; i < factureclientlc.length; i++) {
                    factureclientlc[i].deleteToTable(c);//delete dans factureclientlc
                }
            }
            UnionIntraTable pubfacture = new UnionIntraTable();
            pubfacture.setNomTable("PUBFACTURE");
            UnionIntraTable[] listePubFacture = (UnionIntraTable[]) CGenUtil.rechercher(pubfacture, null, null, " and id2='"+idFactureClient+"'");
            if(listePubFacture.length>0){
                listePubFacture[0].deleteToTable(c);
                System.out.println("HERE anaty PUB Facture");
            }
            FactureClient fa = new FactureClient();
            fa.setIdfacturefournisseur(idFactureClient);
            fa.deleteToTableWithHisto(mapUser, c);//delete dans FactureClient

            c.commit();
            int i = 1;
            return i;
        } catch (Exception e) {
            try {
                if (c != null) {
                    c.rollback();
                }
                throw new Exception(e.getMessage());
            } catch (Exception ef) {
                throw new Exception(ef.getMessage());
            } finally {
                try {
                    if (c != null) {
                        c.close();
                    }
                } catch (SQLException exsq) {
                    throw new Exception(exsq.getMessage());
                }
            }
        }

    }

    public void modifierFacture(String idfm, String[] idfactureFille, double[] prixUnitaire, double[] quantite, int[] reduction, double tva, String mapUser) throws Exception {

        Connection c = null;
        int i = 0;
        double montantTva = 0, montantTotal = 0;
        FactureClientComplet fcc = new FactureClientComplet();
        FactureFille ff = new FactureFille();
        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);

            OrdonnerPayement op = new OrdonnerPayement();
            op.setNomTable("ORDONNERRECETTE");
            System.out.println("IDFM anaty modif" + idfm);
            OrdonnerPayement[] top = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, " and DED_ID = '" + idfm + "'");
            if (top.length > 0) {
                MvtCaisse mouvement = new MvtCaisse();
                MvtCaisse[] tmvt = (MvtCaisse[]) CGenUtil.rechercher(mouvement, null, null, c, "and IDORDRE = '" + top[0].getId() + "'");
                if (tmvt != null && tmvt.length > 0) {
                    throw new Exception("La modification de la facture est impossible");
                }
            }
            System.out.println("OK test mouvement caisse");

            fcc.setNomTable("FACTURECLIENT");
            fcc.setIdfacturefournisseur(idfm);
            System.out.println("Avant recherche FC");

            FactureClientComplet[] tfcc = (FactureClientComplet[]) CGenUtil.rechercher(fcc, null, null, c, " and idfacturefournisseur = '" + idfm + "'");
            if (tfcc != null && tfcc.length > 0) {
                tfcc[0].setIdtva(tva);
            } else {
                throw new Exception("La facture n'est pas presente dans la base");
            }
            ff.setNomTable("factureFille");
            System.out.println("OK FC "+idfactureFille.length);

            for (i = 0; i < idfactureFille.length; i++) {
                FactureFille[] tff = (FactureFille[]) CGenUtil.rechercher(ff, null, null, c, " and idFactureFille ='" + idfactureFille[i] + "'");
                if (tff != null && tff.length > 0) {
                    tff[0].setIdFactureFille(idfactureFille[i]);
                    tff[0].setPrixUnitaire(prixUnitaire[i]);
                    tff[0].setQuantite(quantite[i]);
                    tff[0].setReduction(reduction[i]);
                    tff[0].updateToTableWithHisto(mapUser, c);
                    double montantFille = prixUnitaire[i] * quantite[i];
                    montantFille -=  montantFille*reduction[i]/100;
                    montantTotal +=  montantFille ;
                }
            }
            
            montantTotal += montantTotal * tfcc[0].getIdtva() / 100;
            
            tfcc[0].setMontantttc(montantTotal);
            tfcc[0].updateToTableWithHisto(mapUser, c);
            //update ordonner Paiement
            if (top != null && top.length > 0) {
                top[0].setId(idfm);
                top[0].setMontant(montantTotal);
                top[0].updateToTableWithHisto(mapUser, c);
            } else {
                throw new Exception("Erreur : La facture n'est pas presente dans ordonner paiement");
            }

            //update facture mere
            FactureMereProforma fmp = new FactureMereProforma();
            fmp.setNomTable("FactureMere");
            FactureMereProforma[] tfmp = (FactureMereProforma[]) CGenUtil.rechercher(fmp, null, null, " and idFactureMere ='" + idfm + "'");
            if (tfmp != null && tfmp.length > 0) {
                tfmp[0].setIdClient(idfm);
                tfmp[0].setMontantAPayer(montantTotal);
                tfmp[0].updateToTableWithHisto(mapUser, c);
            }
            c.commit();

        } catch (Exception e) {

            if (c != null) {
                c.rollback();
            }
            throw new Exception(e.getMessage());

        } finally {
            if (c != null) {
                c.close();
            }
        }

    }

    public int annulationPub(String idPub, String mapUser) throws Exception {
        Connection c = null;
        PubFacture[] pubfacture = null;
        VenteFacture[] ventefacture = null;
        VisaFactureClient[] visafactureclient = null;
        UnionIntraTable[] orfclc = null;
        UnionIntraTable[] factureclientlc = null;
        OrdonnerPayement[] ordonnerrecette = null;

        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            String idfactureclient = "";
            PubFacture pF = new PubFacture();
            pubfacture = (PubFacture[]) CGenUtil.rechercher(pF, null, null, c, " and id1='" + idPub + "'");
            if (pubfacture.length > 0) {
                idfactureclient = pubfacture[0].getId2();
            }

            OrdonnerPayement or = new OrdonnerPayement();
            or.setNomTable("ordonnerrecette");
            ordonnerrecette = (OrdonnerPayement[]) CGenUtil.rechercher(or, null, null, c, " and ded_id='" + idfactureclient + "'");
            if (ordonnerrecette.length > 0) {
                MvtCaisse mC = new MvtCaisse();
                MvtCaisse[] mvtCaisse = (MvtCaisse[]) CGenUtil.rechercher(mC, null, null, c, " and idordre='" + ordonnerrecette[0].getId() + "'");
                if (mvtCaisse.length > 0) {
                    throw new Exception("OR déjà attaché à un mouvement de caisse.");
                }
            }

            pubfacture[0].deleteToTable(c);// delete dans Pubfacture          

            VisaFactureClient viF = new VisaFactureClient();
            visafactureclient = (VisaFactureClient[]) CGenUtil.rechercher(viF, null, null, c, " and idobjet='" + idfactureclient + "'");
            if (visafactureclient.length > 0) {
                visafactureclient[0].deleteToTable(c); //delete dans VisaFactureClient
            }

            UnionIntraTable of = new UnionIntraTable();
            of.setNomTable("orfclc");
            if (ordonnerrecette.length > 0) {
                orfclc = (UnionIntraTable[]) CGenUtil.rechercher(of, null, null, c, " and id1='" + ordonnerrecette[0].getId() + "'");
                if (orfclc.length > 0) {
                    for (int i = 0; i < orfclc.length; i++) {
                        orfclc[i].deleteToTable(c);//delete dans orfclc
                    }
                }
                ordonnerrecette[0].deleteToTable(c);//delete dans ordonnerrecette
            }

            of.setNomTable("factureclientlc");
            factureclientlc = (UnionIntraTable[]) CGenUtil.rechercher(of, null, null, c, " and id1 = '" + idfactureclient + "'");
            if (factureclientlc.length > 0) {
                for (int i = 0; i < factureclientlc.length; i++) {
                    factureclientlc[i].deleteToTable(c);//delete dans factureclientlc
                }
            }
            System.out.print("idddpubb" + idPub + idfactureclient);
            FactureClient fa = new FactureClient();
            fa.setIdfacturefournisseur(idfactureclient);
            fa.deleteToTableWithHisto(mapUser, c);// delete dans FactureClient

            c.commit();
            int i = 1;
            return i;
        } catch (Exception e) {
            try {
                if (c != null) {
                    c.rollback();
                }
                throw new Exception(e.getMessage());
            } catch (Exception ef) {
                throw new Exception(ef.getMessage());
            } finally {
                try {
                    if (c != null) {
                        c.close();
                    }
                } catch (SQLException exsq) {
                    throw new Exception(exsq.getMessage());
                }
            }
        }

    }

    SessionContext sessionContext;

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
