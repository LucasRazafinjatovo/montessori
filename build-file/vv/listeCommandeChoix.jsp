<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
  CommandeLibelle e=new CommandeLibelle();

String listeCrt[]={"idcmd","remarque"};
String listeInt[]=null;
String libEntete[]={"idcmd","remarque"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("activa/listecommande.jsp");

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
CommandeLibelle []listeP=(CommandeLibelle [])pr.getRs().getResultat();//liste
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des commandes</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeCommandeChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listecommandechoix" id="listecommandechoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=activa/fichecommande.jsp"};
String colonneLien[]={"idcmd"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=apresChoixCommande.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">idCommande</td>
<td width=30% align=center valign=top>remarque</td>
<td width=14% align=center valign=top>Nombre Impression</td>
<td width=14% align=center valign=top>date commande</td>
<td width=14% align=center valign=top>datelivraisoncmd</td>
<!--<td width=14% align=center valign=top>prixRectoVerso</td> -->

</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getIdcmd()%>" class="radio" /></td>
<td align=center><%=listeP[i].getIdcmd() %></td>
<td align=center><%=listeP[i].getRemarque() %></td>
<td align=center><%=listeP[i].getNombreImpression() %></td>
<td align=center><%=listeP[i].getDatecmd() %></td>
<td align=center><%=listeP[i].getDateLivraisonCmd() %></td>
</tr>
<%}%>
</table>
</form>
<%
//out.println(pr.getBasPage());
%>