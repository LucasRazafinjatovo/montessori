<%@ page import="user.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%!
FactureFournisseurPrevision p;
%>
<%
try{
p=new FactureFournisseurPrevision();
p.setNomTable("facturefournisseurprevision");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation Prevision facture fournisseur</h1>
<%
out.println(pc.getHtml());
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}

%>

<a href="<%=(String)session.getValue("lien")+"?but=facturefournisseur/modifFFPrevision.jsp&id="+request.getParameter("id")%>">Modifier</a>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=facturefournisseur/listeFactureFournisseurPrevision.jsp&classe=facturefournisseur.FactureFournisseurPrevision" onclick="return(confirm('Etes-vous sûr de vouloir supprimer?'));">Supprimer</a>
</html>
