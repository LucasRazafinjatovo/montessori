<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%
RapprochementBancaireVue e = new RapprochementBancaireVue();
e.setNomTable("RapprochementBancaire");
String listeCrt[]={"numcheque","daty","designation","caisse","numreference","id"};
String listeInt[]={"daty"};
String libEntete[]={"numcheque","daty","designation","debit","credit","caisse","id"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3,libEntete,7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/rapprochement.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Caisse prof1=new Caisse();
prof1.setNomTable("Caisse");
liste[0]=new Liste("caisse",prof1,"desccaisse","desccaisse");
pr.getFormu().changerEnChamp(liste);
String[]colSomme={"debit","credit"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>ch&egrave;que rapproch&eacute;</h1>
<form action="<%=pr.getLien()%>?but=finance/rapprochement.jsp" method="post" name="rapprochement" id="rapprochement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/ficheRapprochement.jsp",pr.getLien()+"?but=ded/visualiserOP.jsp"};
String colonneLien[]={"numcheque","id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);%>
<br>
<%out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
