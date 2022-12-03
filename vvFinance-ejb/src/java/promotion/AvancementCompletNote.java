package promotion;

import java.util.Vector;
import bean.*;
import utilitaire.Utilitaire;
import utilitaire.UtilDB;
import java.sql.Connection;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AvancementCompletNote extends AvancementComplet {

  private int numero;
  private String idetudiant;
  private double valeur;
  private String code;
  private String val;
  private String idSem;
  private String idProm;
  private String idMat;
  private String idTypeNote;
  private String sessione;
  private String sessionRem;
  public AvancementCompletNote() {
    this.setNomTable("avancementCompletEtudiant");
  }
  public int getNumero() {
    return numero;
  }
  public void setNumero(int numero) {
    this.numero = numero;
  }
  public void setIdetudiant(String idetudiant) {
    this.idetudiant = idetudiant;
  }
  public String getIdetudiant() {
    return idetudiant;
  }
  public void setValeur(double valeur) {
    this.valeur = valeur;
  }
  public double getValeur() {
    return valeur;
  }
  public void setCode(String code) {
    this.code = code;
  }
  public String getCode() {
    return code;
  }
  public void setVal(String val) {
    this.val = val;
  }
  public String getVal() {
    return val;
  }
  public void setIdSem(String idSem) {
    this.idSem = idSem;
  }
  public String getIdSem() {
    return idSem;
  }
  public void setIdProm(String idProm) {
    this.idProm = idProm;
  }
  public String getIdProm() {
    return idProm;
  }
  public void setIdMat(String idMat) {
    this.idMat = idMat;
  }
  public String getIdMat() {
    return idMat;
  }
  public void setIdTypeNote(String idTypeNote) {
    this.idTypeNote = idTypeNote;
  }
  public String getIdTypeNote() {
    return idTypeNote;
  }
  public void setSessione(String sessione) {
    this.sessione = sessione;
  }
  public String getSessione() {
    return sessione;
  }
  public void setSessionRem(String sessionRem) {
    this.sessionRem = sessionRem;
  }
  public String getSessionRem() {
    return sessionRem;
  }
  //Pour le résultat
  public Object[] listeResultat(String etudiant,String semestre,String num,String idEtudiant,String options,String idTypeNote,String code,String session)throws Exception
  {
    Vector v = new Vector();
    Connection c=null;
    try
    {
      c=new UtilDB().GetConn();
      AvancementCompletNote cri = new AvancementCompletNote();
      cri.setEtudiant(etudiant);
      cri.setSemestre(semestre);
      cri.setIdetudiant(idEtudiant);
      cri.setOptions(options);
      cri.setIdTypeNote(idTypeNote);
      cri.setCode(code);
      cri.setSessione(session);
      AvancementCompletNote[] liste=(AvancementCompletNote[])CGenUtil.rechercher(cri,null,null,c," and numero like '"+num+"'");
      return null;
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      if(c!=null)c.close();
    }
    return null;
  }

}