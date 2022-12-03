<%--
    Document   : rubrique-prix-entite-saisie
    Created on : 22 mai 2018, 09:37:45
    Author     : pro
--%>

<%@page import="javax.validation.ValidationException"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%
    String[] etudiants = request.getParameterValues("id");
 
   String etudiant = Utilitaire.tabToString(etudiants, "", ";");
    FactureMere factureMere = new FactureMere();
    PageInsert pi = new PageInsert(factureMere, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste=new affichage.Champ[1];
     String mois[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[0] = new Liste("mois", mois, moisvalue);

    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("mois").setLibelle("Mois");
    pi.getFormu().getChamp("annee").setLibelle("Année");
      pi.getFormu().getChamp("annee").setLibelle("Annee");
    pi.getFormu().getChamp("idetudiant").setDefaut(etudiant);
    pi.getFormu().getChamp("idetudiant").setAutre(" readOnly=true ");
    pi.preparerDataFormu();
%>
<h1>Generer facture</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="facturemere" id="facturemere" >
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/generer-facture.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.FactureMere">
</form>

