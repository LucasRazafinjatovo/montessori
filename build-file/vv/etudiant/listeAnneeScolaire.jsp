<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%


    
    AnneeScolaire e = new AnneeScolaire();
    String listeCrt[] = {"id", "nom"};
    String listeInt[] = {""};
    String libEntete[] = {"id", "nom"};

    PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/listeAnneeScolaire.jsp");

  
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
   
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeetudiant.submit();
    }

</script>
<h1>Liste Ann&eacute;e scolaire</h1>
<form action="<%=pr.getLien()%>?but=etudiant/listeAnneeScolaire.jsp" method="post" name="listeAnneeScolaire" id="listeAnneeScolaire">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%
    String lienTableau[]={pr.getLien()+"?but=etudiant/fiche-anneescolaire.jsp"};
    String colonneLien[]={"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());
    %>

<br>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
