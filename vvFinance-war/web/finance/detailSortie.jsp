<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        Sortie s = null;
        String idSortie = null;
        TypeObjet ts = null;
        TypeObjet mod = null;
        Caisse caiss = null;
%>
<%
idSortie = request.getParameter("idSortie");
System.out.println("ID SORTIE "+idSortie);
%>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
s = u.findSortie(idSortie, "","", "%", "%", "%", "%", "%", "%", "%")[0];
caiss = u.findCaisse(s.getIdCaisse(),"%","%","%")[0];
//ts = u.findTypeObjet("TypeSortie",s.getIdTypeSortie(),"%")[0];
mod = u.findTypeObjet("ModePaiement",s.getIdModePaiement(),"%")[0];
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tail d&eacute;pense</h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr>
<td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr> 
          <td width="163" class="left">Num :</td>
          <td width="275"><%=s.getIdSortie()%></td>
        </tr>
        <tr> 
          <td width="163" class="left">Date :</td>
          <td width="275"><%=Utilitaire.formatterDaty(s.getDaty())%> </td>
        </tr>
        <tr> 
          <td class="left">D&eacute;signation : </td>
          <td><%=s.getDesignation()%> </td>
        </tr>
        <tr> 
          <td class="left"> Facture : </td>
          <td><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr> 
          <td class="left"> Caisse : </td>
          <td><%=caiss.getDescCaisse()%> </td>
        </tr>
        <tr> 
          <td class="left"> Devise : </td>
          <td><%=s.findDevise().getVal()%> </td>
        </tr>
        
        <tr> 
          <td class="left">Montant : </td>
          <td><%=Utilitaire.formaterAr((double)s.getMontant())%> </td>
        </tr>
        <tr> 
          <td class="left">Mode paiement : </td>
          <td><%=s.findModePayement().getDesce()%> </td>
        </tr>        
		<tr> 
          <td class="left">Projet: </td>
          <td><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
		<tr> 
          <td class="left">Remarque : </td>
          <td><%=s.getRemarque()%> </td>
        </tr>
      </table>
</td>
</tr>
</table>

