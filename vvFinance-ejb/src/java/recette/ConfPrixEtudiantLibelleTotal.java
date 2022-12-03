/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recette;

import bean.ClassMAPTable;

/**
 *
 * @author Amboara
 */
public class ConfPrixEtudiantLibelleTotal extends ClassMAPTable {

    private String id;
    private String nom;
    private String prenom;
    private double total;
    private double ecolage;
    private double food;
    private double transport;
    private double inscription;
    private double autres;

    public ConfPrixEtudiantLibelleTotal() {
        setNomTable("ConfPrixEtudiantLibelleTotal");
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
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

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

}
