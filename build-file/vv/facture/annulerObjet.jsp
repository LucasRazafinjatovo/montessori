<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="utilitaire.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresAnnulerFacture.jsp";
	String lien= null;
	UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Annuler un Objet</h1>
<form name="form1" method="post" action="<%=lien%>?but=<%=apres%>">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td width="55%" height="22" class="left">Num&eacute;ro de l'objet 
              &agrave; annuler :</td>
            <td width="5%">&nbsp;</td>
            <td width="40%"><input name="numFact" type="text" id="numFact"></td>
          </tr>
        </table></td>
  </tr>
  <tr>
      <td height="30">
        <div align="center">
          <input name="Annuler la facture" type="submit" class="submit" id="Annuler la facture" value="Annuler l'objet">
        </div></td>
  </tr>
</table>
</form>
<table width="374" border="0" cellpadding="0" cellspacing="0" class="remarque" align="center">
  <!--DWLayoutTable-->
  <tr>
    <td width="374" height="65" valign="top" class="remarque">(*) Entrer le numéro 
      de l'objet que vous voulez annuler<br>
      RMQ : Un objet ne peut etre annulée qu'avec une autorisation<br>
      d'annulation déjà enregistrée</td>
  </tr>
</table>
