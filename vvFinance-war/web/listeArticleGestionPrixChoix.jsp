<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
  ArticleLibelle e=new ArticleLibelle();

String listeCrt[]={"idArticle","libelle","typearticle","nombrerame"};
String listeInt[]=null;
String libEntete[]={"libelle"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listearticlelibelle.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
ArticleLibelle []listeP=(ArticleLibelle [])pr.getRs().getResultat();//liste
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des articles</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeArticleGestionPrixChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listearticlegestionprixchoix" id="listearticlegestionprixchoix">
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
<form action="<%=pr.getLien() %>?but=apresChoixArticleGestionPrix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">idArticle</td>
<td width=10% align=center valign=top>nombre rame</td>
<td width=10% align=center valign=top>typearticle</td>
<td width=20% align=center valign=top>libelle</td>
<td width=20% align=center valign=top>format</td>
<td width=20% align=center valign=top>grammage</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getIdArticle()%>" class="radio" /></td>
<td align=center><%=listeP[i].getIdArticle() %></td>
<td align=center><%=listeP[i].getNombrerame() %></td>
<td align=center><%=listeP[i].getTypearticle() %></td>
<td align=center><%=listeP[i].getLibelle() %></td>
<td align=center><%=listeP[i].getFormat()%></td>
<td align=center><%=listeP[i].getGrs() %></td>
</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPage());
%>
