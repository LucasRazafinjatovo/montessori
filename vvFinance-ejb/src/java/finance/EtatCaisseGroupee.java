/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package finance;

import java.sql.Date;
import bean.ClassMAPTable;

/**
 *
 * @author Murielle
 */
public class EtatCaisseGroupee extends ClassMAPTable {

    private Date daty;
    private String caisse;
    private double report;
    private double plafonnement;
    private double nrdebit;
    private double nrcredit;
    private double rdebit;
    private double rcredit;
    private double tdebit;
    private double tcredit;
    private double soldetheorique;
    private double soldepratique;

    public EtatCaisseGroupee() {
        this.setNomTable("etatcaissegroupe");
    }

    @Override
    public String getTuppleID() {
        return null;
    }

    @Override
    public String getAttributIDName() {
        return "";
    }

    public EtatCaisseGroupee(String caisse, double report, double rdebit, double rcredit, double nrdebit, double nrcredit, 
            double soldeP, double soldeT, double plafonnement) {
        super.setNomTable("etatcaissegroupe");
        this.setCaisse(caisse);
        this.setReport(report);
        this.setRdebit(rdebit);
        this.setRcredit(rcredit);
        this.setNrdebit(nrdebit);
        this.setNrcredit(nrcredit);
        this.setSoldepratique(soldeP);
        this.setSoldetheorique(soldeT);
        this.setPlafonnement(plafonnement);
    }
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public double getReport() {
        return report;
    }

    public void setReport(double report) {
        this.report = report;
    }

    public double getPlafonnement() {
        return plafonnement;
    }

    public void setPlafonnement(double plafonnement) {
        this.plafonnement = plafonnement;
    }

    public double getNrdebit() {
        return nrdebit;
    }

    public void setNrdebit(double nrdebit) {
        this.nrdebit = nrdebit;
    }

    public double getNrcredit() {
        return nrcredit;
    }

    public void setNrcredit(double nrcredit) {
        this.nrcredit = nrcredit;
    }

    public double getRdebit() {
        return rdebit;
    }

    public void setRdebit(double rdebit) {
        this.rdebit = rdebit;
    }

    public double getRcredit() {
        return rcredit;
    }

    public void setRcredit(double rcredit) {
        this.rcredit = rcredit;
    }

    public double getTdebit() {
        return tdebit;
    }

    public void setTdebit(double tdebit) {
        this.tdebit = tdebit;
    }

    public double getTcredit() {
        return tcredit;
    }

    public void setTcredit(double tcredit) {
        this.tcredit = tcredit;
    }

    public double getSoldetheorique() {
        return soldetheorique;
    }

    public void setSoldetheorique(double soldetheorique) {
        this.soldetheorique = soldetheorique;
    }

    public double getSoldepratique() {
        return soldepratique;
    }

    public void setSoldepratique(double soldepratique) {
        this.soldepratique = soldepratique;
    }

    public EtatCaisseGroupee[] calculer(EtatCaisseGroupee[] list, String date1, String date2) {
        Date daty1 = utilitaire.Utilitaire.string_date("dd/MM/yyyy", date1);
        String datedebut = utilitaire.Utilitaire.convertDatyFormtoRealDatyFormat(daty1.toString());

        Date daty2 = utilitaire.Utilitaire.string_date("dd/MM/yyyy", date2);
        String datefin = utilitaire.Utilitaire.convertDatyFormtoRealDatyFormat(daty2.toString());

        Report temp = new Report();
        temp.setNomTable("REPORTLETTRE");
        try {
            Report[] report = (Report[]) bean.CGenUtil.rechercher(temp, null, null, " and daty = '" + datedebut + "'");
            for (int i = 0; i < list.length; i++) {
                boolean reportOK = false;
                for (int k = 0; k < report.length; k++) {
                    if (list[i].getCaisse().compareToIgnoreCase(report[k].getCaisse()) == 0) {
                        double dispP = (list[i].getRcredit() + report[k].getMontant() + list[i].getPlafonnement()) - list[i].getRdebit();
                        double dispT = (list[i].getNrcredit() + dispP) - list[i].getNrdebit();
                        list[i].setSoldepratique(dispP);
                        list[i].setSoldetheorique(dispT);
                        list[i].setReport(report[k].getMontant());
                        reportOK = true;
                        break;
                    }
                }
                if (!reportOK) {
                    Caisse caisseTest = new Caisse();
                    Caisse[] caisse = (Caisse[]) bean.CGenUtil.rechercher(caisseTest, null, null, " and desccaisse = '" + list[i].getCaisse() + "'");
                    //test banque
                    if (caisse != null && caisse.length > 0 && caisse[0].getRespCaisse().compareTo("1") == 0) {
                        //get dernier report misy
                        Report dernierReport = new Report();
                        dernierReport.setNomTable("REPORTLETTRE");

                        Report[] reportD = (Report[]) bean.CGenUtil.rechercher(dernierReport, null, null, " and caisse = '"
                                + list[i].getCaisse() + "' and daty in (select max(daty) as daty from reportlettre rl where rl.caisse = '"
                                + list[i].getCaisse() + "')");
                        if (reportD != null && reportD.length > 0) {
                            //get ny mouvement rehetra entre an'ilay report sy 

                            String datedebutR = utilitaire.Utilitaire.convertDatyFormtoRealDatyFormat(reportD[0].getDaty().toString());
                            System.out.println("reportRRRRRR : " + datedebutR);
                            EtatCaisseGroupee[] etats = (EtatCaisseGroupee[]) bean.CGenUtil.rechercher(new EtatCaisseGroupee(),
                                    "select max(daty) as daty, caisse, sum(report) as report, sum(plafonnement) as plafonnement, sum(nrdebit) as nrdebit, "
                                    + "sum(nrcredit) as nrcredit, sum(rdebit) as rdebit, sum(rcredit) as rcredit, sum(tdebit) as tdebit, sum(tcredit) as tcredit, "
                                    + "sum(soldetheorique) as soldetheorique, sum(soldepratique) as soldepratique "
                                    + "from etatcaissegroupe where daty >= '" + datedebutR + "' and daty <= '" + datefin + "' and caisse='" + list[i].getCaisse() + "'"
                                            + " group by caisse");
                            list[i] = etats[0];
                            list[i].setReport(reportD[0].getMontant());
                            double dispP = (list[i].getRcredit() + reportD[0].getMontant() + list[i].getPlafonnement()) - list[i].getRdebit();
                            double dispT = (list[i].getNrcredit() + dispP) - list[i].getNrdebit();
                            list[i].setSoldepratique(dispP);
                            list[i].setSoldetheorique(dispT);
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

}
