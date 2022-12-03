<%@ page import="affichage.*" %>
<%@ page import="user.*" %>
<%@ page import="prevision.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>

<%
PrevisionDepense p = new PrevisionDepense();
p.setNomTable("previsiondepensetous");
String id = request.getParameter("id");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));
String lien = (String)session.getValue("lien");
PrevisionDepense[] previsionDepense = (PrevisionDepense[])CGenUtil.rechercher(p,null,null," and upper(id) = upper('"+id+"')");
%>
<html>
<h1>Detail prevision</h1>
<%
out.println(pc.getHtml());
%>

<a href="<%=lien+"?but=ded/ordonnerPayementAvecPrev.jsp&idprev="+id+"&montant="+previsionDepense[0].getMontant()+"&designation="+previsionDepense[0].getRemarque()%>">Creer OP </a>
<a href="<%=lien+"?but=prevision/modifierPrevisionDepense.jsp&daty="+previsionDepense[0].getDaty()+"&idprev="+id+"&montant="+previsionDepense[0].getMontant()+"&remarque="+previsionDepense[0].getRemarque()%>">modifier</a>
</html>