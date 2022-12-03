<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="crieur.*" %>
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
InvenducLib rv=new InvenducLib();
String etat="INVENDUCRTYPE";
//if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0) etat=request.getParameter("etat");
rv.setNomTable("INVENDUCRTYPE");
String listeCrt[]={"grossiste","nom","matricule","place","province","parution","daty","journal","type"};
String listeInt[]={"daty","parution"};
String libEntete[]={"id","nom","grossiste","journal","parution","daty","province","nombreinvendu","type"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/listeInvendu.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
Vendeur ve=new Vendeur();
liste[0]=new Liste("nom",ve,"surnom","surnom");
Journal jou=new Journal();
liste[1]=new Liste("journal",jou,"desce","val");
Grossiste g = new Grossiste();
liste[2]=new Liste("grossiste",g,"surnom","surnom");
pr.getFormu().changerEnChamp(liste);
String colSomme[]={"nombreinvendu"};

pr.creerObjetPage(libEntete,colSomme);
int maxparu=Utilitaire.getMaxNum("parution","numparution");
String id=request.getParameter("id"); if(id==null || id.compareToIgnoreCase("")==0) id="%";
String nom=request.getParameter("nom"); if(nom==null || nom.compareToIgnoreCase("")==0) nom="%";
String matricule=request.getParameter("matricule"); if(matricule==null || matricule.compareToIgnoreCase("")==0) matricule="%";
String place=request.getParameter("place"); if(place==null || place.compareToIgnoreCase("")==0) place="%";
String province=request.getParameter("province"); if(province==null || province.compareToIgnoreCase("")==0) province="%";
String numParution1=request.getParameter("parution1"); if(numParution1==null || numParution1.compareToIgnoreCase("")==0) numParution1="0";
String numParution2=request.getParameter("parution2"); if(numParution2==null || numParution2.compareToIgnoreCase("")==0) numParution2=Utilitaire.intToString(maxparu);
String daty1=request.getParameter("daty1"); if(daty1==null || daty1.compareToIgnoreCase("")==0) daty1="01/"+(Utilitaire.getMoisEnCours()+1)+"/"+Utilitaire.getAneeEnCours();
String daty2=request.getParameter("daty2"); if(daty2==null || daty2.compareToIgnoreCase("")==0) daty2="30/"+(Utilitaire.getMoisEnCours()+1)+"/"+Utilitaire.getAneeEnCours();
String journal=request.getParameter("journal"); if(journal==null || journal.compareToIgnoreCase("")==0) journal="%";
String type=request.getParameter("type"); if(type==null || type.compareToIgnoreCase("")==0) type="%";
String colonne=request.getParameter("colonne");if(colonne==null || colonne.compareToIgnoreCase("")==0) colonne="id";
String ordre=request.getParameter("ordre");if(ordre==null || ordre.compareToIgnoreCase("")==0) ordre="desc";

String apresWhere = "and id like '%"+id+"%' and nom like '%"+nom+"%' and place like '%"+place+"%' and province like '%"+province+"%' and journal like '%"+journal+"%' and type like '%"+type+"%' and daty between '"+daty1+"' and '"+daty2+"' and nombreinvendu >=0 and parution >= '"+numParution1+"' and  parution <= '"+numParution2+"' order by "+colonne+" "+ordre+"";

InvenducLib[] pf=(InvenducLib[])CGenUtil.rechercher(rv,null,null,apresWhere);
double lesMontants = rv.getAllSommeMontant(pf);
%>
<h1>Liste des saisies invendus</h1>
<form action="<%=pr.getLien()%>?but=crieur/listeInvendu.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<!--etat : <select name="etat" class="champ" id="etat" >
              <option value="INVENDULIBNONFACTURE"  <%if(etat.compareTo("INVENDULIBNONFACTURE")==0) out.println("selected");%>>non facture</option>
              <option value="INVENDULIBFACTURE"  <%if(etat.compareTo("INVENDULIBFACTURE")==0) out.println("selected");%>> facture</option>
              <option value="INVENDULIBTYPE">Tous</option>
</select>-->
</form>
<br>
<br/>
<table class="monographe" width="100%" border="0" align="center" cellspacing="3" cellpadding="3">
<tbody>
 <tr class="head">
  <td width="33%" valign="top" align="center"></td>
  <td width="33%" valign="top" align="center">Nombre</td>
  <td width="33%" valign="top" align="center">Somme invendu</td>
 </tr>
 <tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#EAEAEA'" style="">
  <td width="33%" align="center">Total</td>
  <td width="33%" align="center"><%=pf.length%></td>
  <td width="33%" align="center"><%=Utilitaire.arrondir(lesMontants,2)%></td>
 </tr>
</tbody>
</table>
<br/>
<br/>
<form method="post" name="e" action="<%=pr.getLien()%>?but=facture/factureInit.jsp">
<%if(etat.compareTo("INVENDULIBNONFACTURE")==0){%>
<input type='checkbox' id='cocheTout'/><span id='cocheText'>Tout cocher</span>&nbsp;&nbsp;&nbsp;
<input type="submit" value="Valider">
<%}%>
<br/>
<br>
<div id="divchck">
<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
   <tr>
     <td bgcolor="#66CCFF" align="center"><b>id</b></td>
     <td bgcolor="#66CCFF" align="center"><b>nom</b></td>
     <td bgcolor="#66CCFF" align="center"><b>journal</b></td>
     <td bgcolor="#66CCFF" align="center"><b>parution</b></td>
     <td bgcolor="#66CCFF" align="center"><b>daty</b></td>
     <td bgcolor="#66CCFF" align="center"><b>province</b></td>
     <td bgcolor="#66CCFF" align="center"><b>type</b></td>
     <td bgcolor="#66CCFF" align="center"><b>nombre invendu</b></td>
     <td bgcolor="#66CCFF" align="center"></td>
   </tr>
   <%for(int i=0;i<pf.length;i++){%>
        <tr>
           <td align="center"><a href="<%=pr.getLien()%>?but=crieur/ficheInvendu.jsp&id=<%=pf[i].getId()%>"><%=pf[i].getId()%></a></td>
           <td align="center"><%=pf[i].getNom()%></td>
           <td align="center"><%=pf[i].getJournal()%></td>
           <td align="center"><%=pf[i].getParution()%></td>
           <td align="center"><%=Utilitaire.datetostring(pf[i].getDaty())%></td>
           <td align="center"><%=pf[i].getProvince()%></td>
           <td align="center"><%=pf[i].getType()%></td>
           <td align="center"><%=pf[i].getNombreinvendu()%></td>
<%if(etat.compareTo("INVENDULIBNONFACTURE")==0){%>
           <td><!--<input type="checkbox" onclick="getChoixGazety(this)" name="<%=pf[i].getId()%>" value="<%=pf[i].getId()%>"/>-->
<input type="checkbox" id="checkbox<%=i%>" name="id" class="radio" value="<%=pf[i].getId()%>"/>
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
 <div align="center">
            <input type="hidden" name="acte" value="invendu">
            <input type="hidden" name="bute" value="crieur/listeInvendu.jsp">
     </div>
</form>
<%
//out.println(pr.getTableau().getHtml());
//out.println(pr.getBasPage());
%>
