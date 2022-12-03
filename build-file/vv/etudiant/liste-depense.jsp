<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%


    
    Depense depense = new Depense();
    String listeCrt[] = {"id", "daty", "idtypedepense","idecole"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "idtypedepense","designation","daty", "montant","beneficiaire"};

    PageRecherche pr = new PageRecherche(depense, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/liste-depense.jsp");
    affichage.Champ[] liste = new affichage.Champ[2];
    TypeDepense typeDepense=new TypeDepense();
    liste[0] = new Liste("idtypedepense", typeDepense, "val", "id");
    Ecole ecole = new Ecole();
    liste[1] = new Liste("idecole", ecole, "nom", "id");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("idecole").setLibelle("Ecole");
    pr.getFormu().getChamp("idtypedepense").setLibelle("Type de d&eacute;pense");
    pr.getFormu().changerEnChamp(liste);
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listedepense.submit();
    }

</script>
<h1>Liste  D&eacute;pense</h1>
<form action="<%=pr.getLien()%>?but=etudiant/liste-depense.jsp" method="post" name="listedepense" id="listedepense">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%
    out.println(pr.getTableauRecap().getHtml());
%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
