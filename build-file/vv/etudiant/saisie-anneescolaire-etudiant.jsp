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
    String idetudiant = request.getParameter("idetudiant");
    DetailEtudiant detailEtudiant = new DetailEtudiant();
    PageInsert pi = new PageInsert(detailEtudiant, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));


    affichage.Champ[] liste = new affichage.Champ[3];
    etudiant.Niveau niveau = new Niveau();
    liste[0] = new Liste("idNiveau", niveau, "nom", "id");

    etudiant.AnneeScolaire anneeScolaire=new AnneeScolaire();
    liste[1] = new Liste("idAnneeScolaire", anneeScolaire, "nom", "id");
    pi.getFormu().changerEnChamp(liste);

    String mois[]  = { "Tous" ,"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue[]  = {"" , "1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[2] = new Liste("mois", mois, moisvalue);


    if(request.getParameter("idetudiant") != null)
    {
        pi.getFormu().getChamp("etudiant").setDefaut(idetudiant);
    }
    pi.getFormu().getChamp("idNiveau").setLibelle("Niveau");
    pi.getFormu().getChamp("idAnneeScolaire").setLibelle("Anneescolaire");
    pi.getFormu().getChamp("idetudiant").setLibelle("Etudiant");
    pi.getFormu().getChamp("idetudiant").setPageAppel("etudiant/etudiant_tiers.jsp");
    pi.getFormu().getChamp("idetudiant").setAutre("readonly='readonly'");

    pi.preparerDataFormu();
%>

<h1>Inscription ann&eacute;e scolaire d' un(e) etudiant(e)</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="detailEtudiant" id="detailEtudiant">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/listeEtudiant.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.DetailEtudiant">
</form>
