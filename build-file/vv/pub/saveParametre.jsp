<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
ParametreBase p=new ParametreBase();
p.setNomTable("parametrepaier");
PageInsert pc=new PageInsert(p,request,(user.UserEJB)session.getValue("u"));
pc.preparerDataFormu();
%>
<SCRIPT language="JavaScript" src="script.js">
</script>


<h1>Enregistrer nouveau parametre</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="publication" id="publication">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
	<input type="submit" name="Submit2" value="valider" class="submit">
	<input type="reset" name="Submit2" value="Annuler" class="submit">
	<input name="acte" type="hidden" id="nature" value="insert">
	<input name="bute" type="hidden" id="bute" value="pub/saveParametre.jsp">
	<input name="classe" type="hidden" id="classe" value="pub.ParametreBase">
</form>
