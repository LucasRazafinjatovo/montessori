/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.vv.service;

/**
 *
 * @author ando
 */
public class MotifNonTrouve {

    private String motif;
    private String noms;
    private String journaux;
    private int parution;
    private String prix;
    
    public MotifNonTrouve(ImportJournalInvendu imp, String motif) {
        
        this.setMotif(motif);
        this.setNoms(imp.getNoms());
        this.setJournaux(imp.getJournaux());
        this.setParution(imp.getParution());
        
    }
    
    public MotifNonTrouve(ImportJournalPrise imp, String motif) {
        
        this.setMotif(motif);
        this.setNoms(imp.getNoms());
        this.setJournaux(imp.getJournaux());
        this.setParution(imp.getParution());
        
    }

    public String getNoms() {
        return noms;
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

    public String getPrix() {
        return prix;
    }

    public void setPrix(String prix) {
        this.prix = prix;
    }
    
    
    
    

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }
    
    
}
