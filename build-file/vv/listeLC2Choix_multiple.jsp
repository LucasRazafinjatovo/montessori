<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="affichage.*" %>
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
	LigneCreditComplet temp = new LigneCreditComplet();
	temp.setNomTable("LigneCreditComplet");
	
	LigneCreditComplet []lclist = null;
	String apres = "finance/listeSortie.jsp";
	String lien= null;
	UserEJB u = null;
	u = (user.UserEJB)session.getValue("u");
    lien = (String)session.getValue("lien");
	String mois[] = Constante.getMois();
    String moisRang[] = Constante.getMoisRang();
	int anneeEnCours = Utilitaire.getAneeEnCours();
	
	String designation	= request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
	String mois1 = request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= String.valueOf(Utilitaire.getMoisEnCours());
	String mois2 = request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= String.valueOf(Utilitaire.getMoisEnCours());
	String annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
	String abbrevdir = request.getParameter("direction");if ((abbrevdir==null)||abbrevdir.compareTo("")==0) abbrevdir = "DREAL";
	String idType = request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
	String entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
	
	try{
        lclist = LigneCreditComplet.getResultat(designation,mois1,mois2,annee,idType,abbrevdir,entite);
	}
	catch (Exception e){
		%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
	}
%>
<link href="style/style.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les lignes cr&eacute;dit</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche concernant les lignes cr&eacute;dit)</p>
<form action="listeLC2Choix_multiple.jsp?champReturn=<%=request.getParameter("champReturn")%>" method="post" name="listeLC" id="listeLC">
	<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
		<tr>
			<td> 
				<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
					<tr>
						<td class="left">D&eacute;signation :</td>
						<td> <input name="designation" type="text" class="champ" id="designation" value="<%=designation%>"></td>
						<td class="left" valign="top">Ann&eacute;e:</td>
						<td align="left"> 
							<select name="annee" class="champ" id="annee">
								<option value="%">Tous</option>
								<%
								if(annee.compareTo("%")==0) annee=String.valueOf(anneeEnCours);
								for(int i=0;i<3;i++){
									%>
									<option <% if(Integer.parseInt(annee) == (anneeEnCours+1 - i)) out.println("selected");%>><%= (anneeEnCours+1 - i) %></option>
									<%
								}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td class="left">Mois 1:</td>
						<td >
							<select name="mois1" class="champ" id="mois1">
								<option value="%">Tous</option>
								<%
								for(int i=0;i<mois.length;i++){
									%>
									<option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois1)==0)out.print(" selected");%>><%=mois[i]%></option>
									<%
								}
								%>
							</select></td>
						<td class="left">Mois 2:</td>
						<td>
							<select name="mois2" class="champ" id="mois2">
								<option value="%">Tous</option>
								<%
								for(int i=0;i<mois.length;i++){
									%>
									<option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois2)==0)out.print(" selected");%>><%=mois[i]%></option>
									<%
								}
								%>
							</select></td>
					</tr>
					<tr>
						<td class="left">Direction:</td>
						<td>
							<select name="direction" class="champ" id="select2">
								<option value="%">Tous</option>
								<option value="dir info"> dir info </option>
								<option value="Log"> Log</option>
								<option value="d speed">d speed</option>
								<option value="DGA">DGA</option>
								<option value="DCOMMUN"> DCOMMUN</option>
								<option value="DG">DG</option>
								<option value="DREAL">DREAL</option>
								<option value="DFIN">DFIN</option>
								<option value="D Dist">D Dist</option>
								<option value="DRH">DRH</option>
								<option value="DPROJET"> DPROJET</option>
								<option value="redaction">redaction</option>
								<option value="PAuto"> PAuto</option>
								<option value="DMRKT"> DMRKT</option>
								<option value="Dprod- art"> Dprod- art </option>
						 </select></td>
						<td class="left">Entit&eacute;:</td>
						<td>
							<select name="entite" class="champ" id="select">
								  <option value="%">Tous</option>
								  <option value="activa">activa</option>
								  <option value="autres">autres</option>
								  <option value="A2A">A2A</option>
								  <option value="baovola">baovola</option>
								  <option value="BASY VAVA">BASY VAVA</option>
								  <option value="Blagy soir">Blagy soir</option>
								  <option value="Buvette ITU">Buvette ITU</option>
								  <option value="CNAPMAD ">CNAPMAD </option>
								  <option value="couple">couple</option>
								  <option value="Dist">Dist</option>
								  <option value="echo">echo</option>
								  <option value="Ecole Sa">Ecole Sa</option>
								  <option value="fahazavana  ">fahazavana  </option>
								  <option value="Foire VV">Foire VV</option>
								  <option value="gazety toamasina">gazety toamasina</option>
								  <option value="groupe">groupe</option>
								  <option value="HASINA">HASINA</option>
								  <option value="Hey ladies">Hey ladies</option>
								  <option value="IT Univ">IT Univ</option>
								  <option value="JB">JB</option>
								  <option value="JJ">JJ</option>
								  <option value="JREWS Info">JREWS Info</option>
								  <option value="JREWS R">JREWS R</option>
								  <option value="Le Dimanche">Le Dimanche</option>
								  <option value="Malaza">Malaza</option>
								  <option value="Marchés Publics">Marchés Publics</option>
								  <option value="Marque  jejoo">Marque  jejoo</option>
								  <option value="Nation">Nation</option>
								  <option value="o2">o2</option>
								  <option value="PATRIOTE">PATRIOTE</option>
								  <option value="PrintParts">PrintParts</option>
								  <option value="RITSOKA">RITSOKA</option>
								  <option value="RN7">RN7</option>
								  <option value="Speed ">Speed </option>
								  <option value="Sport">Sport</option>
								  <option value="tahina">tahina</option>
								  <option value="The news">The news</option>
								  <option value="Times">Times</option>
								  <option value="Tklk">Tklk</option>
								  <option value="TRIBUNE">TRIBUNE</option>
								  <option value="TT">TT</option>
								  <option value="Vaovaontsika">Vaovaontsika</option>
								  <option value="vraie marque">vraie marque</option>
								  <option value="VS">VS</option>
								  <option value="VV">VV</option>
								  <option value="Yes">Yes</option>
								  <option value="2Foire VV">2Foire VV</option>
								  <option value="3FoireVV">3FoireVV</option>
								  <option value="4foireVV">4foireVV</option>
								  <option value="6 foire">6 foire</option>
							</select>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		<tr>
			<td height="30" align="center"> 
				<table width="75%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"> <input type="submit" name="Submit" value="Lister" class="submit"></td>
						<td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit"></td>
					</tr>
			</table></td>
		</tr>
  </table>
</form>
<h1>Liste ligne credit</h1>
<script type="text/javascript">
	function getChoix(){
		setTimeout("document.frmchx.submit()",800);
	}
</script>

<br>
<form action="apresLcChoix.jsp" methode="POST" name="frmchx" id="frmchx">
	<input type="hidden" name="champReturn" value="<%=request.getParameter("champReturn")%>">

	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
		<tr class="head">
			<td width="5%" align="center" valign="top"><input type="checkbox" name="full_check" id="full_check" onchange="checkBoxer(this,<%=lclist.length%>)"></td>
			<td align="center" valign="top">Designation</td>
			<td width="23%" align="center" valign="top">Crédit</td>
			<td width="26%" align="center" valign="top">Entite</td>
			<td width="26%" align="center" valign="top">Mois</td>
			<td width="26%" align="center" valign="top">Ann&eacute;e</td>
			<td width="26%" align="center" valign="top">Direction</td>
			<td width="26%" align="center" valign="top">Type</td>
		</tr>
		<% 
		for(int i=0;i<lclist.length;i++)
		{
		%>
		<tr>
			<td align="center" valign="top"><input type="checkbox" value="<%=lclist[i].getIdLigne()%>" name="identifiant<%=i%>" id="identifiant<%=i%>" ></td>
			<td align="center"><%=lclist[i].getDesignation() %></td>
			<td align="center"><%=lclist[i].getCreditInitial() %></td>
			<td align="center"><%=lclist[i].getEntite() %></td>
			<td align="center"><%=lclist[i].getMois()+1 %></td>
			<td align="center"><%=lclist[i].getAnnee() %></td>
			<td align="center"><%=lclist[i].getAbbrevdir() %></td>
			<td align="center"><%=lclist[i].getTypeLC() %></td>
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
						<td align="center"> <input type="hidden" name="taille_tableau" value="<%=lclist.length%>" /></td>
					</tr>
			</table></td>
		</tr>
	</table>
</form>
