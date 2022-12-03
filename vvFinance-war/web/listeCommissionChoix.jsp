<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="lc.*" %>
<%@ page import="pub.PubFactPaye" %>
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
PubFactPaye p = new PubFactPaye();
String etat="pubfacttousf";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
	etat=request.getParameter("etat");
System.out.print(etat);
p.setNomTable(etat);
String listeCrt[] = {"idop","factclient","client","numcompte"};
String listeInt[] = null;
String libEntete[] = {"factclient","numcompte","client","montant","paye","commission"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeCommissionChoix.jsp");

pr.getFormu().getChamp("numcompte").setLibelle("Commercial");
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to = new TypeObjet();
to.setNomTable("commercialactif");
liste[0]=new Liste("numcompte",to,"val","val");
pr.getFormu().changerEnChamp(liste);

String colSomme[]={"montant","paye","commission"};
pr.creerObjetPageMultiple(libEntete,colSomme);
PubFactPaye []listeP = (PubFactPaye [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste OR</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeCommissionChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat :


<select name="etat" class="champ" id="etat" >
	<option value="pubfacttousf"  <%if(etat.compareTo("pubfacttousf")==0) out.println("selected");%>>Comm pubF tous</option>
	<option value="pubfacttousfpaye"  <%if(etat.compareTo("pubfacttousfpaye")==0) out.println("selected");%>>Comm pubF paye</option>
	<option value="pubfacttousfnonpaye"  <%if(etat.compareTo("pubfacttousfnonpaye")==0) out.println("selected");%>>Comm pubF non paye</option>
	<option value="pubfacttousnf" <%if(etat.compareTo("pubfacttousnf")==0) out.println("selected");%>>Comm pub OR</option>
</select>
</form>
<%
out.println(pr.getTableauRecap().getHtml());
%>
<br>
<form action="lc/apresLcChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td align="center" valign="top"><input type="checkbox" name="full_check" id="full_check" onchange="checkBoxer(this,<%=listeP.length%>)"></td>
<td bgcolor="#66ccff" align="center"><b>Fact client</b></td>
<td bgcolor="#66ccff" align="center"><b>Commercial</b></td>
<td bgcolor="#66ccff" align="center"><b>Client</b></td>
<td bgcolor="#66ccff" align="center"><b>Montant</b></td>
<td bgcolor="#66ccff" align="center"><b>Paye</b></td>
<td bgcolor="#66ccff" align="center"><b>Commission</b></td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td><input type="checkbox" value="<%=listeP[i].getFactclient()%>" name="identifiant<%=i%>" id="identifiant<%=i%>" ></td>
<td align=center><%=listeP[i].getFactclient()%></td>
<td align="center"><%=listeP[i].getNumcompte()%></td>
<td align="center"><%=listeP[i].getClient()%></td>
<td align="center"><%=Utilitaire.formaterAr(listeP[i].getMontant())%></td>
<td align="center"><%=Utilitaire.formaterAr(listeP[i].getPaye())%></td>
<td align="center"><%=Utilitaire.formaterAr(listeP[i].getCommission())%></td>
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
