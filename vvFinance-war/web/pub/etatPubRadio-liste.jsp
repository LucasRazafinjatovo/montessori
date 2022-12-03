<%-- 
    Document   : etatPubRadio-liste
    Created on : 6 juil. 2017, 10:41:08
    Author     : Alain
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="pub.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    PubRadioPaiement p = p = new PubRadioPaiement();
    p.setNomTable("PUB_RADIO_PAIEMENT1");
    String listeCrt[] = {"id", "daty","client", "observation", "reference", "responsable","nomcampagne", "nature", "duree", "pubtype", "heure"};
    String listeInt[] = {"daty"};
    
    String colGr[] = {"daty","client", "observation"};
    String somDefaut[] = {"montant", "paie", "reste"};
    PageRechercheGroupe pr = new PageRechercheGroupe(p, request, listeCrt, listeInt, 3, colGr, somDefaut, 6, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("pub/etatPubRadio-liste.jsp");
    pr.creerObjetPage();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1> Liste pub radio/facture  </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=pub/etatPubRadio-liste.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
    
</div>
