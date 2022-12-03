<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="pub.*" %>
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
<%
RecetteLibelleType rv=new RecetteLibelleType();
String etat="RecetteLibellenonfacture";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
rv.setNomTable(etat);
String listeCrt[]={"id","nom","matricule","place","province","numParution","daty","montant","journal","type"};
String listeInt[]={"daty","numParution","montant"};
String libEntete[]={"id","daty","nom","matricule","journal","numParution","daty","montant"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeRecette.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
liste[0]=new Liste("nom",ve,"surnom","surnom");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"montant"};

pr.creerObjetPage(libEntete,colSomme);
int maxparu=Utilitaire.getMaxNum("parution","numparution");
String id=request.getParameter("id"); if(id==null || id.compareToIgnoreCase("")==0) id="%";
String nom=request.getParameter("nom"); if(nom==null || nom.compareToIgnoreCase("")==0) nom="%";
String matricule=request.getParameter("matricule"); if(matricule==null || matricule.compareToIgnoreCase("")==0) matricule="%";
String place=request.getParameter("place"); if(place==null || place.compareToIgnoreCase("")==0) place="%";
String province=request.getParameter("province"); if(province==null || province.compareToIgnoreCase("")==0) province="tana";
String numParution1=request.getParameter("numParution1"); if(numParution1==null || numParution1.compareToIgnoreCase("")==0) numParution1="0";
String numParution2=request.getParameter("numParution2"); if(numParution2==null || numParution2.compareToIgnoreCase("")==0) numParution2=Utilitaire.intToString(maxparu);
String daty1=request.getParameter("daty1"); if(daty1==null || daty1.compareToIgnoreCase("")==0) daty1=Utilitaire.dateDuJour();
String daty2=request.getParameter("daty2"); if(daty2==null || daty2.compareToIgnoreCase("")==0) daty2=Utilitaire.dateDuJour();
String montant1=request.getParameter("montant1"); if(montant1==null || montant1.compareToIgnoreCase("")==0) montant1="%";
String montant2=request.getParameter("montant2"); if(montant2==null || montant2.compareToIgnoreCase("")==0) montant2="%";

String journal=request.getParameter("journal"); if(journal==null || journal.compareToIgnoreCase("")==0) journal="%";
String type=request.getParameter("type"); if(type==null || type.compareToIgnoreCase("")==0) type="%";
String colonne=request.getParameter("colonne");if(colonne==null || colonne.compareToIgnoreCase("")==0) colonne="id";
String ordre=request.getParameter("ordre");if(ordre==null || ordre.compareToIgnoreCase("")==0) ordre="desc";

String apresWhere = "and id like '%"+id+"%' and nom like '%"+nom+"%' and place like '%"+place+"%' and province like '%"+province+"%' and journal like '%"+journal+"%' and type like '%"+type+"%' and daty between '"+daty1+"' and '"+daty2+"' and montant >0 and numParution >= '"+numParution1+"' and  numParution <= '"+numParution2+"' order by "+colonne+" "+ordre+"";
RecetteLibelleType[] pf=(RecetteLibelleType[])CGenUtil.rechercher(rv,null,null,apresWhere);

double lesMontants = rv.getAllSommeMontantRecette(pf);
//pr.preparerDataFormu();
%>
<h1>Liste des recettes</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/OrRecette.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
etat : <select name="etat" class="champ" id="etat" >

              <option value="RecetteLibellenonfacture"  <%if(etat.compareTo("RecetteLibellenonfacture")==0) out.println("selected");%>>recette non rattach&eacute; OP</option>
            <option value="RecetteLibellefacture"  <%if(etat.compareTo("RecetteLibellefacture")==0) out.println("selected");%>> recette rattach&eacute; OP</option>
           <option value="RecetteLibellePaye"  <%if(etat.compareTo("RecetteLibellePaye")==0) out.println("selected");%>> paye</option>
           <option value="RecetteLibellenonpaye"  <%if(etat.compareTo("RecetteLibellenonpaye")==0) out.println("selected");%>> impaye</option>
           <option value="RecetteLibelleType">Tous</option>
</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=ventegazety/ficheRecette.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
%>
<br/>
<table class="monographe" width="100%" border="0" align="center" cellspacing="3" cellpadding="3">
<tbody>
 <tr class="head">
  <td width="33%" valign="top" align="center"></td>
  <td width="33%" valign="top" align="center">Nombre</td>
  <td width="33%" valign="top" align="center">Somme de montant</td>
 </tr>
 <tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#EAEAEA'" style="">
  <td width="33%" align="center">Total</td>
  <td width="33%" align="center"><%=pf.length%></td>
  <td width="33%" align="center"><%=lesMontants%></td>
 </tr>
</tbody>
</table>
<br/>
<br/>
<input type='checkbox' id='cocheTout'/><span id='cocheText'>Tout cocher</span>&nbsp;&nbsp;&nbsp;
<br/>
<br/>
<form method="post" name="e" action="<%=pr.getLien()%>?but=ded/ordonnerRecetteDist.jsp">
<%if(etat.compareTo("RecetteLibellenonfacture")==0){%>
 <div align="center">
            <input type="hidden" name="daty" value="<%=daty1%>">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="pub">
            <input type="hidden" name="bute" value="ventegazety/OrRecette.jsp">
     </div>
<%}%>
<div id="divchck">
<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
   <tr>
     <td bgcolor="#66CCFF" align="center"><b>id</b></td>
     <td bgcolor="#66CCFF" align="center"><b>daty</b></td>
     <td bgcolor="#66CCFF" align="center"><b>nom</b></td>
     <td bgcolor="#66CCFF" align="center"><b>journal</b></td>
     <td bgcolor="#66CCFF" align="center"><b>numparution</b></td>
     <td bgcolor="#66CCFF" align="center"><b>type</b></td>
     <td bgcolor="#66CCFF" align="center"><b>montant</b></td>
     <td bgcolor="#66CCFF" align="center"></td>
   </tr>
   <%for(int i=0;i<pf.length;i++){%>
        <tr>
           <td align="center"><a href="<%=pr.getLien()+"?but=ventegazety/ficheRecette.jsp&id="+pf[i].getId()%>"><%=pf[i].getId()%></a></td>
           <td align="center"><%=Utilitaire.datetostring(pf[i].getDaty())%></td>
           <td align="center"><%=pf[i].getNom()%></td>
           <td align="center"><%=pf[i].getJournal()%></td>
           <td align="center"><%=pf[i].getNumparution()%></td>
           <td align="center"><%=pf[i].getType()%></td>
           <td align="center"><%=(int)pf[i].getMontant()%></td>
<%if(etat.compareTo("RecetteLibellenonfacture")==0){%>
           <td><input id="checkbox<%=i%>" name="choix" class="radio"  type="checkbox" value="<%=pf[i].getId()%>"/>
                </td>
           <%}else{%>
  <td></td>

            <% }
}%>
        </tr>
</table>
</div>
<div><input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
            <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></div>

</form>

