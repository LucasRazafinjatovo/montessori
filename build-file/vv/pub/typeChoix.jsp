<%@page import="pub.PubType"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="facture.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.OpLcComplet" %>
<script type="text/javascript">
function checkBoxer(obj,taille)
{
     if(obj.checked==true)
     {
         for(var i=0;i<taille;i++)
         {
          document.getElementById("identifiant"+i).checked = true;
         }
     }
     else
     {
       for(var i=0;i<taille;i++)
         {
          document.getElementById("identifiant"+i).checked = false;
         }
     }
}
</script>
<%
PubType p = new PubType();
String listeCrt[] = {"id","designation","type","duree","durees"};
String listeInt[] = null;
String libEntete[] = {"id","designation","type","duree","durees"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("typeChoix.jsp");
String colSomme[] = null;
pr.creerObjetPageMultiple(libEntete,colSomme);
PubType[] listeT = (PubType[])pr.getRs().getResultat();
%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Liste type pub </h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="typeChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
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
<td align="center" valign="top"></td>
<td align="center" valign="top">ID</td>
<td align="center" valign="top">Designation</td>
<td align="center" valign="top">Type</td>
<td align="center" valign="top">Duree</td>
<td align="center" valign="top">Duree(en lettre)</td>
</tr>

<%
for(int i=0;i<listeT.length;i++)
{
%>
<tr>
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeT[i].getId()%>" class="radio" /></td>
<td align=center><%=listeT[i].getId()%></td>
<td align=center><%=listeT[i].getDesignation()%></td>
<td align=center><%=listeT[i].getType()%></td>
<td align=center><%=listeT[i].getDuree()%></td>
<td align=center><%=listeT[i].getDurees()%></td>
</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPagee(request.getParameter("champReturn")));
%>
