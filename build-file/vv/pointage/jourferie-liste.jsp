<%-- 
    Document   : jourferie-liste
    Created on : 11 déc. 2015, 10:03:25
    Author     : Jetta
--%>

<%@page import="pointage.PointJourferie"%> 
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRecherche"%>

<% PointJourferie lv = new PointJourferie();
    //lv.setNomTable("POINT_POINTAGE_LIBELLE");
    String listeCrt[] = {"id", "daty","designation"};
    String listeInt[] = {"daty"};
    String libEntete[] =  {"id", "daty","designation"};

    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("daty1").setLibelle("Date  min");
    pr.getFormu().getChamp("daty2").setLibelle("Date  max");
    //pr.setAWhere("order by daty asc");
    pr.setApres("pointage/jourferie-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
 
        <h1>Liste des jours feriés</h1>
    
        <form action="<%=pr.getLien()%>?but=pointage/jourferie-liste.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=pointage/jourferie-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "daty","designation"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
     
