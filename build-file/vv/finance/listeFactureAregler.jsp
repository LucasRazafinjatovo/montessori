<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet dev[] = null;
        TypeObjet etat[] = null;
        facture.Client clt[] = null;
        TypeObjet mp[] =null;
        TypeObjet factEn[] = null;
        facture.FactMere fm[] = null;
         %>
<%
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
dev = u.findTypeObjet("Devise","%","%");
factEn = u.findTypeObjet("Devise","%","%");
etat = u.findTypeObjet("etat","%","%");
fm = u.findFactureMere("%",  "%",  "%",  "%",  "%",  "%",  "%", "%");
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les factures
</h1>
<table width="600" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
  <tr>
    <td class="left">Date début :</td><td><input type="text" class="champ" value=" " size="10" maxlength="10"></td>   <td class="left">Date fin:</td><td><input type="text" class="champ" value="" size="10" maxlength="10"></td>
</tr>
<tr>
	<td class="left">Client :</td>
    <td>
      <input name="textfield" type="text" class="champ"></td><td class="left">Type :</td>
    <td><select name="select" class="champ">
        <%
	  for(int i=0;i<clt.length;i++){
	  %>


        <option value="<%=clt[i].getIdClient()%>"><%=clt[i].getNom()%></option>


		<%
		}
		%>
      </select></td>
  </tr>
  <tr>
    <td class="left">Etat :</td>
    <td><select name="select" class="champ">
        <%
	  for(int i=0;i<etat.length;i++){
	  %>


        <option value="<%=etat[i].getId()%>"><%=etat[i].getVal()%></option>


		<%
		}
		%>
      </select></td>
	<td class="left">Factur&eacute; en :</td>
    <td><select name="" class="champ">
        <%
	  for(int i=0;i<factEn.length;i++){
	  %>

        <option value=<%=factEn[i].getId()%>><%=factEn[i].getVal()%></option>


		<%
		}
		%>
      </select></td>
  </tr>
   <tr>
  <td class="left">Date lim. paiement :</td>
    <td><input name="textfield" type="text" class="champ" size="10" maxlength="10"></td>
	<td class="left">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

</table>
<div align="center"><br>
  <br>
  <input type="submit" name="Submit" value="Afficher" class="submit">
  &nbsp;
  <input name="Annuler" type="reset" class="submit" value="Annuler">
  <br>
  <br>
  <br>
</div>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="500">
	<tr><td><span class="page"> >> Liste int&eacute;grale</span></td></tr>
	<tr><td align="right"><span class="page">Page suivante >></span></td></tr>
</table>
<br><br>

<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
  <!--DWLayoutTable-->
  <tr class="head">
  	<td width="1" bgcolor="#CCCCCC"></td>
    <td width="90" height="25" align="center"><strong>Facture N&deg;</strong></td>
	<td width="1" bgcolor="#CCCCCC"></td>
    <td width="110" align="center"><strong>Montant</strong></td>
	<td width="1" bgcolor="#CCCCCC"></td>
	<td width="75" align="center">Date</td>
	<td width="1" bgcolor="#CCCCCC"></td>
	<td align="center" width="150">Client</td>
	<td width="1" bgcolor="#CCCCCC"></td>
	<td align="center" width="50">Etat</td>
	<td width="1" bgcolor="#CCCCCC"></td>
    <td width="89" valign="top" bgcolor="#FFFFFF">&nbsp;</td>
	<td width="1" bgcolor="#ffffff"></td>
  </tr>
 </table>


<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td colspan="13" height="1" bgcolor="#CCCCCC"></td>
	</tr>
	 <%
	  for(int i=0;i<fm.length;i++){
	  %>
  <tr>
  	<td width="1" bgcolor="#CCCCCC"></td>
    <td width="90" height="25" align="center"><%=fm[i].getIdFactureMere()%></td>
	<td width="1" bgcolor="#CCCCCC"></td>
    <td width="110" align="right"><%=fm[i].getMontantAPayer()%> &nbsp;</td>
	<td width="1" bgcolor="#CCCCCC"></td>
	<td align="center" width="75"><%=fm[i].getDaty()%></td>
	<td width="1" bgcolor="#CCCCCC"></td>
	<td align="center" width="150"><%=fm[i].getIdClient()%></td>
	<td width="1" bgcolor="#CCCCCC"></td>
	<td align="center" width="50"><%=fm[i].getIdEtat()%></td>
	<td width="1" bgcolor="#CCCCCC"></td>
    <td width="89" valign="middle" bgcolor="#FFFFFF">&nbsp;&nbsp;<a href="#">R&eacute;gler</a></td>
	<td width="1" bgcolor="#cccccc"></td>
  </tr>
  <tr>
		<td colspan="13" height="1" bgcolor="#CCCCCC"></td>
	</tr>
	<%
		}
		%>
   </table>
<br>

<table width="466" border="0" cellpadding="3" cellspacing="0" align="center">
	<tr>
	<td width="200"><%=fm.length%> r&eacute;sultats sur <%=fm.length%></td>
    <td><strong>Total page en cours :</strong> </td>
    <td><%=fm.length%></td>
  </tr>
	<tr><td></td>
    <td><strong>Total recherche : </strong> </td>
    <td><%=fm.length%></td>
  </tr>
</table>