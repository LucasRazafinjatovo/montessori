<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        String apres="pointage/listePointage.jsp";
        String lien= null;

        String heureInf = null;
         String heureSup = null;
        String datyinf = null;
         String datySup = null;
          String idPointage = null;
          String nom = null;
        String machine = null;
        String ip = null;
        UserEJB u = null;
          String type = null;
        String agence = null;
%>
<%
         heureInf = request.getParameter("heureInf");
         heureSup = request.getParameter("heureSup");
         datyinf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         idPointage = request.getParameter("idPointage");
         nom = request.getParameter("nom");
         machine = request.getParameter("machine");
         ip = request.getParameter("ip");
         type = request.getParameter("type");
         agence = request.getParameter("agence");
         if ((heureInf == null)|| heureInf.compareTo("")==0) heureInf="";
         if (heureSup== null || heureSup.compareTo("")==0) heureSup="";
         if ((datyinf == null)|| datyinf.compareTo("")==0) datyinf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         if (idPointage==null || idPointage.compareTo("")==0) idPointage="%";
          if (nom==null || nom.compareTo("")==0) nom="%";
         if ((machine==null)|| machine.compareTo("")==0) machine="%";
         if ((ip==null)|| ip.compareTo("")==0) ip="%";
         if ((type==null)|| type.compareTo("")==0) type="%";
         if ((agence==null)|| agence.compareTo("")==0) agence="%";
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
<h1>Liste des Pointages</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les Pointages)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listePointage">
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
            <td class="left">Heure début :</td>
            <td><input name="heureInf" type="text" class="champ" id="heureInf" value="<%=heureInf%>"></td>
            <td class="left">Heure fin :</td>
            <td><input name="heureSup" type="text" class="champ" id="heureSup" value="<%=heureSup%>"></td>
          </tr>
          <tr>
            <td class="left">Id Pointage :</td>
            <td><input name="idPointage" type="text" class="champ" id="idPointage" value="<%=idPointage%>"></td>
            <td class="left">Utilisateur :</td>
            <td><input name="nom" type="text" class="champ" id="nom" value="<%=nom%>"></td>
          </tr>
          <tr>
            <td class="left">Machine :</td>
            <td><input name="machine" type="text" class="champ" id="machine" value="<%=machine%>"></td>
            <td class="left">Ip :</td>
            <td><input name="ip" type="text" class="champ" id="ip" value="<%=ip%>"></td>
          </tr>
          <tr>
            <td class="left">Type Pointage :</td>
            <td><input name="idPointage" type="text" class="champ" id="idPointage" value="<%=idPointage%>"></td>
            <td class="left">Utilisateur :</td>
            <td><input name="nom" type="text" class="champ" id="nom" value="<%=nom%>"></td>
          </tr>
          <tr>
            <td class="left">Machine :</td>
            <td><input name="machine" type="text" class="champ" id="machine" value="<%=machine%>"></td>
            <td class="left">Ip :</td>
            <td><input name="ip" type="text" class="champ" id="ip" value="<%=ip%>"></td>
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
