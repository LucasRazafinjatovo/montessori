
<%@page import="commercial.CommRespSociete"%>
<%@page import="user.*"%>
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    CommRespSociete a = new CommRespSociete();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[1];

    TypeObjet op2 = new TypeObjet();
    op2.setNomTable("AGENCE");
    liste[0] = new Liste("idcommercial", op2, "VAL", "id");

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("dateapplication").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("dateapplication").setLibelle("Date d'application");
    pi.getFormu().getChamp("idcommercial").setLibelle("Commercial");
    pi.getFormu().getChamp("idsociete").setLibelle("Societe");
    pi.getFormu().getChamp("idsociete").setPageAppel("listeSocieteChoix.jsp");
    pi.getFormu().getChamp("observation").setLibelle("Observation");
    pi.getFormu().getChamp("observation").setType("textarea");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Commercial responsable société</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="societee" id="societee">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="commercial/comm-resp-ste.jsp">
        <input name="classe" type="hidden" id="classe" value="commercial.CommRespSociete">
    </form>
</div>