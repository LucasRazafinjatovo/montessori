<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
DemandeDevis e=new DemandeDevis();

String listeCrt[]={"nombreImpression","dateDevis"};
String listeInt[]=null;
String libEntete[]={"nombreImpression","dateDevis"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listedemandedevis.jsp");

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
DemandeDevis []listeP=(DemandeDevis [])pr.getRs().getResultat();//liste
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des articles</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeDemandeDevisChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listearticlechoix" id="listearticlechoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichedemandedevis.jsp"};
String colonneLien[]={"idDevis"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=apresChoixDemandeDevis.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">idDevis</td>
<td width=18% align=center valign=top>id code RV</td>
<td width=15% align=center valign=top>id article</td>
<td width=14% align=center valign=top>designation</td>
<td width=14% align=center valign=top>nombre</td>
<td width=14% align=center valign=top>remise</td>
<td width=14% align=center valign=top>date demande devis</td>

</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getIdDevis()%>" class="radio" /></td>
<td align=center><%=listeP[i].getIdDevis() %></td>
<td align=center><%=listeP[i].getIdCodeRV() %></td>
<td align=center><%=listeP[i].getIdArticle() %></td>
<td align=center><%=listeP[i].getDesignation() %></td>
<td align=center><%=listeP[i].getNombre() %></td>
<td align=center><%=listeP[i].getRemise() %></td>
<td align=center><%=listeP[i].getDateDevis()%></td>
</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPage());
%>
