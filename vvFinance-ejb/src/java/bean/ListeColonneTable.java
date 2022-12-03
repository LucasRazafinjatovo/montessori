package bean;

import java.util.Hashtable;
import java.sql.*;
import java.util.Vector;
import java.lang.reflect.Field;
import utilitaire.UtilDB;
import java.util.Enumeration;
import java.util.List;
import java.util.Arrays;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ListeColonneTable
{
  static Hashtable  listeColPTable = new Hashtable();
  public static Field[] getFieldListeHeritage(ClassMAPTable e)
  {
    Field[] prim= e.getClass().getDeclaredFields();
    //System.out.println("Le nombre de champ de base prim "+e.getClass().getName()+" = "+prim.length);
    if(e.getClass().getSuperclass().getName().endsWith("ClassMAPTable")==true)
      return prim;
    Vector listeF=new Vector();
    List temp= Arrays.asList(prim);
    listeF.addAll(temp);
    Class p=e.getClass().getSuperclass();
    while(1<2)
    {
      if(p.getName().endsWith("ClassMAPTable")==true) break;
      Field second[]=p.getDeclaredFields();
      //System.out.println("Le nombre de champ de base second "+p.getName()+"  = "+second.length);
      listeF.addAll(Arrays.asList(second));
      p=p.getSuperclass();
    }
    Field []retour=new Field[listeF.size()];
    listeF.copyInto(retour);
    return retour;
  }
  public static void ajouterAlaListe(ClassMAPTable e, Connection c) throws Exception
 {
    String nomTable=e.getNomTable();
    boolean testDedans=listeColPTable.containsKey(nomTable);
    if (testDedans==false)
   {
     Vector r = getChampFromTable(nomTable, c);
     //System.out.println("Taille du vecteur "+r.size()+e.getNomTable());
     Field fieldlist[] = getFieldListeHeritage(e);
     //System.out.println("Taille du fieldList "+fieldlist.length);
     Champ [] retour = new Champ[r.size()];
     Vector intersect=new Vector();
     for(int i=0;i<r.size();i++)
     {
       retour[i]=(Champ)r.get(i);
       for(int k=0;k<fieldlist.length;k++)
       {
         if(retour[i].getNomColonne().compareToIgnoreCase(fieldlist[k].getName())==0)
         {
           Champ ch=new Champ(fieldlist[k],retour[i].getPrecision());
           ch.setType(retour[i].getType());
           intersect.add(ch);
           break;
         }
       }
     }
     Champ[]valiny=new Champ[intersect.size()];
     intersect.copyInto(valiny);
     //Champ[] =Champ.getChampFromTable(nomTable,c);
     if (valiny.length>0)
       listeColPTable.put(nomTable, valiny);
   }
  }
  public static Field[] getChampBase(ClassMAPTable e, Connection c) throws Exception
 {
    String nomTable=e.getNomTable();
    boolean testDedans=listeColPTable.containsKey(nomTable);
    Champ[] retour=null;
    if (testDedans==false)
   {
     Vector r = getChampFromTable(nomTable, c);
     retour = new Champ[r.size()];
     r.copyInto(retour);
   }
   else
   {
     retour=(Champ[])listeColPTable.get(nomTable);
   }
   Field fieldlist[] = getFieldListeHeritage(e);
   Vector intersect=new Vector();
     for(int i=0;i<retour.length;i++)
     {
       for(int k=0;k<fieldlist.length;k++)
       {
         if(retour[i].getNomColonne().compareToIgnoreCase(fieldlist[k].getName())==0)
         {
           intersect.add(fieldlist[k]);
           break;
         }
       }
     }
     Field[]valiny=new Field[intersect.size()];
     intersect.copyInto(valiny);
     return valiny;
  }
  /*public static void ajouterAlaListe(String nomTable, Connection c) throws Exception
  {
    //Champ[]listeC=listeColPTable.c
    if (listeColPTable.containsKey(nomTable)==false)
    {
      Vector r = getChampFromTable(nomTable, c);
      Champ [] retour = new Champ[r.size()];
      r.copyInto(retour);
      //Champ[] =Champ.getChampFromTable(nomTable,c);
      listeColPTable.put(nomTable, retour);
    }
  }*/
  public static Champ[] getFromListe(ClassMAPTable e, Connection c) throws Exception
{
    Connection cnx=null;
    String nomTable=e.getNomTable();
    try {
        if(c==null)
        {
          cnx=new UtilDB().GetConn();
          ajouterAlaListe(e, cnx);
        }
        else ajouterAlaListe(e, c);
      return (Champ[])listeColPTable.get(nomTable);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
      throw ex;
    }
    finally
    {
      if(cnx!=null)cnx.close();
    }
  }
  public static Champ getChamp(ClassMAPTable e, String col) throws Exception
{
    Connection cnx=null;
    try
    {
      Champ[] liste=null;
      //System.out.println("AVANT EEE TABLE "+e.getNomTable() );
      if(listeColPTable.containsKey(e.getNomTable())==false)
      {
        //System.out.println("INTERIEUR PAS DE TABLE");
        cnx=new UtilDB().GetConn();
        liste=getFromListe(e, cnx);
        //System.out.println("TAILLE DE LA LISTE TABLE "+liste.length);
      }
      else
      {
        //System.out.println("INTERIEUR ELSE PAS DE TABLE");
        liste=(Champ[])listeColPTable.get(e.getNomTable());
      }
      for(int i=0;i<liste.length;i++)
      {
        if(liste[i].getNomColonne().compareToIgnoreCase(col)==0)
          return liste[i];
      }
      return null;
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
      return null;
    }
    finally
    {
      if(cnx!=null)cnx.close();
    }
  }
  /*
  public static Champ[] getFromListe(String nomTable, Connection c) throws Exception
  {
    ajouterAlaListe(nomTable, c);
    return (Champ[])listeColPTable.get(nomTable);
  }*/
  public static Vector getChampFromTable(String nomT, Connection c) throws Exception
  {
    Statement st=null;
    ResultSet dr=null;
    try
    {
    //Console.WriteLine("NIDITRA NAKA CHAMP "+nomT);
    String comande = "SELECT * FROM USER_TAB_COLUMNS where table_Name = upper('"+ nomT+"') order by column_id asc";
    //System.out.println("Liste colonne venant de la base = "+comande);
    st=c.createStatement();
    dr=st.executeQuery(comande);
    Vector retour=new Vector();
    int i=0;
    while (dr.next())
    {
      Champ temp=new Champ(dr.getString(2), dr.getString(3), dr.getInt(7),dr.getInt(8));
      //if(nomT.compareToIgnoreCase("factureclientvise")==0)System.out.println("Anaty ListeColTable "+dr.getString(2)+" type= "+ dr.getString(3));
      retour.add(temp);
        i++;
    }
    return retour;
    }
    catch(Exception ex)
    {
      throw ex;
    }
    finally
    {
      if(st!=null)st.close();
      if(dr!=null);dr.close();
    }
  }


}