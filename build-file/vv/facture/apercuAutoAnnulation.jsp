<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
  String lien=null;
  UserEJB u=null;
  String idAutorisation = null;
  facture.AutorisationAnnulation autoAnl = null;
  Societe spat = null;
%>
<%
idAutorisation = request.getParameter("id");
%>
<%
try{
  u=(UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  autoAnl = u.findAutorisationAnnulation(idAutorisation,"%","%","","","%","%")[0];
  spat = u.findMaSociete("%","%","%","%","%","%","%","%","%","%");
 }catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

 
<link href="style.css" rel="stylesheet" type="text/css">
<title>Autorisation d'annulation</title><table width="560" border="1" align="center" bordercolor="#cccccc">
<tr><td>
<table width="500" border="0" cellpadding="0" cellspacing="0" align="center" >
 	<tr>
	<td height="10"></td>
	</tr>
  <tr>
          <td height="21" align="right">Toamasina, le <font color="15"><%=Utilitaire.formatterDaty(autoAnl.getDaty())%></font></td>
  </tr>
  	<tr>
	<td height="25"></td>
	</tr>
  <tr>
          <td height="21" align="center"><strong>Autorisation d'annulation d'objet 
            n&deg;</strong> <%=autoAnl.getIdAutorisation()%><br>
      </td>
    </tr>
	<tr>
	<td height="25"></td>
	</tr>
        <tr>
          <td height="27" valign="top"><strong>Type objet &agrave; annuler :
            </strong> <font color="15"><%=u.findTypeObjet("TypeObjet",autoAnl.getIdTypeObjet(),"%")[0].getVal()%></font></td>
    </tr>
   <tr>
          <td height="27" valign="top"><strong>N&deg; Objet &agrave; annuler
            :</strong> <font color="15"><%=autoAnl.getIdObjet()%></font></td>
    </tr>
	  <tr>
          <td height="27" valign="top"><strong>Motif :</strong></td>
    </tr>
	<tr>
		<td>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr><td colspan="5" height="1" bgcolor="#999999"></td></tr>
			<tr>
			<td width="1" bgcolor="#999999"></td>
			<td width="10" height="250"></td>
			    <td valign="top"><br>
                  <%=autoAnl.getMotif()%> <br>

			</td>
			<td width="10"></td>
			<td width="1" bgcolor="#999999"></td>
			</tr>
			<tr><td colspan="5" height="1" bgcolor="#999999"></td></tr>
		</table>

		</td>
	</tr>
	<tr>
		<td height="25"></td>
	</tr>
	  </table>
</td></tr>
</table>
<br>
<table width="560" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
	<td height="1" bgcolor="#999999"></td></tr>
</table>
<table width="560" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr>

    <td height="30" valign="bottom"   align="right">
<strong><em>Le responsable</em>
</strong><br><%=autoAnl.getResponsable()%>
</td>
    </tr>
</table>
  <br>
  <!--
<hr align="center" width="500" color="#000000">
<table width="500" border="0" cellpadding="0" cellspacing="0" align="center" >
<tr>
    <td><div align="center"><strong> <br>
        <%=spat.getNom()%><br>
        </strong><br>

       <b>Numéro Statistique :</b> <%=spat.getNumStat()%> - <b>R.C.</b>  <%=spat.getRc()%> - <b>Nif :</b> <%=spat.getNif()%><br><b>T&eacute;l.</b> <%=spat.getTelephone()%> - <b>Fax.</b> <%=spat.getFax()%> - <b>Mail :</b> <%=spat.getEMail()%><strong><br>
        <%=spat.getAdresse()%></strong></div></td>
  </tr>
</table>
-->