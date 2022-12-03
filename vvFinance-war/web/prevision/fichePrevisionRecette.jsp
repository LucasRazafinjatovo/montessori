<%@ page import="affichage.*" %>
<%@ page import="user.*" %>
<%@ page import="prevision.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>

<%
PrevisionRecette p = new PrevisionRecette();
p.setNomTable("previsionrecettetous");
String id = request.getParameter("id");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));
String lien = (String)session.getValue("lien");
PrevisionRecette[] previsionRecette = (PrevisionRecette[])CGenUtil.rechercher(p,null,null," and upper(id) = upper('"+id+"')");

%>
<html>
<h1>Detail prevision</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=lien+"?but=ded/ordonnerRecetteAvecPrev.jsp&daty="+previsionRecette[0].getDaty()+"&idprev="+id+"&montant="+previsionRecette[0].getMontant()+"&designation="+previsionRecette[0].getRemarque()%>">Creer OR </a>
<a href="<%=lien+"?but=prevision/modifierPrevisionRecette.jsp&daty="+previsionRecette[0].getDaty()+"&idprev="+id+"&montant="+previsionRecette[0].getMontant()+"&remarque="+previsionRecette[0].getRemarque()%>">modifier</a>
</html>