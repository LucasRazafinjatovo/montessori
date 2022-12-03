<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        facture.Client clt[] = null;
        facture.SCatService sctserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
        ParametrePenalite paraPen = null;
	String daty=null;
	String a = null;
        //ParametrePenalite[] findParametrePenalite(String idParametrePenalite, String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String date1) throws bean.ErreurDAO, RemoteException;
%>
<%
a =request.getParameter("a");
if(a==null)a="";
daty=request.getParameter("daty");
if (daty== null || daty.compareTo("")==0) daty=Utilitaire.dateDuJour();
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//paraPen = u.findParametrePenalite("%","%","%","%","%","%","%","%","%","%","%","%","%","%","%","")[1];
paraPen = u.loadParametrePenalite(daty);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<form action="<%=lien%>?but=penalites/listeParamPenalite.jsp" method="post" name="paramPen">
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
<tr><td>
 <%
if(a.compareTo("yes")!=0){
%>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="100%" class="monographe">
 <tr>
            <td align="center" valign="top" class="left">Date d&eacute;but de
              validit&eacute; : </td>
            <td align="center">
<input name="daty" type="text" class="champ" id="designation" onBlur="cal_prs_date1(dateDebutValide.value)" value="<%=daty%>" maxlength="10">
              &nbsp; <span class="remarque"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </span></td>
        </tr>
        </table>
        </td></tr>
        <tr><td height="30"><div align="center">
          <input name="Afficher" type="submit" class="submit" value="Afficher">
        </div></td></tr>
</table>
</form>

<%
}
%>
<h1>Param&egrave;tres li&eacute;s aux p&eacute;nalit&eacute;s depuis le <%=Utilitaire.formatterDaty(paraPen.getDatyDebut())%>:</h1>

<br>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="600">
<tr>
<td>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr align="center" bgcolor="#E4E4E4">
          <td height="25" colspan="2"><font color="#666666"><strong>Param&egrave;tre
            li&eacute; aux retards de paiement</strong></font></td>
        </tr>
        <tr>
          <td width="83%" class="left">Majoration du taux de la Banque centrale
            Eur. :</td>
          <td width="17%"><%=paraPen.getTauxDirBanqCentrEurop()%> %</td>
        </tr>
        <tr>
          <td class="left">D&eacute;lai de Retard de paiement de facture de p&eacute;nalit&eacute;
            : </td>
          <td><%=paraPen.getDelaiPaiementPenalite()%> mois</td>
        </tr>
        <tr>
          <td class="left">Majoration SPAT :</td>
          <td><%=paraPen.getMajorBanqueCentrale()%>&nbsp;%</td>
        </tr>
        <tr align="center" bgcolor="#E4E4E4">
          <td height="25" colspan="2"><font color="#666666"><strong>Param&egrave;tre
            li&eacute; aux objectifs de performance</strong></font></td>
        </tr>
        <tr>
          <td class="left">Objectif de performance Annuel :</td>
          <td><%=paraPen.getPerformanceAnnuel()%> conteneurs</td>
        </tr>
        <tr align="center" bgcolor="#E4E4E4">
          <td height="25" colspan="2"><font color="#666666"><strong>Param&egrave;tre
            li&eacute; aux taux d'occupation de l'accostage</strong></font></td>
        </tr>
        <tr>
          <td class="left">Seuil du Taux d&#8217;occupation :</td>
          <td><%=paraPen.getSeuilTauxOccupation()%> % </td>
        </tr>
        <tr>
          <td class="left">Majoration taux d&#8217;occupation :</td>
          <td><%=paraPen.getMajorTauxOccupation()%> % </td>
        </tr>
        <tr align="center" bgcolor="#E4E4E4">
          <td height="25" colspan="2"><font color="#666666"><strong>Param&egrave;tre
            li&eacute; aux pertes / Vols de conteneur</strong></font></td>
        </tr>
        <tr>
          <td class="left">Seuil Rapport entre les pertes annuelles :</td>
          <td><%=paraPen.getSlRapPerteAnnuel()%> %</td>
        </tr>
        <tr>
          <td class="left">Seuil nombre minimum de pertes par An :</td>
          <td><%=paraPen.getSlNbPerteAnnuel()%> unit&eacute; </td>
        </tr>
        <tr>
          <td class="left">Seuil Rapport entre les pertes annuelles :</td>
          <td><%=paraPen.getSlRapPerteAnnuel()%> %</td>
        </tr>
        <tr>
          <td class="left">Prix par unit&eacute; de la p&eacute;nalit&eacute;
            li&eacute; au vol de conteneur :</td>
          <td><%=paraPen.getPxUnVol()%> Euro</td>
        </tr>
        <tr align="center" bgcolor="#E4E4E4">
          <td height="25" colspan="2"><font color="#666666"><strong>Param&egrave;tre
            li&eacute; aux dommages sur conteneur</strong></font></td>
        </tr>
        <tr>
          <td class="left">Seuil Rapport entre conteneurs endommag&eacute;es et
            nb total conteneurs manutentionn&eacute;es :</td>
          <td><%=paraPen.getSlRapEnDomTotal()%> %</td>
        </tr>
        <tr>
          <td class="left">Prix par unit&eacute; de pourcentage excessive :</td>
          <td><%=paraPen.getPxPtageExc()%> Euro</td>
        </tr>
        <tr>
          <td class="left">Valeur limite de conteneur :</td>
          <td><%=paraPen.getValLimCont()%> Euro</td>
        </tr>
        <tr align="center" bgcolor="#E4E4E4">
          <td height="25" colspan="2"><strong><font color="#666666">Param&egrave;tre
            li&eacute; aux accidents de travail</font></strong></td>
        </tr>
        <tr>
          <td class="left">Nombre limite d&#8217;accident de travail par an :</td>
          <td><%=paraPen.getNbLimAccAnnuel()%> Unit&eacute;</td>
        </tr>
        <tr>
          <td class="left">Prix par unit&eacute; d&#8217;accident excessive :</td>
          <td><%=paraPen.getPxAccExc()%> Euro</td>
        </tr>
      </table></td></tr>
</table>
 <%
if(a.compareTo("yes")!=0){
%>
<div align="center"><br>
  <br>
   <a href='javascript:Popup("penalites/listeParamPenalite.jsp?daty=<%=daty%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a></div>
 <!-- <a href="penalites/listeParamPenalite.jsp?daty=<%=daty%>&a=yes" target="_blank">Voir
  aper&ccedil;u</a> --></div>
  <%
  }
  %>
<table>

</table>
<script language="JavaScript">
var cal1 = new calendar1(document.forms['paramPen'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>