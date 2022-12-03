package etudiant;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class EtudiantIsOk extends Etudiant {

  private Boolean isOk;

  public void setIsOk(Boolean isOk){
    this.isOk = isOk;
  }
  public Boolean getIsOk(){
     return isOk;
  }

  public EtudiantIsOk() {
  }
  private String[] antony;
 public void setAntony(String antony){
   if(this.antony == null || this.antony.length == 0){
     this.antony = new String[1];
     this.antony[0] = antony;
   }
   else if(this.antony!=null && this.antony.length==1){
      String temp = this.antony[0];
      this.antony = new String[2];
      this.antony[0] = temp;
      this.antony[1] = antony;
   }
   else{
     this.antony[1] = antony;
   }
 }

 public String getAntony(){
    if(this.antony == null || this.antony.length == 0){
      return "-";
    }
    else if(this.antony.length == 1){
     return "<ul><li>"+this.antony[0]+"</li></ul>";
    }
    else{
      return "<ul><li>"+this.antony[0]+"</li><li>"+this.antony[1] +"</li></ul>";
    }
  }

  public EtudiantIsOk(Etudiant etu) throws Exception {
    super.setId(etu.getId());
    super.setNom(etu.getNom());
    super.setPrenom(etu.getPrenom());
    super.setDateNaissance(etu.getDateNaissance());
    super.setAdresse(etu.getAdresse());
    super.setMail(etu.getMail());
    if(etu.getSexe().compareToIgnoreCase("sex1")==0){
      super.setSexe("Masculin");
    }else{
      super.setSexe("Feminin");
    }
    super.setNiveau(etu.getNiveau());
    super.setId(etu.getId());
  }
}