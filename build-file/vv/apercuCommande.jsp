<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="activa.*" %>
<%@ page import="facture.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
        UserEJB u=null;
        String apres="facture/apresInit.jsp";
        String lien= null;
        String idCommande;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
idCommande=request.getParameter("idCommande");
CommandeLibelle bc=new CommandeLibelle();
bc.setNomTable("commandelibelle");
bc.setIdcmd(idCommande);
CommandeLibelle[] dd=(CommandeLibelle[])CGenUtil.rechercher(bc,null,null,"");
Client crtF=new Client();
crtF.setNom(dd[0].getNomclient());
Client[]client=(Client[])CGenUtil.rechercher(crtF,null,null,"");
%>
 
<link href="style/style.css" rel="stylesheet" type="text/css">
<title>Apercu Commande </title>

<table width="560" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="800" border="0" align="center" bordercolor="#cccccc">
        <tr>
          <td> <table width="550" border="0" cellpadding="0" cellspacing="0" align="center" >
              <!--DWLayoutTable-->
              <tr>
                <td height="21" colspan="4"  align="left"><strong><font color="15" size="+1">ACTIVA PRINT</font></strong></td>
              </tr>
              <tr>
                <td width="550" height="21" colspan="4" align="center"><div align="center"><strong><font color="15" size="+2">COMMANDE
                    N&deg;</font></strong><font size="+1"><%=idCommande%></font> <br>
                  </div></td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
              <tr>
                <td height="23" colspan="4" valign="top"><table width="100%" border="0">
                    <tr>
                      <td width="37%"><strong>Date : </strong><%
String j=Utilitaire.getJour(Utilitaire.dateDuJour());
int mon=Utilitaire.getMoisEnCours()+1;
String monLettre=Utilitaire.nbToMois(mon);
String an=Utilitaire.getAnnee(Utilitaire.dateDuJour());
out.println(j+" "+monLettre+" "+an);
%></td>
                      <td width="33%"><strong>Heure : </strong></td>
                      <td width="30%"><strong>Priorit&eacute; : </strong></td>
                    </tr>
                    <tr>
<td colspan="3"><strong>Nom Client : </strong><%=client[0].getNom()%></td> </tr>
<tr><td colspan="3"><strong> ID Regime : </strong><%=client[0].getIdRegime()%></td></tr>
<tr><td colspan="3"><strong>Adresse : </strong><%=client[0].getAdresse() %></td></tr>
<tr><td colspan="3"><strong>Telephone : </strong><%=client[0].getTelephone() %></td></tr>
<tr><td colspan="3"><strong>Fax : </strong><%=client[0].getFax() %></td></tr>
<tr><td colspan="3"><strong>Numstat : </strong><%=client[0].getNumstat() %></td></tr>
<tr><td colspan="3"><strong>Nif : </strong><%=client[0].getNif()%></td></tr>
<tr><td colspan="3"><strong>RC : </strong><%=client[0].getRc()%></td></tr>
<tr><td colspan="3"><strong>TP : </strong><%=client[0].getTp()%></td></tr>
<tr><td colspan="3"><strong>Quittance : </strong><%=client[0].getQuittance()%></td>
</tr>
                  </table></td>
              </tr>
            </table>

          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
  <tr><td>
          <table width="555" border="0" align="center" bordercolor="#cccccc">
      <td width="149"><strong>Du</strong> ......<b>/</b>......<b>/</b>...... </td>
          </table></td>
  </tr>
  <tr>
    <td height="10"></td>
  </tr>
  <tr>
    <td height="288">
      <table width="560" height="200" border="1" align="center" cellpadding="0" cellspacing="0">
        <tr class="headFact">
          <td width="200" height="20"> <div align="center"><strong>DESIGNATION</strong></div></td>
          <td width="75" align="center"><strong>article</strong></td>
          <td width="61" align="center"><strong>code recto verso</strong></td>
          <td width="70" align="center"><strong>Nombre impression</strong></td>
          <td width="70" align="center"><strong>remise</strong></td>
          <td width="75" align="center"><strong>date du commande</strong></td>
        </tr>

           <!-- <tr>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
            </tr>  -->
            <%
            String d1=dd[0].getDatecmd().toString();
            Utilitaire u1=new Utilitaire();
            String[] d2=u1.split(d1,"-");
            String d3=d2[2]+"-"+d2[1]+"-"+d2[0];
            %>
       <tr>
           <td width="125" height="20" style="border-bottom:none; border-top:none" valign="top"><%=dd[0].getDesignation()%></td>
           <td width="75"  align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getArticle()%></td>
           <td width="61"  align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getCoderv()%></td>
           <td width="70" align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getNombreImpression()%></td>
           <td width="70" align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getRemise()%></td>
           <td width="75" align="center" valign="top" style="border-bottom:none; border-top:none"><%= d3%></td>
       </tr>
<!--<tr valign="bottom">
          <td style="border-top:none; border-bottom:none">&nbsp;</td>
          <td style="border-top:none; border-bottom:none">&nbsp;</td>
          <td style="border-top:none; border-bottom:none">&nbsp;</td>
          <td style="border-top:none; border-bottom:none">&nbsp;</td>
        </tr>
        <tr>
            <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
            <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
            <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
            <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
        </tr> -->

      </table><br />
      <table width="560" align="center" cellpadding="0">
       <tr>
          <% Utilitaire util = new Utilitaire();
            String daty=dd[0].getDateLivraisonCmd().toString();
            String[] tab;
            tab=util.split(daty,"-");
            //System.out.println(tab[2]+" "+tab[1]+" "+tab[0]);
            String se=tab[2]+"-"+tab[1]+"-"+tab[0];
%>
          <td><strong> Date de livraison commande : </strong> <%=se%></td>
        </tr>
        <tr>
          <td><strong> Remarque : </strong> <%=dd[0].getRemarque() %></td>
        </tr>0
      </table></td>
  </tr>
</table>
<div align="center"></div>
<br>
<br>
<br>
</div>
