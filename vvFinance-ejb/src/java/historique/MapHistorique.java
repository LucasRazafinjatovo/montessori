package historique;
import java.sql.Connection;
import java.util.*;
public class MapHistorique extends bean.ClassMAPTable implements java.io.Serializable {
  String idHistorique;
  java.sql.Date dateHistorique;
  String heure;
  String objet;
  String action;
  String idUtilisateur;
  String refObjet;

public MapHistorique()
{

}

  public MapHistorique(String refe,java.sql.Date date,String lera,String refOrd,String action,String user,String refObje) {
    this.setNomTable("historique");
    this.setIdHistorique(refe);
    this.setDateHistorique(date);
    this.setHeure(lera);
    this.setObjet(refOrd);
    this.setAction(action);
    this.setIdUtilisateur(user);
    this.setRefObjet(refObje);
  }
  public MapHistorique(String obje,String action,String user,String refObje) {
    this.setNomTable("historique");
    setNomProcedureSequence("getSeqHistorique");
    this.setLonguerClePrimaire(10);
    this.setIdHistorique(makePK());    this.setDateHistorique(utilitaire.Utilitaire.dateDuJourSql());
    this.setHeure(utilitaire.Utilitaire.heureCourante());

//    this.setObjet(obje);
    if ((obje==null)||(obje.compareTo("")==0)) {
      this.setObjet("-");
    }
    else this.setObjet(obje);

//    this.setAction(action);
    if (action.compareTo("")==0 || action==null) {
      this.setAction("-");
    }
    else this.setAction(action);

//    this.setIdUtilisateur(user);
    if (user.compareTo("")==0 || user==null) {
      this.setIdUtilisateur("-");
    }
    else this.setIdUtilisateur(user);
    //else this.setIdUtilisateur(this.getUtilisateurs().getLoginuser());

//    this.setRefObjet(refObje);
    if (refObje.compareTo("")==0 || refObje==null) {
      this.setRefObjet("-");
    }
    else this.setRefObjet(refObje);
  }
  
  public MapHistorique(String obje,String action,String user,String refObje, Connection c) throws Exception {
    this.setNomTable("historique");
    setNomProcedureSequence("getSeqHistorique");
    this.setLonguerClePrimaire(10);
    this.setIdHistorique(makePK(c));    this.setDateHistorique(utilitaire.Utilitaire.dateDuJourSql());
    this.setHeure(utilitaire.Utilitaire.heureCourante());

//    this.setObjet(obje);
    if ((obje==null)||(obje.compareTo("")==0)) {
      this.setObjet("-");
    }
    else this.setObjet(obje);

//    this.setAction(action);
    if (action.compareTo("")==0 || action==null) {
      this.setAction("-");
    }
    else this.setAction(action);

//    this.setIdUtilisateur(user);
    if (user.compareTo("")==0 || user==null) {
      this.setIdUtilisateur("-");
    }
    else this.setIdUtilisateur(user);
    //else this.setIdUtilisateur(this.getUtilisateurs().getLoginuser());

//    this.setRefObjet(refObje);
    if(refObje==null){
        refObje="";
    }
    if (refObje.compareTo("")==0 || refObje==null) {
      this.setRefObjet("-");
    }
    else this.setRefObjet(refObje);
  }

   public String getTuppleID()
   {
      return String.valueOf(idHistorique);
   }

   /**
   * Implémentation de la méthode qui doit donner le nom du champ de la
   * clé primaire (tjrs pour update)
   */
   public String getAttributIDName()
   {
      return "idHistorique";
   }
  public String getIdHistorique() {
    return idHistorique;
  }
  public void setIdHistorique(String idHistorique) {
    this.idHistorique = idHistorique;
  }
  public void setHeure(String heure) {
    if (heure.compareTo("")==0 || heure==null) {
      this.heure ="-";
    }
    else this.heure = heure;
  }
  public String getHeure() {
    return heure;
  }
  public void setAction(String action) {
    if (action.compareTo("")==0 || action==null) {
      this.action ="-";
    }
    else this.action = action;
  }
  public String getAction() {
    return action;
  }
  public void setIdUtilisateur(String idUtilisateur) {
    this.idUtilisateur = idUtilisateur;
  }
  public String getIdUtilisateur() {
    return idUtilisateur;
  }
  public java.sql.Date getDateHistorique() {
    return dateHistorique;
  }
  public historique.MapUtilisateur getUtilisateurs()
  {
    return (MapUtilisateur)new historique.UtilisateurUtil().rechercher(1,this.getIdUtilisateur())[0] ;
  }
  public void setDateHistorique(java.sql.Date dateHistorique) {
    if (String.valueOf(dateHistorique).compareTo("")==0 || dateHistorique==null){
      this.dateHistorique=utilitaire.Utilitaire.dateDuJourSql();
    }
    else this.dateHistorique= dateHistorique;
  }
  public String getObjet() {
    return objet;
  }
  public void setObjet(String objet) {
    if (objet.compareTo("")==0 || objet==null) {
      this.objet ="-";
    }
    else this.objet = objet;
  }
  public void setRefObjet(String refObjet) {
    if (refObjet.compareTo("")==0 || refObjet==null) {
      this.refObjet ="-";
    }
    else this.refObjet = refObjet;
  }
  public String getRefObjet() {
    return refObjet;
  }
  public MapUtilisateur getUtilisateur()
  {
    return (MapUtilisateur)new UtilisateurUtil().rechercher(1,String.valueOf(this.getIdUtilisateur()))[0];
  }
}