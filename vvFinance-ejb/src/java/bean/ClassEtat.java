/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import utilitaire.ConstanteEtat;

/**
 *
 * @author GILEADA
 */
public abstract class ClassEtat extends ClassUser{

    int etat = 1;

    public int getEtat() {
        return etat;
    }
    
    public void setEtat(int etat) {
        this.etat = etat;
    }
    
    public String getEtatText(int value){
        return chaineEtat(value);
    }
    public String chaineEtat(int value){
        if(value == ConstanteEtat.getEtatCreer()) return "<b style='color:lightskyblue'>CR&Eacute;&Eacute;(E)</b>";
       if(value == ConstanteEtat.getEtatPrivilegerRetourRelance()) return "<b style='color:green'>AVEC PRIVILEGE </b>";
        if(value == ConstanteEtat.getEtatValider()) return "<b style='color:green'>VIS&Eacute;(E)</b>";
        if(value == ConstanteEtat.getEtatAnnuler()) return "<b style='color:orange'>ANNUL&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatCloture()) return "<b style='color:orange'>CLOTUR&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatRejeter()) return "<b style='color:red'>REJET&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatretourner()) return "<b style='color:green'>RETOURN&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatCourrierRecu()) return "<b style='color:green'>RE&Ccedil;U(E)</b>";
        if(value==ConstanteEtat.getEtatPretRetour()) return "<b style='color:green'>RETOURN&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatCourrierEntrant()) return "<b style='color:black'>COURRIER ENTRANT</b>";
        if(value==ConstanteEtat.getEtatCourrierSortant()) return "<b style='color:black'>COURRIER SORTANT</b>";
        if(value==ConstanteEtat.getEtatCourrierRetourner()) return "<b style='color:red'>COURRIER RETOURN&Eacute;E</b>";
        return null;
    }
}
