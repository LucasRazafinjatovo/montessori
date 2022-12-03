<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="penalites/apresVerifPenalite.jsp";
	String lien= null;
	facture.Client clt[] = null;
	facture.SCatService sctserv[] = null;
	UserEJB u = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
sctserv = u.findSCatService("%", "%", "cat2", "%");
lien=(String)session.getValue("lien");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Vérifier les p&eacute;nalit&eacute;s </h1>
<form action="<%=lien%>?but=<%=apres%>" method="post">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
          <td width="17%" class="left">Mois :</td>
            <td width="32%" align="center">
              <select name="mois" class="champ" id="select">
                <option value="01">janvier</option>
                <option value="02">f&eacute;vrier</option>
                <option value="03">mars</option>
                <option value="04">avril</option>
                <option value="05">mai</option>
                <option value="06">juin</option>
                <option value="07">juillet</option>
                <option value="08">ao&ucirc;t</option>
                <option value="09">sept.</option>
                <option value="10">oct.</option>
                <option value="11">nov.</option>
                <option value="12">d&eacute;c.</option>
              </select>
            </td>
          <td width="18%" class="left">Ann&eacute;e :</td>
			<td width="33%" align="center">
<input name="annee" type="text" class="champ" id="annee" value="<%=Utilitaire.getAneeEnCours()%>" size="4" maxlength="4">
            </td>
        </tr>
        <tr>
          <td class="left">Client :</td>
            <td align="center">
              <select name="idClient" class="champ" id="idClient">
              <%
	  for(int i=0;i<clt.length;i++){
	  %>
              <option value="<%=clt[i].getIdClient()%>" <%if(clt[i].getIdClient().compareTo("clt1")==0)out.println("selected");%>><%=clt[i].getNom()%></option>
              <%
	  }
	%>
            </select>
            </td>
          <td class="left">Type :</td>
            <td align="center">
<select name="idType" class="champ" id="idType">
              <option valu="%">Tous</option>
              <%
	  for(int i=0;i<sctserv.length;i++){
	  %>
              <option value="<%=sctserv[i].getIdScatService()%>"><%=sctserv[i].getNomSCatService()%></option>
              <%
          }
		%>
            </select>
            </td>
        </tr>
      </table>

	  </td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center">
<input name="Input2" type="submit" value="V&eacute;rifier" class="submit">
            </td>
            <td align="center">
<input name="Input" type="reset" value="Annuler" class="submit">
            </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</form>



