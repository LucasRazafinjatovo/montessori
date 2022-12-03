<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="finance.Caisse" %>
<%


    
    ReportLib r = new ReportLib();
    String listeCrt[] = {"id", "idcaisse","daty","idecole"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","montant","daty","caisse","ecole"};

    PageRecherche pr = new PageRecherche(r, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("etudiant/liste-report.jsp");
    affichage.Champ[] liste=new affichage.Champ[2];
    Caisse caisse = new Caisse();
    liste[0] = new Liste("idcaisse", caisse, "desccaisse", "idcaisse");
    Ecole ecole=new Ecole();
    ecole.setNomTable("ecole");
    liste[1] = new Liste("idecole", ecole, "nom", "id");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("idcaisse").setLibelle("Caisse");
     pr.getFormu().getChamp("idecole").setLibelle("Ecole");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeniveau.submit();
    }

</script>
<h1>Liste report de caisse</h1>
<form action="<%=pr.getLien()%>?but=etudiant/liste-report.jsp" method="post" name="listeniveau" id="listeniveau">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());
    %>

</form>
<%
 
    String libEnteteAffiche[] = {"ID","MONTANT","DATE","CAISSE","ECOLE"};;
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    out.println(pr.getTableauRecap().getHtml());
%>

<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
