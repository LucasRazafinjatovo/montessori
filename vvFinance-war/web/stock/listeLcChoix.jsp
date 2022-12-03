<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/apresChoixListeLC.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
        String mois[] = Constante.getMois();
		String moisRang[] = Constante.getMoisRang();
		String numObjet = null;
		String typeObjet=null;
		String montantObjet=null;
        TypeObjet source[] =null;
        TypeObjet tlc[] =null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
        Direction dir[] = null;
        LigneCreditComplet lcc[]= null;
		FactureFournisseur bc[] = null;
        double lesMontants[] = null;
        String typeLigne[] = {"Recette","Dépense"};
        String idLC = "";
        String idType = "";
        String dateDebut, dateFin, projet,idFact,fournisseur;
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
        String apresW=null;
        FactureFournisseur factF[] = null;
		String numCompte = null;
		String colonne = null;
		String colonne1 = null;
		String mois2=null;String mois1=null;
		String chemin=null;
		UnionIntraTable[] lcc= null;
		
		u = (user.UserEJB)session.getValue("u");
        lien = (String)session.getValue("lien");
		
		ArticleBL[] listelc = null;
		try{
			ArticleBL.getNumLC(request.getParameter("idBL"));
			UnionIntraTableUtil uit = new UnionIntraTableUtil();
			uit.setNomTable("facturefournisseurlcdetail");
			lcc = (UnionIntraTable[])uit.rechercher(2,numObjet);
			numObjet = request.getParameter("numObjet");
			
			FactureFournisseur crt = new FactureFournisseur();
			crt.setIdFactureFournisseur(numObjet);
			crt.setNomTable("FACTUREFOURNISSEURLETTRE");
			bc = (FactureFournisseur[])CGenUtil.rechercher(crt, null,null,"");
		}catch (Exception e){
			%>
			<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
			<%
			return;
		}
		%>
<script type="text/javascript">
<!--
 function getChoix(){
  setTimeout("document.frmListe.submit()",800);
}
//-->
</script>


<link href="style.css" rel="stylesheet" type="text/css">
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num </td>
    <td width="73%"><div align="center"><%=request.getParameter("numObjet")%></div></td>
  </tr>
  <tr>
    <td class="left">Nature de l'objet</td>
    <td><div align="center"><%=request.getParameter("nature")%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><%=Utilitaire.formaterAr(request.getParameter("montantObjet"))%> Ar </div></td>
  </tr>
</table><br>
   
<form action="<%=lien%>?but=lc/updateLCJointure.jsp" method="POST" name="frmListe" id="frmListe">
	<p align="center"><strong><u>LISTE SELECTION </u></strong></p>
	<p align="center"><u><strong><a title="montant=<%=bc[0].getMontantTTC()%> et client = <%=bc[0].getIdFournisseur()%>" href=<%=lien%>?but=facture/visualiserFactureFournisseur.jsp&idBC=<%=numObjet%>&nature=<%=Constante.objetFactureFournisseur%>>Voir d&eacute;tails facture num <%=numObjet%></a></strong></u></p>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
		<tr class="head">
			<td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
			<td width="10%" align="center" valign="top"><strong>Entite</strong></td>
			<td width="7%" valign="top"><div align="center"><strong>Montant</strong></div></td>
			<td width="5%" valign="top"><div align="center"><strong>ID LC</strong></div></td>
			<td width="6%" valign="top"><div align="center"><strong>Suppr</strong></div></td>
		</tr>
		<%
		for(int i=0;i<lcc.length;i++){
		%>
		<tr>
			<td align="left" valign="top"><div align="left"><%=lcc[i].getRemarque()%></div></td>
			<input name="idLC<%=i%>" type="hidden" class="champ" value=<%=lcc[i].getId2()%>>
			<td align="right" valign="top"><div align="center"><%=lcc[i].getEtat()%></div></td>
			<td align="right" valign="top"><div align="center">
				<%if (lcc[i].estIlModifiable()==true) {%>
					<input name="montant<%=i%>" type="text" class="champ" value=<%=lcc[i].getMontantMere()%> >
				<%}
				else{%>
					<input name="montant<%=i%>" type="text" class="champ" value=<%=lcc[i].getMontantMere()%> disabled="disabled">
				<%}%>
				</div>
			</td>
			<td align="right"><div align="center"><a href="<%=lien %>?but=lc/visualiserDetailLC.jsp&numObjet=<%=lcc[i].getId2()%>"><%=lcc[i].getId2()%></a> </div></td>
			<td align="right"><div align="center"><a href="<%=lien %>?but=lc/updateLCJointure.jsp&idUnion=<%=lcc[i].getId()%>&acte=delete&numObjet=<%=lcc[i].getId1()%>">X</a> </div></td>
		</tr>
		<%
		}
		%>
	</table>
	<div align="center">
		<input type="hidden" name="acte" value="update">
		<input type="hidden" name="nb" value="<%=lcc.length%>">
		<input name="submit" type="submit" value="enregistrer" onClick="acte.value='update'">
		<input type="hidden" name="numObjet" value="<%=numObjet%>">
		<input type="hidden" name="montantObjet"  value="<%=bc[0].getMontantTTC() %>">
		<input type="hidden" name="typeObjet" value="<%=typeObjet%>">
		<input type="hidden" name="avecOp" value="<%=request.getParameter("avecOp")%>">
		<input name="submit" type="submit" value="valider" onClick="acte.value='svalide'">
		<input name="calculer" type="button" value="calculer" onClick='calculere(<%=lcc.length%>)'>
		<input name="total" type="text" value="0">
	</div>
</form>
  

