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
<%@ page import="finance.*" %>
<%
    
    Depense depense = new Depense();
    PageInsert pi = new PageInsert(depense, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[3];
    TypeDepense typedepense = new TypeDepense();
    liste[0] = new Liste("idtypedepense", typedepense, "val", "id");
    Ecole ecole = new Ecole();
    liste[1] = new Liste("idecole", ecole, "nom", "id");
    Caisse caisse = new Caisse();
    liste[2] = new Liste("idcaisse", caisse, "desccaisse", "idcaisse");
    pi.getFormu().changerEnChamp(liste);

    
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("idtypedepense").setLibelle("Type de d&eacute;pense");
    pi.getFormu().getChamp("idecole").setLibelle("Ecole");
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("idcaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("beneficiaire").setLibelle("Beneficiaire");
    pi.preparerDataFormu();
%>

<h1>Enregistrer d&eacute;pense</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="depense" id="depense">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/liste-depense.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.Depense">
</form>
