<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
AbonneComplet p;
AbonneComplet base;
try{
p=new AbonneComplet();
p.setNomTable("abonne_vue");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
base = (AbonneComplet)pc.getBase();
%>
<html>
<h1>Consultation Abonn&eacute;</h1>
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
<% if (base.getEtat()== 0){%>
<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/apresVendeur.jsp&acte=modifEtatAbonne&id="+request.getParameter("id")%>">Activer</a>
<% 
	} 
	else{
%>
<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/apresVendeur.jsp&acte=modifEtatAbonne&id="+request.getParameter("id")%>">D&eacute;sactiver</a>
<% } %>
<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/abonne-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
</html>