package pub;

import bean.*;
import java.sql.Connection;
import facture.Client;
import utilitaire.Utilitaire;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Publicite extends ClassMAPTable {

  public Publicite() {
    super.setNomTable("Publicite");
  }
  public Publicite(String client,String cat,String ag,String paru,String desi,String numBc,String rem,String nPiec,String formu,String coul,String forma,String idJourn) throws Exception
  {
    super.setNomTable("Publicite");
    this.preparePk("PUB","getSeqPub");
    this.setId(makePK());
    this.setIdClient(client);
    setIdCat(cat);
    setIdAgence(ag);
    setIdParution(paru);
    setDesignation(desi);
    setNumBc(numBc);
    setRemarque(rem);
    setNumPiece(nPiec);
    setFormulaire(utilitaire.Utilitaire.stringToInt(formu));
    setCorrection(0);
    setPagemisyazy(0);
  }
  public Publicite(String client,String cat,String ag,String paru,String desi,String numBc,String rem,String nPiec,String formu,String coul,String forma,String idJourn,Connection c) throws Exception
  {
    super.setNomTable("Publicite");
    this.preparePk(ag,"getSeqPub");
    //this.setIdClient(client);
    this.setIdClientLib(client,c);
    setIdCat(cat);
    setIdAgence(ag);
    setIdParution(paru);
    setDesignation(desi);
    setNumBc(numBc);
    setRemarque(rem);
    setNumPiece(nPiec);
    setFormulaire(utilitaire.Utilitaire.stringToInt(formu));
    if(c==null)
    {
      c=new utilitaire.UtilDB().GetConn();
    }
    this.setId(makePK(c));
    //setIdMont(calculerMontant(coul,forma,idJourn,c).getId());
    setCorrection(0);
    setPagemisyazy(0);
  }
  String id;
  private String idClient;
  private String idMont;
  private String idCat;
  private String idAgence;
  private String idParution;
  private int numPage;
  private String designation;
  private String numBc;
  private String remarque;
  private String numPiece;
  private int formulaire;
  private int correction;
  private int pagemisyazy;
  private double montant;
  private double remis;
  public static Montant calculerMontant(String coul,String form,String idJ,String pejy,Connection c) throws Exception
  {
    Montant crt=new Montant();
    crt.setTaille(form);
    crt.setIdgazety(idJ);
    Montant[]temp=(Montant[])(CGenUtil.rechercher(crt,null,null,c," and couleur="+coul));
    if(temp.length==0) throw new Exception("Il n y a pas de montant correspondant");
    if(temp.length>1)
    {
      if(pejy==null||pejy.compareToIgnoreCase("")==0)
      {
        Montant u=(Montant)Utilitaire.extraire(temp,5,"0");
        if(u==null) return temp[0];
        return u;
      }
      Montant u=(Montant)Utilitaire.extraire(temp,5,pejy);
      if(u==null)
        return temp[0];
      return u;
    }
    return temp[0];
  }
  public static Parution findParution(String numPar,String idJ,Connection c) throws Exception
  {
    Parution crt=new Parution();
    crt.setJournal(idJ);
    Parution[]temp=(Parution[])(CGenUtil.rechercher(crt,null,null,c," and numParution="+numPar));
    if(temp.length==0) throw new Exception("Il n y a pas de parution correspondant");
    return temp[0];
  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setIdClient(String idClient) {
    this.idClient = idClient;
  }
  public void setIdClientLib(String idClient,Connection c) throws Exception
  {
    setIdClient(Client.getIdDyn(idClient,c));
  }
  public String getIdClient() {
    return idClient;
  }
  public void setIdMont(String idMont) {
    this.idMont = idMont;
  }
  public String getIdMont() {
    return idMont;
  }
  public void setIdCat(String idCat) {
    this.idCat = idCat;
  }
  public String getIdCat() {
    return idCat;
  }
  public void setIdAgence(String idAgence) {
    this.idAgence = idAgence;
  }
  public String getIdAgence() {
    return idAgence;
  }
  public void setIdParution(String idParution) {
    this.idParution = idParution;
  }
  public String getIdParution() {
    return idParution;
  }
  public void setNumPage(int numPage) {
    this.numPage = numPage;
  }
  public int getNumPage() {
    return numPage;
  }
  public void setDesignation(String designation)throws Exception {
    if((designation==null || designation.compareToIgnoreCase("")==0)&&getMode().compareToIgnoreCase("insert")==0)
    {
      throw new Exception("Designation obligatoire");
    }
    this.designation = designation;
  }
  public String getDesignation() {
    return designation;
  }
  public void setNumBc(String numBc) {
    this.numBc = numBc;
  }
  public String getNumBc() {
    return numBc;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setNumPiece(String numPiece) {
    this.numPiece = numPiece;
  }
  public String getNumPiece() {
    return numPiece;
  }
  public void setFormulaire(int formulaire) {
    this.formulaire = formulaire;
  }
  public int getFormulaire() {
    return formulaire;
  }
  public void setCorrection(int correction) throws Exception {
    if(correction>1 && correction<0) throw new Exception("Valeur non valide");
    this.correction = correction;
  }
  public int getCorrection() {
    return correction;
  }
  public void setPagemisyazy(int pagemisyazy) {
    this.pagemisyazy = pagemisyazy;
  }
  public int getPagemisyazy() {
    return pagemisyazy;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setRemis(double remis) {
    this.remis = remis;
  }
  public double getRemis() {
    return remis;
  }
}