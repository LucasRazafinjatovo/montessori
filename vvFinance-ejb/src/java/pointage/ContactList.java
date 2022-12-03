package pointage;
import bean.*;
import java.util.*;
import java.sql.Connection;
public class ContactList  extends Contact
{
  public ContactList(){
    super();
    super.setNomTable("contact_libelle");
  }

  private String idTypeContact;
  private String nom;
  private String prenom;
  private String val;
  private String desce;
  private String tel1;
  private String tel2;
  private String mail;
  private String adresse;
  private java.sql.Date naissance;

  public void setNom(String nom)
 {
   this.nom=nom;
 }
 public String getNom()
 {
   return nom;
  }
  public void setPrenom(String prenom)
 {
   this.prenom=prenom;
 }
 public String getPrenom()
 {
   return prenom;
  }
  public void setTel1(String tel1)
 {
   this.tel1=tel1;
 }
 public String getTel1()
 {
   return tel1;
  }
  public void setTel2(String tel2)
{
  this.tel2=tel2;
}
public String getTel2()
{
  return tel2;
  }
  public void setMail(String mail)
{
  this.mail=mail;
}
public String getMail()
{
  return mail;
  }

  public void setAdresse(String adresse)
{
  this.adresse=adresse;
}
public String getAdresse()
{
  return adresse;
  }

  public void setNaissance(java.sql.Date naissance)
{
  this.naissance=naissance;
}
public java.sql.Date getNaissance()
{
  return naissance;
  }







  public void setIdTypeContact(String id)
  {
    this.idTypeContact=id;
  }
  public String getIdTypeContact()
  {
    return idTypeContact;
  }

  public void setVal(String val)
  {
    this.val=val;
  }
  public String getVal()
  {
    return val;
  }
  public void setDesce(String desce)
  {
    this.desce=desce;
  }
  public String getDesce()
  {
    return desce;
  }

}
