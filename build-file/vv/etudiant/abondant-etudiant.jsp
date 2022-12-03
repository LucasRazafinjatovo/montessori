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
    String idetudiant = request.getParameter("idetudiant");
    AbondantEtudiant abondantEtudiant = new AbondantEtudiant();
    PageInsert pi = new PageInsert(abondantEtudiant, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste=new affichage.Champ[1];
     String mois[]  = {"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue[]  = {"1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[0] = new Liste("mois", mois, moisvalue);


    if(request.getParameter("idetudiant") != null)
    {
        pi.getFormu().getChamp("idetudiant").setDefaut(idetudiant);
    }
   
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("mois").setLibelle("Mois depart");
    pi.getFormu().getChamp("annee").setLibelle("Annee depart");
     pi.getFormu().getChamp("motif").setLibelle("Motif");
     pi.getFormu().getChamp("motif").setType("textarea");
    pi.getFormu().getChamp("idetudiant").setLibelle("Etudiant");
    pi.getFormu().getChamp("idetudiant").setPageAppel("etudiant/etudiantEnCours.jsp");
    pi.getFormu().getChamp("idetudiant").setAutre("readonly='readonly'");


    pi.preparerDataFormu();
%>
<script>
function validation(){
   return confirm("Voulez-vous confirmer?");
}
</script>
<h1>Abandont etudiant(e)</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="POST" name="abondantEtudiant" id="abondantEtudiant" onsubmit="validation()">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="etudiant/listeEtudiantAbandonnes.jsp">
    <input name="classe" type="hidden" id="classe" value="etudiant.AbondantEtudiant">
</form>

