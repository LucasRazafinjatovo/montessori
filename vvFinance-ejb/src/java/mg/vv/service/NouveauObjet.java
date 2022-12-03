package mg.vv.service;

public class NouveauObjet extends JournalImport {

    private String motif;

    public NouveauObjet(JournalImport journalImport, String motif) {
        this.setIdvendeur(journalImport.getIdvendeur());
        this.setJournal(journalImport.getJournal());
        this.setParution(journalImport.getParution());
        this.setSomme(journalImport.getSomme());
        this.setMotif(motif);
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }
     
}
