<%@page import="pub.PubTarif"%>
<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%!
PubTarif p;
%>
<%
try{
p=new PubTarif();
p.setNomTable("PUB_TARIF_LIBELLE");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
String[] libelleAffichage = {"Id","Type","Durees","Plage Horaire", "Duree", "Montant","Date Effective"};
pc.setLibAffichage(libelleAffichage);
%>
<html>
<h1>Consultation Tarif</h1>
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
<a href="<%=(String)session.getValue("lien")+"?but=pub/pubTarif-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=pub/pubTarif-liste.jsp&classe=pub.PubTarif">Supprimer</a>
</html>
