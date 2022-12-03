package historique;
import bean.*;
import java.sql.*;
import java.util.*;
import java.util.*;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;


public class UtilisateurUtil extends GenUtil implements java.io.Serializable,java.lang.Cloneable
{
  public UtilisateurUtil()
  {
    super("Utilisateur");
  }

/*
  *@Permet de rechercher un utilisateur selon user et passe
*/
  public MapUtilisateur testeValide(String user,String passe) throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      this.setNomTable("UtilisateurValide");
      MapUtilisateur[] temp = null;
      int []a={2};
      String [] valeur=new String [a.length];
      if((user.compareToIgnoreCase("")==0)||(passe.compareToIgnoreCase(""))==0||(passe.compareToIgnoreCase("%"))==0) throw new Exception("Erreur de Login ");
      valeur[0]=user;
      //valeur[1]=passe;
      temp=((MapUtilisateur [])rechercher(a,valeur));
      if (temp.length>0)
      {
        //if(temp[0].getLoginuser().compareToIgnoreCase("dg")==0)return temp[0];
        ParamCrypt[] pc = (ParamCrypt[])new ParamCryptUtil().rechercher(4,temp[0].getTuppleID(),c);
        if(pc.length==0) throw new Exception("Pas de cryptage associe");
        String passCrypt=Utilitaire.cryptWord(passe, pc[0].getNiveau(),pc[0].getCroissante());
        if(temp[0].getPwduser().compareTo(passCrypt)==0)
          return temp[0];
        else throw new Exception("Erreur de Login ");
      }

      else
        throw new Exception("Erreur de Login ");
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
  }

  public MapUtilisateur testeValide(String nomTable,String user,String passe) throws Exception
 {
   Connection c=null;
   try {
     c=new UtilDB().GetConn();
     this.setNomTable(nomTable);
     MapUtilisateur[] temp = null;
     int []a={2};
     String [] valeur=new String [a.length];
     if((user.compareToIgnoreCase("")==0)||(passe.compareToIgnoreCase(""))==0||(passe.compareToIgnoreCase("%"))==0) throw new Exception("Erreur de Login ");
     valeur[0]=user;
     //valeur[1]=passe;
     temp=((MapUtilisateur [])rechercher(a,valeur));
     if (temp.length>0)
     {
       //if(temp[0].getLoginuser().compareToIgnoreCase("dg")==0)return temp[0];
       ParamCrypt[] pc = (ParamCrypt[])new ParamCryptUtil().rechercher(4,temp[0].getTuppleID(),c);
       if(pc.length==0) throw new Exception("Pas de cryptage associe");
       String passCrypt=Utilitaire.cryptWord(passe, pc[0].getNiveau(),pc[0].getCroissante());
       if(temp[0].getPwduser().compareTo(passCrypt)==0)
         return temp[0];
       else throw new Exception("Erreur de Login ");
     }

     else
       throw new Exception("Erreur de Login ");
   }
   catch (Exception ex) {
     throw new Exception(ex.getMessage());
   }
   finally
   {
     if(c!=null)c.close();
   }
  }
 /*
  *@Permet de rechercher un utilisateur par son réference
 */
  public MapUtilisateur rechercheByRef(String refUser)
  {
    MapUtilisateur  retour=((MapUtilisateur [])rechercher (1,refUser))[0];
    return retour;
  }
 /*
  *@Permet de rechercher des utilisateurs par son type
 */
  public MapUtilisateur[] recherche()
  {
    MapUtilisateur[]  retour=(MapUtilisateur [])rechercher (1,"%");
    return retour;
  }
 /*
  *@Permet de rechercher les utilisateurs selon son role
 */
  public MapUtilisateur[] rechercheByRole(int role)
  {
    try {
      MapUtilisateur[]  retour=null;
      int []a={7};
      Object [] valeur=new Object [a.length];
      if (role==0)
      {
        retour=(MapUtilisateur [])rechercher (1,"%");
      }
      else
      {
        valeur[0]=String.valueOf(role);
        retour=(MapUtilisateur [])rechercher (a,valeur);
      }
      return retour;
    }
    catch (Exception ex) {
      return null;
    }
  }


  public Object[] resultatGen (ResultSet rs)
  {
    try
    {
      int i = 0, k = 0;
      MapUtilisateur temp = null;
      Vector vect = new Vector();

      while(rs.next())
      {
        temp = new MapUtilisateur(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7));
        vect.add(i,temp);
        i++;
      }

      MapUtilisateur []retour = new MapUtilisateur[i];

      while (k < i)
      {
        retour[k] = (MapUtilisateur)(vect.elementAt(k));
        k++;
      }
      return retour;
    }
    catch (Exception s)
    {
      System.out.println("Resultat "+s.getMessage());
      return null;
    }
    finally
    {
      try
      {
        if (rs!=null) rs.close();
      }
      catch(SQLException e)
      {
        System.out.println("Erreur Fermeture SQL HistoriqueOrdUtil "+ e.getMessage());
      }
    }
  }
  public Object[] resultatLimit (int numBloc,ResultSet rs)
  {
    return null;
  }

}