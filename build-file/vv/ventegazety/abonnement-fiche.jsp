<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
AbonnementVue p;
AbonnementVue base;
try{
p=new AbonnementVue();
p.setNomTable("abonnement_vue");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
pc.setUtilisateur((user.UserEJB)session.getValue("u"));
base = (AbonnementVue)pc.getBase();
%>
<html>
<h1>Consultation Abonnement</h1>
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
	else if (base.getEtat()== 11){
%>
<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/apresVendeur.jsp&acte=modifEtatAbonne&id="+request.getParameter("id")%>">D&eacute;sactiver</a>
<% }else{
%>
<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/apresVendeur.jsp&acte=validerAbonnement&id="+base.getObservation()%>">Valider</a>
<% } %>
<a href="<%=(String)session.getValue("lien")+"?but=ventegazety/abonnement-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
</html>