<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
String etat=null;
%>
<%
etat=request.getParameter("etat");
OrdonnerPayement p=new OrdonnerPayement();
p.setNomTable(etat);
String listeCrt[]={"id","ded_Id","daty","montant","remarque"};
String listeInt[]={"daty"};
String libEntete[]={"id","daty","ded_Id","remarque","montant"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/choixOP.jsp");
String colSomme[]={"montant"};
pr.setNpp(100);
pr.creerObjetPage(libEntete,colSomme);
OrdonnerPayement []listeP=(OrdonnerPayement [])pr.getRs().getResultat();
//pr.preparerDataFormu();
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les Ordres de paiement </h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="choixOP.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeop" id="listeop">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=ded/visualiserOP.jsp",pr.getLien()+"?but=facture/visualiserFactureFournisseur.jsp"};
String colonneLien[]={"id","ded_Id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="apresChoixOP.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr bgcolor="#D7D7D7">
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id OP</td>
<td width=14% align="center" valign="top">daty</td>
<td width=14% align="center" valign="top">Facture F</td>
<td width=14% align="center" valign="top">Designation</td>
<td width=14% align="center" valign="top">Montant</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="idOP" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId()%></td>
<td align=center><%=listeP[i].getDaty()%></td>
<td align=center><%=listeP[i].getDed_Id()%></td>
<td align=center><%=listeP[i].getRemarque()%></td>
<td align=center><%=listeP[i].getMontant()%></td>
</tr>
<%}%>
</table>
</form>

<%
out.println(pr.getBasPage());
%>
