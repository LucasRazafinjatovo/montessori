<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
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
OrdonnerPayement e = new OrdonnerPayement();
String listeCrt[]={"id","remarque","ded_id","daty","montant"};
String listeInt[]={"daty"};
String libEntete[]={"id","daty","remarque","montant","ded_id"};
PageRecherche pr = new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeOPChoix.jsp");
String colSomme[]={"montant"};
pr.creerObjetPage(libEntete,colSomme);
OrdonnerPayement []listeP=(OrdonnerPayement [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste OP</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeOPChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="facturefournisseur/apresChoixFactureFPopUp.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">
<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td align="center" valign="top"></td>
<td align="center" valign="top">ID</td>
<td align="center" valign="top">Date</td>
<td align="center" valign="top">Remarque</td>
<td align="center" valign="top">Montant</td>
<td  align="center" valign="top">Facture</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td align="center"><input name="indice" type="radio" id="numObjet" value=<%=listeP[i].getId()%> onMouseDown="getChoix()">
</td>
<td align=center><%=listeP[i].getId()%></td>
<td align=center><%=listeP[i].getDaty() %></td>
<td align=center><%=listeP[i].getRemarque()%></td>
<td align=center><%=listeP[i].getMontant()%></td>
<td align=center><%=listeP[i].getDed_Id()%></td>
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

