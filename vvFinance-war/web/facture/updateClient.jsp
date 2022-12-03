<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
    String apres="facture/apresClient.jsp";
    Client clt = null;
    String lien= null;
    UserEJB u = null;
    String idClient = null;
	TypeObjet regime[] = null;
%>
<%
idClient = request.getParameter("idClient");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
regime = u.findTypeObjet("Regime","%","%");
clt = u.findClient(idClient,"%","%","%","%","%","%","%","%","%","%")[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier Client</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" target="_parent" onsubmit="return (verifie(nomClient.value))">
<table cellpadding="0" cellspacing="0" border="0" width="450" align="center"><tr><td>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <!--DWLayoutTable-->
          <tr>
            <td width="149" height="23" valign="top" class="left">Nom du client
              :</td>
            <td width="239" valign="top"><input name="nomClient" type="text" class="champ" value="<%=clt.getNom()%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">T&eacute;l&eacute;phone
              : </td>
            <td valign="top"><input name="telephone" type="text" class="champ" id="telephone" value="<%=clt.getTelephone()%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Fax :</td>
            <td valign="top"><input name="fax" type="text" class="champ" id="fax" value="<%=clt.getFax()%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Adresse :</td>
            <td valign="top"><textarea name="adresse" id="adresse"><%=clt.getAdresse()%></textarea></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">R&eacute;gime :</td>
            <td valign="top"><select name="idRegime" class="champ" id="idRegime">
                <%
for(int i=0;i<regime.length;i++){

%>
                <option value="<%=regime[i].getId()%>" <%if(clt.getIdRegime().compareTo(regime[i].getId())==0)out.println("selected");%>><%=regime[i].getVal()%></option>
                <%
}
%>
              </select></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Num&eacute;ro statistique
              :</td>
            <td valign="top"><input name="numStat" type="text" class="champ" id="numStat" value="<%=clt.getNumstat()%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">NIF :</td>
            <td valign="top"><input name="nif" type="text" class="champ" id="nif" value="<%=clt.getNif()%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">RC :</td>
            <td valign="top"><input name="rc" type="text" class="champ" id="rc" value="<%=clt.getRc()%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Taxe professionnelle:</td>
            <td valign="top"> <input name="tp" type="text" class="champ" id="tp" value="<%=clt.getTp()%>">
            </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">CIF n&deg;:</td>
            <td valign="top" ><input name="quittance" type="text" class="champ" id="quittance" value="<%=clt.getQuittance()%>">
              <input name="acte" type="hidden" id="acte" value="UPDATE"> <input name="idClient" type="hidden" id="idClient" value="<%=clt.getIdClient()%>">
            </td>
          </tr>
        </table>
	</td></tr>
	<tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center">
<input type="submit" name="Submit" value="Valider" class="submit">
            </td>
            <td align="center">
<input type="reset" name="Submit2" value="Annuler" class="submit">
            </td>
  </tr>
</table>
      </td>
    </tr>
		 </table>
		  </form>