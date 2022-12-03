/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import historique.MapUtilisateur;
import java.sql.Connection;
import recette.ConfPrixEtudiant;
import recette.RubriquePrixEntite;
import utilitaire.Utilitaire;
import bean.CGenUtil;
import bean.UnionIntraTable;
import bean.UnionIntraTableUtil;
import bean.ValidationException;
import ded.DedEjb;
import ded.DedEjbClient;
import ded.OrdonnerPayement;
import facture.Client;
import facturefournisseur.FactureFournisseur;
import finance.FinanceEjb;
import finance.FinanceEjbClient;
import finance.MvtCaisse;

import java.util.HashMap;
import java.util.List;

import lc.LCEjb;
import lc.LCEjbClient;
import lc.LigneCredit;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.UtilDB;

/**
 *
 * @author Murielle
 */
public class EtudiantService {

    public void insertEtudiant(Etudiant etudiant, Connection c, MapUtilisateur u) throws Exception {
        System.out.println("*********************** tonga ato aminy insertEtudiant **************************");
        etudiant.setDate_fin(null);
        etudiant.construirePK(c);
        etudiant.insertToTableWithHisto(u.getTuppleID(), c);

        RubriquePrixEntite rub = new RubriquePrixEntite();
        rub.setEntite(etudiant.getEntite());
        RubriquePrixEntite[] rubrique = (RubriquePrixEntite[]) CGenUtil.rechercher(rub, null, null, c, "");

        ConfPrixEtudiant conf = new ConfPrixEtudiant();
        conf.setDate_debut(etudiant.getDate_debut());
        conf.setDate_fin(null);
        conf.setDaty(Utilitaire.dateDuJourSql());
        conf.setEtudiant(etudiant.getId());
        conf.setEcheance(1);
        for (int i = 0; i < rubrique.length; i++) {
            if (rubrique[i].getLibelle().compareToIgnoreCase("Ecolage") == 0) {
                conf.setEcolage(rubrique[i].getMontant());
            }
            if (rubrique[i].getLibelle().compareToIgnoreCase("Food") == 0) {
                conf.setFood(rubrique[i].getMontant());
            }
            if (rubrique[i].getLibelle().compareToIgnoreCase("Transport") == 0) {
                conf.setTransport(rubrique[i].getMontant());
            }
            if (rubrique[i].getLibelle().compareToIgnoreCase("Inscription") == 0) {
                conf.setInscription(rubrique[i].getMontant());
            }
        }
        conf.setAutres(0);
        conf.setRemarques("");
        conf.construirePK(c);
        String id = u.getTuppleID();
        System.out.println("ID ==== " + id);
        System.out.println("ID conf prix ==== " + conf.getId());
        saveConfigPrix(conf, c, u);
        //(conf, c, u);

        MouvementEtudiant mouvementEtudiant = new MouvementEtudiant();
        mouvementEtudiant.setType("1");
        MouvementEtudiant mouvement = new MouvementEtudiant();
        mouvement.setNomTable("mouvementEtudiant");
        mouvement.setEtudiant(etudiant.getId());
        mouvement.setDaty(mouvementEtudiant.getDaty());
        mouvement.setMotif(mouvementEtudiant.getMotif());
        mouvement.setType(mouvementEtudiant.getType());
        mouvement.construirePK(c);
        mouvement.insertToTableWithHisto(u.getTuppleID(), c);
    }

    public void insertRubriquePrixEntite(RubriquePrixEntite rubriquePrixEntite, Connection c, MapUtilisateur u) throws Exception {
        RubriquePrixEntite rubrique = new RubriquePrixEntite();
        rubrique.setNomTable("rubriqueprixentitehisto");
        rubrique.setLibelle(rubriquePrixEntite.getLibelle());
        rubrique.setMontant(rubriquePrixEntite.getMontant());
        rubrique.setEntite(rubriquePrixEntite.getEntite());
        rubrique.setDaty(rubriquePrixEntite.getDaty());
        rubrique.construirePK(c);
        rubrique.insertToTableWithHisto(u.getTuppleID(), c);
    }

    public void insertMouvementEtudiant(MouvementEtudiant mouvementEtudiant, Connection c, MapUtilisateur u) throws Exception {
        MouvementEtudiant mouvement = new MouvementEtudiant();
        mouvement.setNomTable("mouvementEtudiant");
        mouvement.setEtudiant(mouvementEtudiant.getEtudiant());
        mouvement.setDaty(mouvementEtudiant.getDaty());
        mouvement.setMotif(mouvementEtudiant.getMotif());
        mouvement.setType(mouvementEtudiant.getType());
        mouvement.construirePK(c);
        mouvement.insertToTableWithHisto(u.getTuppleID(), c);

        Etudiant e = new Etudiant();
        e.setId(mouvementEtudiant.getEtudiant());
        Etudiant[] etudiants = (Etudiant[]) CGenUtil.rechercher(e, null, null, c, "");
        for (int i = 0; i < etudiants.length; i++) {
            Etudiant etu = new Etudiant();
            etu.setId(etudiants[i].getId());
            etu.setNom(etudiants[i].getNom());
            etu.setPrenom(etudiants[i].getPrenom());
            etu.setDateNaissance(etudiants[i].getDateNaissance());
            etu.setPere(etudiants[i].getPere());
            etu.setProffPere(etudiants[i].getProffPere());
            etu.setMere(etudiants[i].getMere());
            etu.setProfMere(etudiants[i].getProfMere());
            etu.setAdresse(etudiants[i].getAdresse());
            etu.setContact(etudiants[i].getContact());
            etu.setMail(etudiants[i].getMail());
            etu.setChemin(etudiants[i].getChemin());
            etu.setSexe(etudiants[i].getSexe());
            etu.setEntite(etudiants[i].getEntite());
            etu.setNiveau(etudiants[i].getNiveau());
            etu.setPays(etudiants[i].getPays());
            etu.setDate_debut(etudiants[i].getDate_debut());
            etu.setDate_fin(etudiants[i].getDate_fin());
            etu.setEtat(0);
            etu.updateToTableWithHisto(u.getTuppleID(), c);
        }
        Edition edition = new Edition();
        edition.setIdetudiant(e.getId());
        Edition[] ed = (Edition[]) CGenUtil.rechercher(edition, null, null, c, "");
        for (int i = 0; i < ed.length; i++) {
            if (ed[i].getAnnee() >= mouvementEtudiant.getDaty().getYear()) {
                if (ed[i].getMois()>=mouvementEtudiant.getDaty().getMonth()) {
                    ed[i].deleteToTableWithHisto(u.getTuppleID(), c);
                }
            }
        }

        if (mouvement.getType().compareToIgnoreCase("1") == 0) {
            //
        }
    }

    public void updateRubriquePrixEntite(RubriquePrixEntite rubriquePrixEntite, Connection c, MapUtilisateur u) throws Exception {
        rubriquePrixEntite.updateToTable(c);
        insertRubriquePrixEntite(rubriquePrixEntite, c, u);
    }

    public void insertConfigHistoByConfig(ConfPrixEtudiant conf, Connection c, MapUtilisateur u) throws Exception {
        ConfPrixEtudiant confHisto = new ConfPrixEtudiant();
        confHisto.setNomTable("confprixetudianthisto");
        confHisto.setDaty(conf.getDaty());
        confHisto.setEtudiant(conf.getEtudiant());
        confHisto.setEcheance(conf.getEcheance());
        confHisto.setEcolage(conf.getEcolage());
        confHisto.setFood(conf.getFood());
        confHisto.setTransport(conf.getTransport());
        confHisto.setInscription(conf.getInscription());
        confHisto.setAutres(conf.getAutres());
        confHisto.setRemarques(conf.getRemarques());
        confHisto.construirePK(c);
        confHisto.insertToTableWithHisto(u.getTuppleID(), c);
    }

    public void updateConfPrix(ConfPrixEtudiant conf, Connection c, MapUtilisateur u) throws Exception {
        conf.updateToTable(c);
        insertConfigHistoByConfig(conf, c, u);
    }

    public void saveConfigPrixMultiple(ConfPrixEtudiant conf, Connection c, MapUtilisateur u) throws Exception {
        String etudiants = conf.getEtudiant();
        String[] etu = etudiants.split(";");
        for (int i = 0; i < etu.length; i++) {
            System.out.println(etu[i]);
            conf.setEtudiant(etu[i]);
            saveConfigPrix(conf, c, u);
        }
        System.out.println("Insertion de N conf" + etu.length);
    }

    public void saveConfigPrix(ConfPrixEtudiant conf, Connection c, MapUtilisateur u) throws Exception {
        conf.setNomTable("CONFPRIXETUDIANT");
        // select configuration anterieur
        ConfPrixEtudiant confAnt = new ConfPrixEtudiant();
        confAnt.setNomTable("CONFPRIXETUDIANT");
        confAnt.setEtudiant(conf.getEtudiant());
        ConfPrixEtudiant[] confAnts = (ConfPrixEtudiant[]) CGenUtil.rechercher(confAnt, null, null, c, " AND DATE_FIN IS NULL");
        // controle date if date debut < date fin
        //if(conf.getDate_debut().compareTo(confAnt.getDate_debut())<0){
        //throw new Exception("La date debut est anterieur � la date de la configuration precedente");
        //}
        // update configuration ant�rieur
        if (confAnts != null && confAnts.length > 0) {
            confAnts[0].setDate_fin(Utilitaire.ajoutJourDate(conf.getDate_debut(), -1));
            confAnts[0].updateToTable(c);
        }
        // insert configuration
        
        ConfPrixEtudiant[] conftemp =(ConfPrixEtudiant[]) CGenUtil.rechercher(new ConfPrixEtudiant(), null, null, c, " and etudiant='" + conf.getEtudiant() + "'");
        if (conftemp.length> 0){
            System.out.println("-------------tonga ato anaty update ---------------------------");
            conf.setId(conftemp[0].getId());
            conf.updateToTable(c);
        }
        else {
            conf.setDate_fin(null);
            conf.construirePK(c);
            conf.insertToTableWithHisto(u.getTuppleID(), c);
        }
        
        System.out.println("daty jour +"+Utilitaire.dateDuJour());
        System.out.println("daty = "+conf.getDate_debut());
        // recherche edition where date >= datedebut
        String where = " and idetudiant='" + conf.getEtudiant() + "' AND (ANNEE > EXTRACT(YEAR FROM to_date('" + Utilitaire.formatterDaty(conf.getDate_debut()) + "')) or (MOIS >= EXTRACT(MONTH FROM to_date('" + Utilitaire.formatterDaty(conf.getDate_debut()) + "')) AND ANNEE = EXTRACT(YEAR FROM to_date('" + Utilitaire.formatterDaty(conf.getDate_debut()) + "'))))";
        System.out.println(where);
        Edition ed = new Edition();
        Edition[] editions = (Edition[]) CGenUtil.rechercher(ed, null, null, c, where);
        List<Edition> edList = null;
        int moiss = Utilitaire.getMois(conf.getDate_debut());
        int nb = 12 - moiss + 1;
        int nbAcompleter = nb;
        if (editions != null && editions.length > 0) {
            // tester jusqu'� decembre ve ampy
            if (editions.length <= nb) {
                nbAcompleter = nb - editions.length;
            }
            // update montant�payer edition
            System.out.println("DEBUT BOUCLE 1");
            for (int i = 0; i < editions.length; i++) {
                //editions[i].setMois(moiss);
                //editions[i].setAnnee(Utilitaire.getAnnee(conf.getDate_debut()));
                //editions[i].setIdetudiant(conf.getEtudiant());
                editions[i].setEcolagedu(conf.getEcolage());
                editions[i].setFooddu(conf.getFood());
                
                editions[i].setTransportdu(conf.getTransport());
                editions[i].setInscriptiondu(conf.getInscription());
                editions[i].setAutredu(conf.getAutres());
                editions[i].updateToTableWithHisto(u.getTuppleID(), c);
            }
        }
        System.out.println("NOMBRE EDITION = " + editions.length);
        System.out.println("NOMBRE A COMPLETER = " + nbAcompleter);
        // insert edition tsy tafiditra
        for (int i = 0; i < nbAcompleter; i++) {
            System.out.println("BOUCLE 2 : insert edition");
            Edition e = new Edition();
            e.setMois(moiss + i);
            e.setAnnee(Utilitaire.getAnnee(conf.getDate_debut()));
            e.setIdetudiant(conf.getEtudiant());
            e.setEcolagedu(conf.getEcolage());
            e.setFooddu(conf.getFood());
            e.setTransportdu(conf.getTransport());
            e.setInscriptiondu(conf.getInscription());
            e.setAutredu(conf.getAutres());
            e.construirePK(c);
            e.insertToTableWithHisto(u.getTuppleID(), c);
        }
    }

    public PaiementDetail savePaiement(PaiementDetail conf, Connection c, MapUtilisateur u, UserEJBBean user) throws Exception {
        System.out.println("--------debut--------");
        System.out.println("Ecolage:" + conf.getEcolage());
        System.out.println("Food:" + conf.getFood());
        System.out.println("Etablissement" + conf.getEtablissement());
        System.out.println("Transport" + conf.getTransport());
        System.out.println("Autre" + conf.getAutre());
        System.out.println("Total" + conf.getMontant_total());
        System.out.println("--------debut--------");
        PaiementDetail temp = conf;
        double total1 = conf.getAutre() + conf.getEcolage() + conf.getFood() + conf.getInscription() + conf.getTransport();
        if (total1 != conf.getMontant_total()) {
            throw new Exception("les details ne correspond pas a la somme");
        }

        DedEjb fi = DedEjbClient.getInterface();
        LCEjb lci = LCEjbClient.getInterface();
        FinanceEjb finance = FinanceEjbClient.getInterface();

        double totalTestNull = conf.getMontant_total();

        //ERROR ...
        if (conf.getMontant_total() <= 0) {
            //partage
            conf.setMontant_total(total1);
        }

        System.out.println("----------------------------------------------");
        FactureFournisseur ff = fi.createOrSimpleResp(Utilitaire.formatterDaty(conf.getDaty()),
                String.valueOf(conf.getMontant_total()), "0", conf.getEtudiant(), conf.getDevise(),
                "-", conf.getRemarque(), "", u.getTuppleID(), c);
        HashMap<String, String> idLC = null;
        if (totalTestNull == 0) {
            System.out.println("-----------------traitementMontantReparti---------------------");
            idLC = traitementMontantReparti(conf, u, c);
        } else {
            System.out.println("--------------------traitementMontantTotal----------------------");
            idLC = traitementMontantTotal(conf, u, c);
        }
        System.out.println("----------------------------------------------");

        //LC avec montant par rubrique et mois / annee
        String[] idLcArecup = new String[idLC.keySet().size()];
        String[] montantTab = new String[idLcArecup.length];
        int i = 0;
        for (String mapKey : idLC.keySet()) {
            idLcArecup[i] = mapKey;
            montantTab[i] = idLC.get(mapKey);
            i++;
        }

        System.out.println("*************OKKK UPDATE EDITION " + idLcArecup.length);

//      ato ny fonction atsona maha tonga ny lien inexistant
        lci.mapperOrFactureClientLCTableau(ff.getRemarque(), idLcArecup, "facture or auto", montantTab, u.getTuppleID(), c);

        UnionIntraTableUtil uiti = new UnionIntraTableUtil();
        uiti.setNomTable("FACTURECLIENTLC");
//        System.out.println("---------EREUR-------------");
//        System.out.println(ff.getIdFactureFournisseur());
//        System.out.println("---------EREUR-------------");
        System.out.println("---------EREUR-------------" + ff.getIdFactureFournisseur());
        UnionIntraTable[] liefflc = (UnionIntraTable[]) uiti.rechercher(2, ff.getIdFactureFournisseur(), c);
        if (liefflc.length == 0) {
            throw new Exception("le lien n existe pas");
        }

        String[] idLien = new String[liefflc.length];
        String[] montants = new String[liefflc.length];
        for (int a = 0; a < idLien.length; a++) {
            idLien[a] = liefflc[a].getId();
            montants[a] = String.valueOf(liefflc[a].getMontantMere());
        }

        lci.updateMontantUnionIntraLcOp(Constante.tableOrFcLc, "FACTURECLIENTLC", ff.getRemarque(), idLien, montants, u.getTuppleID(), c);
        lci.validerMappageLCMOrControle(Constante.tableOrFcLc, "FACTURECLIENTLC", ff.getRemarque(), u.getTuppleID(), c);
        fi.viserOr(Utilitaire.formatterDaty(conf.getDaty()), conf.getRemarque(), ff.getRemarque(), u.getTuppleID(), c);
        user.savePrevision(ff.getRemarque(), "ORPREVISION", "ORDONNERRECETTE", c);

        System.out.println("OKKK visa OR ");

        String mvmax = Utilitaire.makePK(6, "MVT", "getseqmvt");
        String[] g = Utilitaire.split(mvmax, "MVT");
        String idmvtor = "SMOR" + g[0] + 1;
        String idEtablissement = conf.getEtablissement();
        String numeroCheque = "-";
        if (!"pay2".equalsIgnoreCase(conf.getMode())) {
            numeroCheque = "-";
            idEtablissement = "-";
        }

        String[] numObjets = Utilitaire.split(ff.getRemarque(), "<br/>");
        OrdonnerPayement o = new OrdonnerPayement();
        o.setNomTable("orapayer");
        String retour = null;
        String[] lmvt = new String[numObjets.length];
        int k = 0;
//        System.out.println("-----------taille numObjets ------------");
//        System.out.println(numObjets.length);
//        System.out.println("-----------taille  numObjets------------");
        for (int j = 0; j < numObjets.length; j++) {
            OrdonnerPayement[] lop = (OrdonnerPayement[]) CGenUtil.rechercher(o, null, null, c, " and id='" + numObjets[j] + "'");
            retour = finance.createMvtCaisseRecette(Utilitaire.formatterDaty(conf.getDaty()), "",
                    "Paiement scolarite " + conf.getRemarque(), "" + lop[0].getMontant(), conf.getDevise(),
                    conf.getModepaiement(), conf.getCaisse(), conf.getRemarque(),
                    "-", conf.getEtudiant(), "-",
                    "1", numObjets[j], numeroCheque, idEtablissement, idmvtor, u.getTuppleID(), c);
            lmvt[k] = retour;
            k++;
        }
        user.saveMvtOr(idmvtor, lmvt[0], ff.getRemarque(), c);
        System.out.println("-------------Final-----------");
        System.out.println("OKKK Paiement");
        System.out.println("-------------Final-----------");

        System.out.println("-------------objet taloha-----------");
        System.out.println("Ecolage:" + conf.getEcolage());
        System.out.println("Food:" + conf.getFood());
        System.out.println("Etablissement" + conf.getEtablissement());
        System.out.println("Transport" + conf.getTransport());
        System.out.println("Autre" + conf.getAutre());
        System.out.println("Total" + conf.getMontant_total());
        System.out.println("-------------objet taloha-----------");

        System.out.println("-------------objet temp-----------");
        System.out.println("Ecolage:" + temp.getEcolage());
        System.out.println("Food:" + temp.getFood());
        System.out.println("Etablissement" + temp.getEtablissement());
        System.out.println("Transport" + temp.getTransport());
        System.out.println("Autre" + temp.getAutre());
        System.out.println("Total" + temp.getMontant_total());
        System.out.println("-------------objet temp-----------");

        conf.construirePK(c);
        conf.insertToTableWithHisto(u.getTuppleID(), c);
        return conf;
    }

    private HashMap traitementMontantReparti(PaiementDetail conf, MapUtilisateur u, Connection c) throws Exception {
        System.out.print("traitementMontantReparti");
        Client[] clients = (Client[]) CGenUtil.rechercher(new Client(), null, null, c, " and numstat='" + conf.getEtudiant() + "'");
        if (clients == null || clients.length == 0) {
            throw new Exception("Etudiant inexistant");
        }
        Etudiant[] etuds = (Etudiant[]) CGenUtil.rechercher(new Etudiant(), null, null, c, " and id='" + clients[0].getNumstat() + "'");
        if (etuds == null || etuds.length == 0) {
            throw new Exception("Etudiant inexistant");
        }
        //edition
        String where = " and idetudiant='" + clients[0].getNumstat() + "' order by mois, annee asc";
        Edition edition = new Edition();
        edition.setNomTable("edition_nonpayer");
        Edition[] editions = (Edition[]) CGenUtil.rechercher(edition, null, null, c, where);

        //double montant_reste = conf.getMontant_total();
        double montant_reste = conf.getEcolage() + conf.getFood() + conf.getTransport() + conf.getInscription() + conf.getAutre();
        double ecolage = 0, inscription = 0, food = 0, transport = 0, autre = 0;

        HashMap<String, String> idLC = new HashMap<String, String>();
        System.out.println("EDITIONS " + editions.length);

        for (int a = 0; a < editions.length; a++) {
            double ecolagetemp = 0, inscriptiontemp = 0, foodtemp = 0, transporttemp = 0, autretemp = 0;

            double impaye = (editions[a].getAutredu() + editions[a].getEcolagedu() + editions[a].getFooddu()
                    + editions[a].getInscriptiondu() + editions[a].getTransportdu())
                    - (editions[a].getAutrepaye() + editions[a].getEcolagepaye() + editions[a].getFoodpaye()
                    + editions[a].getInscriptionpaye() + editions[a].getTransportpaye());

            if (montant_reste - impaye < 0) {
                //pourcentage
                ecolagetemp = conf.getEcolage();
                inscriptiontemp = conf.getInscription();
                foodtemp = conf.getFood();
                transporttemp = conf.getTransport();
                autretemp = conf.getAutre();
            } else {
                //partage mameno
                ecolagetemp = editions[a].getEcolagedu() - editions[a].getEcolagepaye();
                inscriptiontemp = editions[a].getInscriptiondu() - editions[a].getInscriptionpaye();
                foodtemp = editions[a].getFooddu() - editions[a].getFoodpaye();
                transporttemp = editions[a].getTransportdu() - editions[a].getTransportpaye();
                autretemp = editions[a].getAutredu() - editions[a].getAutrepaye();
            }
            System.out.println("-------------objet tonga any aminy edtion traitementMontantReparti-----------");
            System.out.println("Ecolage:" + conf.getEcolage());
            System.out.println("Food:" + conf.getFood());
            System.out.println("Etablissement" + conf.getEtablissement());
            System.out.println("Transport" + conf.getTransport());
            System.out.println("Autre" + conf.getAutre());
            System.out.println("Total" + conf.getMontant_total());
            System.out.println("-------------objet tonga any aminy edtion traitementMontantReparti-----------");
            conf.setMontant_total(ecolagetemp + inscriptiontemp + foodtemp + transporttemp + autretemp);
            System.out.println("eco :" + ecolagetemp + "inscription : " + inscriptiontemp + "food :" + foodtemp + "transport : " + transporttemp + " autre :" + autretemp);
            System.out.println("EtudiantService.traitementMontantReparti");
            editions[a].setEcolagepaye(ecolagetemp);
            editions[a].setInscriptionpaye(inscriptiontemp);
            editions[a].setFoodpaye(foodtemp);
            editions[a].setTransportpaye(transporttemp);
            editions[a].setAutrepaye(autretemp);
            //update
            editions[a].setNomTable("edition");
            editions[a].updateToTableWithHisto(u.getTuppleID(), c);

            ecolage += ecolagetemp;
            inscription += inscriptiontemp;
            food += foodtemp;
            transport += transporttemp;
            autre += autretemp;

            montant_reste = montant_reste - (ecolagetemp + inscriptiontemp + foodtemp + transporttemp + autretemp);

            String apWhere = " and mois='" + editions[a].getMois() + "' and annee=" + editions[a].getAnnee() + " and idTypeLigne in ('" + ConstanteScolarite.typeLCinscription + "', '" + ConstanteScolarite.typeLCecolage + "', "
                    + "'" + ConstanteScolarite.typeLCfood + "', '" + ConstanteScolarite.typeLCtransport + "', "
                    + "'" + ConstanteScolarite.typeLCautres + "') and identite='" + etuds[0].getEntite() + "'";
            //entite
            LigneCredit licr = new LigneCredit();
            licr.setNomTable("lignecreditrecette");
            LigneCredit[] lignes = (LigneCredit[]) CGenUtil.rechercher(licr, null, null, c, apWhere);
            if (lignes != null && lignes.length > 0) {
                for (int b = 0; b < lignes.length; b++) {
                    if (foodtemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCfood) == 0) {
                        idLC.put(lignes[b].getIdLigne(), String.valueOf(foodtemp));
                    }
                    if (transporttemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCtransport) == 0) {
                        idLC.put(lignes[b].getIdLigne(), String.valueOf(transporttemp));
                    }
                    if (autretemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCautres) == 0) {
                        idLC.put(lignes[b].getIdLigne(), String.valueOf(autretemp));
                    }
                    if (inscriptiontemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCinscription) == 0) {
                        idLC.put(lignes[b].getIdLigne(), String.valueOf(inscriptiontemp));
                    }
                    if (ecolagetemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCecolage) == 0) {
                        idLC.put(lignes[b].getIdLigne(), String.valueOf(ecolagetemp));
                    }
                }
            }
            System.out.println("Dans update " + a);
            if (montant_reste <= 0) {
                break;
            }
        }
        return idLC;
    }

    private HashMap traitementMontantTotal(PaiementDetail conf, MapUtilisateur u, Connection c) throws Exception {
        System.out.println("---------------- debut fonction traitementMontantTotal ------------------");
        PaiementDetail conftemp = new PaiementDetail();
//        conftemp = conf;
        conftemp.setAutre(conf.getAutre());
        conftemp.setFood(conf.getFood());
        conftemp.setTransport(conf.getTransport());
        conftemp.setEcolage(conf.getEcolage());
        conftemp.setInscription(conf.getInscription());

        Client[] clients = (Client[]) CGenUtil.rechercher(new Client(), null, null, c, " and numstat='" + conf.getEtudiant() + "'");

        System.out.println(conf.getEtudiant());
        if (clients == null || clients.length == 0) {
            throw new Exception("Etudiant inexistant");
        }
        Etudiant[] etuds = (Etudiant[]) CGenUtil.rechercher(new Etudiant(), null, null, c, " and id='" + clients[0].getNumstat() + "'");
        if (etuds == null || etuds.length == 0 || clients == null || clients.length == 0) {
            throw new Exception("Etudiant inexistant");
        }
        //edition
        String where = " and idetudiant='" + clients[0].getNumstat() + "' order by annee, mois asc";
        Edition edition = new Edition();
        edition.setNomTable("edition_nonpayer");
        Edition[] editions = (Edition[]) CGenUtil.rechercher(edition, null, null, c, where);
        //System.out.println("========EDITIONS======" + editions.length);
        //double montant_reste = conf.getMontant_total();
        double ecolage = 0, inscription = 0, food = 0, transport = 0, autre = 0;
        double ecolagereste = 0, inscriptionreste = 0, foodreste = 0, transportreste = 0, autrereste = 0;

        System.out.println("-------------objet tonga any aminy edtion traitementMontantTotal-----------");
        System.out.println("Ecolage:" + conf.getEcolage());
        System.out.println("Food:" + conf.getFood());
        System.out.println("Etablissement" + conf.getEtablissement());
        System.out.println("Transport" + conf.getTransport());
        System.out.println("Autre" + conf.getAutre());
        System.out.println("Total" + conf.getMontant_total());
        System.out.println("-------------objet tonga any aminy edtion traitementMontantTotal-----------");
        HashMap<String, String> idLC = new HashMap<String, String>();
        System.out.println("EDITIONS " + editions.length);
//        for (int a = 0; a < editions.length; a++) {
        //int a = 0;

        //while (conftemp.getEcolage() > 0 || conftemp.getInscription() > 0 || conftemp.getFood() > 0 || conftemp.getTransport() > 0) {
        for(int a=0; a<editions.length; a++){
            if(conftemp.getEcolage() > 0 || conftemp.getInscription() > 0 || conftemp.getFood() > 0 || conftemp.getTransport() > 0) {
                System.out.println("--------------------------comtpeur" + String.valueOf(a));
                System.out.println("-------------objet temporaire tonga any aminy edtion traitementMontantTotal-----------");
                System.out.println("Ecolage:" + conftemp.getEcolage());
                System.out.println("Food:" + conftemp.getFood());
                System.out.println("Etablissement" + conftemp.getEtablissement());
                System.out.println("Transport" + conftemp.getTransport());
                System.out.println("Autre" + conftemp.getAutre());
                System.out.println("Total" + conftemp.getMontant_total());
                System.out.println("-------------objet temporaire tonga any aminy edtion traitementMontantTotal-----------");
                double ecolagetemp = 0, inscriptiontemp = 0, foodtemp = 0, transporttemp = 0, autretemp = 0;

                double impaye = (editions[a].getAutredu() + editions[a].getEcolagedu() + editions[a].getFooddu()
                        + editions[a].getInscriptiondu() + editions[a].getTransportdu())
                        - (editions[a].getAutrepaye() + editions[a].getEcolagepaye() + editions[a].getFoodpaye()
                        + editions[a].getInscriptionpaye() + editions[a].getTransportpaye());


                if (impaye > 0) {

                    if (editions[a].getEcolagedu() > 0) {
                        System.out.println("+++++++++++++++++editions[a].getEcolagedu()++++++++++++++"+editions[a].getEcolagedu());
                        if (editions[a].getEcolagedu() > 0 ) {
                            if (editions[a].getEcolagedu() - editions[a].getEcolagepaye() >= conftemp.getEcolage()) {
                                System.out.println("+++++++++++++++++++++++++ato ambony +++++++++++++++++++++++++++++");
                                ecolagetemp = editions[a].getEcolagepaye() + conftemp.getEcolage();
                                ecolagereste = 0;
                                editions[a].setEcolagepaye(ecolagetemp);

                            } 
                            else {

                                System.out.println("+++++++++++++++++++++++++ato ambony else +++++++++++++++++++++++++++++");
                                //ecolagetemp = conftemp.getEcolage() - (editions[a].getEcolagedu() - editions[a].getEcolagepaye());
                                ecolagetemp = editions[a].getEcolagedu();
                                ecolagereste = conftemp.getEcolage() - (editions[a].getEcolagedu() - editions[a].getEcolagepaye());
                                conftemp.setEcolage(ecolagereste);

                            }
    //                    System.out.println("eco: " + pourcEcolage);
                            System.out.println("ecoconf: " + conftemp.getEcolage());
                            System.out.println("eco: " + ecolagetemp);
                            System.out.println("eco dif: " + String.valueOf(editions[a].getEcolagedu() - editions[a].getEcolagepaye()));
                        }

                    }
                    if (editions[a].getInscriptiondu() > 0) {
                        if (editions[a].getInscriptiondu() - editions[a].getInscriptionpaye() > 0) {
                            double pourcInscription = (editions[a].getInscriptiondu() - editions[a].getInscriptionpaye()) * 100 / impaye;
    //                    inscriptiontemp = Math.round(montant_reste * pourcInscription / 100);

                            if (editions[a].getInscriptiondu() - editions[a].getInscriptionpaye() >= conftemp.getInscription()) {
                                inscriptiontemp = editions[a].getInscriptionpaye() + conftemp.getInscription();
                                inscriptionreste = 0;
                                editions[a].setInscriptionpaye(inscriptiontemp);

                            } else {
                                inscriptionreste = conftemp.getInscription() - (editions[a].getInscriptiondu() - editions[a].getInscriptionpaye());
                                inscriptiontemp =  editions[a].getInscriptiondu();
                                conftemp.setInscription(inscriptionreste);
                            }

                        }
                    }
                    if (editions[a].getFooddu() > 0) {
                        if (editions[a].getFooddu() - editions[a].getFoodpaye() > 0) {
                            double pourcFood = (editions[a].getFooddu() - editions[a].getFoodpaye()) * 100 / impaye;
    //                    foodtemp = Math.round(montant_reste * pourcFood / 100);

                            if (editions[a].getFooddu() - editions[a].getFoodpaye() >= conftemp.getFood()) {
                                foodtemp = editions[a].getFoodpaye() + conftemp.getInscription();
                                foodreste = 0;
                                editions[a].setFoodpaye(foodtemp);
                            } else {
                                foodreste = conftemp.getInscription() - (editions[a].getFooddu() - editions[a].getFoodpaye());
                                foodtemp = editions[a].getFooddu();
                                editions[a].setFoodpaye(foodtemp);
                            }
    //                    System.out.println("food: " + pourcFood);
                            System.out.println("food: " + foodtemp);
                            System.out.println("food: " + String.valueOf(editions[a].getFooddu() - editions[a].getFoodpaye()));
                        }
                    }
                    if (editions[a].getTransportdu() > 0) {
                        if (editions[a].getTransportdu() - editions[a].getTransportpaye() > 0) {
                            double pourcTransport = (editions[a].getTransportdu() - editions[a].getTransportpaye()) * 100 / impaye;
    //                    transporttemp = Math.round(montant_reste * pourcTransport / 100);

                            if (editions[a].getTransportdu() - editions[a].getTransportpaye() >= conftemp.getFood()) {
                                transporttemp = editions[a].getTransportpaye() + conftemp.getTransport();
                                transportreste = 0;
                                editions[a].setTransportpaye(transporttemp);
                            } else {
                                transportreste = conftemp.getTransport() - (editions[a].getTransportdu() - editions[a].getFoodpaye());
                                transporttemp = editions[a].getTransportdu();
                                editions[a].setTransportpaye(transporttemp);
                            }
                            System.out.println("Transport: " + pourcTransport);
                            System.out.println("Transport: " + transporttemp);
                            System.out.println("Transport: " + String.valueOf(editions[a].getTransportdu() - editions[a].getTransportpaye()));

                        }
                    }

                    if (editions[a].getAutredu() > 0) {
                        if (editions[a].getAutredu() - editions[a].getAutrepaye() > 0) {
                            if (editions[a].getAutredu() - editions[a].getAutrepaye() >= conftemp.getAutre()) {
                                autretemp = editions[a].getAutrepaye() + conftemp.getAutre();
                                autrereste = 0;
                                editions[a].setAutrepaye(autretemp);
                            } else {
                                autrereste = conftemp.getAutre() - (editions[a].getAutredu() - editions[a].getAutrepaye());
                                autretemp = editions[a].getAutredu();
                                editions[a].setAutrepaye(autretemp);
                            }
                            System.out.println("autre: " + autretemp);
                            System.out.println("autre: " + String.valueOf(editions[a].getAutredu() - editions[a].getAutrepaye()));

                        }
                    }
                    //autretemp = montant_reste - Math.round(ecolagetemp + inscriptiontemp + foodtemp + transporttemp);
                    //traiement de surplus des paiement
                    if (a - 1 == editions.length) {
                        if (ecolagereste > 0 || foodreste > 0 || transportreste > 0 || inscriptionreste > 0 || autrereste > 0) {
                            double restetotal = ecolagereste + foodreste + transportreste + inscriptionreste + autrereste;
                            for (int e = 0; e < editions.length; e++) {
                                if (editions[e].getEcolagedu() > 0) {

                                    if (editions[e].getEcolagedu() > 0) {
                                        if (editions[e].getEcolagedu() - editions[e].getEcolagepaye() >= restetotal) {
                                            ecolagetemp = editions[a].getEcolagepaye() + restetotal;
                                            ecolagereste = 0;
                                        } else {
                                            ecolagereste = restetotal - (editions[a].getEcolagedu() - editions[a].getEcolagepaye());
                                            ecolagetemp = restetotal;
                                        }
                                        System.out.println("ecoconf: " + ecolagetemp);
                                        System.out.println("eco: " + ecolagetemp);
                                        System.out.println("eco dif: " + String.valueOf(editions[a].getEcolagedu() - editions[a].getEcolagepaye()));
                                    }

                                }

                            }
                        }
                    }
                } else {
                    //partage mameno
                    ecolagetemp = editions[a].getEcolagedu() - editions[a].getEcolagepaye();
                    inscriptiontemp = editions[a].getInscriptiondu() - editions[a].getInscriptionpaye();
                    foodtemp = editions[a].getFooddu() - editions[a].getFoodpaye();
                    transporttemp = editions[a].getTransportdu() - editions[a].getTransportpaye();
                    autretemp = editions[a].getAutredu() - editions[a].getAutrepaye();

                }
    //            conf.setEcolage(ecolagetemp);
    //            conf.setFood(foodtemp);
    //            conf.setTransport(transporttemp);
    //            conf.setInscription(inscriptiontemp);
    //            conf.setAutre(autretemp);
                System.out.println("+++++++++++++ito le reste ++++++++++++++++++++");
                System.out.println(String.valueOf(ecolagereste));
                System.out.println("+++++++++++++ito le reste ++++++++++++++++++++");




                System.out.println("-------------objet tonga any aminy edtion traitementMontantTotal-----------");
                System.out.println("Ecolage:" + conf.getEcolage());
                System.out.println("Food:" + conf.getFood());
                System.out.println("Etablissement" + conf.getEtablissement());
                System.out.println("Transport" + conf.getTransport());
                System.out.println("Autre" + conf.getAutre());
                System.out.println("Total" + conf.getMontant_total());
                System.out.println("-------------objet tonga any aminy edtion traitementMontantTotal-----------");

                System.out.println("eco " + ecolagetemp + "inscri " + inscriptiontemp + "food " + foodtemp + "tran " + transporttemp + " autre" + autretemp);
                System.out.println("EtudiantService.traitementMontantTotal");

                if (conftemp.getEcolage() > 0) {
                    editions[a].setEcolagepaye(ecolagetemp);
                }
                if (conftemp.getInscription() > 0) {
                    editions[a].setInscriptionpaye(inscriptiontemp);
                }
                if (conftemp.getFood() > 0) {
                    editions[a].setFoodpaye(foodtemp);
                }
                if (conftemp.getTransport() > 0) {
                    editions[a].setTransportpaye(transporttemp);
                }
                if (conftemp.getAutre() > 0) {
                    editions[a].setAutrepaye(autretemp);
                }
                conftemp.setEcolage(ecolagereste);
                conftemp.setFood(foodreste);
                conftemp.setTransport(transportreste);
                conftemp.setInscription(inscriptionreste);
                conftemp.setAutre(autrereste);
                //update
                editions[a].setNomTable("edition");
                editions[a].updateToTableWithHisto(u.getTuppleID(), c);

                ecolage += ecolagetemp;
                inscription += inscriptiontemp;
                food += foodtemp;
                transport += transporttemp;
                autre += autretemp;

      //          montant_reste = montant_reste - (ecolagetemp + inscriptiontemp + foodtemp + transporttemp + autretemp);


                String apWhere = " and mois='" + editions[a].getMois() + "' and annee=" + editions[a].getAnnee() + " and idTypeLigne in ('" + ConstanteScolarite.typeLCinscription + "', '" + ConstanteScolarite.typeLCecolage + "', "
                        + "'" + ConstanteScolarite.typeLCfood + "', '" + ConstanteScolarite.typeLCtransport + "', "
                        + "'" + ConstanteScolarite.typeLCautres + "') and identite='" + etuds[0].getEntite() + "'";
                //entite
                LigneCredit licr = new LigneCredit();
                licr.setNomTable("lignecreditrecette");
                System.out.println("apWhere ===== "+apWhere);
                LigneCredit[] lignes = (LigneCredit[]) CGenUtil.rechercher(licr, null, null, c, apWhere);
                if (lignes != null && lignes.length > 0) {
                    for (int b = 0; b < lignes.length; b++) {
                        if (foodtemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCfood) == 0) {
                            idLC.put(lignes[b].getIdLigne(), String.valueOf(foodtemp));
                        }
                        if (transporttemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCtransport) == 0) {
                            idLC.put(lignes[b].getIdLigne(), String.valueOf(transporttemp));
                        }
                        if (autretemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCautres) == 0) {
                            idLC.put(lignes[b].getIdLigne(), String.valueOf(autretemp));
                        }
                        if (inscriptiontemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCinscription) == 0) {
                            idLC.put(lignes[b].getIdLigne(), String.valueOf(inscriptiontemp));
                        }
                        if (ecolagetemp > 0 && lignes[b].getIdTypeLigne().compareTo(ConstanteScolarite.typeLCecolage) == 0) {
                            idLC.put(lignes[b].getIdLigne(), String.valueOf(ecolagetemp));
                        }
                    }
                }
                //a++;
                //System.out.println("Dans update " + a);
    //            if (montant_reste <= 0) {
    //                break;
    //            }
                if (a - 1 == editions.length) {
                    double reste_traiment = conftemp.getAutre()+conftemp.getEcolage()+conftemp.getFood()+conftemp.getInscription()+conftemp.getTransport();
                    if(reste_traiment >0){
                        throw new Exception("la somme saisie est est au dessous de la somme a paye");
                    }
                }
            }
            
        }
        //System.out.println("--------------------------comtpeur fin " + String.valueOf(a) + " -----------------------------------");
        System.out.println("-------------objet temporaire tonga any aminy edtion traitementMontantTotal-----------");
        System.out.println("Ecolage:" + conftemp.getEcolage());
        System.out.println("Food:" + conftemp.getFood());
        System.out.println("Etablissement" + conftemp.getEtablissement());
        System.out.println("Transport" + conftemp.getTransport());
        System.out.println("Autre" + conftemp.getAutre());
        System.out.println("Total" + conftemp.getMontant_total());
        System.out.println("-------------objet temporaire tonga any aminy edtion traitementMontantTotal-----------");
        System.out.println("---------------- fin fonction traitementMontantTotal ------------------");

        return idLC;
    }
    
    public PaiementDetail savePaiementsanspayement(PaiementDetail conf, Connection c, MapUtilisateur u, UserEJBBean user) throws Exception {
        System.out.println("--------debut--------");
        System.out.println("Ecolage:" + conf.getEcolage());
        System.out.println("Food:" + conf.getFood());
        System.out.println("Etablissement" + conf.getEtablissement());
        System.out.println("Transport" + conf.getTransport());
        System.out.println("Autre" + conf.getAutre());
        System.out.println("Total" + conf.getMontant_total());
        System.out.println("--------debut--------");
        PaiementDetail temp = conf;
        double total1 = conf.getAutre() + conf.getEcolage() + conf.getFood() + conf.getInscription() + conf.getTransport();
        if (total1 != conf.getMontant_total()) {
            throw new Exception("les details ne correspond pas a la somme");
        }

        DedEjb fi = DedEjbClient.getInterface();
        LCEjb lci = LCEjbClient.getInterface();
        FinanceEjb finance = FinanceEjbClient.getInterface();

        double totalTestNull = conf.getMontant_total();

        //ERROR ...
        if (conf.getMontant_total() <= 0) {
            //partage
            conf.setMontant_total(total1);
        }

        System.out.println("----------------------------------------------");
        FactureFournisseur ff = fi.createOrSimpleResp(Utilitaire.formatterDaty(conf.getDaty()),
                String.valueOf(conf.getMontant_total()), "0", conf.getEtudiant(), conf.getDevise(),
                "-", conf.getRemarque(), "", u.getTuppleID(), c);
        HashMap<String, String> idLC = null;
        if (totalTestNull == 0) {
            System.out.println("-----------------traitementMontantReparti---------------------");
            idLC = traitementMontantReparti(conf, u, c);
        } else {
            System.out.println("--------------------traitementMontantTotal----------------------");
            idLC = traitementMontantTotal(conf, u, c);
        }
        System.out.println("----------------------------------------------");

        //LC avec montant par rubrique et mois / annee
        String[] idLcArecup = new String[idLC.keySet().size()];
        String[] montantTab = new String[idLcArecup.length];
        int i = 0;
        for (String mapKey : idLC.keySet()) {
            idLcArecup[i] = mapKey;
            montantTab[i] = idLC.get(mapKey);
            i++;
        }

        System.out.println("*************OKKK UPDATE EDITION " + idLcArecup.length);

//      ato ny fonction atsona maha tonga ny lien inexistant
        lci.mapperOrFactureClientLCTableau(ff.getRemarque(), idLcArecup, "facture or auto", montantTab, u.getTuppleID(), c);

        UnionIntraTableUtil uiti = new UnionIntraTableUtil();
        uiti.setNomTable("FACTURECLIENTLC");
//        System.out.println("---------EREUR-------------");
//        System.out.println(ff.getIdFactureFournisseur());
//        System.out.println("---------EREUR-------------");
        System.out.println("---------EREUR-------------" + ff.getIdFactureFournisseur());
        UnionIntraTable[] liefflc = (UnionIntraTable[]) uiti.rechercher(2, ff.getIdFactureFournisseur(), c);
        if (liefflc.length == 0) {
            throw new Exception("le lien n existe pas");
        }

        String[] idLien = new String[liefflc.length];
        String[] montants = new String[liefflc.length];
        for (int a = 0; a < idLien.length; a++) {
            idLien[a] = liefflc[a].getId();
            montants[a] = String.valueOf(liefflc[a].getMontantMere());
        }

//        lci.updateMontantUnionIntraLcOp(Constante.tableOrFcLc, "FACTURECLIENTLC", ff.getRemarque(), idLien, montants, u.getTuppleID(), c);
//        lci.validerMappageLCMOrControle(Constante.tableOrFcLc, "FACTURECLIENTLC", ff.getRemarque(), u.getTuppleID(), c);
//        fi.viserOr(Utilitaire.formatterDaty(conf.getDaty()), conf.getRemarque(), ff.getRemarque(), u.getTuppleID(), c);
//        user.savePrevision(ff.getRemarque(), "ORPREVISION", "ORDONNERRECETTE", c);

        System.out.println("OKKK visa OR ");

        String mvmax = Utilitaire.makePK(6, "MVT", "getseqmvt");
        String[] g = Utilitaire.split(mvmax, "MVT");
        String idmvtor = "SMOR" + g[0] + 1;
        String idEtablissement = conf.getEtablissement();
        String numeroCheque = "-";
        if (!"pay2".equalsIgnoreCase(conf.getMode())) {
            numeroCheque = "-";
            idEtablissement = "-";
        }

        String[] numObjets = Utilitaire.split(ff.getRemarque(), "<br/>");
        OrdonnerPayement o = new OrdonnerPayement();
        o.setNomTable("orapayer");
        String retour = null;
        String[] lmvt = new String[numObjets.length];
        int k = 0;

//        for (int j = 0; j < numObjets.length; j++) {
//            OrdonnerPayement[] lop = (OrdonnerPayement[]) CGenUtil.rechercher(o, null, null, c, " and id='" + numObjets[j] + "'");
//            retour = finance.createMvtCaisseRecette(Utilitaire.formatterDaty(conf.getDaty()), "",
//                    "Paiement scolarite " + conf.getRemarque(), "" + lop[0].getMontant(), conf.getDevise(),
//                    conf.getModepaiement(), conf.getCaisse(), conf.getRemarque(),
//                    "-", conf.getEtudiant(), "-",
//                    "1", numObjets[j], numeroCheque, idEtablissement, idmvtor, u.getTuppleID(), c);
//            lmvt[k] = retour;
//            k++;
//        }
//        user.saveMvtOr(idmvtor, lmvt[0], ff.getRemarque(), c);
        System.out.println("-------------Final-----------");
        System.out.println("OKKK Paiement");
        System.out.println("-------------Final-----------");

        System.out.println("-------------objet taloha-----------");
        System.out.println("Ecolage:" + conf.getEcolage());
        System.out.println("Food:" + conf.getFood());
        System.out.println("Etablissement" + conf.getEtablissement());
        System.out.println("Transport" + conf.getTransport());
        System.out.println("Autre" + conf.getAutre());
        System.out.println("Total" + conf.getMontant_total());
        System.out.println("-------------objet taloha-----------");

        System.out.println("-------------objet temp-----------");
        System.out.println("Ecolage:" + temp.getEcolage());
        System.out.println("Food:" + temp.getFood());
        System.out.println("Etablissement" + temp.getEtablissement());
        System.out.println("Transport" + temp.getTransport());
        System.out.println("Autre" + temp.getAutre());
        System.out.println("Total" + temp.getMontant_total());
        System.out.println("-------------objet temp-----------");

        conf.construirePK(c);
        conf.insertToTableWithHisto(u.getTuppleID(), c);
        return conf;
    }

    public void insertEdition(Edition edition, Connection c, MapUtilisateur u) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                indice = 1;
                c.setAutoCommit(false);
            }
            Edition[] tEdition = (Edition[]) CGenUtil.rechercher(new Edition(), null, null, c, " and annee = "+edition.getAnnee());
            if(tEdition.length > 0){
                throw new Exception("Annee "+edition.getAnnee()+" existant");
            }
            
            EtudiantTiers[] tEtudiantTiers = (EtudiantTiers[]) CGenUtil.rechercher(new EtudiantTiers(), null, null, c, " ");
            if(tEtudiantTiers.length == 0){
                throw new Exception("Etudiant introuvable");
            }
            
            for(int a=0; a < tEtudiantTiers.length; a++ ){
                Edition[] tEditions = (Edition[]) CGenUtil.rechercher(new Edition(), null, null, c, " and idetudiant = '"+tEtudiantTiers[a].getIdetudiant()+"' order by annee, mois");
                if(tEditions.length > 0){
                    for(int i=1; i<=12; i++){
                        edition.setIdetudiant(tEtudiantTiers[a].getIdetudiant());
                        edition.setEcolagedu(tEditions[tEditions.length-1].getEcolagedu());
                        edition.construirePK(c);
                        edition.setMois(i);
                        edition.insertToTableWithHisto(u.getTuppleID(), c);
                    }
                }
            }
            if (indice == 1) {
                c.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (indice == 1 && c != null) {
                c.close();
            }
        }
    }
    public void insertAnneeScolaire(AnneeScolaire anneeScolaire, Connection c, MapUtilisateur u) throws Exception {
        int indice = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                indice = 1;
                c.setAutoCommit(false);
            }
            AnneeScolaire[] tAnneeScolaire = (AnneeScolaire[]) CGenUtil.rechercher(new AnneeScolaire(), null, null, c, " and nom='"+anneeScolaire.getNom()+"'");
            if(tAnneeScolaire.length > 0){
                throw new Exception("Erreur! Annee scolaire existant");
            } 
            else
            {
                
                anneeScolaire.construirePK(c);
                anneeScolaire.insertToTableWithHisto(u.getTuppleID(), c);;
               
            }
            if (indice == 1) {
                c.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (indice == 1 && c != null) {
                c.close();
            }
        }
    }
    
    public void inscriptionEtudiantAnneeScolaire(InscriptionEtudiant inscriptionEtudiant, Connection c, MapUtilisateur u) throws Exception {
        int indice = 0;
        try {
            boolean testInscri=inscriptionEtudiant.isExist(c);
            if(testInscri==true){
                throw new Exception("Erreur! Etudiant deja inscrit");
            } 
            else
            {  
                String idTarif=inscriptionEtudiant.getTarif(c).getId();
                System.out.println(idTarif);
                inscriptionEtudiant.setIdTarif(idTarif);
                FactureMere factureMere=new FactureMere();
                factureMere.setMois(inscriptionEtudiant.getMoisDebut());
                factureMere.setAnnee(inscriptionEtudiant.getAnnee(c));
                factureMere.setIdetudiant(inscriptionEtudiant.getIdEtudiant());
                System.out.println("------------facture--------------");
               
                System.out.println("facturemere mois : "+factureMere.getMois());
                System.out.println("facturemere annee : "+factureMere.getAnnee());
                System.out.println("facturemere idetudiant : "+factureMere.getIdetudiant());
                inscriptionEtudiant.construirePK(c);
                inscriptionEtudiant.insertToTableWithHisto(u.getTuppleID(), c);
                factureMere.construirePK(c);
                factureMere.insertToTableWithHisto(u.getTuppleID(), c);
                System.out.println("facturemere mere : "+factureMere.getId());
                FactureFille fraisInscription=new FactureFille();
                inscriptionEtudiant.setIdTarif("Once off Registration fee");
                fraisInscription.setDesignation(inscriptionEtudiant.getTarif(c).getDesignation()+"(inscription)");
                fraisInscription.setMontant(inscriptionEtudiant.getTarif(c).getMontant());
                fraisInscription.setIdfacturemere(factureMere.getId());
                FactureFille stationnery=new FactureFille();
                inscriptionEtudiant.setIdTarif("Stationary and toiletries");
                stationnery.setDesignation(inscriptionEtudiant.getTarif(c).getDesignation()+"(Station)");
                stationnery.setMontant(inscriptionEtudiant.getTarif(c).getMontant());
                stationnery.setIdfacturemere(factureMere.getId());
                fraisInscription.construirePK(c);
                fraisInscription.insertToTableWithHisto(u.getTuppleID(), c);
                stationnery.construirePK(c);
                stationnery.insertToTableWithHisto(u.getTuppleID(), c);
               
            }
            if (indice == 1) {
                c.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (indice == 1 && c != null) {
                c.close();
            }
        }
    }
    

   

}
