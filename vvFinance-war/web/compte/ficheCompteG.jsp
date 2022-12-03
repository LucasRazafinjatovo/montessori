<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="compte.*" %>
<%!
CompteG p;
%>
<%
try{
p=new CompteG();
p.setNomTable("compteg");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
%>
<html>
<h1>Consultation Compte general</h1>
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
<a href="<%=(String)session.getValue("lien")+"?but=compte/modifCompteG.jsp&id="+request.getParameter("id")%>">Modifier</a>

</html>
