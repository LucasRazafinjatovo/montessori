<%-- 
    Document   : rubrique-prix-entite-liste
    Created on : 22 mai 2018, 09:31:58
    Author     : pro
--%>

<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>

<%
try{
    RubriquePrixEntite rubriquePrixEntite = new RubriquePrixEntite();
    
    rubriquePrixEntite.setNomTable("rubriqueprixentitelib");
    String listeCrt[]={"daty"};
    String listeInt[]={"daty"};
    PageRecherche pr=new PageRecherche(rubriquePrixEntite,request,listeCrt,listeInt,2);
    pr.setUtilisateur((user.UserEJB)session.getValue("u"));
    pr.setLien((String)session.getValue("lien"));
    pr.setApres("rubrique/rubrique-prix-entite-liste.jsp");
   
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date debut");
    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date fin");
    String libEntete[]={"id","libelle","montant","entite","daty"};
    String[]colSomme=null;
    pr.creerObjetPage(libEntete,colSomme);
    %>
    <h1>Liste des configurations</h1>
    <form action="<%=pr.getLien()%>?but=rubrique/rubrique-prix-entite-liste.jsp" method="post" name="listerubrique" id="listerubrique">
    <%
    out.println(pr.getFormu().getHtmlEnsemble());%>
    </form>
    <%
    String lienTableau[]={pr.getLien()+"?but=rubrique/rubrique-prix-entite-fiche.jsp"};
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

