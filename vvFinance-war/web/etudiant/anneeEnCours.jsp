<%--
    Document   : rubrique-prix-entite-saisie
    Created on : 22 mai 2018, 09:37:45
    Author     : pro
--%>

<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%
    
    AnneeEnCours anneeEnCours = new AnneeEnCours();
    PageUpdate pu = new PageUpdate(anneeEnCours, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));


    affichage.Champ[] liste = new affichage.Champ[1];
    etudiant.AnneeScolaire anneeScolaire=new AnneeScolaire();
    liste[0] = new Liste("nom", anneeScolaire, "nom", "nom");
    pu.getFormu().changerEnChamp(liste);

    pu.getFormu().getChamp("nom").setLibelle("Annee scolaire");
    pu.getFormu().getChamp("id").setAutre("readonly='readonly'");
    
    pu.preparerDataFormu();
%>

<h1>Modifier ann&eacute;e scolaire en cours</h1>
<form action="<%=pu.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="anneeEnCours" id="anneeEnCours">
    <%
        pu.getFormu().makeHtmlInsertTabIndex();
        out.println(pu.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="update">
    <input name="bute" type="hidden" id="bute" value="etudiant/anneeEnCours.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.AnneeEnCours">
</form>
