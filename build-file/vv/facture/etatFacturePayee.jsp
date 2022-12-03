<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="facture.EtatFacturePayee" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
EtatFacturePayee e = new EtatFacturePayee();
String listeCrt[]={"daty","nif","nom","numstat","adresse","libelle","numfact","montantht","tva","montantttc","montant_paye"};
String listeInt[]={"montantht","tva","montantttc","montant_paye","daty"};
String libEntete[]={"daty","nif","nom","numstat","adresse","libelle","numfact","montantht","tva","montantttc","montant_paye"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3);

pr.getFormu().getChamp("montantht1").setLibelleAffiche("Montant Hors Taxe(min)");
pr.getFormu().getChamp("montantht2").setLibelleAffiche("Montant Hors Taxe(max)");
pr.getFormu().getChamp("tva1").setLibelleAffiche("Montant TVA(min)");
pr.getFormu().getChamp("tva2").setLibelleAffiche("Montant TVA(max)");
pr.getFormu().getChamp("montantttc1").setLibelleAffiche("Montant TTC(min)");
pr.getFormu().getChamp("montantttc2").setLibelleAffiche("Montant TTC(max)");
pr.getFormu().getChamp("montant_paye1").setLibelleAffiche("Montant payée(min)");
pr.getFormu().getChamp("montant_paye2").setLibelleAffiche("Montant payée(max)");
pr.getFormu().getChamp("daty1").setLibelleAffiche("Date min");
pr.getFormu().getChamp("daty2").setLibelleAffiche("Date max");
pr.getFormu().getChamp("nom").setLibelleAffiche("Client");
pr.getFormu().getChamp("adresse").setLibelleAffiche("Adresse");
pr.getFormu().getChamp("libelle").setLibelleAffiche("Libellé");
pr.getFormu().getChamp("numfact").setLibelleAffiche("Facture No");
pr.getFormu().getChamp("nif").setLibelleAffiche("NIF");
pr.getFormu().getChamp("numstat").setLibelleAffiche("Numero Stat");

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);

%>
<h1>Déclaration TVA</h1>
<form action="<%=pr.getLien()%>?but=facture/etatFacturePayee.jsp" method="post" name="facture" id="facture">
<%
    out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
    out.println(pr.getTableauRecap().getHtml());
%>
<br>
    <%
        String libEnteteAffiche[]={"Date","NIF","Client","Stat","Adresse","Libellé","Facture No","Hors taxe","TVA","Montant TTC","Montant payé"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
    %>
<br>
<%
    out.println(pr.getBasPage());
%>