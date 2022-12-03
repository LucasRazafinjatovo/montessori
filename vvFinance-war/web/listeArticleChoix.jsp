<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
  Article e=new Article();

String listeCrt[]={"libelle","idTypeArticle","format"};
String listeInt[]=null;
String libEntete[]={"libelle"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,4);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listearticle.jsp");

//affichage.Champ[] liste=new affichage.Champ[3];
/*TypeObjet pay=new TypeObjet();
pay.setNomTable("pays");
liste[0]=new Liste("pays",pay,"val","id");
TypeObjet ville=new TypeObjet();
ville.setNomTable("ville");
liste[1]=new Liste("ville",ville,"val","id");

pr.getFormu().changerEnChamp(liste); */
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
Article []listeP=(Article [])pr.getRs().getResultat();//liste
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des articles</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeArticleChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listearticlechoix" id="listearticlechoix">
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
<form action="<%=pr.getLien() %>?but=apresChoixArticle.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=15% align="center" valign="top">idArticle</td>
<td width=30% align=center valign=top>libelle</td>
<td width=25% align=center valign=top>format</td>
<td width=28% align=center valign=top>grammage</td>

</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getIdArticle()%>" class="radio" /></td>
<td align=center><%=listeP[i].getIdArticle() %></td>
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
