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
liste[0]=new Liste("nom",ve,"nom");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>
<h1>Saisir Recette Province</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisirecetteprov" id="saisirecetteprov">


<%
out.println(pi.getFormu().getHtmlInsert());
%>

<input type="reset" name="Submit2" value="Annuler" class="submit">
<input type="submit" name="Submit2" value="valider" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/saisirecetteprov.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.RecetteLibelle">
</form>
