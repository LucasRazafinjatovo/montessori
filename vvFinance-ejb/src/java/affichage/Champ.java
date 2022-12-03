package affichage;

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
public class Champ {

    private String nom;
    private String defaut = "";
    private String css = "champ";
    private String type = ConstanteAffichage.typeTextBox;
    private String libelle;
    private String pageAppel;
    private String cssLibelle = "left";
    private String html;
    private int taille;
    private String valeur;
    private String typeData = ConstanteAffichage.typeTexte;
    private java.lang.reflect.Field attribut;
    private int estIntervalle = 0;
    private String autre;
    private String libelleAffiche;
    private String htmlInsert;
    private String ajax;
    private boolean visible = true;

    public Champ() {
    }

    public Champ(String nom) {
        setNom(nom);
    }

    public String toString() {
        return getNom();
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setDefaut(String defaut) {
        this.defaut = defaut;
    }

    public String getDefaut() {
        return defaut;
    }

    public void setCss(String css) {
        this.css = css;
    }

    public String getCss() {
        return css;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        if (libelle == null || libelle.compareToIgnoreCase("") == 0) {
            return nom;
        }
        return libelle;
    }

    public void setPageAppel(String pageAppel) {
        this.pageAppel = pageAppel;
    }

    public String getPageAppel() {
        return pageAppel;
    }

    public void setCssLibelle(String cssLibelle) {
        this.cssLibelle = cssLibelle;
    }

    public String getCssLibelle() {
        return cssLibelle;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public String getHtml() throws Exception {
        if (html == null || html.compareToIgnoreCase("") == 0) {
            this.makeHtml();
        }
        return html;
    }

    public void makeHtml() throws Exception {
        String temp = "";
        if (type.compareTo(ConstanteAffichage.textarea) == 0) {
            temp = "<textarea name=" + this.getNom() + " class=" + this.getCss() + "id=" + getNom() + "maxlength=" + getTaille() + ">" + getValeur() + "</textarea>";
        } else {
            temp = "<input name=" + getNom() + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + " value='" + getValeur() + "' " + getAutre() + ">";
        }
        setHtml(temp);
    }

    public void makeHtmlInsert() throws Exception {

    }

    public void setTaille(int taille) {
        this.taille = taille;
    }

    public int getTaille() {
        return taille;
    }

    public void setValeur(String valeur) {
        this.valeur = valeur;
    }

    public String getValeur() {
        if (valeur == null || valeur.compareToIgnoreCase("null") == 0 || valeur.compareToIgnoreCase("") == 0) {
            if (getDefaut() == null || getDefaut().compareToIgnoreCase("null") == 0) {
                return "";
            }
            return getDefaut();
        }
        return valeur;
    }

    public void setTypeData(String typeData) {
        this.typeData = typeData;
    }

    public String getTypeData() {
        return typeData;
    }

    public void setAttribut(java.lang.reflect.Field attribut) {
        this.attribut = attribut;
    }

    public java.lang.reflect.Field getAttribut() {
        return attribut;
    }

    public void setEstIntervalle(int estIntervalle) {
        this.estIntervalle = estIntervalle;
    }

    public int getEstIntervalle() {
        return estIntervalle;
    }

    public void findData(Connection c) throws Exception {
    }

    public void setAutre(String autre) {
        this.autre = autre;
    }

    public String getAutre() {
        if (autre == null) {
            return "";
        }
        return autre;
    }

    public void setLibelleAffiche(String libelleAffiche) {
        this.libelleAffiche = libelleAffiche;
    }

    public String getLibelleAffiche() {
        if (libelleAffiche == null || libelleAffiche.compareToIgnoreCase("") == 0) {
            return getLibelle();
        }
        return libelleAffiche;
    }

    public void setHtmlInsert(String htmlInsert) {
        this.htmlInsert = htmlInsert;
    }

    public String getHtmlInsert() throws Exception {
        if (htmlInsert == null || htmlInsert.compareToIgnoreCase("") == 0) {
            makeHtmlInsert();
        }
        if (htmlInsert == null || htmlInsert.compareToIgnoreCase("") == 0) {
            htmlInsert = getHtml();
        }
        return htmlInsert;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public boolean getVisible() {
        return visible;
    }

    public void setAjax(String ajax) {
        this.ajax = ajax;
    }

    public String getAjax() {
        return ajax;
    }
}
