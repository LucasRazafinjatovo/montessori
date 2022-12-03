package affichage;

import java.lang.reflect.Field;
import bean.ClassMAPTable;
import javax.servlet.http.HttpServletRequest;

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
public class Page {

    Formulaire formu;
    private TableauRecherche tableau;
    private TableauRecherche tableauRecap;
    private String lien;
    private TableauRecherche tableauRegroup;
    private bean.ClassMAPTable base;
    private String titre;
    private user.UserEJB utilisateur;
    private String html;
    private javax.servlet.http.HttpServletRequest req;

    public Page() {
    }

    public Page(ClassMAPTable p, HttpServletRequest r) {
        setBase(p);
        setReq(r);
    }

    public void makeHtml() {

    }

    public Formulaire getFormu() {
        return formu;
    }

    public void setFormu(Formulaire formu) {
        this.formu = formu;
    }

    public void setTableau(TableauRecherche tableau) {
        this.tableau = tableau;
    }

    public TableauRecherche getTableau() {
        return tableau;
    }

    public void setBase(bean.ClassMAPTable base) {
        this.base = base;
    }

    public bean.ClassMAPTable getBase() {
        return base;
    }

    public void setLien(String lien) {
        this.lien = lien;
    }

    public String getLien() {
        return lien;
    }

    public TableauRecherche getTableauRecap() {
        return tableauRecap;
    }

    public void setTableauRecap(TableauRecherche tableauRecap) {
        this.tableauRecap = tableauRecap;
    }

    public void setTableauRegroup(TableauRecherche tableauRegroup) {
        this.tableauRegroup = tableauRegroup;
    }

    public TableauRecherche getTableauRegroup() {
        return tableauRegroup;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getTitre() {
        return titre;
    }

    public void setUtilisateur(user.UserEJB utilisateur) {
        this.utilisateur = utilisateur;
    }

    public user.UserEJB getUtilisateur() {
        return utilisateur;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public String getHtml() {
        if (html == null || html.compareToIgnoreCase("") == 0) {
            makeHtml();
        }
        return html;
    }

    public void setReq(javax.servlet.http.HttpServletRequest req) {
        this.req = req;
    }

    public javax.servlet.http.HttpServletRequest getReq() {
        return req;
    }

    public String getParamSansNull(String nomP) {
        String temp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        if ((temp != null) && temp.compareToIgnoreCase("") != 0) {
            return temp;
        }
        return "";
    }

    public void getValeurFormulaire() throws Exception {
        Champ[] c = formu.getListeChamp();
        for (int i = 0; i < c.length; i++) {
            String valeurRecup = getParamSansNull(c[i].getNom());

            c[i].setValeur(valeurRecup);
        }
        Champ[] f = formu.getChampGroupe();
        if (f != null) {
            for (int j = 0; j < f.length; j++) {
                f[j].setValeur(getParamSansNull(f[j].getNom()));
            }
        }
        Champ[] af = formu.getChampTableauAff();
        if (af != null) {
            for (int j = 0; j < af.length; j++) {
                af[j].setValeur(getParamSansNull(af[j].getNom()));
            }
        }
    }

    public ClassMAPTable getObjectAvecValeur() throws Exception {
        //Field[]tempChamp=getBase().getFieldList();
        Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
        for (int i = 0; i < tempChamp.length; i++) {
            Field f = tempChamp[i];
            //System.out.println("f.getType().getName() = " + f.getType().getName());
            String valeur = getParamSansNull(f.getName());
            //System.out.println("valeur = " + valeur + " === " + valeur.split("-").length+ " === " + valeur.split("-")[0]);
            if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                bean.CGenUtil.setValChamp(getBase(), f, valeur);
            }
            if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                if (valeur.split("-").length > 2) {
                    bean.CGenUtil.setValChamp(getBase(), f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", utilitaire.Utilitaire.convertDatyFormtoRealDatyFormat(valeur)));
                } else {
                    bean.CGenUtil.setValChamp(getBase(), f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
                }
            }
            if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                bean.CGenUtil.setValChamp(getBase(), f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
            }
            if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                if (valeur != null && valeur.compareToIgnoreCase("") != 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Integer(valeur));
                }
            }
            if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                bean.CGenUtil.setValChamp(getBase(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
            }
        }
        return getBase();
    }

    public void getValeurFormulaireMultiple() throws Exception {
        Champ[] c = formu.getListeChamp();
        for (int i = 0; i < c.length; i++) {
            String valeurRecup = getParamSansNullMultiple(c[i].getNom());
            c[i].setValeur(valeurRecup);
        }
        Champ[] f = formu.getChampGroupe();
        if (f != null) {
            for (int j = 0; j < f.length; j++) {
                f[j].setValeur(getParamSansNullMultiple(f[j].getNom()));
            }
        }
        Champ[] af = formu.getChampTableauAff();
        if (af != null) {
            for (int j = 0; j < af.length; j++) {
                af[j].setValeur(getParamSansNullMultiple(af[j].getNom()));
            }
        }
    }

    public String getParamSansNullMultiple(String nomP) {
        String[] listetemp = getReq().getParameterValues(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        String temp = "";
        if (listetemp != null) {
            temp = listetemp[0];
            for (int i = 1; i < listetemp.length; i++) {
                if (listetemp[i].compareToIgnoreCase("") != 0) {
                    temp = temp + "','" + listetemp[i];
                }
            }
        }
        if (nomP.compareTo("colonne") == 0 || nomP.compareTo("ordre") == 0) {
            temp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        }
        if ((temp != null) && temp.compareToIgnoreCase("") != 0) {
            return temp;
        }
        return "";
    }
}
