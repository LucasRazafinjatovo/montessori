<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="penalite.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        ChiffreAffTac chiff = null;
        String lien = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
chiff=u.findChiffreAffTac(request.getParameter("idChiffre"),"%","%","%")[0];
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Montant chiffre d'affaires TAC</h1>
<form action="<%=lien%>?but=parametre/apresChiffreAffaire.jsp" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center" width="450">
<tr><td>  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
    <td  height="27" align="left" valign="top" class="left">Mois de
      :</td>
          <td  align="center" valign="top">
<select name="mois" class="champ" id="mois">
          <option value="1">janvier</option>
        <option value="2">f&eacute;vrier</option>
        <option value="3">mars</option>
        <option value="4">avril</option>
        <option value="5">mai</option>
        <option value="6">juin</option>
        <option value="7">juillet</option>
        <option value="8">ao&ucirc;t</option>
        <option value="9">sept.</option>
        <option value="10">oct.</option>
        <option value="11">nov.</option>
        <option value="12">d&eacute;c.</option>
      </select>
          </td>
	 </tr>
	 <tr>
    <td align="left" valign="top" class="left">Année :</td>
          <td  align="center" valign="top">
            <input name="annee" type="text" class="champ" id="annee" size="4" maxlength="4" value="<%=chiff.getAnnee()%>">
          </td>
      </tr>
	  <tr><td class="left">Montant</td>
          <td align="center">
<input name="montant" type="text" class="champ" id="montant" value="<%=(long)chiff.getMontant()%>">
            <input name="acte" type="hidden" id="acte" value="UPDATE">
<input name="idChiffre" type="hidden" id="acte" value="<%=request.getParameter("idChiffre")%>">
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
<input name="submit" type="submit" class="submit" value="Enregistrer">
          </td>
          <td align="center">
<input name="submit2" type="submit" class="submit" value="Annuler">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>


</form>