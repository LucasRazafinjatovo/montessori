// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   EtatCaisse.java
package finance;

import java.sql.Date;
import bean.ClassMAPTable;
import java.util.HashSet;
import java.util.Hashtable;

public class EtatCaisseTableau extends ClassMAPTable {

    private Date daty;
    private String devise;
    private String caisse;
    private double debit;
    private double credit;
    private double montantbrut;
    private double plafonnement;
    private double report;
    private double disponiblenet;

    public String getTuppleID() {
        return null;
    }

    public String getAttributIDName() {
        return "";
    }

    public EtatCaisseTableau() {
        super.setNomTable("EtatCaisseTableau");
    }
    
    public EtatCaisseTableau(String caisse, double report, double debit, double credit, double disponiblenet, double plafonnement) {
        super.setNomTable("EtatCaisseTableau");
        this.setCaisse(caisse);
        this.setReport(report);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setDisponiblenet(disponiblenet);
        this.setPlafonnement(plafonnement);
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getDevise() {
        return devise;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getCaisse() {
        return caisse;
    }

    public Date getDaty() {
        return daty;
    }

    public double getDisponiblenet() {
        return disponiblenet;
    }

    public double getMontantbrut() {
        return montantbrut;
    }

    public double getPlafonnement() {
        return plafonnement;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public void setDisponiblenet(double disponiblenet) {
        this.disponiblenet = disponiblenet;
    }

    public double getDisponibleReel() {
        return getCredit() + getPlafonnement() - getDebit();
    }

    public void setMontantbrut(double montantbrut) {
        this.montantbrut = montantbrut;
    }

    public void setPlafonnement(double plafonnement) {
        this.plafonnement = plafonnement;
    }

    public double getDebit() {
        return debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public EtatCaisseTableau[] calculer(EtatCaisseTableau[] list, String date1, String date2, String date) {

        Date daty1 = utilitaire.Utilitaire.string_date("dd/MM/yyyy", date);

        String u = daty1.toString();
        String daty = utilitaire.Utilitaire.convertDatyFormtoRealDatyFormat(u);
        Report temp = new Report();
        temp.setNomTable("REPORTLETTRE");
        try {
            Report[] report = (Report[]) bean.CGenUtil.rechercher(temp, null, null, " and daty = '" + daty + "'");
            for (int i = 0; i < list.length; i++) {
                boolean reportOK = false;
                for (int k = 0; k < report.length; k++) {
                    if (list[i].getCaisse().compareToIgnoreCase(report[k].getCaisse()) == 0) {
                        double disp = (list[i].getCredit() + report[k].getMontant() + list[i].getPlafonnement()) - list[i].getDebit();
                        list[i].setDisponiblenet(disp);
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
                        Report[] reportD = (Report[]) bean.CGenUtil.rechercher(dernierReport, null, null, " and caisse = '" + list[i].getCaisse() + "' and daty in (select max(daty) as daty from reportlettre rl where rl.caisse = '" + list[i].getCaisse() + "')");
						
						//get efa rapproché

						EtatCaisseTableau[] etats = (EtatCaisseTableau[]) bean.CGenUtil.rechercher(new EtatCaisseTableau(), "select max(rp.dateoperation) as daty, mvt.iddevise, caisse.desccaisse as caisse, sum(debit) as debit, sum(credit) as credit,sum(credit)-sum(debit) as montantbrut, 0 as plafonnement, 0 as report, 0 as disponiblenet from rapprochement rp, mvtcaisse mvt, caisse  where rp.idmouvement = mvt.id and mvt.idcaisse=caisse.idcaisse and caisse.desccaisse='"+list[i].getCaisse()+"' and rp.dateoperation between '"+date1+"' and '"+date2+"' group by caisse.desccaisse, mvt.iddevise");
						
                        if (reportD!=null && reportD.length>0){
							list[i].setReport(reportD[0].getMontant());
                            double disp = reportD[0].getMontant() + list[i].getPlafonnement() + list[i].getCredit() - list[i].getDebit();
							if(etats!= null && etats.length>0){
								disp += etats[0].getCredit() - etats[0].getDebit();
							}
                            list[i].setDisponiblenet(disp);
                            
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
	public EtatCaisseTableau[] calculer(EtatCaisseTableau[] list, String date) {

        Date daty1 = utilitaire.Utilitaire.string_date("dd/MM/yyyy", date);

        String u = daty1.toString();
        String daty = utilitaire.Utilitaire.convertDatyFormtoRealDatyFormat(u);
        Report temp = new Report();
        temp.setNomTable("REPORTLETTRE");
        try {
            Report[] report = (Report[]) bean.CGenUtil.rechercher(temp, null, null, " and daty = '" + daty + "'");
            for (int i = 0; i < list.length; i++) {
                boolean reportOK = false;
                for (int k = 0; k < report.length; k++) {
                    if (list[i].getCaisse().compareToIgnoreCase(report[k].getCaisse()) == 0) {
                        double disp = (list[i].getCredit() + report[k].getMontant() + list[i].getPlafonnement()) - list[i].getDebit();
                        list[i].setDisponiblenet(disp);
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
                        Report[] reportD = (Report[]) bean.CGenUtil.rechercher(dernierReport, null, null, " and caisse = '" + list[i].getCaisse() + "' and daty in (select max(daty) as daty from reportlettre rl where rl.caisse = '" + list[i].getCaisse() + "')");
						
						
                        if (reportD!=null && reportD.length>0){
							list[i].setReport(reportD[0].getMontant());
                            double disp = (list[i].getCredit() + reportD[0].getMontant() + list[i].getPlafonnement()) - list[i].getDebit();
							
                            list[i].setDisponiblenet(disp);
                            
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public double getReport() {
        return report;
    }

    public void setReport(double report) {
        this.report = report;
    }
}
