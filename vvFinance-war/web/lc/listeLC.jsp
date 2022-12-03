<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/listeSortie.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
        String mois[] = {"Janvier","Février","Mars","Avril","Mai","Juin",
        		"Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};

        TypeObjet source[] = null;
        TypeObjet tlc[] = null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
		Direction dir[] = null;
        LigneCreditComplet lcc[]= null;
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
		String numCompte = null;
		String colonne = null;
		String mois2=null;
		String sender=null;

		int pazy=0;
	   int nbParPazy=Parametre.getNbParPage();
	   int indiceDebut=0;
	   int indiceFin=Parametre.getNbParPage();
	   int nbPage=0;
%>
<%
  sender = request.getParameter("sender");if ((sender==null)||sender.compareTo("")==0) sender="LC";
  nomCol=Utilitaire.getNomColonne(new LigneCredit());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idLigne";
  mois2=request.getParameter("mois");if ((mois2==null)||mois2.compareTo("")==0) mois2= "Janvier";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  idType=request.getParameter("idType");
  if(sender.compareToIgnoreCase("LC")==0)
	  if ((idType==null)||idType.compareTo("")==0) idType="%";
  if(sender.compareToIgnoreCase("entree")==0) idType="Recette";
  if(sender.compareToIgnoreCase("sortie")==0) idType="Dépense";

  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }

 %>
<%

try{

	u=(user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
	source = u.findTypeObjet("Beneficiaire","%","%");
	tlc = u.findTypeObjet("TypeLigneCredit","%","%");
	compte = u.findTypeObjet("comptecompta","%","%");
	dir = u.findDirection("","","","","");

	lcc = u.findLCComplet(idLC,designation,mois2,idType,numCompte,"","","",entite,direction,colonne,ordre, annee,"lignecreditrecettecomplet");
	indiceDebut=Utilitaire.getBornePage(pazy,lcc)[0];
	indiceFin=Utilitaire.getBornePage(pazy,lcc)[1];
	nbPage=Utilitaire.calculNbPage(lcc);

}
catch (Exception e){
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
<h1>Lister les lignes cr&eacute;dit</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les lignes cr&eacute;dit)</p>
<form action="listeLC.jsp" method="post" name="listeLC" id="listeLC">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
           <tr>
            <td class="left">D&eacute;signation :</td>
            <td> <input name="designation" type="text" class="champ" id="designation" value="<%=designation%>"></td>
            <td class="left">Num&eacute;ro LC:</td>
            <td> <input name="idLC" type="text" class="champ" id="idLC" size="10" value="<%=idLC%>"></td>
          </tr>
          <tr>
            <td class="left">Mois:</td>
            <td ><select name="mois" class="champ">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<mois.length;i++){
          %>
                <option <%if(mois[i].compareTo(mois2)==0)out.print(" selected");%>><%=mois[i]%></option>
                <%
                }
                %>
              </select></td>
            <td class="left">Direction: </td>
            <td> <select name="direction" class="champ" id="direction">
            <option value="%">Tous</option>
                <%
for(int i=0;i<dir.length;i++){
%>
                <option value="<%=dir[i].getIdDir()%>" <%if(dir[i].getIdDir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getAbbrevDir()%></option>
                <%
}
%>
              </select>
               </td>
          </tr>
          <tr>
            <td class="left" valign="top">Ann&eacute;e:</td>
            <td align="left"> <select name="annee" class="champ" id="annee">
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
            <td class="left">Entit&eacute;:</td>
            <td align="center"> <div align="left">

 <select name="entite" class="champ" id="entite">
 <option value="%">Tous</option>
                <%
for(int i=0;i<source.length;i++){
%>
                <option value="<%=source[i].getVal()%>" <%if(source[i].getVal().compareTo(entite)==0) out.println(" selected ");%>><%=source[i].getVal()%></option>
                <%
}
%>
              </select>

              </div>

              </td>
          </tr>
          <tr>
            <td class="left">Type LC: </td>
            <td>
            <% if(sender.compareToIgnoreCase("LC")==0){ %>
            <select name="idType" class="champ" id="idType" >
                <option value="%">Tous</option>
                <%
          for(int i=0;i<tlc.length;i++){
          %>
                <option value="<%=tlc[i].getVal()%>"  <%if(tlc[i].getVal().compareTo(idType)==0) out.println("selected");%>><%=tlc[i].getVal()%></option>
                <%
                }
                %>
              </select>
       <% }
   else if(sender.compareToIgnoreCase("entree")==0){ %>
         <input type="text" class="champ" readonly="readonly" name="idType" id="idType" value="Recette" />
<% }
   else { %>
   <input type="text" class="champ" readonly="readonly" name="idType" id="idType" value="Dépense" />

   <%} %>

              </td>
            <td class="left">Num Compte:</td>
            <td> <input name="numCompte" type="text" class="champ" id="numCompte" size="10" value="<%=numCompte %>"></td>
          </tr>

        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"><strong><font color="#FF0000" size="+1">TRIER
        PAR </font></strong></td>
    </tr>
    <tr>
      <td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Colonne :</td>
            <td align="center"> <select name="colonne" class="champ" id="colonne">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp;
            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre" class="champ" id="ordre">
                <option value="ASC" <%=(ordre.compareTo("ASC")==0?"selected":"") %>>Croissante</option>
                <option value="DESC" <%=(ordre.compareTo("DESC")==0?"selected":"") %>>Décroissante</option>
              </select>
            </td>
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

   <form action="apreschoixLC.jsp" methode="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="7%" valign="top"><div align="center">choix</div></td>
          <td width="23%" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="10%" height="19" valign="top"><div align="center"><strong>Crédit Actuel</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>Dispo</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>Type</strong></div></td>
          <td width="10%" align="center" valign="top"><strong>Direction</strong></td>
          <td width="10%" valign="top"><div align="center"><strong>Mois</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>Annee</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>ID LC</strong></div></td>
        </tr>
        <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr>
          <td align="left" valign="top"><input type="radio" value="<%=lcc[i].getIdLigne()%>" name="choix" onMouseDown="getChoix()"> </td>
          <td align="left" valign="top"><div align="left"><%=lcc[i].getDesignation()%></div></td>
          <td height="19" align="right" valign="top"><%=Utilitaire.formaterAr(lcc[i].getCreditModifier())%></td>
          <td align="left" valign="top"><div align="right"><%=Utilitaire.formaterAr(lcc[i].getCreditModifier()-lcc[i].getMontantEng())%></div></td>
          <td align="left" valign="top"><div align="right"><%=lcc[i].getTypeLC()%></div></td>
          <td align="right" valign="top"><%=lcc[i].getAbbrevdir()%></td>
          <td align="right" valign="top"><%=lcc[i].getMois()%></td>
          <td align="right" valign="top"><%=lcc[i].getAnnee()%></td>
          <td align="right">
          <a href="listeLC.jsp?acte=détails&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&idLCDetail=<%=Utilitaire.remplacePourcentage(lcc[i].getIdLigne())%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&colonne=<%=colonne%>&ordre=<%=ordre%>"><%=lcc[i].getIdLigne()%></a>
          </td>


        </tr>
        <%
  }
  %>
     </table>
     <input type="hidden" id="sender" name="sender" value="<%=sender %>">
   </form>
<br />

   <!-- Pagination -->
   <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
	<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=lcc.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%=Math.floor(lcc.length/nbParPazy)+1%></td>
	</tr>
	    <tr>
	    <td width="295" valign="top" height="25">
		<%if(pazy>1){%>
	        <a href="listeLC.jsp?pazy=<%=(pazy-1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
		      pr&eacute;c&eacute;dente</a>
		<%
		}

	   %></td>
	   <td width="305" align="right">
	     <%
	     if(pazy<nbPage){
	     %>
	     <a href="listeLC.jsp?pazy=<%=(pazy+1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
	     suivante&gt;&gt;</a>
	    <%
	    }
	      %></td>
	  </tr>
	</table>

<br />

<%
	if(request.getParameter("acte") != null){
		LigneCreditComplet l = u.findLCComplet(request.getParameter("idLCDetail"),"","","","","","","","","","idLigne","ASC",request.getParameter("annee"),"lignecreditrecettecomplet")[0];
		%>
		<p align="center"><strong><u>Détail Ligne Crédit</u></strong></p>
      <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
	      <tr>
	      <td class="left" width="40%">Id Ligne Crédit:</td>
	      <td><%=l.getIdLigne() %></td>
	      </tr>
      	  <tr>
	      <td class="left">Désignation:</td>
	      <td><%=l.getDesignation() %></td>
	      </tr>
	      <tr>
	      <td class="left">Type d'utilisation:</td>
	      <td><%=l.getTypeLC() %></td>
	      </tr>
	      <tr>
	      <td class="left">Crédit Initial:</td>
	      <td><%=Utilitaire.formaterAr(l.getCreditInitial()) %></td>
	      </tr>
	      <tr>
	      <td class="left">Crédit Actuel:</td>
	      <td><%=Utilitaire.formaterAr(l.getCreditModifier()) %></td>
	      </tr>
	      <tr>
	      <td class="left">Crédit Dispo:</td>
	      <td><%=Utilitaire.formaterAr(l.getCreditInitial()-l.getMontantEng()) %></td>
	      </tr>
	      <tr>
	      <td class="left">Montant Engagé:</td>
	      <td><%=Utilitaire.formaterAr(l.getMontantEng())  %></td>
	      </tr>
	      <tr>
	      <td class="left">Montant Visa:</td>
	      <td><%=Utilitaire.formaterAr(l.getMontantVis()) %></td>
	      </tr>
	      <tr>
	      <td class="left">Montant Facturé:</td>
	      <td><%=Utilitaire.formaterAr(l.getMontantFac()) %></td>
	      </tr>
	      <tr>
	      <td class="left">Direction:</td>
	      <td><%=l.getLibelledir()+" ("+l.getAbbrevdir()+")" %></td>
	      </tr>
	      <tr>
	      <td class="left">Entité:</td>
	      <td><%=l.getEntite() %></td>
	      </tr>
	      <tr>
	      <td class="left">Num Compte:</td>
	      <td><%=l.getNumCompte()+ " ("+l.getDescCompte()+")" %></td>
	      </tr>
	      <tr>
	      <td class="left">Excercice:</td>
	      <td><%=l.getMois()+ " "+l.getAnnee() %></td>
	      </tr>

	 </table>
		<%

	}

%>
