package pcg;

import javax.ejb.*;
import java.sql.*;
import utilitaire.*;
import historique.*;
import bean.*;
import java.rmi.RemoteException;
import pcg.*;

@Stateful
@AccessTimeout(0)
public class GestionPlanComptableBean implements GestionPlanComptable, GestionPlanComptableRemote, SessionBean {
  SessionContext sessionContext;
  java.lang.String arbretxt;
  public void ejbCreate() throws CreateException {
    /**@todo Complete this method*/
  }
  public void ejbRemove() {
    /**@todo Complete this method*/
  }
  public void ejbActivate() {
    /**@todo Complete this method*/
  }
  public void ejbPassivate() {
    /**@todo Complete this method*/
  }
  public void setSessionContext(SessionContext sessionContext) {
    this.sessionContext = sessionContext;
  }
  public java.lang.String ajouterCompte(String c, String lib, String pc) {
    Connection con=null;
     int d=0;
     Pcg ff=new Pcg(c, lib, pc);


                try
                {System.out.println("avant con");
                  con = (new UtilDB()).GetConn();
                  System.out.println("avant commit");
                 // con.setAutoCommit(false);
                //  MapHistorique h = new MapHistorique("FFournisseur", "insert", "refUser", ff.getTuppleID());
System.out.println("avant ff");
                  d=ff.insertToTable(con);
                   System.out.println("apres ff");
                  //h.insertToTable(con);

                  System.out.println("vita fact");
                    con.commit();
                }
                catch(Exception ex)
				{
                                      try{
					con.rollback();
                                        }catch(SQLException e)
                                          {
                                                  e.printStackTrace();
					}
				}
				finally
				{
					try
					{
						con.close();
					}
					catch(SQLException ex)
					{
						ex.printStackTrace();
					}
				}

      return "cree "+d;
  }
  public java.lang.String majCompte(String idCompte, String cpt, String lib, String pcpt) throws Exception {
    try
         {
             Pcg av = new  Pcg( idCompte, cpt,  lib,  pcpt);
             MapHistorique h = new MapHistorique("PCG", "update", cpt, av.getTuppleID());
             av.upDateToTable();
             //av.updateToTableWithHisto(h);
             String s = av.getTuppleID();
             System.out.println("sss=="+s);
             return s;
         }
         catch(Exception ex)
         {
             throw new Exception(ex.getMessage());
        }
  }
  public pcg.Pcg[] findCompteTab(String idc, String cpt, String lib, String pcpt) throws Exception {
    int a[] = {
            1,2,3,4
        };
        String val[] = new String[a.length];
        val[0] =idc;
        val[1] = cpt;
        val[2] = lib;
        val[3] = pcpt;
        try
    {
       PcgUtil eu = new PcgUtil();
        eu.setNomTable("pcg");
       // String apresWhere=null;
 String apresWhere=" order by COMPTE";
        return (Pcg[])(eu.rechercher(a,val,apresWhere));
    }
    catch(Exception ex){
         throw new ErreurDAO(ex.getMessage());
      }
  }
  public java.lang.String findCompteTxt(String idc, String cpt, String lib, String pcpt) throws Exception {
    /**@todo Complete this method*/
    arbretxt = arbretxt + "debut";
    makeArbre("0");
    return arbretxt;
  }

  public void makeArbre(String pId) throws Exception {

  Pcg pcg1[]  =findCompteTab("%","%","%", pId);

  if (pcg1.length > 0){
    if(pId!="0"){
      //affichage
      Pcg pcg2  =findCompteTab("%",pId,"%", "%")[0];
      arbretxt = arbretxt + pcg2.getCOMPTE() +" - "+pcg2.getLIBELLE()+" <br> ";
      arbretxt = arbretxt + "<div align=\"left\" style=\"display:block; margin-left: 0px\" id=\"a"+pId+"\" name=\"a"+pId+"\">";
    }
      for (int i=0;i<pcg1.length;i++){
        //boucle pour les fils
        System.out.println("T :"+pcg1.length);
         for (int j=0;j<pcg1.length;j++){
           System.out.println("COMPTE   --->"+pcg1[j].getCOMPTE());
         }
        makeArbre(pcg1[i].getCOMPTE());

      }
       if(pId!="0"){
          arbretxt = arbretxt+"</div> ";
       }
    }  else{
      if(pId!="0"){
        Pcg pcg2  =findCompteTab("%",pId,"%", "%")[0];
     arbretxt = arbretxt + pcg2.getCOMPTE() +" - "+pcg2.getLIBELLE()+" <br> ";
      }
    }
  }
   /* boolean tl;
                 String reqS="";
                 String reqS2="";
                 String whereDate="";
                 String trcolor="";
                 String margin="0px";
                 String colorC="#ffffff";

                          reqS 	= "select * from t_activites where p_id='"+pId+"' order by ACTIVITE_CODE";//and ACTIVITE_RESP like '%"+direction.trim()+"%'";
                          reqS2 	= "select * from t_activites where id='"+pId+"' order by ACTIVITE_CODE";// and ACTIVITE_RESP like '%"+direction.trim()+"%'";

                  connect.initConnexion();
                     ResultSet rs = connect.executeQuerry(reqS);
                  ResultSet rs2 = null;
                  connect2.initConnexion();
                 rs2 = connect2.executeQuerry(reqS2);
                  rs2.first();
          //	connect.closeConnexion () ;
         // 	connect2.closeConnexion () ;
                  if(pId.trim().equals("0")){
                          tl=true;
                          arbretxt=arbretxt+"old";
                  }
                  else{
                          testLeaf=false;
                          tl=true;
                          if(!(critere.trim().equals("Toutes"))){
                                  explorerP_id(rs2.getString("id"),pId,rs2.getString("TYPE"));
                                  tl=testLeaf;
                          }
                  }

                  //CONSTRUCTION D'UNE ACTIVITE AYANT UNE SOUS ACTIVITE
                  if (rs.next()){
                          if(pId!="0"){
                                  if (tl){
                                          arbretxt =arbretxt +"<table width=\"1200%\"><tr><td valign=\"top\" >";
                                          colorC=getTaskCritic(rs2.getString("ACTIVITE_DATE_FIN"),Integer.parseInt(rs2.getString("ACTIVITE_AVANCEMENT")));


                                          arbretxt =arbretxt +" <table width=\"800\"><tr bgcolor=\""+colorC+"\" onmouseover=\"this.style.backgroundColor='#F0F0F0'\" onmouseout=\"this.style.backgroundColor=''\"><td > <div align=\"left\" style=\"width:495;display:block; margin-left: \">";
                                          arbretxt =arbretxt +"<table><a href=\"gestion_Activite.jsp?operation=1&id="+pId+"&ssActiviteId="+rs2.getString("ACTIVITE_CODE")+"&ssActiviteLib="+rs2.getString("ACTIVITE_LIBELLE")+"\" style='text-decoration:none;font-weight:bold;text-decoration:none;color:#330033'><tr><td valign=\"top\">";
                                          arbretxt =arbretxt +" <img src=\"treeImg//nolines_minus.gif\" name=\"a"+pId+"i\" style=\"border:0px\" onClick=\"swapTree('a"+pId+"')\"/>";
                                          arbretxt =arbretxt +" </td><td valign=\"top\"><font color=\""+getColor(rs2.getString("TYPE"))+"\"><strong>"+rs2.getString("ACTIVITE_CODE")+" &nbsp; - &nbsp; "+rs2.getString("ACTIVITE_LIBELLE") ;
                                          arbretxt =arbretxt +" </strong></font></td></tr></a></table></div></td>";

                                           //BOUCLE POUR L'AFFICHAGE DES COLONNES SELECTIONNEES
                                            for(int i=2;i<v.size();i++){
                                                  if(!((rs2.getString((String)(v.elementAt(i)))).trim().equals(""))){
                                                          if((((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_DEB"))||(((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_FIN"))){
                                                                  arbretxt=arbretxt +"<td width=\"90\" valign=\"top\"><div align=\"left\" width=\"140\"><table width=\"90\"><tr><td>"+dateTools.permuteDate(rs2.getString((String)(v.elementAt(i))))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_AVANCEMENT")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_REALISATION_FINANCIERE")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESP")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_ATTENDUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>"+getHistoryResult(rs2.getString("id"),((String)(v.elementAt(i))),(rs2.getString((String)(v.elementAt(i)))),"a")+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_OBTENUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>"+getHistoryResult(rs2.getString("id"),((String)(v.elementAt(i))),(rs2.getString((String)(v.elementAt(i)))),"o")+"</td></tr></table></div></td>";
                                                          }

                                                          else{
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }

                                                  }else{
                                                          if((((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_DEB"))||(((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_FIN"))){
                                                                  arbretxt=arbretxt +"<td width=\"90\" valign=\"top\"><div align=\"left\" width=\"140\"><table width=\"90\"><tr><td>"+dateTools.permuteDate(rs2.getString((String)(v.elementAt(i))))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_AVANCEMENT")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_REALISATION_FINANCIERE")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESP")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_ATTENDUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;</td></tr></table></div></td>";
                                                          }
                                                                  else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_OBTENUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_ATTENDUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else{
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          //	arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;&nbsp;</td></tr></table></div></td>";
                                                  }

                                            }
                                            arbretxt =arbretxt +" </tr></table>";

                                  }
                                  arbretxt = arbretxt + "<div align=\"left\" style=\"display:block; margin-left: 0px\" id=\"a"+pId+"\" name=\"a"+pId+"\">";
                          }
                          rs.beforeFirst();
                          //CONSTRUCTION DE L'ARBRE PAR UN BOUCLE IMBRIQUE
                          while (rs.next()){
                                   makeTree(rs.getString("id"),direction);
                          }
                          if(pId!="0"){
                                  if (tl){
                           arbretxt = arbretxt+"</div></td></tr></table> ";
                                  }
                          }
                  }

                  else{

                          testLeaf=false;
                          tl=true;

                  if(!(critere.trim().equals("Toutes"))){
                          explorerP_id(rs2.getString("id"),pId,rs2.getString("TYPE"));
                          tl=testLeaf;
                  }

                         connect2.initConnexion();
                 //	connect.closeConnexion () ;

                     rs2 = connect2.executeQuerry(reqS2);

             //	connect2.closeConnexion () ;
                         rs2.first();
                         colorC=getTaskCritic(rs2.getString("ACTIVITE_DATE_FIN"),Integer.parseInt(rs2.getString("ACTIVITE_AVANCEMENT")));

         /*



                                         if(testNonFils(rs2.getString("id"))){
                                                         arbretxt =arbretxt + "<table width=\"800\"><tr bgcolor=\""+colorC+"\"  onmouseover=\"this.style.backgroundColor='#F0F0F0'\" onmouseout=\"this.style.backgroundColor=''\"><td>";

                                          arbretxt = arbretxt +"<table width=\"100%\" ><a href=\"gestion_Activite.jsp?operation=1&id="+pId+"&ssActiviteId="+rs2.getString("ACTIVITE_CODE")+"&ssActiviteLib="+rs2.getString("ACTIVITE_LIBELLE")+"\" style='text-decoration:none;font-weight:bold;text-decoration:none;color:#330033'><tr><td valign=\"top\"><div align=\"left\" style=\"width:495;display:block; margin-left:\"><font color=\""+getColor(rs2.getString("TYPE"))+"\"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+rs2.getString("ACTIVITE_CODE")+" &nbsp; - &nbsp; "+rs2.getString("ACTIVITE_LIBELLE") + "</strong></font></div></td>";

                                          for(int i=2;i<v.size();i++){
                                                  if(!((rs2.getString((String)(v.elementAt(i)))).trim().equals(""))){
                                                          if((((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_DEB"))||(((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_FIN"))){
                                                                  arbretxt=arbretxt +"<td width=\"90\" valign=\"top\"><div align=\"left\" width=\"140\"><table width=\"90\"><tr><td>"+dateTools.permuteDate(rs2.getString((String)(v.elementAt(i))))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_AVANCEMENT")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"left\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_REALISATION_FINANCIERE")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESP")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_ATTENDUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>"+getHistoryResult(rs2.getString("id"),((String)(v.elementAt(i))),(rs2.getString((String)(v.elementAt(i)))),"a")+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_OBTENUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>"+getHistoryResult(rs2.getString("id"),((String)(v.elementAt(i))),(rs2.getString((String)(v.elementAt(i)))),"o")+"</td></tr></table></div></td>";
                                                          }
                                                          else{
                                                                          arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>"+rs2.getString((String)(v.elementAt(i)))+"</td></tr></table></div></td>";
                                                          }
                                                  }else{
                                                          if((((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_DEB"))||(((String)(v.elementAt(i))).trim().equals("ACTIVITE_DATE_FIN"))){
                                                                  arbretxt=arbretxt +"<td width=\"90\" valign=\"top\"><div align=\"left\" width=\"140\"><table width=\"90\"><tr><td>"+dateTools.permuteDate(rs2.getString((String)(v.elementAt(i))))+"</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_AVANCEMENT")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_REALISATION_FINANCIERE")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESP")) {
                                                                  arbretxt=arbretxt +"<td width=\"100\" valign=\"top\"><div align=\"center\" width=\"100\"><table width=\"150\"><tr><td align=\"center\">&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_OBTENUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else if(((String)(v.elementAt(i))).trim().equals("ACTIVITE_RESULTATS_ATTENDUS")) {
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          else{
                                                                  arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"300\"><table width=\"250\"><tr><td>&nbsp;&nbsp;</td></tr></table></div></td>";
                                                          }
                                                          //	arbretxt=arbretxt +"<td width=\"250\" valign=\"top\"><div align=\"left\" width=\"250\"><table width=\"250\"><tr><td>&nbsp;&nbsp;</td></tr></table></div></td>";
                                                  }

                                            }


                                                  arbretxt = arbretxt+"</td></tr></table> ";
                                                  arbretxt = arbretxt+"</td></tr></table> ";
                                  }




		}*/

  public java.lang.Boolean explorer_pid(String id, String p_id, String critere) {
    /**@todo Complete this method*/
    return null;
  }
  public void setArbretxt(java.lang.String arbretxt) {
    this.arbretxt = arbretxt;
  }
  public java.lang.String getArbretxt() {
    return arbretxt;
  }

    @Override
    public EJBHome getEJBHome() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object getPrimaryKey() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void remove() throws RemoteException, RemoveException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Handle getHandle() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isIdentical(EJBObject obj) throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}