
<%@page import="commercial.PersRespSociete"%>
<%@page import="user.*"%>
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    PersRespSociete a = new PersRespSociete();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("dateapplication").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("dateapplication").setLibelle("Date d'application");
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("societe").setLibelle("Societe");
    pi.getFormu().getChamp("societe").setPageAppel("listeSocieteChoix.jsp");
    pi.getFormu().getChamp("contact").setLibelle("Contact");
    pi.getFormu().getChamp("observation").setLibelle("Observation");
    pi.getFormu().getChamp("observation").setType("textarea");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie responsable société</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="societee" id="societee">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="commercial/saisie-pers-ste.jsp">
        <input name="classe" type="hidden" id="classe" value="commercial.PersRespSociete">
    </form>
</div>