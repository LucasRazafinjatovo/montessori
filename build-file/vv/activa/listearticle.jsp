<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Article a=new Article();
a.setNomTable("article");

//e.setNomTable("article");

String listeCrt[]={"libelle","idTypeArticle","idNombreRame","grs","format"};
String listeInt[]=null;
String libEntete[]={"idArticle","libelle","grs","puRame","format"};
PageRecherche pr=new PageRecherche(a,request,listeCrt,listeInt,3,libEntete,6);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listearticle.jsp");

/*affichage.Champ[] liste=new affichage.Champ[2];
TypeArticle t=new TypeArticle();
t.setNomTable("typearticle");
liste[0]=new Liste("idTypeArticle",t,"val","idTypeArticle");
NombreRame w=new NombreRame();
w.setNomTable("nombreRame");
liste[1]=new Liste("idNombreRame",w,"valeur","idNombreRame");
pr.getFormu().changerEnChamp(liste);*/
pr.preparerDataFormu();
//pr.getFormu().getChamp("grs").setLibelle("grammage");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des articles</h1>
<form action="<%=pr.getLien()%>?but=artiva/listearticle.jsp" method="post" name="article" id="article">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichearticle.jsp"};
String colonneLien[]={"idArticle"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>