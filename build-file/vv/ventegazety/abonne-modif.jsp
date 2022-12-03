<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
AbonneComplet atcl=new AbonneComplet();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[2];

TypeObjet to=new TypeObjet();
to.setNomTable("civilite");
liste[0]=new Liste("idcivilite",to, "val", "id");

TypeObjet to=new TypeObjet();
to.setNomTable("quartier");
liste[1]=new Liste("idquartier",to, "val", "id");

pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("dateembauche").setLibelle("Date");
pi.getFormu().getChamp("datenaissance").setLibelle("Date de naissance");
pi.getFormu().getChamp("idcivilite").setLibelle("Civilit&eacute;");
pi.getFormu().getChamp("cin").setLibelle("CIN");
pi.getFormu().getChamp("telephone").setLibelle("T&eacute;l&eacute;phone");
pi.getFormu().getChamp("adresse").setLibelle("Adresse");
pi.getFormu().getChamp("idquartier").setLibelle("Quartier");

pi.getFormu().getChamp("etat").setVisible(false);
pi.getFormu().getChamp("datesortie").setVisible(false);
pi.getFormu().getChamp("nummatricule").setVisible(false);
pi.getFormu().getChamp("taux").setVisible(false);
pi.getFormu().getChamp("type").setVisible(false);
pi.getFormu().getChamp("iplace").setVisible(false);

pi.preparerDataFormu();
%>

<h1>Modification Abonn&eacute;</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="ventegazety/abonne-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.AbonneComplet">
</form>
