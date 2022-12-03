package mg.vv.service;

import bean.ClassMAPTable;

public class JournalImport extends ClassMAPTable {

    private String idvendeur,journal, parution, somme;

    public String getIdvendeur() {
        return idvendeur;
    }

    public void setIdvendeur(String idvendeur) {
        this.idvendeur = idvendeur;
    }

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public String getParution() {
        return parution;
    }

    public void setParution(String parution) {
        this.parution = parution;
    }

    public String getSomme() {
        return somme;
    }

    public void setSomme(String somme) {
        this.somme = somme;
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
