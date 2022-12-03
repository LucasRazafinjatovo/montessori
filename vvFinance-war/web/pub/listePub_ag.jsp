<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="facture.*" %>
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
<%
try
{
Pucomplet p=new Pucomplet();
String etat="PUBCOMPLETNONOR";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"id","idclient","idCat","libAgence","designation","libJournal","idMont","couleur","numParution","pagemisyazy","formulaire","montantVal","datyparution"};
String listeInt[]={"numParution","pagemisyazy","formulaire","montantVal","datyparution"};
String libEntete[]={"id","libClient","idMont","numParution","datyParution","montantVal","libAgence"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listePub_ag.jsp");
pr.setNpp(60);
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[0]=new Liste("idCat",to);
Client to1=new Client();
to1.setNomTable("client");
liste[1]=new Liste("idclient",to1,"nom","idclient");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("format",6);
pr.getFormu().getChamp("idclient").setLibelle("client");
//String libAffiche[]={"id","libClient","format","numParution","datyParution","montantVal","libAgence"};
String colSomme[]={"montantVal"};
pr.creerObjetPage(libEntete,colSomme);
Pucomplet[] pf=(Pucomplet[])pr.getRs().getResultat();
//pr.getTableau().setLibelleAffiche(libAffiche);
%>
<h1>Liste des pubicites</h1>
<form action="<%=pr.getLien()%>?but=pub/listePub_ag.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="PUBCOMPLETNONOR"  <%if(etat.compareTo("PUBCOMPLETNONOR")==0) out.println("selected");%>>Pub non OR</option>
              <option value="PUBCOMPLETAVECOR"  <%if(etat.compareTo("PUBCOMPLETAVECOR")==0) out.println("selected");%>> Pub deja OR</option>
              <option value="PubComplet">Tous</option>
</select>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=pub/fichePub.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());
%>
<br>
<form method="post" name="e" action="<%=pr.getLien()%>?but=pub/apresPub.jsp">
	<div id="divchck">
	<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
	<tr>
     <td bgcolor="#66CCFF" align="center"><b>id</b></td>
     <td bgcolor="#66CCFF" align="center"><b>libClient</b></td>
     <td bgcolor="#66CCFF" align="center"><b>idMont</b></td>
     <td bgcolor="#66CCFF" align="center"><b>Journal</b></td>
     <td bgcolor="#66CCFF" align="center"><b>numParution</b></td>
     <td bgcolor="#66CCFF" align="center"><b>datyParution</b></td>
     <td bgcolor="#66CCFF" align="center"><b>montantVal</b></td>
     <td bgcolor="#66CCFF" align="center"><b>libAgence</b></td>
     <td bgcolor="#66CCFF" align="center"><b>daty</b></td>
     <td bgcolor="#66CCFF" align="center"><input type="checkbox" id="cocheTout"></td>
	</tr>
	<%for(int i=0;i<pf.length;i++){%>
	<tr>
		<td align="center"><a href="<%=pr.getLien()%>?but=pub/fichePub.jsp&id=<%=pf[i].getId()%>"><%=pf[i].getId()%></a></td>
		<td align="center"><%=pf[i].getLibClient()%></td>
		<td align="center"><%=pf[i].getIdMont()%></td>
		<td align="center"><%=pf[i].getLibJournal()%></td>
		<td align="center"><%=pf[i].getNumParution()%></td>
		<td align="center"><%=Utilitaire.datetostring(pf[i].getDatyParution())%></td>
		<td align="center"><%=pf[i].getMontantVal()%></td>
		<td align="center"><%=pf[i].getLibAgence()%></td>
		<td align="center"><%=Utilitaire.datetostring(pf[i].getDatycloture())%></td>
		<%if(etat.compareTo("PUBCOMPLETNONOR")==0){%>
		<td><input type="checkbox" id="checkbox<%=i%>" onclick="getChoixGazety(this)" name="id" value="<%=pf[i].getId()%>"/></td>
		<%}else{%>
		<td></td>
		<% }
	}%>
	</tr>
</table>
<div><input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
            <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></div>
<%if(etat.compareTo("PUBCOMPLETNONOR")==0){%>
 <div align="center">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="pubor">
            <input type="hidden" name="bute" value="pub/listePub_ag.jsp">
     </div>
<%}%>
</div>
</form>
<%//out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
