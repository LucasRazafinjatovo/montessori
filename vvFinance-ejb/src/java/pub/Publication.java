package pub;

import bean.*;
import java.sql.Connection;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class Publication extends ClassMAPTable {

    public Publication() {
        super.setNomTable("Publication");
    }

    public void construirePK(Connection c) throws Exception {
        super.setNomTable("Publication");
        //this.preparePk("PLT","getSeqPublication"); ank
        this.preparePk("PBL", "getSeqPublication");
        this.setId(makePK(c));
    }

    public Publication(String dat, String journ, String numP, String datyP, String nbp, String nbEx, String rem, String j, String h, String rub) throws Exception {
        super.setNomTable("Publication");
        this.preparePk("PBL", "getSeqPublication");
        this.setId(makePK());
        this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy", dat));
        this.setJournal(journ);
        this.setNumParution((numP));
        this.setDatyParution(utilitaire.Utilitaire.string_date("dd/MM/yyyy", datyP));
        this.setNbpage(utilitaire.Utilitaire.stringToInt(nbp));
        this.setNbexth(utilitaire.Utilitaire.stringToInt(nbEx));
        this.setRemarque(rem);
        this.setJour(j);
        this.setHeure(h);
        this.setRubrique(rub);
    }

    public void controler(Connection c) throws Exception {

    }

    public void controlerUpdate(Connection c) throws Exception {
        /*Publication crt = new Publication();
        Parution pa = new Parution();
        pa.setJournal(this.getJournal());
        Parution[] par = (Parution[]) CGenUtil.rechercher(pa, null, null, c, " and numParution=" + this.getNumParution());
        if (par.length == 0) {
            throw new Exception("Pas de parution existante");
        }
        this.setNumParution(par[0].getId());
        crt.setNumParution(this.getNumParution());
        if (CGenUtil.rechercher(crt, null, null, c, " and id<>'" + this.getId() + "'").length > 0) {
            throw new Exception("Publication deja existante");
        }*/
    }
    String id;
    java.sql.Date daty;
    String journal;
    java.sql.Date datyParution;
    int nbpage;
    int nbexth;
    String remarque;
    String numParution;
    String jour;
    String heure;
    String rubrique;
    String parametre;
    private double nbexhuit;

    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return id;
    }

    public void setDaty(java.sql.Date daty) {
        this.daty = daty;
    }

    public java.sql.Date getDaty() {
        return daty;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public String getJournal() {
        return journal;
    }

    public void setNumParution(String numParution) {
        this.numParution = numParution;
    }

    public String getNumParution() {
        return numParution;
    }

    public void setDatyParution(java.sql.Date datyParution) {
        this.datyParution = datyParution;
    }

    public java.sql.Date getDatyParution() {
        return datyParution;
    }

    public void setNbpage(int nbpage) throws Exception {
        if (nbpage == 0) {
            throw new Exception("nombre non valide");
        }
        this.nbpage = nbpage;
    }

    public int getNbpage() {
        return nbpage;
    }

    public void setNbexth(int nbexth) throws Exception {
        if (nbexth == 0) {
            throw new Exception("nombre non valide");
        }
        this.nbexth = nbexth;
    }

    public int getNbexth() {
        return nbexth;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getRemarque() {
        return remarque;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getJour() {
        return jour;
    }

    public void setJour(String jour) {
        this.jour = jour;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }

    public String getHeure() {
        return heure;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public String getRubrique() {
        return rubrique;
    }

    public String getParametre() {
        return parametre;
    }

    public void setParametre(String param) throws Exception {
        if (param.compareToIgnoreCase("") == 0 || param == null) {
            throw new Exception("le champ Parametre ne doit pas etre vide");
        }
        this.parametre = param;
    }

    public void setNbexhuit(double nbexhuit) {
        this.nbexhuit = nbexhuit;
    }

    public double getNbexhuit() {
        return nbexhuit;
    }
}
