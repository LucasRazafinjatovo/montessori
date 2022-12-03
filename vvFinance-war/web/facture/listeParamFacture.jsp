<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresInit.jsp";
        String lien= null;
        UserEJB u = null;
        facture.ParametreFacture pf[] = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
pf = u.findParametreFacture("%","","%","%","","");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 

<h1>Liste des paramètres liés aux factures </h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
  <td>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
  <tr class="head">
          <td width="20%" height="21" align="center">Date d&eacute;but val.</td>
          <td width="25%" align="center">D&eacute;lai paiement</td>
          <td width="25%" align="center">EVP BONUS</td>
          <td width="30%" align="center">R&eacute;duction EVP BONUS</td>
  </tr>
  <%
  for(int i=0;i<pf.length;i++){
  %>
  <tr>
          <td align="center"><%=Utilitaire.formatterDaty(pf[i].getDatedebutvalid())%></td>
    <td align="center"><%=pf[i].getDelaiPaiement()%></td>
          <td align="center"><%=pf[i].getBonusEVP()%></td>
            <td align="center"><%=pf[i].getReductionTrafic()%></td>
  </tr>
  <%
  }
  %>
</table>
</td>
</tr>
</table>