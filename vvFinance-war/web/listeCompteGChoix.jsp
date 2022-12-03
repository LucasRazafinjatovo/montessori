<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="compte.*" %>

<%
CompteG c=new CompteG();
c.setNomTable("COMPTEG");
String listeCrt[]={"id","val","desce","datyDebutValid"};
String listeInt[]=null;
String libEntete[]={"id","val","desce","datyDebutValid"};
PageRecherche pr=new PageRecherche(c,request,listeCrt,listeInt,2,libEntete,4);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("compte/listeCompteG.jsp");
 String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
CompteG []listeP=(CompteG [])pr.getRs().getResultat();//liste listeCompteG
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des CompteG</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeCompteGChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listecomptegchoix" id="listecomptegchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=compte/ficheCompteG.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=apresEtudiantChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top">id</td>
<td width=10% align="center" valign="top">id</td>
<td width=35% align=center valign=top>val</td>
<td width=35% align=center valign=top>desce</td>
<td width=15% align=center valign=top>datyDebutValid</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getVal() %></td>
<td align=center><%=listeP[i].getDesce() %></td>
<td align=center><%=listeP[i].getDatyDebutValid() %></td>
</tr>
<!--<input type="hidden" name="id<%=i%>" value="<%=listeP[i].getId()%>">-->
<%}%>
</table>
<!--<input type="hidden" name="nb" value="<%=listeP.length%>">-->
<!--<input type="hidden" name="crt" value="<%=pr.getFormu().getListeCritereString()%>&numPage=<%=pr.getNumPage()%>">-->
<!--<input type="submit" value="valider">-->
</form>


<%
//out.println(pr.getBasPage());
%>
