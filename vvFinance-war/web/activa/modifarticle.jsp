<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Article atcl=new Article();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[2];

TypeArticle t=new TypeArticle();
t.setNomTable("typearticle");
liste[0]=new Liste("idTypeArticle",t,"val","idTypeArticle");
NombreRame n=new NombreRame();
n.setNomTable("nombrerame");
liste[1]=new Liste("idNombreRame",n,"valeur","idNombreRame");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("idArticle").setAutre("readonly='readonly'");
pi.preparerDataFormu();
%>

<h1>Modification article</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="activa/listearticlelibelle.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Article">
</form>
