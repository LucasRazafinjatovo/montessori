<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="historique.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String lien = null;
  String apres = "facture/listeClient.jsp";
  UserEJB u = null;
 String annee1=null;
 String annee2=null;


%>
<%
//datyInf = request.getParameter("datyInf");
//datySup = request.getParameter("datySup");
  if (annee1 == null || annee1.compareTo("")==0 ) annee1=String.valueOf(Utilitaire.getAneeEnCours());
if (annee2 == null || annee1.compareTo("")==0) annee2=String.valueOf(Utilitaire.getAneeEnCours());
%>
<%
try{
	u=(UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
    apres = "facture/listeTraficEvp.jsp";


}catch(Exception e){
 return;
}

%>
<link href="style.css" rel="stylesheet" type="text/css">
 

<h1>Liste Trafic EVP</h1>
<form action="<%=lien%>?but=facture/listeTraficEvp.jsp" name="listeTraffic" method="post">
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="0" class="monographe">
        <tr>
            <td width="17%" class="left">Mois d&eacute;but :</td>
          <td width="31%"><select name="mois1" class="champ" id="mois1">
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
              </select> </td>  <td width="17%" class="left">Ann&eacute;e d&eacute;but :</td>
          <td width="35%"><input name="annee1" type="text" class="champ" id="annee1" maxlength="4" value="<%=annee1%>">
            </td>
        </tr>
		 <tr>
            <td class="left">Mois fin :</td>
          <td><select name="mois2" class="champ" id="mois2">
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
              </select> </td>
            <td class="left">Ann&eacute;e fin :</td>
          <td><input name="annee2" type="text" class="champ" id="annee2" maxlength="4" value="<%=annee2%>">
            </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
<input name="Submit" type="submit" class="submit" value="Afficher">
          </td>
          <td align="center">
<input name="Submit2" type="reset" class="submit" value="Annuler">
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<br>
