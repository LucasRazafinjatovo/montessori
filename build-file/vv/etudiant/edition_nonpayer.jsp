<%-- 
    Document   : edition_nonpayer.jsp
    Created on : 25 mai 2018, 15:53:44
    Author     : Christophe Lai
--%>

<%@page import="etudiant.Edition"%>
<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>

<%
try{
    Edition edition = new Edition();
    edition.setNomTable("edition_nonpayer");
    String[] listeCrt   = {};
    String   listeInt[] ={};
    String   idEtudiant = request.getParameter("idetudiant");
    if(idEtudiant != null){
        listeCrt = new String[]{"idetudiant"};
        edition.setIdetudiant(idEtudiant);
        //out.println(idEtudiant);
    }
    PageRecherche pr=new PageRecherche(edition,request,listeCrt,listeInt,2);
    pr.setUtilisateur((user.UserEJB)session.getValue("u"));
    pr.setLien((String)session.getValue("lien"));
    pr.setApres("etudiant/edition_nonpayer.jsp");
   
    //pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
//    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date debut");
//    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
//    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date fin");
    String libEntete[]={"id","mois","annee","idetudiant","ecolagedu","ecolagepaye","fooddu","foodpaye","transportdu","transportpaye","inscriptiondu","inscriptionpaye","autredu","autrepaye","remarque"};
    String[]colSomme=null;
    pr.creerObjetPage(libEntete,colSomme);
    %>
    <h1>Liste des editions non payées</h1>
    <form action="<%=pr.getLien()%>?but=etudiant/edition_nonpayer.jsp" method="post" name="listerubrique" id="listerubrique">
    <%
    out.println(pr.getFormu().getHtmlEnsemble());%>
    </form>
    <%
    String lienTableau[]={pr.getLien()+"?but=etudiant/edition_nonpayer.jsp"};
    String colonneLien[]={"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    out.println(pr.getTableauRecap().getHtml());%>
    <br>
    <%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
}
catch(Exception e){
    e.printStackTrace();
    %>
     <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
    <%
    return;
}
%>

