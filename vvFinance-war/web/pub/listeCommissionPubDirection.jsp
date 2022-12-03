<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<link href="../style/style.css" rel="stylesheet" type="text/css">
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
 UserEJB u=(user.UserEJB)session.getValue("u");
String lien=(String)session.getValue("lien");
PubFactPaye p=new PubFactPaye();
String etat="pubfactnonopdirection";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
System.out.print(etat);
p.setNomTable(etat);
String listeCrt[]={"idop","factclient","client","numcompte","mois","annee"};
String listeInt[]={"mois"};
String libEntete[]={"factclient","numcompte","client","designation","montant","paye","commission"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/listeCommissionPubDirection.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
TypeObjet to=new TypeObjet();
to.setNomTable("commercialactif");
liste[0]=new Liste("numcompte",to,"val","val");
liste[1]=new Liste("mois1");
((Liste)(liste[1])).makeListeMois();
liste[2]=new Liste("mois2");
((Liste)(liste[2])).makeListeMois();
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","libClient","format","numParution","datyParution","montantVal","libAgence"};
String colSomme[]={"montant","paye","commission"};
pr.creerObjetPage(libEntete,colSomme);
PubFactPaye[] pf=(PubFactPaye[])pr.getRs().getResultat();
//pr.getTableau().setLibelleAffiche(libAffiche);
%>
<br/><br/>
<h2><a href="<%=lien%>?but=pub/listeCommissionPub.jsp">Commission 10%</a></h2>
<h1>Liste commission direction par pub par commercial</h1>
<form action="<%=lien%>?but=pub/listeCommissionPubDirection.jsp"  method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >
              <option value="pubfactnonopdirection"  <%if(etat.compareTo("pubfactnonopdirection")==0) out.println("selected");%>>commission 1% sans op</option>
              <option value="pubfactpayedirection" <%if(etat.compareTo("pubfactpayedirection")==0) out.println("selected");%>>commission 1% paye</option>
              <option value="pubfactnonpayedirection" <%if(etat.compareTo("pubfactnonpayedirection")==0) out.println("selected");%>>commission 1% non paye</option>

</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form method="post" name="e" action="modeleAdmin.jsp?but=pub/ordonnerPayementPub.jsp">
<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
   <tr>
     <td bgcolor="#66ccff" align="center"><b>fact client</b></td>
     <td bgcolor="#66ccff" align="center"><b>numcompte</b></td>
     <td bgcolor="#66ccff" align="center"><b>client</b></td>
     <td bgcolor="#66ccff" align="center"><b>designation</b></td>
     <td bgcolor="#66ccff" align="center"><b>montant</b></td>
     <td bgcolor="#66ccff" align="center"><b>paye</b></td>
     <td bgcolor="#66ccff" align="center"><b>commission 1% par pub</b></td>
<%if(etat.compareTo("pubfactpayedirection")==0 || etat.compareTo("pubfactnonpayedirection")==0){%>
     <td bgcolor="#66ccff" align="center"><b>idop</b></td>
<%}%>
     <td bgcolor="#66ccff" align="center"></td>
   </tr>
<%if(pf.length!=0){%>
   <%for(int i=0;i<pf.length;i++){%>
        <tr>
           <td align="center"><a title="fact numero <%=pf[i].getFactclient()%>" href="<%=lien%>?but=facture/visualiserFactureClient.jsp&idFactureFournisseur=<%=pf[i].getFactclient()%>"><%=pf[i].getFactclient()%></a></td>
           <td align="center"><%=pf[i].getNumcompte()%></td>
           <td align="center"><%=pf[i].getClient()%></td>
           <td align="center"><%=pf[i].getDesignation()%></td>
           <td align="center"><%=pf[i].getMontant()%></td>
           <td align="center"><%=pf[i].getPaye()%></td>
           <td align="center"><%=pf[i].getCommission()%></td>
<%if(etat.compareTo("pubfactpayedirection")==0 || etat.compareTo("pubfactnonpayedirection")==0){%>
           <td align="center"><a title="fact numero <%=pf[i].getIdop()%>" href="<%=lien%>?but=ded/visualiserOP.jsp&id=<%=pf[i].getIdop()%>"><%=pf[i].getIdop()%></a></td>
<%}%>
<%if(etat.compareTo("pubfactnonopdirection")==0 || etat.compareTo("PUBFACTNONOPDIRECTION10")==0){%>
           <td><input type="checkbox" onclick="getChoixGazety(this)" name="<%=pf[i].getFactclient()%>" value="<%=pf[i].getFactclient()%>"/>
                </td>
           <%}else{%>
  <td></td>

            <% }
}%>
        </tr>
</table>
<div><input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
<input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></div>
<input name="numcompte" id="numcompte" class="submit" type="hidden" value="<%=pf[0].getNumcompte()%>"></div>
<input name="lmoisd" id="lmoisd" class="submit" type="hidden" value="<%=request.getParameter("mois1")%>/<%=request.getParameter("annee")%>"></div>
<input name="lmoisf" id="lmoisf" class="submit" type="hidden" value="<%=request.getParameter("mois2")%>/<%=request.getParameter("annee")%>"></div>
<%if(etat.compareTo("pubfactnonopdirection")==0 || etat.compareTo("PUBFACTNONOPDIRECTION10")==0){%>
 <div align="center">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="insert">
            <input type="hidden" name="pourcentage" value="1">
            <input type="hidden" name="bute" value="pub/listeCommissionPubDirection.jsp">
     </div>
<%}
}%>
</form>
<%
//out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
