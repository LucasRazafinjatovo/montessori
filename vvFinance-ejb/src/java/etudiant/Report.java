package etudiant;

import java.sql.Connection;
import java.sql.Date;

import bean.ClassMAPTable;

public class Report extends ClassMAPTable{
    String id;
    Date daty;
    double montant;
    String idcaisse;
    String idecole;
    
    public Report(){
        this.setNomTable("report");
    }
    public String getId()
    {
        return id;
    }
    public void setId(String id)
    {
        this.id=id;
    }
    public String getIdecole()
    {
        return idecole;
    }
    public void setIdecole(String idecole)
    {
        this.idecole=idecole;
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
    public void construirePK(Connection c) throws Exception{
        super.setNomTable("report");
        this.preparePk("RPT","getseqreport");
        this.setId(makePK(c));
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
