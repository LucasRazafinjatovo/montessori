<%-- 
    Document   : analysecommissionpub
    Created on : 25 juil. 2017, 14:30:53
    Author     : Doudou Tiarilala
--%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
 
<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        PubFactPaye p = new PubFactPaye();
        String etat = "pubfacttousf";
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            etat = request.getParameter("etat");
        } 
        p.setNomTable(etat);
         
        String listeCrt[] = {"numcompte", "mois", "annee"};
        String listeInt[] = null;
        String somDefaut[] = {"montant", "paye", "commission"};
        String colDefaut[] = {"numcompte","mois", "annee"};
        PageRechercheGroupe pr = new PageRechercheGroupe(p, request, listeCrt, listeInt, 3, colDefaut, somDefaut, 4, 3);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("pub/analysecommissionpub.jsp");

        pr.getFormu().getChamp("numcompte").setLibelle("Commercial");
        affichage.Champ[] liste = new affichage.Champ[1];
        TypeObjet to = new TypeObjet();
        to.setNomTable("commercialactif");
        liste[0] = new Liste("numcompte", to, "val", "val");
        pr.getFormu().changerEnChamp(liste);

        String colSomme[] = {"montant", "paye", "commission"};
        pr.creerObjetPage();
      
%>
<br/>
<h2>
    <%
        if (u.getUser().getLoginuser().compareToIgnoreCase("tahina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("medicis") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("tsilavina") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("felana") == 0 || u.getUser().getLoginuser().compareToIgnoreCase("schall") == 0) {%>
    <a href="<%=lien%>?but=pub/listeCommissionPubDirection.jsp">Commission 1% (seulement direction)</a>
    <%}%></h2>
<h1>Liste commission commercial par pub</h1>
<form action="<%=lien%>?but=pub/analysecommissionpub.jsp"  method="post" name="listePub" id="listePub">
    <%
        out.println(pr.getFormu().getHtmlEnsemble());%>
    etat :
  <select name="etat" class="champ" id="etat" >
        <option value="pubfacttousf"  <%if (etat.compareTo("pubfacttousf") == 0) {
                out.println("selected");
            }%>>Comm pubF tous</option>
        <option value="pubfacttousfpaye"  <%if (etat.compareTo("pubfacttousfpaye") == 0) {
                out.println("selected");
            }%>>Comm pubF paye</option>
        <option value="pubfacttousfnonpaye"  <%if (etat.compareTo("pubfacttousfnonpaye") == 0) {
                out.println("selected");
            }%>>Comm pubF non paye</option>
        <option value="pubfacttousnf" <%if (etat.compareTo("pubfacttousnf") == 0) {
                out.println("selected");
            }%>>Comm pub OR</option>
    </select>

</form>
<%
    pr.setApresLienPage("&etat=" + etat);
    out.println(pr.getTableauRecap().getHtml());%>
</br> 
<%
    out.println(pr.getTableau().getHtml());   
%>
<%
        out.println(pr.getBasPage());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
