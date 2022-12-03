<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%!
Publicite p;
UserEJB u;
%>
<%
p = new Publicite();
p.setNomTable("publibelle");
u = (user.UserEJB)session.getValue("u");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
p = (Publicite)pc.getBase();
%>
<html>
<h1>Consultation d'une publicite</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp&id=<%=request.getParameter("id")%>&libJournal=<%=request.getParameter("libJournal")%>&numParution=<%=p.getIdParution()%>" method="post" name="fichePub" id="listePub">
	<%
	out.println(pc.getHtml());
	int compt=u.checkCloture(request.getParameter("id"));

	if((u.getUser().getIdrole().compareTo("dg") == 0 || u.getUser().getIdrole().compareTo("controle") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("dev") == 0) && compt == 0){%>

	<a href="<%=(String)session.getValue("lien")+"?but=pub/updatePub.jsp&id="+request.getParameter("id")%>">Modifier</a>
	<%}%>
	<%if(u.getUser().getIdrole().compareTo("dg") == 0){%>
	<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=pub/listePub.jsp&classe=pub.Publicite">suprimmer</a>
	<%}%>
	<input name="acte" type="hidden" id="acte" value="update">

</form>
</html>
