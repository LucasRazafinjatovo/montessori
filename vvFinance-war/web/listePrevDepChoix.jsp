<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
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
PrevisionDepense p = new PrevisionDepense();
p.setNomTable("PrevisionDepense");
String listeCrt[] = {"daty","montant","description"};
String listeInt[] = {"daty","montant"};
String libEntete[] = {"id","daty","montant","description"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listePrevDepChoix.jsp");
String colSomme[]={"montant"};
pr.creerObjetPageMultiple(libEntete,colSomme);
PrevisionDepense []listeP = (PrevisionDepense [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste OR</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listePrevDepChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
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
<td align="center" valign="top">Date</td>
<td align="center" valign="top">Montant Init</td>
<td align="center" valign="top">Montant Effectif</td>
<td align="center" valign="top">Description</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td><input type="radio" name="choix" onMouseDown="getChoix()" value="<%=listeP[i].getId()%>" class="radio" /></td>
<td align=center><%=listeP[i].getId()%></td>
<td align=center><%=listeP[i].getDaty() %></td>
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontantinit()) %></td>
<td align=center><%=Utilitaire.formaterAr(listeP[i].getMontant())%></td>
<td align=center><%=listeP[i].getDescription()%></td>
</tr>
<%}%>
</table>
<table width="50%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
		<tr>
			<td height="30" align="center">
				<table width="75%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"> <input type="submit" name="Submit" value="Valider" class="submit"></td>
						<td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit"></td>
						<td align="center"> <input type="hidden" name="taille_tableau" value="<%=listeP.length%>" /></td>
					</tr>
			</table></td>
		</tr>
	</table>
</form>


<%
//out.println(pr.getBasPagee(request.getParameter("champReturn")));
%>
