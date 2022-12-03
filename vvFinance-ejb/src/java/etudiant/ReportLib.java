package etudiant;

import java.sql.Connection;
import java.sql.Date;

import bean.ClassMAPTable;

public class ReportLib extends ClassMAPTable{
    String id;
    Date daty;
    double montant;
    String idcaisse;
    String caisse;
    String idecole;
    String ecole;
    
    public ReportLib(){
        this.setNomTable("report_caisse");
    }
    public String getId()
    {
        return id;
    }
    public void setId(String id)
    {
        this.id=id;
    }
    public Date getDaty()
    {
        return daty;
    }
    public void setDaty(Date daty)
    {
        this.daty=daty;
    }
    public double getMontant()
    {
        return montant;
    }
    public void setMontant(double montant)
    {
        this.montant=montant;
    }
    public String getIdcaisse()
    {
        return idcaisse;
    }
    public void setIdcaisse(String idcaisse)
    {
        this.idcaisse=idcaisse;
    }
    public String getCaisse()
    {
        return caisse;
    }
    public void setCaisse(String caisse)
    {
        this.caisse=caisse;
    }
    public String getIdecole()
    {
        return idecole;
    }
    public void setIdecole(String idecole)
    {
        this.idecole=idecole;
    }

    public String getEcole()
    {
        return ecole;
    }
    public void setEcole(String ecole)
    {
        this.ecole=ecole;
    }
    @Override
    public String getTuppleID() {
        // TODO Auto-generated method stub
        return id;
    }

    @Override
    public String getAttributIDName() {
        // TODO Auto-generated method stub
        return "id";
    }
}
