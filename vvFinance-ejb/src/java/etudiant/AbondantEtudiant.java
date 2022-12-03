package etudiant;
import java.sql.Connection;

import bean.ClassEtat;
public class AbondantEtudiant extends ClassEtat{
    String id;
    String idEtudiant;
    int mois;
    int annee;
    String motif;
    public AbondantEtudiant() {
        super.setNomTable("abondantetudiant");
      }
      public String getTuppleID(){
        return idEtudiant;
      }
      public String getAttributIDName(){
        return "id";
      }
     
       public String getId() {
         return id;
       }
       public void setId(String id) {
         this.id = id;
       }
       public String getIdEtudiant() {
        return idEtudiant;
    }

    public void setIdEtudiant(String idEtudiant) {
        this.idEtudiant = idEtudiant;
    }
    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }
    
    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }
    public void construirePK(Connection c) throws Exception{
        super.setNomTable("abondantetudiant");
        this.preparePk("ABN","getSeqAbondantEtudiant");
        this.setId(makePK(c));
      }

}
