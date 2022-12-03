<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
String type = "";
LivraisonFait p = new LivraisonFait();
String listeCrt[]={"id","vendeur","coursier","datedebut","datefin","datelivraison","quartier","secteur"};
String listeInt[]={"datedebut","datefin","datelivraison"};
String libEntete[]={"id","vendeur","coursier","datedebut","datefin","datelivraison","quartier","secteur"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/livraison-liste.jsp");
String colSomme[]=null;
pr.getFormu().getChamp("datedebut1").setLibelle("Date debut abonnement 1");
pr.getFormu().getChamp("datedebut2").setLibelle("Date debut abonnement 2");
pr.getFormu().getChamp("datefin1").setLibelle("Date fin abonnement 1");
pr.getFormu().getChamp("datefin2").setLibelle("Date fin abonnement 2");
pr.getFormu().getChamp("datelivraison1").setLibelle("Date livraison 1");
pr.getFormu().getChamp("datelivraison2").setLibelle("Date livraison 2");
pr.setNpp(100);
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>LISTE LIVRAISON</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/livraison-liste.jsp" method="post" name="livraison" id="livraison">
<%
out.println(pr.getFormu().getHtmlEnsemble());
%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ventegazety/livraison-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br />
<br />
	<%
        String libEnteteAffiche[] = {"Id","Vendeur","Coursier","Date debut abo","Date fin abo","Date livraison","Quartier","Secteur"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
	%>
