<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="penalite.*" %>
<%@page import="utilitaire.*" %>
<%@page import="facture.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/factureFille.jsp";
        String lien= null;
        UserEJB u = null;
        bean.TypeObjet unite[] = null;
        Penalite pen = null;
        String idPen = null;
        facture.SCatService  sctserv = null;
        Change ch= null;

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
ch = u.loadChangeValide("Eur",Utilitaire.formatterDaty(pen.getDateFin()));

}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>D&eacute;tails p&eacute;nalit&eacute; accident</title><h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es aux accidents de travail</h1>

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>

	<table width="600" border="0" cellspacing="0" cellpadding="0" class="monographe">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="36%" align="right" class="left">&nbsp;Num&eacute;ro
                  :</td>
                <td width="64%" align="center"><%=pen.getIdPenalite()%></td>
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
                <td align="center"><%=Utilitaire.formaterAr((double)pen.getMontant())%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Type :</td>
                <td align="center"><%=sctserv.getNomSCatService()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Nombre d'accident :</td>
                <td align="center"><%=pen.getChamp2()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Prix par nombre d'accident
                  :</td>
                <td align="center"><%=pen.getChamp3()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Nombre limite d'accident
                  :</td>
                <td align="center"><%=pen.getChamp4()%></td>
              </tr>
              <tr>
                <td align="right" class="left">Change du <%=Utilitaire.formatterDaty(pen.getDateFin())%> :</td>
                <td align="center"><%=ch.getValeurEnAriary()%> Ar</td>
              </tr>
            </table></td>
  </tr>
</table>

</td>
  </tr>
</table>


<br>
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td height="30" align="center">&nbsp;<strong> Montant</strong> = (<%=pen.getChamp2()%> - <%=pen.getChamp4()%>) x <%=pen.getChamp3()%> x <%=ch.getValeurEnAriary()%> = <%=Utilitaire.formaterAr((double)pen.getMontant())%>  Ar</td>
        </tr>
      </table></td>
  </tr>
</table><br>
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr>
          <td height="30" align="center"><div align="justify">&#8226; Objectif
              :<br>
              Le concessionnaire devra assurer la s&eacute;curit&eacute; maximale
              &agrave; ses employ&eacute;s, entre autres, en r&eacute;duisant
              les accidents de travail. Il doit s&#8217;assurer que le nombre
              annuel d&#8217;accidents n&eacute;cessitant hospitalisation se limite
              &agrave; <%=pen.getChamp4()%>.<br>
              <br>
              &#8226; Sanction :<br>
              Lorsque le nombre annuel d&#8217;accidents n&eacute;cessitant hospitalisation
              pour une ann&eacute;e d&eacute;termin&eacute;e est de 12, la p&eacute;nalit&eacute;
              sera de 2 x <%=pen.getChamp3()%> = <%=(pen.getChamp3()*2)%> Euros. </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
if(a.compareTo("yes")!=0){
%>

<div align="center"><br>
  <br>
  <a href='javascript:Popup("penalites/detailPenAccident.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a>
  <!--<a href="penalites/detailPenAccident.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes" target="_blank">Voir
  aperçu</a>--></div>
  <%
  }
  %>
