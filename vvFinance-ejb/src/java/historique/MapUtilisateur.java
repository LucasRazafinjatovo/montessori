package historique;
import java.util.*;

public class MapUtilisateur extends bean.ClassMAPTable  implements java.io.Serializable{

  String loginuser;
  String pwduser;
  String idrole;
  String nomuser;
  String adruser;
  String teluser;
  int refuser;

  public MapUtilisateur()
  {
	//setIndicePk("US");
	setNomTable("utilisateur");
	//idrole="admin";
  }


  public MapUtilisateur(int refus, String loginus,String pwdus,  String nomus,String adrus,  String telus,  String idrol)
  {
	  this.setRefuser(refus);
          this.setLoginuser(loginus);
          this.setPwduser(pwdus);
          this.setNomuser(nomus);
	  this.setAdruser(adrus);
          this.setTeluser(telus);
          this.setIdrole(idrol);
	  setNomTable("utilisateur");
  }
  public MapUtilisateur(String refus,String loginus,String pwdus,  String nomus,String adrus,  String telus,  String idrol)
{

    super.setNomTable("utilisateur");
    this.setRefuser(utilitaire.Utilitaire.getMaxSeq("getSeqUtilisateur"));
//  this.setRefuser(refus);
    if (String.valueOf(refus).compareTo("")==0){
      this.setRefuser(0);
    }
    else this.setRefuser(utilitaire.Utilitaire.stringToInt(refus));

//    this.setLoginuser(loginus);
  if (loginus.compareTo("")==0 || loginus==null) {
    this.setLoginuser("-");
  }
  else this.setLoginuser(loginus);

//    this.setPwduser(pwdus);
  if (pwdus.compareTo("")==0 || pwdus==null) {
    this.setPwduser("-");
  }
  else this.setPwduser(pwdus);

//    this.setNomuser(nomus);
  if (nomus.compareTo("")==0 || nomus==null) {
    this.setNomuser("-");
  }
  else this.setNomuser(nomus);

//    this.setAdruser(adrus);
  if (adrus.compareTo("")==0 || adrus==null) {
    this.setAdruser("-");
  }
  else this.setAdruser(adrus);

//    this.setTeluser(telus);
  if (telus.compareTo("")==0 || telus==null) {
    this.setTeluser("-");
  }
  else this.setTeluser(telus);

//    this.setIdrole(idrol);
  if (idrol.compareTo("")==0 || idrol==null) {
    this.setIdrole("-");
  }
    else this.setIdrole(idrol);
}
  public MapUtilisateur(String loginus,String pwdus,  String nomus,String adrus,  String telus,  String idrol)
  {
    super.setNomTable("utilisateur");
    this.setRefuser(utilitaire.Utilitaire.getMaxSeq("getSeqUtilisateur"));
//    this.setLoginuser(loginus);
    if (loginus.compareTo("")==0 || loginus==null) {
      this.setLoginuser("-");
    }
    else this.setLoginuser(loginus);

//    this.setPwduser(pwdus);
    if (pwdus.compareTo("")==0 || pwdus==null) {
      this.setPwduser("-");
    }
    else this.setPwduser(pwdus);

//    this.setNomuser(nomus);
    if (nomus.compareTo("")==0 || nomus==null) {
      this.setNomuser("-");
    }
    else this.setNomuser(nomus);

//    this.setAdruser(adrus);
    if (adrus.compareTo("")==0 || adrus==null) {
      this.setAdruser("-");
    }
    else this.setAdruser(adrus);

//    this.setTeluser(telus);
    if (telus.compareTo("")==0 || telus==null) {
      this.setTeluser("-");
    }
    else this.setTeluser(telus);

//    this.setIdrole(idrol);
    if (idrol.compareTo("")==0 || idrol==null) {
      this.setIdrole("-");
    }
    else this.setIdrole(idrol);
  }
   public String getAttributIDName()
   {
      return "refuser";
   }
   public String getTuppleID()
	{
        return String.valueOf(refuser);
   }
public MapUtilisateur(String loginuser, String pwduser)
{
	this.loginuser=loginuser; this.pwduser=pwduser;
	setNomTable("utilisateur");
        super.setNombreChamp(7);
	}

  public int getRefuser() {
    return refuser;
  }
  public void setRefuser(int refuser) {
    this.refuser = refuser;
  }
  public void setLoginuser(String loginuser) {
    if (loginuser.compareTo("")==0 || loginuser==null) {
      this.loginuser ="-";
    }
    else this.loginuser = loginuser;
  }
  public String getLoginuser() {
    return loginuser;
  }
  public void setPwduser(String pwduser) {
    if (pwduser.compareTo("")==0 || pwduser==null) {
      this.pwduser ="-";
    }
    else this.pwduser = pwduser;
  }
  public String getPwduser() {
    return pwduser;
  }
  public void setNomuser(String nomuser) {
    if (nomuser.compareTo("")==0 || nomuser==null) {
      this.nomuser ="-";
    }
    else this.nomuser = nomuser;
  }
  public String getNomuser() {
    return nomuser;
  }
  public void setAdruser(String adruser) {
    if (adruser.compareTo("")==0 || adruser==null) {
      this.adruser ="-";
    }
    else this.adruser = adruser;
  }
  public String getAdruser() {
    return adruser;
  }
  public void setTeluser(String teluser) {
    if (teluser.compareTo("")==0 || teluser==null) {
      this.teluser ="-";
    }
    else this.teluser = teluser;
  }
  public String getTeluser() {
    return teluser;
  }
  public void setIdrole(String idrole) {
    this.idrole = idrole;
  }
  public String getIdrole() {
    return idrole;
  }
  public MapRoles getRole()
  {
	  //RoleUtil rU=new RoleUtil();
	  //MapRoles a=rU.rechercheById(idrole);
	  return null;
  }
  public String getEtat()
  {
    AnnulationUtilisateurUtil au=new AnnulationUtilisateurUtil();
    if(au.rechercher(2,this.getTuppleID()).length>0)//si lutilisateur est désactivé
      return "activer";
    else
      return "desactiver"; //si l'utilisateur est activé
  }
  public boolean isSuperUser()
  {
    if(getIdrole().compareToIgnoreCase("dg")==0||getIdrole().compareToIgnoreCase("controle")==0)
      return true;
    return false;
  }
}