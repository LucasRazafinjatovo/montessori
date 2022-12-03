/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recette;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

import java.sql.Connection;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Amboara
 */
public class ConfPrixEtudiant extends ClassMAPTable {
    private String id;
    private Date daty;
    private String etudiant;
    private int echeance;
    private double ecolage;
    private double food;
    private double transport;
    private double inscription;
    private double autres;
    private String remarques;
    private Date date_debut;
    private Date date_fin;

    public ConfPrixEtudiant() {
        this.setNomTable("ConfPrixEtudiant");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(String etudiant) {
        this.etudiant = etudiant;
    }

    public int getEcheance() {
        return echeance;
    }

    public void setEcheance(int echeance) {
        this.echeance = echeance;
    }

    public double getEcolage() {
        return ecolage;
    }

    public void setEcolage(double ecolage) {
        this.ecolage = ecolage;
    }

    public double getFood() {
        return food;
    }

    public void setFood(double food) {
        this.food = food;
    }

    public double getTransport() {
        return transport;
    }

    public void setTransport(double transport) {
        this.transport = transport;
    }

    public double getInscription() {
        return inscription;
    }

    public void setInscription(double inscription) {
        this.inscription = inscription;
    }

    public double getAutres() {
        return autres;
    }

    public void setAutres(double autres) {
        this.autres = autres;
    }

    public String getRemarques() {
        return remarques;
    }

    public void setRemarques(String remarques) {
        this.remarques = remarques;
    }

    public Date getDate_debut() {

        return date_debut;
    }

    public void setDate_debut(Date date_debut) throws ParseException {
      
        if(date_debut==null)
        {

            String[] tabDate=Utilitaire.dateDuJour().split("/");
            int j=Integer.parseInt(tabDate[0]);
            int m=Integer.parseInt(tabDate[1]);
            int y=Integer.parseInt(tabDate[2])-1900;
            Date dateDuJour=new java.sql.Date(y,m,j);
            date_debut=Utilitaire.string_date("dd/MM/yyyy", Utilitaire.formatterDaty(dateDuJour));
        }
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }
    
    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
     public void construirePK(Connection c) throws Exception{
         
            this.preparePk("CFP","GETSEQCONFPRIXETUDIANT");
            this.setId(makePK(c));
    }

}

    
