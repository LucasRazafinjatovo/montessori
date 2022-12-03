<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
RecetteLibelle rec=new RecetteLibelle();
rec.setNomTable("recettelibelle");
//String listeInt[]={""};
PageInsert pi=new PageInsert(rec,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
ve.setNomTable("vendeur");
liste[0]=new Liste("nom",ve,"surnom");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("place").setVisible(false);
pi.getFormu().getChamp("province").setVisible(false);
pi.getFormu().getChamp("daty").setValeur(request.getParameter("daty"));
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("journal").setDefaut(request.getParameter("journal"));
pi.getFormu().getChamp("numparution").setDefaut(request.getParameter("numparution"));
pi.preparerDataFormu();
%>
<h1>Saisir Recette</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisirecette" id="saisirecette">


<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/saisirecette.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.RecetteLibelle">
<input name="rajoutLien" type="hidden" id="classe" value="journal-numparution-daty">
</form>
