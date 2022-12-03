<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

	String apres="facture/listeFactureAnalyse.jsp";
	String lien= null;
	facture.EtatFacture fm[] = null;
	String datyinf = null;
 	String datySup = null;
  	String idFactureMere = null;
  	String dateLimite = null;
	String idEtat = null;
	String idCatServ = null;
        String idSsCatServ = null;
        SCatService scatserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
	TypeObjet cat[] = null;//Représente Devise
        Client clt = null;
	String numFact = null;
        String client = null;
	String role = null;
	historique.MapUtilisateur ut=null;
%>
<%

%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");                         //String idFact, String daty1, String daty2, String etat, String clien, String scat
etat = u.findTypeObjet("Etat","%","%");
cat = u.findTypeObjet("devise","%","%");//represente devise
scatserv = u.findSCatService("%","%","%","%");
ut=u.getUser();
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Analyse des factures</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les factures)</p>
<form action="<%=lien%>?but=facture/listeFactureAnalyse.jsp" method="post" name="listeFact">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Monnaie :</td>
            <td><select name="idCat" class="champ" id="idCat">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<cat.length;i++){
          %>
                <option value=<%=cat[i].getId()%>><%=cat[i].getVal()%></option>
                <%
         }
          %>
              </select></td>
            <td class="left">Type de Fact :</td>
            <td><select name="sscat" class="champ"  id="sscat">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<scatserv.length;i++){
          %>
                <option value=<%=scatserv[i].getIdScatService()%>><%=scatserv[i].getNomSCatService()%></option>
                <%
                }
                %>
              </select></td>
          </tr>
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin :</td>
            <td><input name="datySup" type="text" class="champ" id="datySup">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">Client :</td>
            <td><input name="client" type="text" class="champ" id="client"></td>
            <td class="left">Num. Facture :</td>
            <td><input name="numFact" type="text" class="champ" id="numFact" size="10"></td>
          </tr>
        </table>



</td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center">
<input name="Annuler" type="reset" class="submit" value="Annuler">
            </td>
          </tr>
        </table>
        </td>
  </tr>
</table>
</form>




<br>
<script language="javascript">
var cal1 = new calendar1(document.forms['listeFact'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeFact'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
