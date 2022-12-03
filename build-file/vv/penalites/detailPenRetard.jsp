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
        penalite.DetPenRetard penRetard[] = null;
        String a = null;
        ParametrePenalite paraPen = null;
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
//findDetPenRetard(String id, String idPen, String daty1, String daty2, String nbJour, String numPiece)
penRetard = u.findDetPenRetard("%",idPen,"","","%","%");
sctserv = u.findSCatService(pen.getIdSCatService(), "%", "%", "%")[0];
paraPen = u.loadParametrePenalite(Utilitaire.formatterDaty(pen.getDateFin()));
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>D&eacute;tails p&eacute;nalit&eacute; de retard</title><h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es au retard de paiement</h1>

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>

	<table width="600" border="0" cellspacing="0" cellpadding="0" class="monographe">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr>
                <td width="42%" align="right" class="left">&nbsp;Num&eacute;ro
                  :</td>
                <td width="58%" align="center"><%=pen.getIdPenalite()%></td>
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
                <td align="right" class="left">&nbsp;Num&eacute;ro Facture impay&eacute;
                  :</td>
                <td align="center"><a href="<%=lien%>?but=facture/detailFacture.jsp&idFactureMere=<%=pen.getChamp1()%>"><%=pen.getChamp1()%></a></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Taux directeur banque centrale
                  :</td>
                <td align="center"><%=pen.getChamp2()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Majoration SPAT :</td>
                <td align="center"><%=pen.getChamp3()%></td>
              </tr>
            </table></td>
  </tr>
</table>

</td>
  </tr>
</table>
<br>
	<table width="600" border="0" cellspacing="0" cellpadding="0" class="monographe" align="center">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr class="head"><td width="8%">Id</td>
          <td width="10%">N° Pén.</td>
          <td width="10%">D. inf.</td>
          <td width="12%">D. sup.</td>
          <td width="9%">R.A.P.</td>
          <td width="12%">N. j.d.r.</td>
          <td width="16%">Num Pi&egrave;ce</td>
          <td width="23%"><div align="right">Montant </div></td>
         </tr>
          <%
          for(int i=0;i<penRetard.length;i++){
          %>
         <tr height="30">
         <td align="center"><%=penRetard[i].getId()%></td>
          <td align="center"><%=penRetard[i].getIdPenalite()%></td>
          <td align="center"><%=Utilitaire.formatterDaty(penRetard[i].getDatyInf())%></td>
          <td align="center"><%=Utilitaire.formatterDaty(penRetard[i].getDatySup())%></td>
          <td align="center"><%=Utilitaire.formaterAr((double)penRetard[i].getReste())%></td>
          <td align="center"><%=penRetard[i].getNbJourRetard()%></td>
          <td align="center"><%=penRetard[i].getNumPiece()%></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr((double)penRetard[i].getMontant())%></div></td>
       </tr>
          <%
          }
          %>
         </table>
	</td>
	</tr>
	</table>
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td height="30" align="center"><div align="right">&nbsp;Montant = <%=Utilitaire.formaterAr((double)pen.getMontant())%> Ar </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr>
          <td height="30" align="center"><div align="justify">Tout retard de paiement,
              partiel ou total, de la redevance emportera le paiement d&#8217;int&eacute;r&ecirc;ts
              de retards &eacute;gal au taux directeur mensuel de la Banque Centrale
              Europ&eacute;enne en vigueur durant la p&eacute;riode de retard
              de paiement, major&eacute; de <%=utilitaire.ChiffreLettre.convertIntToString((long)pen.getChamp3())%> (<%=pen.getChamp3()%>) %, quelle que soit la cause
              du retard, sans qu&#8217;il soit besoin d&#8217;une mise en demeure,
              ce jusqu&#8217;&agrave; complet paiement des redevances dues et
              des int&eacute;r&ecirc;ts courus et &eacute;chus sur le montant
              de ces redevances dues. <br>
              <br>
              En cas de complet paiement en cours de mois, les int&eacute;r&ecirc;ts
              de retard seront calcul&eacute;s prorata temporis.<br>
              <br>
              Les int&eacute;r&ecirc;ts courus et &eacute;chus au cours d&#8217;une
              p&eacute;riode de <%=utilitaire.ChiffreLettre.convertIntToString((long)paraPen.getDelaiPaiementPenalite())%> (<%=paraPen.getDelaiPaiementPenalite()%>) mois seront automatiquement capitalis&eacute;s
              et porteront &agrave; leur tour int&eacute;r&ecirc;t jusqu&#8217;&agrave;
              parfait et complet paiement.</div></td>
        </tr>
      </table></td>
  </tr>
</table>
            <%
if(a.compareTo("yes")!=0){
%>
            <div align="center"><br>
  <br>
  <!--<a href="penalites/detailPenRetard.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes" target="_blank">Voir
  aperçu</a>-->
   <a href='javascript:Popup("penalites/detailPenRetard.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a></div>
<%
}
%>
<!--
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td width="33%" height="15" align="center"><strong>D. inf :</strong></td>
          <td width="40%" align="center">Date inf</td>
          <td width="27%" rowspan="4" align="center">&nbsp;</td>
        </tr>
        <tr>
          <td height="15" align="center"><strong>D. sup :</strong></td>
          <td align="center">Date sup</td>
        </tr>
        <tr>
          <td height="15" align="center"><strong>R.A.P. :</strong></td>
          <td align="center">Reste &agrave; payer</td>
        </tr>
        <tr>
          <td height="15" align="center"><strong>N. j.d.r. :</strong></td>
          <td align="center">Nombre de jour de retard</td>
        </tr>
      </table></td>
  </tr>
</table>
-->