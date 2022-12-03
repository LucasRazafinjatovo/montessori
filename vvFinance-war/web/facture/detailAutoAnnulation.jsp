<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        UserEJB u = null;
	facture.AutorisationAnnulation autoAnnul = null;
        String lien = null;
        String idAuto = null;
        TypeObjet to=null;
%>
<%
idAuto = request.getParameter("idAuto");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
autoAnnul = u.findAutorisationAnnulation(idAuto,"%","%","","","%","%")[0];
to=u.findTypeObjet("TypeObjet",autoAnnul.getIdTypeObjet(),"%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tail : Autorisation d'annulation N&deg; <%=autoAnnul.getIdAutorisation()%></h1>
<table cellspacing="0" cellpadding="0" align="center" width="445">
<tr><td width="441"><form name="form1" method="post" action="<%=lien%>?but=facture/apresAutoAnnulation.jsp">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td width="186" height="25" class="left">Date :</td>
          <td width="245"><div align="center"><%=Utilitaire.formatterDaty(autoAnnul.getDaty()) %></div></td>
        </tr>
        <tr>
          <td class="left" height="25">Type de l'objet annul&eacute; :</td>
          <td><div align="center"><%=to.getVal()%></div></td>
        </tr>
        <tr>
          <td class="left" height="25">Num&eacute;ro Objet annul&eacute; : </td>
          <td><div align="center"><%=autoAnnul.getIdObjet()%> </div></td>
        </tr>
        <tr>
          <td class="left" height="25">Responsable : </td>
          <td><div align="center"><%=autoAnnul.getResponsable()%> </div></td>
        </tr>
        <tr>
          <td class="left" height="25">Motif :</td>
		  <td><div align="center"><%=autoAnnul.getMotif()%></div></td>
        </tr>
      </table>
  <div align="center">

<%
  if(u.getUser().getIdrole().compareTo("admin") == 0 || u.getUser().getIdrole().compareTo("dg") == 0 || u.getUser().getIdrole().compareTo("adminFacture") == 0)
      {
    if(autoAnnul.getValidation()==null){
%>
<input type="submit" name="Submit" value="Valider">

<%
    }}%><input name="acte" type="hidden" id="acte" value="valider">
    <input name="id" type="hidden" id="id" value="<%=autoAnnul.getIdAutorisation()%>">
<input name="typa" type="hidden" id="typa" value="<%=to.getDesce() %>">
<input name="objet" type="hidden" id="typa" value="<%=autoAnnul.getIdObjet()%> ">

  </div>
</form>
</td>
</tr>
</table>
<br>
<div align="center">
<a href='javascript:Popup("facture/apercuAutoAnnulation.jsp?id=<%=autoAnnul.getIdAutorisation()%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a>


<!--<a href="facture/apercuAutoAnnulation.jsp?id=<%=autoAnnul.getIdAutorisation()%>" target="_blank"><br>
  Aperçu</a>--> </div>
