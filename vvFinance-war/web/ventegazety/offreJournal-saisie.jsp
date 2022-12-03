<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
String id=request.getParameter("id");
OffreJournal pj=new OffreJournal();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("idoffre").setLibelleAffiche("Offre");
pi.getFormu().getChamp("idoffre").setDefaut(id);
pi.getFormu().getChamp("idoffre").setAutre("readonly");
pi.getFormu().getChamp("idoffre").setPageAppel("ventegazety/offreChoix.jsp");
pi.getFormu().getChamp("idjournal").setLibelleAffiche("Journal");
pi.getFormu().getChamp("idjournal").setPageAppel("ventegazety/journalChoix.jsp");
pi.preparerDataFormu();
%>

<h1>Saisie offre journal</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/offreJournal-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.OffreJournal">
</form>
