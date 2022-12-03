<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="penalite.*" %>
<%@page import="utilitaire.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/factureFille.jsp";
        String lien= null;
        UserEJB u = null;
        bean.TypeObjet unite[] = null;
        Penalite pen = null;
        String idPen = null;
             facture.SCatService  sctserv = null;

             String a = null;
     %>
     <%
     a =request.getParameter("a");
if(a==null)a="";
idPen = request.getParameter("idPen");
%>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
unite = u.findTypeObjet("unite","%","%");
//String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4
pen = u.findPenalite(idPen,"","%","%","%","%","%","%","%")[0];
sctserv = u.findSCatService(pen.getIdSCatService(), "%", "%", "%")[0];



}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>D&eacute;tails p&eacute;nalit&eacute; Taux d'occuppation</title><h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es aux taux d'occupation
  de quai </h1>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>

	<table width="600" border="0" cellspacing="0" cellpadding="0" class="monographe">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr>
                <td width="54%" align="right" class="left">&nbsp;Num&eacute;ro
                  :</td>
                <td width="46%" align="center"><%=pen.getIdPenalite()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Date d&eacute;but :</td>
                <td align="center"><%=Utilitaire.formatterDaty(pen.getDateDebut())%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Date fin :</td>
                <td align="center"><%=Utilitaire.formatterDaty(pen.getDateFin())%></td>
              </tr>
              <tr>
                <td align="right" valign="top" class="left">&nbsp;D&eacute;signation
                  :</td>
                <td align="center"><%=pen.getDesignation()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Montant :</td>
                <td align="center"><%=Utilitaire.formaterAr((double)pen.getMontant())%> Ar</td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Type :</td>
                <td align="center"><%=sctserv.getNomSCatService()%></td>
              </tr>
              <tr>
                <td align="right" class="left">Temps d'ammarage - temps d&eacute;sammarage(%)
                  : </td>
                <td align="center">( <%=pen.getChamp1()%> / <%=pen.getChamp2()%>)
                  x 100 )</td>
              </tr>
              <tr>
                <td align="right" class="left">Chiffre d'affaire de la TAC du
                  mois de <%=Utilitaire.nbToMois(Utilitaire.getMois(pen.getDateFin()))%> :</td>
                <td align="center"><%=Utilitaire.formaterAr((double)u.calculCA(Utilitaire.formatterDaty(pen.getDateFin()),Utilitaire.formatterDaty(pen.getDateFin())))%> Ar</td>
              </tr>
              <tr>
                <td align="right" class="left">Seuil taux d'occuppation des quais
                  :</td>
                <td align="center"><%=pen.getChamp4()%> %</td>
              </tr>
            </table></td>
  </tr>
</table>

</td>
  </tr>
</table>



<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td height="30" align="center">
            Montant =[((( <%=pen.getChamp1()%>  / <%=pen.getChamp2()%>) x 100 ) + <%=pen.getChamp3()%> % ) -  <%=pen.getChamp4()%>) / <%=pen.getChamp4()%>)] x <%=Utilitaire.formaterAr((double)u.calculCA(Utilitaire.formatterDaty(pen.getDateFin()),Utilitaire.formatterDaty(pen.getDateFin())))%> = <%=Utilitaire.formaterAr((double)pen.getMontant())%> Ar
        <br>
</td>
        </tr>
      </table></td>
  </tr>
</table>
            
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr> 
          <td height="30" align="center"><div align="justify">&#8226; Objectif 
              : <br>
              Le taux d&#8217;occupation du front maritime par les activit&eacute;s 
              du TAC (postes C2 et C3) ne doit pas exc&eacute;der <%=pen.getChamp4()%>% 
              en moyenne semestrielle. Les semestres courent du 1er Janvier au 
              30 Juin et du 1er Juillet au 31 D&eacute;cembre de chaque ann&eacute;e. 
              Le premier semestre d&eacute;bute le 1er Janvier 2006.<br>
              La comptabilisation du temps d&#8217;occupation est bas&eacute;e 
              sur la disponibilit&eacute; ouvrable des quais en relation &agrave; 
              leur occupation effective par les navires (Tamarrage &#8211; Td&eacute;samarrage 
              + 15%) en heures et est exprim&eacute;e en %.<br>
              <br>
              &#8226; Sanction : &eacute;cart entre la performance r&eacute;alis&eacute;e 
              et la performance vis&eacute;e (en%) x 1 x le chiffre d&#8217;affaires 
              du mois consid&eacute;r&eacute;.<br>
              <br>
              <u>Exemple :</u> <br>
              Premier semestre 2006 (1er janvier au 30 juin), taux d&#8217;occupation 
              des quais C2 et C3 = 52%.<br>
              Ecart = (52-50)/50=4%.<br>
              P&eacute;nalit&eacute; : 4% x 1 x CA du semestre consid&eacute;r&eacute;<br>
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
<%
if(a.compareTo("yes")!=0){
%>
  <div align="center"><br>
  <br>
  <a href='javascript:Popup("penalites/detailPenTauxQuai.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a>
 <!-- <a href="penalites/detailPenTauxQuai.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes" target="_blank">Voir
  aperçu</a>--></div>
<%
}
%>

