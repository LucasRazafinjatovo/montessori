/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.vv.service;

import bean.ClassMAPTable;

/**
 *
 * @author ando
 */
public class ImportJournalPrise extends ClassMAPTable {

    private String noms;
    private String journaux;
    private int parution;
    private int prises;
    private int prix;

    public String getNoms() {
        return noms;
    }

    public int getPrises() {
        return prises;
    }

    public void setPrises(int prises) {
        this.prises = prises;
    }

    public void setNoms(String noms) {
        this.noms = noms;
    }

    public String getJournaux() {
        return journaux;
    }

    public void setJournaux(String journaux) {
        this.journaux = journaux;
    }

    public int getParution() {
        return parution;
    }

    public void setParution(int parution) {
        this.parution = parution;
    }

    public int getPrix() {
        return prix;
    }

    public void setPrix(int prix) {
        this.prix = prix;
    }

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
