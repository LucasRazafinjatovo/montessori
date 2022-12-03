<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        String apres="facture/listeFactureAnalyse.jsp";
        String lien= null;

        String datyinf = null;
         String datySup = null;
          String idEcriture = null;
          String compte = null;
        String piece = null;
        String libelle = null;
        UserEJB u = null;
%>
<%
         datyinf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         idEcriture = request.getParameter("idEcriture");
         compte = request.getParameter("compte");
         piece = request.getParameter("piece");
         libelle = request.getParameter("libelle");
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (idEcriture==null || idEcriture.compareTo("")==0) idEcriture="%";
          if (compte==null || compte.compareTo("")==0) compte="%";
         if ((piece==null)|| piece.compareTo("")==0) piece="%";
         if ((libelle==null)|| libelle.compareTo("")==0) libelle="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//findEcriture(String idEcriture, String daty1, String daty2, String libelle, String compte, String piece) throws Exception {

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des &eacute;critures Comptables</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les factures)</p>
<form action="<%=lien%>?but=facture/listeEcriture.jsp" method="post" name="listeFact">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf" value="<%=datyinf%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin :</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=datySup%>">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">Id Ecriture :</td>
            <td><input name="idEcriture" type="text" class="champ" id="idEcriture" value="<%=idEcriture%>"></td>
            <td class="left">Compte :</td>
            <td><input name="compte" type="text" class="champ" id="compte" value="<%=compte%>"></td>
          </tr>
          <tr>
            <td class="left">Num Piece :</td>
            <td><input name="piece" type="text" class="champ" id="piece" value="<%=piece%>"></td>
            <td class="left">Libelle :</td>
            <td><input name="libelle" type="text" class="champ" id="libelle" value="<%=libelle%>"></td>
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
        <div align="center"></div></td>
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
