<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="penalites/apresParamPenalite.jsp";
        String lien= null;
        facture.Client clt[] = null;
        facture.SCatService sctserv[] = null;
        UserEJB u = null;
        TypeObjet etat[] = null;
        ParametrePenalite paraPen = null;
		String daty;
        //ParametrePenalite[] findParametrePenalite(String idParametrePenalite, String tauxDirBcEurop, String majorBcEurop, String delaiPaiementPenalit, String performAnnuel, String slTauxOccup, String majorTauxOccup, String slRappPerteAnnu, String slNbPerteAnnu, String pxUnitVol, String slRappDommagTotal, String pxPourcExc, String valLimitcont, String nbLimitAccAnnu, String pxAccExc, String date1) throws bean.ErreurDAO, RemoteException;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
if (daty== null || daty.compareTo("")==0) daty=Utilitaire.dateDuJour();
//paraPen = u.findParametrePenalite("%","%","%","%","%","%","%","%","%","%","%","%","%","%","%","")[1];
paraPen = u.loadParametrePenalite(daty);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Modifier les param&egrave;tres li&eacute;s aux p&eacute;nalit&eacute;s</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="paramPen" id="paramPen">
  <table width="600" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
    <tr>
      <td class="left">Date de d&eacute;but d'application :</td>
      <td><input name="datyD" type="text" class="champ" id="datyD" value="<%=Utilitaire.dateDuJour()%>" maxlength="10">
        <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
      </td>
    </tr>
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#E4E4E4"><font color="#666666"><strong>Param&egrave;tre
        li&eacute; aux retards de paiement</strong></font></td>
    </tr>
    <tr>
      <td class="left">Majoration du taux de la Banque centrale Eur. :</td>
      <td><input name="tauxDirBce" type="text" class="champ" id="tauxDirBce" value="<%=paraPen.getTauxDirBanqCentrEurop()%>" size="4" maxlength="4">
        % </td>
    </tr>
    <tr>
      <td class="left">D&eacute;lai de paiement de p&eacute;nalit&eacute; :
        <input name="acte" type="hidden" id="acte" value="INSERT"></td>
      <td><input name="delaiPaie" type="text" class="champ" id="delaiPaie" value="<%=paraPen.getDelaiPaiementPenalite()%>" size="3" maxlength="3">
        jours</td>
    </tr>
    <tr>
      <td class="left">Majoration SPAT : </td>
      <td><input name="majorSpat" type="text" class="champ" value="<%=paraPen.getMajorBanqueCentrale()%>" size="4" maxlength="4">
        %</td>
    </tr>
    <tr align="center" bgcolor="#E4E4E4">
      <td height="25" colspan="2"><font color="#666666"><strong>Param&egrave;tre
        li&eacute; aux objectifs de performance</strong></font></td>
    </tr>
    <tr>
      <td class="left">Objectif de performance Annuel :</td>
      <td><input name="objPerfAnnuel" type="text" class="champ" id="objPerfAnnuel" value="<%=paraPen.getPerformanceAnnuel()%>" size="25" maxlength="25">
        conteneurs</td>
    </tr>
    <tr bgcolor="#E4E4E4">
      <td height="25" colspan="2" align="center"><font color="#666666"><strong>Param&egrave;tre
        li&eacute; aux taux d'occupation de l'accostage</strong></font> </td>
    </tr>
    <tr>
      <td class="left">Seuil du Taux d&#8217;occupation :</td>
      <td><input name="slTauxOccup" type="text" class="champ" id="slTauxOccup" value="<%=paraPen.getSeuilTauxOccupation()%> ">
        &nbsp;%</td>
    </tr>
    <tr>
      <td class="left">Majoration taux d&#8217;occupation :</td>
      <td><input name="majorTauxOccup" type="text" class="champ" id="majorTauxOccup" value="<%=paraPen.getMajorTauxOccupation()%>" size="3" maxlength="3">
        % </td>
    </tr>
    <tr align="center">
      <td height="25" colspan="2" bgcolor="#E4E4E4"><strong><font color="#666666"><strong>Param&egrave;tre
        li&eacute; aux pertes / Vols de conteneur</strong></font></strong></td>
    </tr>
    <tr>
      <td class="left">Seuil Rapport entre les pertes annuelles :</td>
      <td><input name="slRappPerteAnnu" type="text" class="champ" id="slRappPerteAnnu" value="<%=paraPen.getSlRapPerteAnnuel()%>" size="3" maxlength="3">
        %</td>
    </tr>
    <tr>
      <td class="left">Seuil nombre minimum de perte par An :</td>
      <td><input name="slNbPerteAnnu" type="text" class="champ" id="slNbPerteAnnu" value="<%=paraPen.getSlNbPerteAnnuel()%>" size="3" maxlength="3">
        conteneurs</td>
    </tr>
    <tr>
      <td class="left">Seuil Rapport entre les pertes annuelles :</td>
      <td><input name="slRappPerteAnnu" type="text" class="champ" id="slRappPerteAnnu" value="<%=paraPen.getSlRapPerteAnnuel()%>" size="3" maxlength="3">
        unit&eacute; </td>
    </tr>
    <tr>
      <td class="left">Prix par unit&eacute; de la p&eacute;nalit&eacute; li&eacute;e
        aux vols de conteneur :</td>
      <td><input name="pxUnitVol" type="text" class="champ" id="pxUnitVol" value="<%=paraPen.getPxUnVol()%>">
        Euro</td>
    </tr>
    <tr bgcolor="#E4E4E4">
      <td height="25" colspan="2" align="center"><font color="#666666"><strong>Param&egrave;tre
        li&eacute; aux dommages sur conteneur</strong></font></td>
    </tr>
    <tr>
      <td class="left">Seuil Rapport entre conteneurs endommag&eacute;s et <br>
        nb total conteneurs manutentionn&eacute;s :</td>
      <td><input name="slRappDommagTotal" type="text" class="champ" id="slRappDommagTotal" value="<%=paraPen.getSlRapEnDomTotal()%>" size="3" maxlength="3">
        %</td>
    </tr>
    <tr>
      <td class="left">Prix par unit&eacute; de pourcentage excessive :</td>
      <td><input name="pxPourcExc" type="text" class="champ" id="pxPourcExc" value="<%=paraPen.getPxPtageExc()%>">
        Euro</td>
    </tr>
    <tr>
      <td class="left">Valeur limite de conteneur :</td>
      <td><input name="valLimitcont" type="text" class="champ" id="valLimitcont" value="<%=paraPen.getValLimCont()%>">
        Euro</td>
    </tr>
    <tr>
      <td class="left">Nombre limite d&#8217;accident de travail par an :</td>
      <td><input name="nbLimitAccAnnu" type="text" class="champ" id="nbLimitAccAnnu" value="<%=paraPen.getNbLimAccAnnuel()%>">
        Unit&eacute;</td>
    </tr>
    <tr bgcolor="#E4E4E4">
      <td height="25" colspan="2" align="center"><strong><font color="#666666">Param&egrave;tre
        li&eacute; aux accidents de travail</font></strong></td>
    </tr>
    <tr>
      <td class="left">Prix par unit&eacute; d&#8217;accident excessive :</td>
      <td><input name="pxAccExc" type="text" class="champ" id="pxAccExc" value="<%=paraPen.getPxAccExc()%>" maxlength="1"></td>
    </tr>
  </table>
  <table width="600" height="30" border="0" align="center" valign="center">
    <tr>
            <td width="50%"> <div align="center">

          <input type="submit" name="Submit" value="Modifier" class="submit">
              </div></td>
            <td><div align="center">
                <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
              </div></td>
          </tr>
        </table>
</form>
<script language="javascript">
var cal1 = new calendar1(document.forms['paramPen'].elements['datyD']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
