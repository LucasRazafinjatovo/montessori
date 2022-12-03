<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="recette.*" %>

<%
String idetudiant = request.getParameter("idetudiant");
    
ConfPrixEtudiant atcl=new ConfPrixEtudiant();
atcl.setEtudiant(idetudiant);
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("id").setAutre("readonly='readonly'");
pi.getFormu().getChamp("remarques").setAutre("textarea");
pi.getFormu().getChamp("etudiant").setPageAppel("etudiant/choixEtudiant.jsp");
pi.getFormu().getChamp("etudiant").setAutre("readonly='readonly'");


pi.preparerDataFormu();
%>

<h1>Configuration prix</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="etudiant/ficheEtudiant.jsp&id="<%=idetudiant%>>
 <input name="classe" type="hidden" id="classe" value="recette.ConfPrixEtudiant">
</form>
