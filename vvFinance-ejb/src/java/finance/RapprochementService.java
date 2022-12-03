package finance;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;
import bean.CGenUtil;
import java.util.ArrayList;
import java.util.List;

public class RapprochementService
{
  public double calculsolde(MvtCaisseTous[] gl, Rib[] releve)throws Exception {
        try{
            double solde = 0;
            double creditgl = 0;
            double creditr = 0;
            double debitgl = 0;
            double debitr = 0;
            double soldereleve = 0;
            double soldegl = 0;
            for (int i = 0; i < gl.length; i++) {
                if (gl[i] != null) {
                    creditgl = creditgl + (int)gl[i].getCredit();
                    debitgl = debitgl + (int)gl[i].getDebit();
                }
            }
            for (int i = 0; i < releve.length; i++) {
                if (releve[i] != null) {
                    creditr = creditr + (int)releve[i].getCredit();
                    debitr = debitr + (int)releve[i].getDebit();
                }
            }
            soldereleve = debitr - creditr;
            soldegl = debitgl - creditgl;
            solde = soldegl - soldereleve;
            return solde;
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
  
    // mise a jour date de mouvement
    public boolean updateDateMvtCaisseRib (MvtCaisseTous[] mvt, Date dateRib, String refUser, Connection c) throws Exception {
        try {
            for(int i = 0; i < mvt.length; i++){
                MvtCaisse mvtc = new MvtCaisse();
                mvtc.setNomTable("MVTCAISSE");
                MvtCaisse list = ((MvtCaisse[])CGenUtil.rechercher(mvtc, null, null, c, "AND ID = '"+mvt[i].getId()+"'"))[0];
                if(list.getDaty() != dateRib){
                    list.setDaty(dateRib);
                    list.setDatyValeur(dateRib);
                    list.updateToTableWithHisto(refUser, c);
                }
                System.out.println("mise a jour reussi = " );
            }
        } catch (Exception e) {
            throw e;
        }
        return false;
    }
  
    //rapprochement manuel
    public boolean rapprocher(Rib[] releve, MvtCaisseTous[] gl, String u, Connection c) throws Exception {

        try {
            String l = "AAA";
            double solde = 0;
            solde = calculsolde(gl, releve);
            // System.out.println("solde =============== " + solde);
            if (solde < 100) {
                String idLettre = null;
                String idreleve = null;
                String idgl = null;
                ComptaLettrageParam lettrage = new ComptaLettrageParam();
                String idcaisse = releve[0].getCaisse();
                int exercice = Utilitaire.getAnnee(releve[0].getDaty());
                String exerc = String.valueOf(exercice);
                lettrage.setId_compte_tiers(idcaisse);
                lettrage.setExercice(exerc);
                ComptaLettrageParam[] listeLettre = (ComptaLettrageParam[]) CGenUtil.rechercher(lettrage, null, null, c, " ORDER BY LETTRE DESC");
                if (listeLettre.length > 0) {
                    char[] a = listeLettre[listeLettre.length-1].getLettre().toCharArray();
                    l = Utilitaire.incrementLettre(a);
                }
                ComptaLettrageParam lettrageParam = new ComptaLettrageParam(idcaisse, exerc, l);
                lettrageParam.construirePK(c);
                lettrageParam.insertToTableWithHisto(u, c);
                RapproLettre rl = new RapproLettre(l, releve[0].getDaty(), "manuel");
                rl.construirePK(c);
                rl.insertToTableWithHisto(u, c);
                idLettre = rl.getId();
                for (int i = 0; i < releve.length; i++) {
                    idreleve = releve[i].getId();
                    RapproSousReleve rsr = new RapproSousReleve(idLettre, idreleve);
                    rsr.construirePK(c);
                    rsr.insertToTableWithHisto(u, c);
                    //System.out.println("idlettreR="+rsr.getIdraprolettre());
                   // System.out.println("idsousR="+rsr.getId());
                }
                for (int j = 0; j < gl.length; j++) {
                    idgl = gl[j].getId();
                    RapproSousMvtCaisse sec = new RapproSousMvtCaisse(idLettre, idgl);
                    sec.construirePK(c);
                    sec.insertToTableWithHisto(u, c);
                   // System.out.println("idlettreS="+sec.getIdraprolettre());
                   // System.out.println("idsousE="+sec.getId());
                }
                return true;
            } else {
                throw new Exception("Rapprochement non valide:motant non equilibré");
            }

        } catch (Exception e) {
            throw e;
        }

    }
    //rapprochement automatique
    public void lettrerAuto(Rib[] rl, MvtCaisseTous[] gl, String u, Connection c) throws Exception {

        try {
            Rib[] rel = new Rib[rl.length];
            MvtCaisseTous[] grandLivre = new MvtCaisseTous[gl.length];
            List<MvtCaisseTous> listmvt = new ArrayList();
            List<Rib> listrib = new ArrayList();
            int indice=0;
            for (int i = 0; i < gl.length; i++) {
                for (int j = 0; j < rl.length; j++) {
                  if(gl[i].getNumcheque()!=null && rl[j].getNumcheque()!=null)
                  {
                    if (gl[i].getNumcheque().compareToIgnoreCase(rl[j].getNumcheque())==0) {
                        if(gl[i].getCredit()==rl[j].getCredit() && gl[i].getDebit()==rl[j].getDebit())
                        {
                                listmvt.add(gl[i]);
                                listrib.add(rl[i]);
                                indice++;
                        }
                    }
                  }
                }

            }
            if(listmvt.size()>0){
                grandLivre = new MvtCaisseTous[listmvt.size()];
                rel = new Rib[listrib.size()];
                grandLivre = listmvt.toArray(grandLivre);
                rel = listrib.toArray(rel);
                rapprocher(rel, grandLivre, u, c);
            }

        } catch (Exception ex) {
            throw ex;
        }
    }
}