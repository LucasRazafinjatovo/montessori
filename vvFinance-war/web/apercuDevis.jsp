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
        String idDevis;
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
idDevis=request.getParameter("idDevis");
System.out.println("test idDevis==="+idDevis);
DemandeDevisLibelle ddl=new DemandeDevisLibelle();
ddl.setNomTable("demandedevisarticleprix");
ddl.setIdDevis(idDevis);
DemandeDevisLibelle[] test=(DemandeDevisLibelle[])CGenUtil.rechercher(ddl,null,null,"");
String coderv=test[0].getIdCodeRV();
String idclient=test[0].getIdClient();
String table="";
if(coderv.compareToIgnoreCase("CODE1")==0){
  table="demandedevisarticlerecto";
}
 else table="demandedevisarticlerv";
DemandeDevisRecto bc=new DemandeDevisRecto();
bc.setNomTable(table);
bc.setIdDevis(idDevis);
DemandeDevisRecto[] dd=(DemandeDevisRecto[])CGenUtil.rechercher(bc,null,null,"");
Client crtF=new Client();
crtF.setIdClient(idclient);
Client[]client=(Client[])CGenUtil.rechercher(crtF,null,null,"");
%>
 
<link href="style/style.css" rel="stylesheet" type="text/css">
<title>Apercu Demande Devis </title>

<table width="560" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="800" border="0" align="center" bordercolor="#cccccc">
        <tr>
          <td> <table width="550" border="0" cellpadding="0" cellspacing="0" align="center" >
              <tr>
                <td height="21" colspan="4"  align="left"><strong><font color="15" size="+1">ACTIVA PRINT</font></strong></td>
              </tr>
              <tr>
                <td width="550" height="21" colspan="4" align="center"><div align="center"><strong><font color="15" size="+2">DEMANDE DEVIS
                    N&deg;</font></strong><font size="+1"><%=idDevis%></font> <br>
                  </div></td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
              <tr>
                <td height="23" colspan="4" valign="top"><table width="100%" border="0">
                    <tr>
                      <td width="37%"><strong>Date : </strong>
<%
String j=Utilitaire.getJour(Utilitaire.dateDuJour());
int mon=Utilitaire.getMoisEnCours()+1;
String monLettre=Utilitaire.nbToMois(mon);
String an=Utilitaire.getAnnee(Utilitaire.dateDuJour());
out.println(j+" "+monLettre+" "+an);
%>
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
          <td width="125" height="20"> <div align="center"><strong>DESIGNATION</strong></div></td>
          <td width="75" align="center"><strong>papier</strong></td>
          <td width="61" align="center"><strong>code recto verso</strong></td>
          <td width="70" align="center"><strong>Nombre article</strong></td>
          <td width="70" align="center"><strong>NB exemplaire A3</strong></td>
          <td width="70" align="center"><strong¨>Cout unitaire impression (Ariary)</strong></td>
          <td width="75" align="center"><strong>date du devis</strong></td>
        </tr>

           <!-- <tr>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
              <td height="50" style="border-top:none; border-bottom:none">&nbsp;</td>
            </tr>  -->
            <!-- ligne 115 -->
                      <% Utilitaire util = new Utilitaire();
            String daty=dd[0].getDateDevis().toString();
            String[] tab;
            tab=util.split(daty,"-");
            //System.out.println(tab[2]+" "+tab[1]+" "+tab[0]);
            String se=tab[2]+"-"+tab[1]+"-"+tab[0];
            double xx=(dd[0].getCout()*dd[0].getNombreimpression())/dd[0].getNombre();
%>
                 <tr>
           <td width="125" height="20" style="border-bottom:none; border-top:none" valign="top"><%=dd[0].getDesignation()%></td>
           <td width="75"  align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getArticle()%></td>
           <td width="61"  align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getCoderv()%></td>
           <td width="70" align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getNombre()%></td>
           <td width="70" align="center" valign="top" style="border-bottom:none; border-top:none"><%=dd[0].getNbExemplaireA3()%></td>
           <td width="70" align="center" valign="top" style="border-bottom:none; border-top:none"><%= Utilitaire.arrondir(xx,2) %></td>
           <td width="75" align="center" valign="top" style="border-bottom:none; border-top:none"><%= se %></td>
       </tr>
      <!---<tr valign="bottom">
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
     <table width="560" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><strong> Nombre impression A3 : </strong><%=dd[0].getNombreimpression() %></td>
        </tr>

        <tr>
          <td><strong> Cout unitaire impression A3 : </strong><%=dd[0].getCout()%> &nbsp; Ariary</td>
        </tr>

        <tr>
          <td><strong> Total (sans remise) : </strong><%=dd[0].getCout()*dd[0].getNombreimpression()%> &nbsp; Ariary</td>
        </tr>
        <tr>
          <%  double w1=dd[0].getCout()*dd[0].getNombreimpression();
              double w2=w1-(w1*dd[0].getRemise())/100;
           %>
          <td><strong> Net à payer (avec remise) : </strong><%=w2%> &nbsp; Ariary</td>
          <td><strong> Remise : </strong><%= dd[0].getRemise() %> %</td>
        </tr>
         <tr>
          <td><strong> Marge Beneficiaire: </strong><%= dd[0].getMargeBenefice()%> %</td>
        </tr>
        <tr>
          <td><strong> Benefice unitaire A3: </strong><%= dd[0].getBenefice()%> &nbsp; Ariary</td> <td><strong> Benefice totale: </strong><%= dd[0].getBenefice()*dd[0].getNombreimpression()%> &nbsp; Ariary</td>
        </tr>
      </table></td>
  </tr>
</table>
<div align="center"></div>
<br>
<br>
<br>
</div>
