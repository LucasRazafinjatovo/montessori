<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
    Parution p = new Parution();
    String etat = "Parutionlibelle";
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        etat = request.getParameter("etat");
    }
    p.setNomTable(etat);
    String listeCrt[] = {"id", "journal", "numParution"};
    String listeInt[] = {"numParution"};
    PageRecherche pr = new PageRecherche(p, request, listeCrt, listeInt, 2);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("pub/listeParution.jsp");
    String libEntete[] = {"id", "journal", "datyParution", "numParution"};
//String colSomme[]={"montantVal"};
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<h1>Liste des parutions</h1>
<form action="<%=pr.getLien()%>?but=pub/listeParution.jsp" method="post" name="listeParution" id="listeParution">
    <%
    out.println(pr.getFormu().getHtmlEnsemble());%>
    etat : <select name="etat" class="champ" id="etat" >
        <option value="Parutionlibelle">Tous</option>
        <option value="ParutionlibellePublie"  <%if (etat.compareTo("ParutionlibellePublie") == 0) {
        out.println("selected");}%>> publie</option>
    </select>
</form>
<%
    String lienTableau[] = {pr.getLien() + "?but=pub/ficheParution.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
