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
<h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es aux p&eacute;nalit&eacute;s
  de retard de paiement</h1>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
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
                <td align="center"><%=pen.getMontant()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Type :</td>
                <td align="center"><%=sctserv.getNomSCatService()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;</td>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;</td>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;</td>
                <td align="center">&nbsp;</td>
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
          <td height="30"><div align="center">&nbsp; Montant =<%=pen.getMontant()%></div></td>
        </tr>
      </table></td>
  </tr>
</table>
            <%
if(a.compareTo("yes")!=0){
%>

<div align="center"><br>
  <br>
  <a href="penalites/detailPenPenalite.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes" target="_blank">Voir
  aperçu</a></div>
  <%
}
  %>
