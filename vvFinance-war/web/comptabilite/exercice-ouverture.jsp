<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>

<%
Exercice pj=new Exercice();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[1];

Societe societe = new Societe();
societe.setNomTable("Societe");
liste[0]=new Liste("idsociete",societe, "nom", "id");
pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("idsociete").setLibelle("Soci&eacute;t&eacute;");
pi.getFormu().getChamp("datedebut").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("datedebut").setLibelle("Date d'ouverture");
pi.getFormu().getChamp("datefin").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("datefin").setLibelle("Date de cloture");
pi.getFormu().getChamp("etat").setVisible(false);
pi.preparerDataFormu();
%>

<h1>Ouverture d'exercice</h1>
<form action="<%=pi.getLien()%>?but=comptabilite/apresCompta.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="ouvrirExercice">
 <input name="bute" type="hidden" id="bute" value="comptabilite/exercice-ouverture.jsp">
 <input name="classe" type="hidden" id="classe" value="comptabilite.Exercice">
</form>
