<%-- 
    Document   : pubRadioMereChoix
    Created on : 17 mai 2017, 16:28:44
    Author     : Safidimahefa
--%>
<%@page import="pub.PubRadioMere"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
  PubRadioMere p = new PubRadioMere();
  p.setNomTable("pubradiolib");
String listeCrt[]={"id","daty","client","observation","reference","responsable"};
String listeInt[]=null;
  PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
String libEntete[]={"id","daty","client","observation","reference","responsable"};

String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);
PubRadioMere []listeP=(PubRadioMere [])pr.getRs().getResultat();//liste offre
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste client</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="clientChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeetudiantchoix" id="listeetudiantchoix">
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
<td align="left" valign="top">ID</td>
<td align="left" valign="top">Daty</td>
<td align="left" valign="top">Client</td>
<td align="left" valign="top">Observation</td>
<td align="left" valign="top">Reference</td>
<td align="left" valign="top">Responsable</td>

</tr>
<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<!--<tr onmouseover=this.style.backgroundColor='#EAEAEA' onmouseout="this.style.backgroundColor=''">-->
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=left><%=listeP[i].getId()%></td>
<td align=left><%= Utilitaire.datetostring(listeP[i].getDaty())%></td>
<td align=left><%=listeP[i].getClient()%></td>
<td align=left><%=listeP[i].getObservation()%></td>
<td align=left><%=listeP[i].getReference()%></td>
<td align=left><%=listeP[i].getResponsable()%></td>
</tr>
<%}%>
</table>
</form>


<%
out.println(pr.getBasPage());
%>

