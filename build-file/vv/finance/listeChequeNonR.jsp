<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
Cheque e = new Cheque();
e.setNomTable("CHEQUEVIREVISENONRAPPRO");
String listeCrt[]={"numcheque","datysaisie","designation","caisse"};
String listeInt[]={"datysaisie"};
String libEntete[]={"datysaisie","id","designation","numcheque","caisse","montant"};

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeChequeNonR.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Caisse caisse=new Caisse();
liste[0]=new Liste("caisse",caisse,"desccaisse","desccaisse",true);
pr.getFormu().changerEnChamp(liste);
String[]colSomme={"montant"};
pr.creerObjetPageMultiple(libEntete,colSomme);
%>
<h1>Lister Cheque pay&eacute; non rapproch&eacute;e</h1>
<form action="<%=pr.getLien()%>?but=finance/listeChequeNonR.jsp" method="post" name="rapprochement" id="rapprochement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/visualiserMvtCaisse.jsp",pr.getLien()+"?but=finance/detailCheque.jsp"};
String colonneLien[]={"id","numcheque"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);%>
<br>
<%out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
