<%--
    Document   : rubrique-prix-entite-saisie
    Created on : 22 mai 2018, 09:37:45
    Author     : pro
--%>

<%@page import="etudiant.EntiteBeneficiaire"%>
<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
    RubriquePrixEntite rubriquePrixEntite = new RubriquePrixEntite();
    PageInsert pi = new PageInsert(rubriquePrixEntite, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("libelle").setLibelle("Libell&eacute; *");
    pi.getFormu().getChamp("montant").setLibelle("Montant *");
    pi.getFormu().getChamp("daty").setLibelle("Date");

    affichage.Champ[] liste = new affichage.Champ[2];
    String idSociete = "SOC00003";
    EntiteBeneficiaire entite = new EntiteBeneficiaire();
    entite.setIdSociete(idSociete);
    liste[0] = new Liste("entite", entite, "val", "id");
    TypeObjet libelle = new TypeObjet();
    libelle.setNomTable("typerubrique");
    liste[1] = new Liste("libelle", libelle, "val", "val");
    pi.getFormu().getChamp("entite").setLibelle("Entit&eacute;");
    pi.getFormu().changerEnChamp(liste);
    

    pi.preparerDataFormu();
%>

<h1>Saisir configuration</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="rubriqueprix" id="rubriqueprix">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="rubrique/rubrique-prix-entite-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="recette.RubriquePrixEntite">
</form>
