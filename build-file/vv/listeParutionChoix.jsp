<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="pub.*" %>
<%
Parution p=new Parution();
String etat="Parutionlibelle";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","journal","numParution"};
String listeInt[]={"numParution"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeParutionChoix.jsp");
String libEntete[] = {"id","journal","datyParution","numParution"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
Parution []listeP=(Parution [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste parution</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeParutionChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien() %>?but=listeParutionChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=5% align="center" valign="top"></td>
<td width=9% align="center" valign="top">id</td>
<td width=16% align=center valign=top>Journal</td>
<td width=14% align=center valign=top>Date de parution</td>
<td width=14% align=center valign=top>Numero de parution</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId() %></td>
<td align=center><%=listeP[i].getJournal() %></td>
<td align=center><%=listeP[i].getDatyParution() %></td>
<td align=center><%=listeP[i].getNumParution() %></td>

</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPage());
%>
