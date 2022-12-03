/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package etudiant;

import java.sql.Date;

import bean.ClassEtat;

/**
 *
 * @author LUCAS
 */
public class EtatDeCaisse extends Report{
   
    Date datydernier;
    double debit;
    double credit;
    double reste;
    String caisse;
    String ecole;

    public EtatDeCaisse()
    {
        super();
        this.setNomTable("etatdecaisse");
    }
    public String getCaisse()
    {
        return caisse;
    }
    public void setCaisse(String caisse)
    {
        this.caisse=caisse;
    }
    public String getEcole()
    {
        return ecole;
    }
    public void setEcole(String ecole)
    {
        this.ecole=ecole;
    }
    public Date getDatydernier()
    {
        return datydernier;
    }
    public void setDatydernier(Date datydernier)
    {
        this.datydernier=datydernier;
    }
  
    public double getDebit()
    {
        return debit;
    }
    public void setDebit(double debit)
    {
        this.debit=debit;
    }
    public double getCredit()
    {
        return credit;
    }
    public void setCredit(double credit)
    {
        this.credit=credit;
    }
    public double getReste()
    {
        return reste;
    }
    public void setReste(double reste)
    {
        this.reste=reste;
    }
    
    
}
