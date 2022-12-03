<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="indicateur.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
MoisProduction p;
try{
p=new MoisProduction();
p.setNomTable("MOISPRODUCTION_LIBELLE");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation Mois de production</h1>
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
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=indicateur/moisproduction-liste.jsp&classe=indicateur.MoisProduction">Supprimer</a>
<a href="<%=(String)session.getValue("lien")+"?but=indicateur/moisproduction-modif.jsp&id="+request.getParameter("id")%>">Modifier</a>
</html>