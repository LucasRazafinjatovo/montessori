<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
AbonneComplet pj=new AbonneComplet();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[3];

TypeObjet to1=new TypeObjet();
to1.setNomTable("civilite");
liste[0]=new Liste("idcivilite",to1, "val", "id");

TypeObjet to=new TypeObjet();
to.setNomTable("quartier");
liste[1]=new Liste("idquartier",to, "val", "id");

TypeObjet to2=new TypeObjet();
to2.setNomTable("secteur");
liste[2]=new Liste("idsecteur",to2, "val", "id");

pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("datenaissance").setLibelle("Date de naissance");
pi.getFormu().getChamp("idcivilite").setLibelle("Civilit&eacute;");
pi.getFormu().getChamp("cin").setLibelle("CIN");
pi.getFormu().getChamp("etat").setVisible(false);
pi.getFormu().getChamp("telephone").setLibelle("T&eacute;l&eacute;phone");
pi.getFormu().getChamp("adresse").setLibelle("Adresse");
pi.getFormu().getChamp("idquartier").setLibelle("Quartier");
pi.getFormu().getChamp("idsecteur").setLibelle("Secteur");

pi.preparerDataFormu();
%>

<h1>Saisie Abonn&eacute;</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/abonne-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.AbonneComplet">
</form>
