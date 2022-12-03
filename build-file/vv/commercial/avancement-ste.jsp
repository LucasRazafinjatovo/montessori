
<%@page import="commercial.SituationSociete"%>
<%@page import="user.*"%>
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    SituationSociete a = new SituationSociete();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[1];

    TypeObjet op2 = new TypeObjet();
    op2.setNomTable("ETATSOCIETECOMMERCIAL");
    liste[0] = new Liste("etat", op2, "VAL", "id");

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("societe").setLibelle("Societe");
    pi.getFormu().getChamp("societe").setPageAppel("listeSocieteChoix.jsp");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daterdv").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("daterdv").setLibelle("Date de rendez-vous");
    pi.getFormu().getChamp("etat").setLibelle("Situation");
    pi.getFormu().getChamp("observation").setLibelle("Observation");
    pi.getFormu().getChamp("observation").setType("textarea");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie situation société</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="societee" id="societee">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="commercial/avancement-ste.jsp">
        <input name="classe" type="hidden" id="classe" value="commercial.SituationSociete">
    </form>
</div>