<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
  Offre o=new Offre();
  String listeCrt[]={"id","dateeffectivite", "duree"};
String listeInt[]={"dateeffectivite","duree"};
  PageRecherche pr=new PageRecherche(o,request,listeCrt,listeInt,3);
  pr.setUtilisateur((user.UserEJB)session.getValue("u"));
  pr.setLien((String)session.getValue("lien"));
  pr.setApres("offreChoix.jsp");
  pr.getFormu().getChamp("dateeffectivite1").setLibelleAffiche("Date effectivite (min)");
pr.getFormu().getChamp("dateeffectivite2").setLibelleAffiche("Date effectivite (max)");
pr.getFormu().getChamp("duree1").setLibelleAffiche("Duree (min)");
pr.getFormu().getChamp("duree2").setLibelleAffiche("Duree (max)");
  String libEntete[]={"id","dateeffectivite", "duree"};
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
Offre []listeP=(Offre [])pr.getRs().getResultat();//liste offre
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste des offres</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="offreChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="../apresChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=16% align="center" valign="top">Date effectivite</td>
<td width=14% align="center" valign="top">Duree</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getDateeffectivite() %></td>
<td align=center><%=listeP[i].getDuree() %></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>
