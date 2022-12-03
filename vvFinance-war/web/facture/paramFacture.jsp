<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresParamFacture.jsp";
	String lien= null;
        UserEJB u = null;
        facture.ParametreFacture pf = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//pf=u.loadParametreFacture(Utilitaire.dateDuJour());
//System.out.println("daty="+Utilitaire.dateDuJour());
pf = u.loadParametreFacture(Utilitaire.dateDuJour());
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier Param&egrave;tre</h1>
<form name="param" method="post" action="<%=lien%>?but=<%=apres%>">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="86">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
          <td class="left">Date d&eacute;but validit&eacute; :</td>
          <td><input name="dateDebut" type="text" class="champ" id="dateDebut" size="10" maxlength="10" value="<%=Utilitaire.formatterDaty(pf.getDatedebutvalid())%>" onBlur="cal_prs_date1(dateDebut.value)">
            <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
        </tr>
        <tr>
          <td class="left">D&eacute;lai de paiement d'une facture : </td>
          <td><input name="delaiFact" type="text" class="champ" id="delaiFact" size="3" maxlength="3" value="<%=pf.getDelaiPaiement()%>">
            jours</td>
        </tr>
        <tr>
          <td class="left">Nombre en EVP pour Bonus : </td>
          <td><input name="plafondEvp" type="text" class="champ" id="plafondEvp" value="<%=(long)pf.getBonusEVP()%>">
              conteneurs</td>
        </tr>
        <tr>
          <td class="left">Reduction pour bonus EVP : </td>
          <td><input name="redEvp" type="text" class="champ" id="redEvp" value="<%=pf.getReductionTrafic()%>">
              %
              <input name="acte" type="hidden" id="acte2" value="INSERT"></td>
        </tr>
            </table>
      </td>
  </tr>
  <tr>
      <td height="30">
<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center">
<input type="submit" name="Submit2" value="Modifier" class="submit" onClick="MM_validateForm('dateDebut','','R','delaiFact','','RisNum','plafondEvp','','RisNum');return document.MM_returnValue">

          </td>
          <td align="center">
<input type="reset" name="Submit" value="R&eacute;tablir" class="submit">
          </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</form>

<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
    <td class="remarque" align="left">(*) La modification des paramètres prend
        effet à partir de la date de début de validité donnée ci dessus.</td>
</tr>
</table>
<script language="javascript">
var cal1 = new calendar1(document.forms['param'].elements['dateDebut']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>