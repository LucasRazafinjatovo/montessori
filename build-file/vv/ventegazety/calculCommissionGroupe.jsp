<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="java.sql.*" %>
<%!
String apres="ventegazety/calculCommissionGroupe.jsp";
String[] id;
Etatvente e=null;
Etatvente[] lec1=null;
Etatvente[] lec=null;
Etatvente[] let=null;
Etatvente[] les=null;
String lien= null;
UserEJB u = null;
int nbrechoix1=0;
int pazy=0;
int nbPage;
String requete=null;
String suivant="";
double sumnbreprise=0,sumvente=0,summontant=0,sumrecette=0,sumcommission=0;
String[] nomCol;
String nomjournal,vendeur,daty1,daty2,province,type,place,colonne,ordre,nbrechoix,matricule;
Vendeur ve=null;
Vendeur[] lve=null;
%>
<%
e = new Etatvente();
e.setNomTable("etatvente");
String[] liste={"nbreprise","vente","montant","recette","totalcommission"};
if (request.getParameter("pazy")==null)
{
	pazy=1;
}
else
{
	pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
}
try{
	u = (UserEJB)session.getValue("u");
	lien = (String)session.getValue("lien");
	vendeur = request.getParameter("vendeur"); if(vendeur==null || vendeur.compareTo("")==0) vendeur="%";
	daty1 = request.getParameter("daty1"); if(daty1== null || daty1.compareTo("")==0) daty1="";
	daty2 = request.getParameter("daty2"); if(daty2==null || daty2.compareTo("")==0) daty2="";
	province = request.getParameter("province"); if(province==null || province.compareTo("")==0) province="%";
	type = request.getParameter("type"); if(type==null || type.compareTo("")==0) type="%";
	place = request.getParameter("place"); if(place==null || place.compareTo("")==0) place="%";
	colonne = request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="daty";
	ordre = request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
	nbrechoix = request.getParameter("nombrechoix");if(nbrechoix==null) nbrechoix="0";
	nomjournal = request.getParameter("nomjournal");if(nomjournal==null || nomjournal.compareTo("")==0) nomjournal="%";
	nbrechoix1 = Utilitaire.stringToInt(nbrechoix);
	id = new String[nbrechoix1];
	id = Utilitaire.split(nomjournal,",");
	nomCol = Utilitaire.getNomColonne(new Prisejournallib());
	lec = (Etatvente[])CGenUtil.rechercher(e,null,null," and vendeur = '"+vendeur+"' and daty between '"+daty1+"' and '"+daty2+"' and journal = '%' and place = '"+place+"' and province = '"+province+"' and type = '"+type+"' order by "+colonne+" "+ordre  );
	if(nbrechoix1==0) {
		lec = (Etatvente[])CGenUtil.rechercher(e,null,null," and upper(vendeur) like upper('"+vendeur+"') and daty between '"+daty1+"' and '"+daty2+"' and upper(journal) like upper('"+nomjournal+"') and upper(place) like upper('"+place+"') and upper(province) like upper('"+province+"') and upper(type) like upper('"+type+"') order by "+colonne+" "+ordre  );
	}
	else{
		sumnbreprise = 0;
		sumvente = 0;
		summontant = 0;
		sumrecette = 0;
		sumcommission = 0;

		for(int m = 0;m<nbrechoix1;m++){
			lec1 = (Etatvente[])CGenUtil.rechercher(e,null,null," and upper(vendeur) like upper('"+vendeur+"') and daty between '"+daty1+"' and '"+daty2+"' and upper(journal) like upper('"+id[m]+"') and upper(place) like upper('"+place+"') and upper(province) like upper('"+province+"') and upper(type) like upper('"+type+"') order by "+colonne+" "+ordre  );
	
	
	
			let = Utilitaire.concatener(lec,lec1);
			lec = let;
			les = (Etatvente[])CGenUtil.rechercherSommeIntegrale(e,null,null," and upper(vendeur) like upper('"+vendeur+"') and daty between '"+daty1+"' and '"+daty2+"' and upper(journal) like upper('"+id[m]+"') and upper(place) like upper('"+place+"') and upper(province) like upper('"+province+"') and upper(type) like upper('"+type+"') order by "+colonne+" "+ordre , liste );
	
	
	
			sumnbreprise = sumnbreprise+les[0].getNbreprise();
			sumvente = sumvente+les[0].getVente();
			summontant = summontant+les[0].getMontant();
			sumrecette = sumrecette+les[0].getRecette();
			sumcommission = sumcommission+les[0].getTotalcommission();
		}
	}
	ve = new Vendeur();
	lve = (Vendeur[])CGenUtil.rechercher(ve,null,null," order by nom");
	nbPage = Utilitaire.calculNbPage(lec);
	suivant = "&vendeur="+Utilitaire.remplacePourcentage(vendeur)+"&province="+Utilitaire.remplacePourcentage(province)+"&daty1="+daty1+"&type="+Utilitaire.remplacePourcentage(type)+"&place="+Utilitaire.remplacePourcentage(place)+"&nomjournal="+nomjournal+"&nbrechoix="+nbrechoix+"&daty2="+daty2+"&colonne="+colonne+"&ordre="+ordre;
}
catch(Exception e){
	e.printStackTrace(); %>
	<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
	return;
}%>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
  $(document).ready(function() {
      $('#cocheTout').click(function() {

          var cases = $("#divchck").find(':checkbox');
          if(this.checked){
              cases.attr('checked', true);
              $('#cocheText').html('Tout decocher');
          }else{
              cases.attr('checked', false);
              $('#cocheText').html('Tout cocher');
          }

      });

});
</script>
<script type="text/javascript">
function validation(){
   return confirm("Valider les donnees");
}
var $namesJournal = [];
var nombrechoix =0;
function getChoixGazety(element){

  $name = $(element).attr("name");
  if( $('input[name='+$name+']').is(':checked')){
    //$nombrechoix = parseInt($('#nombrechoix').val())
    $nombrechoix = parseInt($('#nombrechoix').val())+ 1;
    $namesJournal.push(element.name);
  }else{
    $namesJournal = [];
    $('#mydiv input:checked').each(function() {
           $namesJournal.push(this.name);
    });
     $nombrechoix =  $nombrechoix - 1;
         $('#nomjournal').val($namesJournal);
  }
  $('#nomjournal').val("");
  $('#nombrechoix').val($nombrechoix);
  $('#nomjournal').val($namesJournal);
}
</script>
<!-- FIN LISTE SELECTIONNE-->
<h1>&nbsp;</h1>
<h1>Lister commission groupe</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les commissions)</p>
<form action="<%=lien%>?but=ventegazety/calculCommissionGroupe.jsp" method="post" name="commission" id="commission">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2" class="monographe">
           <tr>
             <td class="left" width='120' height='10'>Vendeur :</td>
            <td> <select name="vendeur" class="champ" id="vendeur" width='120' height='10'>
                <option value="">Tous</option>
                <%
for(int i=0;i<lve.length;i++){
%>
                <option value="<%=lve[i].getNom()%>"><%=lve[i].getNom()%></option>
                <%
}
%>
              </select></td>
              <td class="left" width='120' height='10'>Place:</td>
              <td width='120' height='10'><input name="place" type="text" class="champ" id="place" size="10" value="<%=place%>"></td>
              <td class="left" width='120' height='10'>Province:</td>
              <td width='120' height='10'><input name="province" type="text" class="champ" id="province" size="10" value="<%=province%>"></td>

          </tr>
          <tr>
            <td class="left" width='120' height='10'>Type:</td>
            <td width='120' height='10'><input name="type" type="text" class="champ" id="province" size="10" value="<%=type%>"></td>
            <td class="left" width='120' height='10'>Date 1:</td>
            <td width='120' height='10'><input name="daty1" type="text" class="champ" id="daty1" size="10" value="<%=daty1%>"></td>
            <td class="left" width='120' height='10'>Date 2:</td>
            <td width='120' height='10'><input name="daty2" type="text" class="champ" id="daty2" size="10" value="<%=daty2%>"></td>
          </tr>
          <tr>
            <td class="left" width='120' height='10'>Journal:</td>
            <td width='160' id="mydiv" height='10'><input name="JJ" type="checkbox" value="JJ" onclick="getChoixGazety(this)">JJ<input name="VV" type="checkbox" value="VV" onclick="getChoixGazety(this)">VV
            <input name="JB" type="checkbox" value="JB" onclick="getChoixGazety(this)">JB<input name="TT" type="checkbox" value="TT" onclick="getChoixGazety(this)">TT
            <input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
            <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></td>
           </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"><strong><font color="#FF0000" size="1">TRIER
        PAR </font></strong></td>
    </tr>
    <tr>
      <td height="30" align="center"><table width="100%">
          <tr>
            <td >Colonne :</td>
            <td align="center"> <select id="colonne" class="champ" name="colonne">
                <%
                  for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
                <%
                  }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
            <td ><div align="center">Ordre :</div></td>
            <td align="center"> <select id="ordre" class="champ" name="ordre">
                <option value="ASC">ASC</option>
                <option value="DESC">DESC</option>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
     <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Lister" class="submit">
            </td>
            <td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>

<!--RECAPITULATION-->
<h1>&nbsp;</h1>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr class="head">
          <td width="14%" align="right" height="30"><strong></strong></td>
          <td width="14%" align="center" height="30">Somme de nbreprise</td>
          <td width="14%" align="center" height="30">Somme de nbrevente</td>
          <td width="14%" align="center" height="30">Somme de totalcommission</td>
          <td width="14%" align="center" height="30">Somme de montant</td>
          <td width="14%" align="center" height="30">Somme de recette</td>
        </tr>
        <tr>
          <td width="14%" align="right" height="30">Total</td>
          <td width="14%" align="center" height="30"><%=sumnbreprise%></td>
          <td width="14%" align="center" height="30"><%=sumvente%></td>
          <td width="14%" align="center" height="30"><%=sumcommission%></td>
          <td width="14%" align="center" height="30"><%=summontant%></td>
          <td width="14%" align="center" height="30"><%=sumrecette%></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
 <br />
<!--FIN RECAPITULATION-->

<!--DEBUT LISTE JOURNAL CHOIX-->
<h1>&nbsp;</h1>

    <p align="center"><strong><u>LISTE</u></strong></p>
	<div id="divchck">
<form method="post" name="e" action="<%=lien%>?but=pub/apresPub.jsp">
	<input type="submit" value="Valider">
     <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
       <!--DWLayoutTable-->
       <tr class="head">
           <td width="14%" height="30" align="center" valign="top"><strong>Daty</strong></td>
           <td width="7%" height="30" align="center" valign="top"><strong>Journal</strong></td>
           <td width="14%" height="30" align="center" valign="top"><strong>Vendeur</strong></td>
           <td width="14%" height="30" align="center" valign="top"><strong>Matricule</strong></td>
           <td width="10%" height="30" align="center" valign="top"><strong>Prise</strong></td>
           <td width="10%" height="30" align="center" valign="top"><strong>Vente</strong></td>
           <td width="14%" height="30" align="center" valign="top"><strong>Montant</strong></td>
           <td width="14%" height="30" align="center" valign="top"><strong>Recette</strong></td>
           <td width="14%" height="30" align="center" valign="top"><strong>Reste</strong></td>
           <td width="14%" height="30" valign="top"><div align="center"><strong>Commission</strong></div></td>
           <td height="30" ><input type='checkbox' id='cocheTout'/></td>
       </tr>
       <%
	for(int i=0;i<lec.length;i++){
	%>
		<tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''" width="14%" height="30">
			<td align="center" valign="top"><%=Utilitaire.datetostring(lec[i].getDaty())%></td>
			<td align="center" valign="top"><%=lec[i].getJournal()%></td>
			<td align="center" valign="top"><%=lec[i].getVendeur()%></td>
			<td align="center" valign="top"><%if(lec[i].getMatricule()==null)matricule=""; else matricule=lec[i].getMatricule();%><%=matricule%></td>
			<td align="center" valign="top"><%=lec[i].getNbreprise()%></td>
			<td align="center" valign="top"><%=lec[i].getVente()%></td>
			<td align="center" valign="top"><%=lec[i].getMontant()%></td>
			<td align="center" valign="top"><%=lec[i].getRecette()%></td>
			<td align="center" valign="top"><%=lec[i].getReste()%></td>
			<td align="center" valign="top"><%=lec[i].getTotalcommission()%></td>
			<td align="center" valign="top"><input type="checkbox" id="checkbox<%=i%>" name="idcomm" value="<%=lec[i].getId().trim()%>"></td>
		</tr>
		<%
	}
	%>
     </table>
            <input type="hidden" name="acte" value="commissiongroupe">
            <input type="hidden" name="bute" value="ventegazety/calculCommissionGroupe.jsp">
    
</form></div>
   <br />
