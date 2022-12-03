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
<%@ page import="finance.Caisse" %>
<%
    
    Report report = new Report();
    PageInsert pi = new PageInsert(report, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste=new affichage.Champ[2];
    Caisse caisse = new Caisse();
    liste[0] = new Liste("idcaisse", caisse, "desccaisse", "idcaisse");
     Ecole ecole=new Ecole();
    ecole.setNomTable("ecole");
    liste[1] = new Liste("idecole", ecole, "nom", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idecole").setLibelle("Ecole");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("idcaisse").setLibelle("Caisse");

    pi.preparerDataFormu();
%>

<h1>Saisir report de caisse</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="report" id="report">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/liste-report.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.Report">
</form>
