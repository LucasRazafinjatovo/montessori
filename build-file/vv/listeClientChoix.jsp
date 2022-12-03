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
Client p = new Client();
p.setNomTable("Client");
String listeCrt[] = {"idClient","nom","adresse","telephone"};
String listeInt[] = null;
String libEntete[] = {"idClient","nom","adresse","telephone"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeClientChoix.jsp");
String colSomme[] = null;
pr.creerObjetPageMultiple(libEntete,colSomme);
Client[] listeP = (Client[])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste OR</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeClientChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="apresChoixFournisseur.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td align="center" valign="top"></td>
<td align="center" valign="top">ID</td>
<td align="center" valign="top">Nom</td>
<td align="center" valign="top">Adresse</td>
<td align="center" valign="top">Telephone</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getIdClient()%>" class="radio" /></td>
<td align=center><%=listeP[i].getIdClient()%></td>
<td align=center><%=listeP[i].getNom() %></td>
<td align=center><%=listeP[i].getAdresse()%></td>
<td align=center><%=listeP[i].getTelephone()%></td>
</tr>
<%}%>
</table>
</form>


<%
//out.println(pr.getBasPagee(request.getParameter("champReturn")));
%>
