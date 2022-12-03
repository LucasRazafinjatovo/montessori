package pub;

import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Statpub extends bean.ClassMAPTable {

  private String idparution;
  private String format;
  private int nombre;
  private double montant;
  private int couleur;
  private String journal;
  private int numparution;
  public Statpub() {
    super.setNomTable("statPubSaisie");
  }
  public void construirePK(Connection c) throws Exception
{
    super.setNomTable("statPubSaisie");
    this.preparePk("SPS","getSeqMontant");
    this.setIdparution(makePK(c));
  }
  public String getAttributIDName() {
    return "idparution";
  }
  public String getTuppleID() {
    return idparution;
  }
  public String getIdparution() {
    return idparution;
  }
  public void setIdparution(String idparution) {
    this.idparution = idparution;
  }
  public void setFormat(String format) {
    this.format = format;
  }
  public String getFormat() {
    return format;
  }
  public void setCouleur(int couleur) {
    this.couleur = couleur;
  }
  public int getCouleur() {
    return couleur;
  }
  public void setNombre(int nombre) {
    this.nombre = nombre;
  }
  public int getNombre() {
    return nombre;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setNumparution(int numparution) {
    this.numparution = numparution;
  }
  public int getNumparution() {
    return numparution;
  }
}