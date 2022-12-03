<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String lien= null;
        UserEJB u = null;
        String nature=null;
        String numObjet = null;
     %>
<%
numObjet=request.getParameter("id");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="PrevisionDepense";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Visa Prevision Depense</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=prevision/apresFichePrevision.jsp" method="post" >

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

        <tr>
			<td class="left">Prévision num : <span class="remarque">*</span></td>
            <td align="center"><input name="numPrev" type="text" class="champ"  id="numFact" readonly value="<%=numObjet%>" /></td>
            <td align="left">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
        </tr>
		<tr>
            <td class="left">Date : </td>
            <td align="center"><input name="daty" type="text" class="champ" id="daty" value=<%=Utilitaire.dateDuJour() %> /></td>
            <td align="left">&nbsp;
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
        </tr>
        <tr>
            <td class="left">Remarque : </td>
            <td align="center"><input name="remarque" type="text" class="champ" id="remarque" maxlength="20" /></td>
            <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
        </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
          <input name="acte" type="hidden" id="acte" value="VISER">
              <input type="submit" name="Submit" value="Viser" class="submit">
          </td>
          <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
          </td>
  </tr>
</table>
    </td>
        </tr>
</table>










</form>
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;

</script>
  <span class="remarque">(*) Champs obligatoires</span></div>