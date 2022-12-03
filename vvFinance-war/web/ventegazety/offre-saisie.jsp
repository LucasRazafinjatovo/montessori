<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Offre pj=new Offre();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("dateeffectivite").setLibelleAffiche("Date effectivite");
pi.getFormu().getChamp("dateeffectivite").setDefaut(Utilitaire.dateDuJour());
pi.preparerDataFormu();
%>

<h1>Saisie Offre;</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="rajoutLien" type="hidden" id="rajoutLien" value="id">
 <input name="bute" type="hidden" id="bute" value="ventegazety/offreJournal-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.Offre">
</form>
