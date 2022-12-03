<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Article m=new Article();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("idTypeArticle").setLibelle("type article");
affichage.Champ[] liste = new affichage.Champ[2];
NombreRame n = new NombreRame();
n.setNomTable("nombrerame");
liste[0]=new Liste("idNombreRame",n,"valeur","idNombreRame");

TypeArticle t=new TypeArticle();
t.setNomTable("typeArticle");
liste[1]=new Liste("idTypeArticle",t,"val","idTypeArticle");

pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("grs").setLibelle("grammage");
pi.preparerDataFormu();
%>
<h1>Saisir Papier </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/listearticlelibelle.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Article">
<!-- <input name="rajoutLien" type="hidden" id="classe" value="grs-pu-prix">  -->
</form>
