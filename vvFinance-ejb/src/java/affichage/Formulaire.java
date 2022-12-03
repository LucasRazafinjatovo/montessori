package affichage;

import bean.ListeColonneTable;
import java.util.Vector;
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
public class Formulaire {

    private Champ[] listeChamp;
    private String id;
    private int nbRangee = 2;
    private String html;
    private String tailleTableau = "100%";
    private String cssTableau = "monographe";
    private bean.ClassMAPTable objet;
    private Champ[] crtFormu;
    private int nbIntervalle = 0;
    private String htmlTri;
    private String htmlButton;
    private String htmlInsert;
    private Champ[] champGroupe;
    private Champ[] champTableauAff;
    private String htmlGroupe;
    private String htmlTableauAff;

    public Formulaire() {
    }

    public static Champ[] transformerEnChamp(String[] list) {
        Champ[] ret = new Champ[list.length];
        for (int i = 0; i < list.length; i++) {
            ret[i] = new Champ(list[i]);
        }
        return ret;
    }

    public void changerEnChamp(Champ[] list) throws Exception {
        int nombre = list.length;
        for (int i = 0; i < nombre; i++) {
            for (int j = 0; j < listeChamp.length; j++) {
                if (listeChamp[j].getNom().compareToIgnoreCase(list[i].getNom()) == 0) {
                    if (list[i].getValeur() == null || list[i].getValeur().compareToIgnoreCase("") == 0) {
                        list[i].setValeur(listeChamp[j].getValeur());
                    }
                    if (list[i].getNom().compareToIgnoreCase("mois2") == 0) {
                        ((Liste) (list[i])).setDefaultSelected("12");
                        //System.out.println("niditra "+i+" nom = "+list[i].getNom());
                    }
                    listeChamp[j] = list[i];
                    break;
                }
            }
        }
    }

    public Formulaire(Champ[] listeC, int range) {
        setListeChamp(listeC);
        setNbRangee(range);
    }

    public Formulaire(String[] listeC, int range) {
        setListeChamp(transformerEnChamp(listeC));
        setNbRangee(range);
    }

    public String makeHtmlForm() throws Exception {
        String retour = "";
        //retour+="<form action="++"?but="++" method='post' name='formu'";
        return retour;
    }

    public void makeHtmlTri() throws Exception {
        String temp = "<br><table width=" + getTailleTableau() + "><tr><strong><font color='#FF0000' size=1>TRIER PAR </font></strong></tr>";
        temp += "<tr>";
        temp += "<td> Colonne </td>";
        temp += "<td>" + getListeChamp()[getListeChamp().length - 2].getHtml() + "</td>";
        temp += "<td> Ordre </td>";
        temp += "<td>" + getListeChamp()[getListeChamp().length - 1].getHtml() + "</td>";
        temp += "</tr>";
        temp += "</table>";
        setHtmlTri(temp);
    }

    public String makeHtmlButton() {
        String temp = "<br>";
        temp += "<table width=" + getTailleTableau() + " border=0 cellspacing=0 cellpadding=0><tr>";
        temp += "<td align=center> <input type=submit name=Submit value='Afficher' class='submit'></td>";
        temp += "<td align=center> <input type=reset name=Submit value='annuler' class='submit'></td></tr>";
        temp += "</table>";
        return temp;
    }

    public Champ[] getListeIntervalle() {
        Vector ret = new Vector();
        for (int i = 0; i < getListeChamp().length; i++) {
            if (getListeChamp()[i].getEstIntervalle() == 1) {
                ret.add(getListeChamp()[i]);
            }
        }
        Champ[] retour = new Champ[ret.size()];
        ret.copyInto(retour);
        return retour;
    }

    public String getHtmlEnsemble() throws Exception {
        String temp = getHtml();
        temp += getHtmlTri();
        temp += makeHtmlButton();
        makeHtmlGroupe();
        temp += getHtmlGroupe();
        makeHtmlTableauAff();
        temp += getHtmlTableauAff();
        return temp;
    }

    public Champ getChamp(String nomChamp) {
        for (int i = 0; i < getListeChamp().length; i++) {
            if (getListeChamp()[i].getNom().compareToIgnoreCase(nomChamp) == 0) {
                return getListeChamp()[i];
            }
        }
        return null;
    }

    public void changerLibelle(String[] libelle) throws Exception {
        if (libelle.length != getListeChamp().length) {
            throw new Exception("nombre de champ different de linitial");
        }
        for (int i = 0; i < getListeChamp().length; i++) {
            getListeChamp()[i].setLibelle(libelle[i]);
        }
    }

    public void makeChampFormu(String[] crt, String[] listeInterval, int nbRange) throws Exception {
        setCrtFormu(transformerEnChamp(crt));
        Vector liste = new Vector();
        for (int i = 0; i < crt.length; i++) {
            System.out.println("Criter ::: "+crt[i]);
            String type = ListeColonneTable.getChamp(getObjet(), crt[i]).getTypeColonne();
            if (utilitaire.Utilitaire.estIlDedans(crt[i], listeInterval) != -1) //On fait des intervalles pour les valeurs dates et montant
            {
                getCrtFormu()[i].setEstIntervalle(1);
                setNbIntervalle(getNbIntervalle() + 1);
                String t1 = crt[i] + "1";
                String t2 = crt[i] + "2";
                liste.add(new Champ(t1));
                liste.add(new Champ(t2));
                if (type.compareToIgnoreCase("java.sql.Date") == 0) {
                    getCrtFormu()[i].setTypeData(ConstanteAffichage.typeDaty);
                }
            } else {
                liste.add(new Champ(crt[i]));
            }
        }
        bean.Champ[] nomCol = ListeColonneTable.getFromListe(getObjet(), null);
        Champ col = new Liste("colonne", nomCol);
        String[] val = {"DESC", "ASC"};
        Champ ord = new Liste("ordre", val);
        liste.add(col);
        liste.add(ord);
        Champ[] listeForm = new Champ[liste.size()];
        liste.copyInto(listeForm);
        setListeChamp(listeForm);
        setNbRangee(nbRange);
    }

    public void makeChampFormuInsert() throws Exception {
    }

    public void makeHtml() throws Exception {
        String temp = "";
        //temp+="<form action="++"?but="++" method='post' name='formu'";
        temp += "<table width=" + getTailleTableau() + " border='0' align='center' cellpadding=2 cellspacing=0 class=" + getCssTableau() + ">";
        int reste = listeChamp.length % getNbRangee();
        int nombreLigne = 0;
        if (reste != 0) {
            nombreLigne = listeChamp.length / getNbRangee();
        } else {
            nombreLigne = (listeChamp.length / getNbRangee()) + 1;
        }
        for (int i = 0; i < nombreLigne; i++) {
            temp += "<tr>";
            for (int j = 0; j < getNbRangee(); j++) {
                if (((i * getNbRangee()) + j) >= listeChamp.length - 2) {
                    break;
                }
                Champ c = listeChamp[(i * getNbRangee()) + j];
                String troisiemeTd = "";
                if (c.getTypeData() != null && c.getTypeData().compareToIgnoreCase(ConstanteAffichage.typeDaty) == 0) {
                    troisiemeTd = "<a href='javascript:cal.popup()'><img src='calendar/img/cal.gif' alt='Cliquez ici pour choisir une date' width=16 height=16 border=0 align='absmiddle' /></a>";
                }
                if (c.getPageAppel() != null && c.getPageAppel().compareToIgnoreCase("") != 0) {
                    troisiemeTd = "<input name='choix' type='button' class='submit' onclick=pagePopUp('" + c.getPageAppel() + "?champReturn=" + c.getNom() + "') value=... />";
                }
                temp += "<td align=left class=" + c.getCssLibelle() + ">" + c.getLibelleAffiche() + "</td>";
                temp += "<td align=center class=" + c.getCss() + ">" + c.getHtml() + "</td>";
                temp += "<td>" + troisiemeTd + "</td>";
            }
            temp += "</tr>";
        }
        temp += "</table>";
        setHtml(temp);
    }

    public void makeChampTableauAffiche(int nbTabAffiche, String[] defaut) throws Exception {
        Champ[] listeAff = new Champ[nbTabAffiche];
        bean.Champ[] nomCol = ListeColonneTable.getFromListe(getObjet(), null);
        String valeur[] = new String[nomCol.length + 1];
        valeur[0] = "-";
        for (int k = 0; k < nomCol.length; k++) {
            valeur[k + 1] = nomCol[k].getNomColonne();
        }
        for (int i = 0; i < nbTabAffiche; i++) {
            listeAff[i] = new Liste("colAffiche" + (i + 1), valeur);
            ((Liste) (listeAff[i])).setDefaultSelected(defaut[i]);
        }
        setChampTableauAff(listeAff);
    }

    public void makeChampGroupe(int nombreChamp, int nbsomme) throws Exception {
        Champ[] listeGroupe = new Champ[nombreChamp + nbsomme];
        bean.Champ[] nomCol = ListeColonneTable.getFromListe(getObjet(), null);
        String valeur[] = new String[nomCol.length + 1];
        valeur[0] = "-";
        for (int k = 0; k < nomCol.length; k++) {
            valeur[k + 1] = nomCol[k].getNomColonne();
        }
        //Champ col=new Liste("colonne",nomCol);
        for (int i = 0; i < nombreChamp + nbsomme; i++) {
            if (i < nombreChamp) {
                listeGroupe[i] = new Liste("colGroupe" + (i + 1), valeur);
            } else {
                listeGroupe[i] = new Liste("colSomme" + (i + 1), valeur);
            }
        }
        setChampGroupe(listeGroupe);
    }

    public void makeHtmlTableauAff() throws Exception {
        if (getChampTableauAff() == null) {
            setHtmlTableauAff("");
            return;
        }
        String temp = "";
        temp += "<table width=" + getTailleTableau() + " border='0' align='center' cellpadding=2 cellspacing=0 class=" + getCssTableau() + ">";
        int reste = getChampTableauAff().length % getNbRangee();
        int nombreLigne = 0;
        if (reste != 0) {
            nombreLigne = getChampTableauAff().length / getNbRangee() + 1;
        } else {
            nombreLigne = (getChampTableauAff().length / getNbRangee());
        }
        for (int i = 0; i < nombreLigne; i++) {
            temp += "<tr>";
            for (int j = 0; j < getNbRangee(); j++) {
                if (((i * getNbRangee()) + j) == getChampTableauAff().length) {
                    break;
                }
                Champ c = getChampTableauAff()[(i * getNbRangee()) + j];
                temp += "<td align=left class=" + c.getCssLibelle() + ">" + c.getLibelleAffiche() + "</td>";
                temp += "<td align=center class=" + c.getCss() + ">" + c.getHtml() + "</td>";
            }
            temp += "</tr>";
        }
        temp += "</table>";
        setHtmlTableauAff(temp);
    }

    public void makeHtmlGroupe() throws Exception {
        if (getChampGroupe() == null) {
            setHtmlGroupe("");
            return;
        }
        String temp = "";
        //temp+="<form action="++"?but="++" method='post' name='formu'";
        temp += "<table width=" + getTailleTableau() + " border='0' align='center' cellpadding=2 cellspacing=0 class=" + getCssTableau() + ">";
        int reste = getChampGroupe().length % getNbRangee();
        int nombreLigne = 0;
        if (reste != 0) {
            nombreLigne = getChampGroupe().length / getNbRangee() + 1;
        } else {
            nombreLigne = (getChampGroupe().length / getNbRangee());
        }
        for (int i = 0; i < nombreLigne; i++) {
            temp += "<tr>";
            for (int j = 0; j < getNbRangee(); j++) {
                if (((i * getNbRangee()) + j) == getChampGroupe().length) {
                    break;
                }
                Champ c = getChampGroupe()[(i * getNbRangee()) + j];
                temp += "<td align=left class=" + c.getCssLibelle() + ">" + c.getLibelleAffiche() + "</td>";
                temp += "<td align=center class=" + c.getCss() + ">" + c.getHtml() + "</td>";
            }
            temp += "</tr>";
        }
        temp += "</table>";
        setHtmlGroupe(temp);
    }

    public void setLibelleAffiche(String[] liste) {
        for (int i = 0; i < liste.length; i++) {
            listeChamp[i].setLibelleAffiche(liste[i]);
        }
    }

    public void setLibelleAffiche(String libelle, int numeroLib) {
        listeChamp[numeroLib].setLibelleAffiche(libelle);
    }

    public void makeHtmlInsert() throws Exception {
        String temp = "";
        temp += "<table width=60% class=" + getCssTableau() + ">";
        Champ[] listeC = getListeChamp();
        for (int i = 0; i < listeC.length; i++) {
            String troisiemeTd = "";
            if (listeC[i].getVisible() == true) {
                temp += "<tr>";
                temp += "<td align=rigth width=30% class=" + listeC[i].getCssLibelle() + ">" + listeC[i].getLibelle() + "</td>";
                temp += "<td align=center width=70%>" + listeC[i].getHtmlInsert() + "</td>";
                if (listeC[i].getPageAppel() != null && listeC[i].getPageAppel().compareToIgnoreCase("") != 0) {
                    troisiemeTd = "<input name='choix' type='button' class='submit' onclick=pagePopUp('" + listeC[i].getPageAppel() + "?champReturn=" + listeC[i].getNom() + "') value=... />";
                }
                temp += "<td>" + troisiemeTd + "</td>";
                temp += "</tr>";
            }
        }
        temp += "</table>";

        setHtmlInsert(temp);
    }

    public void makeHtmlInsertTabIndex() throws Exception {
        String temp = "";
        temp += "<table width=60%>";
        temp += "<tr>";
        temp += "<td>";
        temp += "<table width=100% class=" + getCssTableau() + ">";
        for (int i = 0; i < getListeChamp().length; i++) {
            Champ c = getListeChamp()[i];
            String troisiemeTd = "";
            if (c.getVisible() == true) {
                temp += "<tr>";
                c.setAutre("tabindex='" + (i + 1) + "'" + c.getAutre());
                temp += "<td align=rigth width=30% class=" + getListeChamp()[i].getCssLibelle() + ">" + getListeChamp()[i].getLibelle() + "</td>";
                temp += "<td align=center width=60%>" + getListeChamp()[i].getHtmlInsert() + "</td>";
                if (c.getPageAppel() != null && c.getPageAppel().compareToIgnoreCase("") != 0) {
                    troisiemeTd = "<input name='choix' type='button' class='submit' onclick=pagePopUp('" + c.getPageAppel() + "?champReturn=" + c.getNom() + "') value=... />";
                    temp += "<td width=10%>" + troisiemeTd + "</td>";
                } else {
                    temp += "<td width=10%></td>";
                }
                temp += "</tr>";
            }
        }
        temp += "</table>";
        temp += "</td>";
        temp += "</tr>";
        temp += "<tr>";
        temp += "<td>";
        temp += "<table width=100%>";
        temp += "<tr>";
        temp += "<td align='center'>";
        temp += "<input type='submit' name='Submit2' value='valider' class='submit' tabIndex='" + getListeChamp().length + 1 + "'>";
        temp += "</td>";
        temp += "<td align='center'>";
        temp += "<input type='reset' name='Submit2' value='Annuler' class='submit' tabIndex='" + getListeChamp().length + 2 + "'>";
        temp += "</td>";
        temp += "</tr>";
        temp += "</table>";
        temp += "</td>";
        temp += "</tr>";
        temp += "</table>";
        setHtmlInsert(temp);
    }

    public String getBoutonsValiderAnnulerTabIndex() {
        String temp = "";
        temp += "<input type='submit' name='Submit2' value='valider' class='submit' tabIndex='" + getListeChamp().length + 1 + "'>";
        temp += "<input type='reset' name='Submit2' value='Annuler' class='submit' tabIndex='" + getListeChamp().length + 2 + "'>";
        return temp;
    }

    public String getListeCritereString() {
        String retour = "";
        for (int i = 0; i < getListeChamp().length; i++) {
            Champ temp = getListeChamp()[i];
            String valeur = temp.getValeur();
            if (temp.getTypeData().compareToIgnoreCase(ConstanteAffichage.typeTexte) == 0) {
                valeur = utilitaire.Utilitaire.remplacePourcentage(valeur);
            }
            retour += "&" + temp.getNom() + "=" + valeur;
        }
        if (getChampGroupe() != null) {
            for (int j = 0; j < getChampGroupe().length; j++) {
                Champ temp = getChampGroupe()[j];
                String valeur = temp.getValeur();
                if (temp.getTypeData().compareToIgnoreCase(ConstanteAffichage.typeTexte) == 0) {
                    valeur = utilitaire.Utilitaire.remplacePourcentage(valeur);
                }
                retour += "&" + temp.getNom() + "=" + valeur;
            }
        }
        if (getChampTableauAff() != null) {
            for (int j = 0; j < getChampTableauAff().length; j++) {
                Champ temp = getChampTableauAff()[j];
                String valeur = temp.getValeur();
                if (temp.getTypeData().compareToIgnoreCase(ConstanteAffichage.typeTexte) == 0) {
                    valeur = utilitaire.Utilitaire.remplacePourcentage(valeur);
                }
                retour += "&" + temp.getNom() + "=" + valeur;
            }
        }
        return retour;
    }

    public void getAllData(Connection c) throws Exception {
        for (int i = 0; i < getListeChamp().length; i++) {
            getListeChamp()[i].findData(c);
        }
    }

    public Champ[] getListeChamp() {
        return listeChamp;
    }

    public void setListeChamp(Champ[] listeChamp) {
        this.listeChamp = listeChamp;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setNbRangee(int nbRangee) {
        this.nbRangee = nbRangee;
    }

    public int getNbRangee() {
        return nbRangee;
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

    public void setTailleTableau(String tailleTableau) {
        this.tailleTableau = tailleTableau;
    }

    public String getTailleTableau() {
        return tailleTableau;
    }

    public void setCssTableau(String cssTableau) {
        this.cssTableau = cssTableau;
    }

    public String getCssTableau() {
        return cssTableau;
    }

    public void setObjet(bean.ClassMAPTable objet) {
        this.objet = objet;
    }

    public bean.ClassMAPTable getObjet() {
        return objet;
    }

    public void setCrtFormu(Champ[] crtFormu) {
        this.crtFormu = crtFormu;
    }

    public Champ[] getCrtFormu() {
        return crtFormu;
    }

    public void setNbIntervalle(int nbIntervalle) {
        this.nbIntervalle = nbIntervalle;
    }

    public int getNbIntervalle() {
        return nbIntervalle;
    }

    public void setHtmlTri(String htmlTri) {
        this.htmlTri = htmlTri;
    }

    public String getHtmlTri() throws Exception {
        if (htmlTri == null || htmlTri.compareToIgnoreCase("") == 0) {
            this.makeHtmlTri();
        }
        return htmlTri;
    }

    public void setHtmlButton(String htmlButton) {
        this.htmlButton = htmlButton;
    }

    public String getHtmlButton() {
        return htmlButton;
    }

    public void setHtmlInsert(String htmlInsert) {
        this.htmlInsert = htmlInsert;
    }

    public String getHtmlInsert() throws Exception {
        if (htmlInsert == null || htmlInsert.compareToIgnoreCase("") == 0) {
            makeHtmlInsert();
        }
        return htmlInsert;
    }

    public void setChampGroupe(Champ[] champGroupe) {
        this.champGroupe = champGroupe;
    }

    public Champ[] getChampGroupe() {
        return champGroupe;
    }

    public void setHtmlGroupe(String htmlGroupe) {
        this.htmlGroupe = htmlGroupe;
    }

    public String getHtmlGroupe() {
        return htmlGroupe;
    }

    public Champ[] getChampTableauAff() {
        return champTableauAff;
    }

    public void setChampTableauAff(Champ[] champTableauAff) {
        this.champTableauAff = champTableauAff;
    }

    public String getHtmlTableauAff() {
        return htmlTableauAff;
    }

    public void setHtmlTableauAff(String htmlTableauAff) {
        this.htmlTableauAff = htmlTableauAff;
    }
}
