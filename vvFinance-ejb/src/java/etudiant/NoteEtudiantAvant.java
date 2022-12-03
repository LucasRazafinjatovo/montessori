package etudiant;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class NoteEtudiantAvant extends ClassMAPTable{

  private String id;
  private String typeNoteAvant;
  private String matiereAvant;
  private String etudiant;
  private String mention;
  private float valeur;
  public NoteEtudiantAvant() {
    super.setNomTable("noteetudiantavant");
  }
  public String getTuppleID(){
    return id;
  }
  public String getAttributIDName(){
    return "id";
  }
  public void construirePK(Connection c) throws Exception{
    super.setNomTable("noteetudiantavant");
    this.preparePk("NEAV","getSeqNoteEtudiantAvant");
    this.setId(makePK(c));
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setTypeNoteAvant(String typeNoteAvant) {
    this.typeNoteAvant = typeNoteAvant;
  }
  public String getTypeNoteAvant() {
    return typeNoteAvant;
  }
  public void setValeur(float valeur) throws Exception{
    if(valeur<0) throw new Exception("Note non valide");
    this.valeur = valeur;
  }
  public float getValeur() {
    return valeur;
  }
  public void setMatiereAvant(String matiereAvant) {
    this.matiereAvant = matiereAvant;
  }
  public String getMatiereAvant() {
    return matiereAvant;
  }
  public void setEtudiant(String etudiant) {
    this.etudiant = etudiant;
  }
  public String getEtudiant() {
    return etudiant;
  }
  public void setMention(String mention) {
    this.mention = mention;
  }
  public String getMention() {
    return mention;
  }
}