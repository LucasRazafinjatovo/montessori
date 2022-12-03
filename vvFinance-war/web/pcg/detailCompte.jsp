<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresAnnulerFacture.jsp";
        String lien= null;
        UserEJB u = null;
        Entree e = null;
        String idEntree = null;
        facture.Client clt = null;
        TypeObjet te = null;
        TypeObjet mod = null;
        Caisse caiss = null;
%>
<%
idEntree = request.getParameter("idEntree");
%>
<%
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
e = u.findEntree(idEntree, "","", "%", "%", "%", "%", "%", "%", "%")[0];
caiss = u.findCaisse(e.getIdCaisse(),"%","%","%")[0];
//clt = u.findClient(e.getClient(), "%", "%", "%", "%", "%", "%", "%", "%", "%", "%")[0];
te = u.findTypeObjet("TypeEntree",e.getIdTypeEntree(),"%")[0];
//System.out.println("typeEntree "+te.getDesce());
mod = u.findTypeObjet("ModePaiement",e.getIdModePaiement(),"%")[0];
%>
<link href="../Asa/EJB/gestion%20croise%20dyn/gestion%20vv/affichage/finance/style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tails compte</h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
   <tr>
  <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr> 
          <td width="179" class="left">Classe: </td>
          <td width="259"><%=caiss.getDescCaisse()%> </td>
        </tr>
        <tr> 
          <td class="left">Compte: </td>
          <td><%=mod.getVal()%> </td>
        </tr>
        <tr> 
          <td class="left">Libell&eacute; du compte : </td>
          <td> <%=e.getRemarque()%></td>
        </tr>
      </table>
</td>
  </tr>

  </table>
  <br>
  <br>

