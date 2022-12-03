<%-- 
    Document   : saisie-commercial.jsp
    Created on : 21 juin 2017, 10:20:59
    Author     : Alain
--%>
<%@page import="commercial.Commercial"%>
<%@page import="user.*"%>
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*" %>
<%@page import="utilitaire.*" %>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Commercial a = new Commercial();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[1];

    String[] affiche = {"Commercial","Freelance"};
    String[] value = {"comm","freelance"};
    Liste lst = new Liste();
    lst.ajouterValeur(value, affiche);
    liste[0] = lst;
    liste[0].setNom("type"); 

    pi.getFormu().changerEnChamp(liste);

    pi.getFormu().getChamp("desce").setType("textarea");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Enregistrer commercial</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="societee" id="societee">
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="commercial/saisie-commercial.jsp">
        <input name="classe" type="hidden" id="classe" value="commercial.Commercial">
    </form>
</div>