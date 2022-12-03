<%-- 
    Document   : pubType-liste
    Created on : 9 mai 2017, 09:27:36
    Author     : Doudou Tiarilala
--%>

<%@page import="pub.PubType"%>
<%@page import="affichage.PageRecherche"%>
<%  PubType lv = new PubType();
    //lv.setNomTable("CONT_ORDRE_MISSION_LIBELLE");
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        lv.setNomTable(request.getParameter("etat"));

    }
    String listeCrt[] = {"id", "DESIGNATION", "TYPE", "DUREES"};
    String listeInt[] = {};
    String libEntete[] = {"id", "DESIGNATION", "TYPE", "DUREES"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    
    pr.getFormu().getChamp("DUREES").setLibelle("DUREES(HH:MM:SS)"); 

    
    pr.setApres("pub/pubType-liste.jsp");
    String[] colSomme = {"duree"};
    pr.creerObjetPage(libEntete, colSomme);%>


<h1>Liste Type de pub</h1>


<form action="<%=pr.getLien()%>?but=pub/pubType-liste.jsp" method="post" name="incident" id="incident">
    <%

        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%  String lienTableau[] = {pr.getLien() + "?but=pub/pubType-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    String libEnteteAffiche[] = {"id", "DESIGNATION", "TYPE", "DUREES"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());

%>

