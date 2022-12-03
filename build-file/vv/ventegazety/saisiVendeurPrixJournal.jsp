<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>

<%
Prixjournalvendeur inv=new Prixjournalvendeur();
PageInsert pi=new PageInsert(inv,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ven=new Vendeur();
ven.setNomTable("vendeur");
liste[0]=new Liste("vendeur",ven,"surnom");

pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>
<h1>Saisir Prix de vente par journal par vendeur</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipjv" id="saisipjv">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/saisiprise.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.Prixjournalvendeur">
</form>
