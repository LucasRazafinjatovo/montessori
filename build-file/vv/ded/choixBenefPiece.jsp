<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.*" %>

<%
  //Etudiant e=new Etudiant();
  BenefPiece a=new BenefPiece();
  a.setNomTable("BenefPiece");
  String listeCrt[]={"nom","tel","poste"};
  String listeInt[]={"datenaissance"};
  PageRecherche pr=new PageRecherche(a,request,listeCrt,listeInt,3);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("choixBenefPiece.jsp");
  String libEntete[]={"id","nom","tel","poste"};
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
BenefPiece []listeP=(BenefPiece [])pr.getRs().getResultat();//liste listeEtudiant
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des beneficiaires</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="choixBenefPiece.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ded/ficheBenefPiece.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../<%=pr.getLien() %>?but=ded/apreschoixTiers.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=14% align="center" valign="top">nom</td>
<td width=14% align="center" valign="top">telephone</td>
<td width=14% align="center" valign="top">poste</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="idClient" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getNom() %></td>
<td align=center><%=listeP[i].getTel() %></td>
<td align=center><%=listeP[i].getPoste()%></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
