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
<link href="style.css" rel="stylesheet" type="text/css">
<h1>D&eacute;tails recette</h1>
<table cellpadding="0" cellspacing="0" border="0" align="center" width="450">
   <tr>
  <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
          <td width="179" class="left">Num :</td>
          <td width="259"><%=e.getIdEntree()%></td>
        </tr>
        <tr>
          <td width="179" class="left">Date :</td>
          <td width="259"><%=Utilitaire.formatterDaty(e.getDaty())%></td>
        </tr>
        <tr>
          <td class="left">D&eacute;signation : </td>
          <td><%=e.getDesignation()%></td>
        </tr>
        <tr>
          <td class="left">Client : </td>
          <td> <%=e.getClient()%></td>
        </tr>
        <tr>
          <td class="left">Type : </td>
          <td><%=te.getVal()%></td>
        </tr>
        <tr>
          <td class="left">Num&eacute;ro pi&egrave;ce : </td>
          <td><%=e.getNumpiece()%> </td>
        </tr>
        <tr>
          <td class="left">Montant : </td>
          <td><%=Utilitaire.formaterAr((double)e.getMontant())%> </td>
        </tr>
        <tr>
          <td class="left">Caisse : </td>
          <td><%=caiss.getDescCaisse()%> </td>
        </tr>
        <tr>
          <td class="left">Mode de paiement : </td>
          <td><%=mod.getVal()%> </td>
        </tr>
        <tr>
          <td class="left">Etat : </td>
          <td> <%=e.findEtat().getDesce()%></td>
        </tr>
        <tr>
          <td class="left">Agence : </td>
          <td><%=e.getAgence()%> </td>
        </tr>
        <tr>
          <td class="left">Parution : </td>
          <td> <%=e.getParution()%></td>
        </tr>
        <tr>
          <td class="left">Remarque : </td>
          <td> <%=e.getRemarque()%></td>
        </tr>
        <tr>
          <td class="left"></td>
          <td> <a href="finance/recuEntree.jsp?idEntree=<%=e.getTuppleID()%>">Voir
            apercu</a></td>
        </tr>
        <%if(u.getUser().getIdrole().compareToIgnoreCase("dg")==0) {%>
        <tr>
          <td class="left"></td>
          <td> <a href="finance/updateEntree.jsp?idEntree=<%=e.getTuppleID()%>">Modifier entree</a></td>
        </tr>
        <%}%>
      </table>
</td>
  </tr>

  </table>
  <br>
  <br>

