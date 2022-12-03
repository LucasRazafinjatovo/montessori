<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
    String apres="ded/apresEntreeRetourPiece.jsp";
    String lien= null;
    facture.Client clt[] = null;
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
	//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>RETOUR PIECE </h1>
<h2>&nbsp;</h2>


<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">

        <tr>
    <td height="30" align="center">

<table width="100%" border="0" class="monographe">


   <tr>
            <td class="left">Ref Ordre de paiement : <span class="remarque">*</span></td>
            <td align="center"><input name="idOP" type="text" class="champ"  id="idOP" /></td>
            <td align="left">&nbsp;<input name="choix3" type="button" onClick="pagePopUp('ded/choix_OPPiece.jsp?champReturn=idOP')" value="..." class="submit"><img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>


  <tr>
    <td class="left">Date: <span class="remarque">*</span></td>
    <td align="center"><input name="daty" type="text" class="champ" id="daty" value="<%=Utilitaire.dateDuJour()%>">
              &nbsp; </td>
			  <td class="left"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>  </td>
  </tr>
  <tr>
    <td class="left">Reference interne: <span class="remarque">*</span></td>
    <td align="center"><input name="refpiece" type="text" class="champ" id="refpiece" ></td>
  </tr>
  <tr>
    <td class="left">Reference originale: </td>
    <td align="center"><textarea name="remarque" class="champ" id="remarque" ></textarea>
              &nbsp;</td><td></td>
  </tr>

</table>
	  <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">

          <input name="acte" type="hidden" id="acte" value="INSERT">
          <input name="bute" type="hidden" id="bute" value="ded/entreeRetourPiece.jsp">
          <input type="submit" name="Submit" value="Enregistrer" class="submit">
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