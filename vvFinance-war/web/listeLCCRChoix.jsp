<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="lc.*" %>
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
LigneCreditRecetteComplet e = new LigneCreditRecetteComplet();
String listeCrt[]={"designation","idligne","mois","annee","iddirection","typelc","entite"};
String listeInt[]={"mois"};
String libEntete[]={"designation","creditmodifier","montanteng","montantvis","montantfac","entite","typelc","abbrevdir","mois","idligne"};
//PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,3);
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2,libEntete,10);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("listeLCChoix.jsp");
affichage.Champ[] liste=new affichage.Champ[5];
Mois prof1=new Mois();
prof1.setNomTable("mois");
liste[0]=new Liste("mois",prof1,"mois","rang");
Annee an=new Annee();
an.setNomTable("annee");
liste[1]=new Liste("annee",an,"annee","annee");
Direction dir=new Direction();
dir.setNomTable("Direction");
liste[2]=new Liste("iddirection",dir,"libelledir","iddir");
TypeObjet to=new TypeObjet();
to.setNomTable("typeentreeliste");
liste[3]=new Liste("typelc",to,"val","val");
TypeObjet benef=new TypeObjet();
benef.setNomTable("beneficiaire");
liste[4]=new Liste("entite",benef,"val","val");
pr.getFormu().changerEnChamp(liste);

  pr.getFormu().getChamp("iddirection").setLibelleAffiche("direction");
  String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
LigneCreditRecetteComplet []listeP=(LigneCreditRecetteComplet [])pr.getRs().getResultat();
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<h1>Liste LC Recettes</h1>
<script type="text/javascript">
function getChoix(){
  setTimeout("document.frmchx.submit()",800);
}
</script>
<form action="listeLCChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="apresLCChoix.jsp" method="post" name="frmchx" id="frmchx">
<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

<table width=100% border=0 align=center cellpadding=3 cellspacing=3 class=monographe>
<tr class=head>
<td width=16% align="center" valign="top"><input type="checkbox" name="full_check" id="full_check" onchange="checkBoxer(this,<%=listeP.length%>)"></td>
<td width=16% align="center" valign="top">D&eacute;signation</td>
<td width=10% align="center" valign="top">Cr&eacute;dit</td>
<td width=10% align="center" valign="top">Consomme</td>
<td width=10% align="center" valign="top">Op vise</td>
<td width=10% align="center" valign="top">Fact vise</td>
<td width=9% align="center" valign="top">Entite</td>
<td width=14% align="center" valign="top">Type</td>
<td width=7% align="center" valign="top">Direction</td>
<td width=4% align="center" valign="top">Mois</td>
<td width=5% align="center" valign="top">Id LC</td>
</tr>

<%
for(int i=0;i<listeP.length;i++)
{
%>
<tr>
<td align="center" valign="top"><input type="checkbox" value="<%=listeP[i].getIdLigne()%>" name="identifiant<%=i%>" id="identifiant<%=i%>" ></td>
<td align=center><%=listeP[i].getDesignation()%></td>
<td align=center><%=listeP[i].getCreditInitial() %></td>
<td align=center><%=listeP[i].getMontantEng() %></td>
<td align=center><%=listeP[i].getMontantVis() %></td>
<td align=center><%=listeP[i].getMontantFac()%></td>
<td align=center><%=listeP[i].getEntite()%></td>
<td align=center><%=listeP[i].getTypeLC()%></td>
<td align=center><%=listeP[i].getAbbrevdir()%></td>
<td align=center><%=listeP[i].getMois()%></td>
<td align=center><%=listeP[i].getIdLigne()%></td>
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
