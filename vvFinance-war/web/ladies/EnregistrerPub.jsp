<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="facture.*" %>
<%@ page import="ladies.*" %>
<%@ page import="ventegazety.*" %>
<%
Publicity pj=new Publicity();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("montant").setVisible(false);
pi.getFormu().getChamp("datycreation").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("idClient").setPageAppel("ded/choix_tiers.jsp");
pi.getFormu().getChamp("format").setPageAppel("listeTarifPubChoix.jsp");
pi.getFormu().getChamp("designation").setType("textarea");
pi.getFormu().getChamp("remarque").setType("textarea");

affichage.Champ[] liste=new affichage.Champ[2];

TypeObjet crt = new TypeObjet();
crt.setNomTable("categoriePub");
liste[0] = new Liste("idCat",crt,"val","id");

TypeObjet agence = new TypeObjet();
agence.setNomTable("agence");
liste[1] = new Liste("idAgence",agence,"val","id");

pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();

%>

<h1>Enregistrer pub</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ladies/EnregistrerPub.jsp">
 <input name="classe" type="hidden" id="classe" value="ladies.Publicity">
</form>
