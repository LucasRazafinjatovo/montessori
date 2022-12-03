<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%       
PrixVentePrevision pj=new PrixVentePrevision();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[1];

TypeObjet journal = new TypeObjet();
journal.setNomTable("JOURNAL");
liste[0] = new Liste("journal", journal, "DESCE", "id");
    
pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("prix").setLibelle("Prix");
pi.getFormu().getChamp("dateeffectivite").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("dateeffectivite").setLibelle("Date d'effectivi&eacute;");
pi.preparerDataFormu();
%>

<h1>Saisie Prix de vente pr&eacute;visionnel</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipj" id="saisipj">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="indicateur/prixventeprevision-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="indicateur.PrixVentePrevision">
</form>
