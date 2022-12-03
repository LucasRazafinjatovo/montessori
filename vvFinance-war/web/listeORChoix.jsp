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
try{
	OpLcComplet e = new OpLcComplet();
	OpLcComplet p=new OpLcComplet();
	String etat="orvisenonPayelc";
	p.setNomTable(etat);
	String listeCrt[]={"id","remarque","ded_id","designationLc","idTypeLigne","identite","iddirection","annee","numCompte","idLigne","mois","daty","montant","paye","idFournisseur"};
	String listeInt[]={"mois","daty","montant","paye"};
	String libEntete[]={"id","daty","ded_id","idLigne","montant","remarque","paye"};
	PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);
	pr.setUtilisateur((user.UserEJB)session.getValue("u"));
	pr.setLien((String)session.getValue("lien"));
	pr.setApres("ded/listeOR_o.jsp");
	affichage.Champ[] liste=new affichage.Champ[6];

	TypeObjet to=new TypeObjet();
	to.setNomTable("typeentree");
	liste[0]=new Liste("idTypeLigne",to,"val","val");
	TypeObjet to1=new TypeObjet();
	to1.setNomTable("beneficiaire");
	liste[1]=new Liste("identite",to1,"val","val");
	Direction to2=new Direction();
	to2.setNomTable("direction");
	liste[2]=new Liste("iddirection",to2,"libelledir","libelledir");
	liste[3]=new Liste("mois1");
	((Liste)(liste[3])).makeListeMois();
	liste[4]=new Liste("mois2");
	((Liste)(liste[4])).makeListeMois();
	TypeObjet to5=new TypeObjet();
	to5.setNomTable("agence");
	liste[5]=new Liste("numCompte",to5,"val","val");
	pr.getFormu().changerEnChamp(liste);
	pr.getFormu().setLibelleAffiche("Agence",8);
	String colSomme[]={"montant","paye","parution"};
	pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
	pr.creerObjetPageMultiple(libEntete,colSomme);
	OpLcComplet []listeP=(OpLcComplet [])pr.getRs().getResultat();
	%>
	<link href="style/style.css" rel="stylesheet" type="text/css">
	<h1>Liste OR</h1>
	<script type="text/javascript">
	function getChoix(){
	  setTimeout("document.frmchx.submit()",800);
	}
	</script>
	<form action="listeORChoix.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listelcchoix" id="listelcchoix">
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
	<td align="center" valign="top"><input type="checkbox" name="full_check" id="full_check" onchange="checkBoxer(this,<%=listeP.length%>)"></td>
	<td align="center" valign="top">ID</td>
	<td align="center" valign="top">Date</td>
	<td align="center" valign="top">Facture C</td>
	<td align="center" valign="top">Id LC</td>
	<td align="center" valign="top">Montant</td>
	<td align="center" valign="top">Remarque</td>
	<td  align="center" valign="top">Num Compte</td>
	</tr>

	<%
	for(int i=0;i<listeP.length;i++)
	{
	%>
	<tr>
	<td align="center"><input name="indice" type="radio" id="numObjet" value=<%=listeP[i].getId()%> onMouseDown="getChoix()"></td>
	<td align=center><%=listeP[i].getId()%></td>
	<td align=center><%=listeP[i].getDaty() %></td>
	<td align=center><%=listeP[i].getDed_id() %></td>
	<td align=center><%=listeP[i].getIdLigne() %></td>
	<td align=center><%=listeP[i].getMontant()%></td>
	<td align=center><%=listeP[i].getRemarque()%></td>
	<td align=center><%=listeP[i].getNumCompte()%></td>
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
<%}catch(Exception ex){
	ex.printStackTrace();
}
%>

