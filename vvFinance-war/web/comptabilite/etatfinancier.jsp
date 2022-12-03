<%@ page import="user.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
        String apres="comptabilite/etatfinancier-resultat.jsp";
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


<h1>Etat financier</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent">

<table border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>EXERCICE : </td>
		<td><input name="exercice" type="text" id="exercice" value=""/></td>
		<td>
			<input name="btn" type="button" onClick="pagePopUp('comptabilite/choixExercice.jsp?champReturn=exercice')" value="..." class="submit">
		</td>
	</tr>
</table>
<br>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
			<td align="center">
              <input type="submit" name="Submit" value="Etat financier" class="submit">
			</td>
          <td align="center"><input type="reset" name="annuler" value="R&eacute;tablir" class="submit" /></td>
			 <input name="bute" type="hidden" id="bute" value="comptabilite/etatfinancier.jsp">
  </tr>
</table>
    </td>
        </tr>
</table>
</form>