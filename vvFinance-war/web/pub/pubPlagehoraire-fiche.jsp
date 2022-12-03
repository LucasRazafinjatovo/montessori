<%@page import="pub.PubPlageHoraire"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%!
PubPlageHoraire p;
%>
<%
try{
p=new PubPlageHoraire();
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
String[] libelleAffichage = {"id","designation", "numero","heure debut", "heure fin"};
pc.setLibAffichage(libelleAffichage);
%>
<html>
<h1>Consultation Plage horaire</h1>
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
<a href="<%=(String)session.getValue("lien")+"?but=pub/pubPlagehoraire-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=pub/pubPlagehoraire-liste.jsp&classe=pub.PubPlageHoraire">Supprimer</a>
</html>
