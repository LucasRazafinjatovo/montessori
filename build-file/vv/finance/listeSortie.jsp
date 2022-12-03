<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/listeSortie.jsp";
        String lien= null;
        UserEJB u = null;
        String designation=null;
        Caisse caiss[] = null;
        Sortie sort[]= null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet te[] = null;
        String idType = null;
        String caisse=null;
        String idModePaiement = null;
        String idDevise = null;
        String idDepense = null;
        String dateDebut=null;
        String dateFin=null;
        String parution=null;
        String agence=null;
        String idLigne=null;
        historique.MapUtilisateur ut=null;
        TypeObjet ben=null;
        int pazy=0;
        double sommePage=0;
        int nbParPazy=Parametre.getNbParPage();
                int indiceDebut=0;
                int indiceFin=Parametre.getNbParPage();
                int nbPage=0;
                String projet, partenaire, facture;
        String colonne,ordre;
        String nomCol[]=null;
        String devise=null;
                TypeObjet ag[] =null;
%>
<%
  nomCol=Utilitaire.getNomColonne(new Sortie());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  //devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  parution=request.getParameter("parution");if ((parution==null)||parution.compareTo("")==0) parution="%";
  agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
  idModePaiement=request.getParameter("idModePaiement");if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  idDepense=request.getParameter("idDepense");if ((idDepense==null)||idDepense.compareTo("")==0) idDepense="%";
  idLigne = request.getParameter("idLigne");if ((idLigne==null)||idLigne.compareTo("")==0) idLigne="%";
  dateDebut=request.getParameter("datyInf");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("datySup");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
  projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
  partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
  facture=request.getParameter("facture");if ((facture==null)||facture.compareTo("")==0) facture="%";
  //fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
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
//(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat)
  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
ag = u.findTypeObjet("Agence","%","%");
  mp = u.findTypeObjet("Beneficiaire","%","%");
  te = u.findTypeObjet("TypeSortie","%","%");
  caiss = u.findCaisse("%","%","%","%");
  dev = u.findTypeObjet("Devise","%","%");
  ut=u.getUser();
  ////////findSortieAgence( idSortie, daty1, daty2, beneficiaire, typeSortie, designation, idModePaiement, idDevise, idCaisse, idEtat, parution, agence, colonne, ordre,  prj, part, fact
  sort= u.findSortieAgence(idDepense,dateDebut,dateFin,idModePaiement,idType,designation, "%", "%",caisse, "eta2",parution,agence,colonne,ordre, projet, partenaire, facture,idLigne);//n'affiche que les sorties crees seulement, n'affiche pas le annulees
  indiceDebut=Utilitaire.getBornePage(pazy,sort)[0];
  indiceFin=Utilitaire.getBornePage(pazy,sort)[1];
  nbPage=Utilitaire.calculNbPage(sort);
  sommePage=AdminCharge.getSommeSortie(sort,indiceDebut,indiceFin);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les d&eacute;penses</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les d&eacute;penses)</p>
<form action="<%=lien%>?but=finance/listeSortie.jsp" method="post" name="listeDepense" id="listeDepense">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date d�but :</td>
            <td> <input name="datyInf" type="text" class="champ" id="datyInf" value="<%=dateDebut%>" size="10" maxlength="10">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin:</td>
            <td> <input name="datySup" type="text" class="champ" id="datySup" value="<%=dateFin%>" size="10">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">D&eacute;signation :</td>
            <td> <input name="designation" type="text" class="champ" id="designation" value="<%=designation%>"></td>
            <td class="left">Parution :</td>
            <td> <input name="parution" type="text" class="champ" id="parution" size="10" value="<%=parution%>"></td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td ><select name="caisse" class="champ">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<caiss.length;i++){
          %>
                <option value=<%=caiss[i].getIdCaisse()%> <%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.print("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
                }
                %>
              </select></td>
            <td class="left">Facture : </td>
            <td> <input name="facture" type="text" class="champ" id="facture" size="10"> </td>
          </tr>
          <tr>
            <td class="left" valign="top">Agence :</td>
            <td align="left"> <select name="agence" class="champ" id="agence">
                <option value="%">Tous</option>
                <%
for(int i=0;i<ag.length;i++){
%>
                <option value="<%=ag[i].getId()%>" <%if(ag[i].getId().compareTo(agence)==0) out.println("selected");%>><%=ag[i].getVal()%></option>
                <%
}
%>
              </select>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Num�ro :</td>
            <td align="center"> <div align="left">
                <input name="idDepense" type="text" class="champ" id="idDepense" value="<%=idDepense%>">
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td class="left">Type : </td>
            <td><select name="idType" class="champ" id="idType" >
                <option value="%">Tous</option>
                <%
          for(int i=0;i<te.length;i++){
          %>
                <option value="<%=te[i].getId()%>"  <%if(te[i].getId().compareTo(idType)==0) out.println("selected");%>><%=te[i].getVal()%></option>
                <%
                }
                %>
              </select> </td>
            <td class="left">B�n�ficiaire :</td>
            <td align="left"> <select name="idModePaiement" class="champ" id="idModePaiement">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<mp.length;i++){
 %>
                <option value=<%=mp[i].getTuppleID()%> <%if(mp[i].getTuppleID().compareTo(idModePaiement)==0)out.print("selected");%>><%=mp[i].getVal()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
			<tr>
            <td class="left">ID Ligne :</td>
            <td> <input name="idLigne" type="text" class="champ" id="idLigne" value="<%=idLigne %>"></td>
            <td class="left"></td>
            <td class="left"></td>
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
            <td align="center"> <select name="colonne" class="champ" id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre" class="champ" id="select5">
                <option value="ASC">ASC</option>
                <option value="DESC">DESC</option>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<script language="JavaScript">
var cal1 = new calendar1(document.forms['listeDepense'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeDepense'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
 <tr>
    <td> <p align="center"><strong><u>RECAPITULATION</u></strong></p>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="137"  height="25" align="center" bgcolor="#C300FF"><strong>Somme de la page</strong></td>
          <td width="150" align="right"><%=Utilitaire.formaterAr(sommePage)%></td>
          <td width="57" align="center">
            <div align="right"></div></td>
          <td width="162" align="center">
            <div align="right"></div></td>
          <td width="90" align="center"><strong> </strong></td>
        </tr>
       <%
           for(int k=0;k<dev.length;k++)
    {
    %>
        <tr class="head">
          <td width="137"  height="25" align="center" bgcolor="#C300FF"><strong><%=dev[k].getVal()%></strong></td>
          <td width="150" align="right">&nbsp;</td>
          <td width="57" align="center">
            <div align="right"></div></td>
          <td width="162" align="center">
            <div align="right"></div></td>
          <td width="90" align="center"><strong> </strong></td>
        </tr>
        <tr>
          <td  height="25" align="left"><strong>Total <%=dev[k].getVal()%> :</strong></td>
          <td align="right"><%=Utilitaire.formaterAr((double)AdminCharge.getSommeSortieByDevise(sort,dev[k].getId()))%>
            <%=dev[k].getVal()%></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><strong> Nb</strong> :<%=AdminCharge.getNombreSortieByDevise(sort,dev[k].getId())%>
          </td>
        </tr>
        <%}%>
      </table>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="77" valign="top"><div align="center">Date</div></td>
          <td width="136" height="19" valign="top"><div align="center"><strong>D&eacute;signation</strong></div></td>
          <td width="112" valign="top"><div align="center"><strong>Montant </strong></div></td>
          <td width="83" valign="top"><div align="center"><strong>Type</strong></div></td>
          <td width="85" align="center" valign="top"><strong>Ben</strong></td>
          <td width="65" valign="top"><div align="center"><strong>Id</strong></div></td>
       <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td width="38" valign="top"></td>
   <%
                }
   %>
        </tr>
        <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr >
          <td align="left" valign="top"><div align="center"><%=Utilitaire.formatterDaty(sort[i].getDaty())%></div></td>
          <td height="19" align="right" valign="top"><%=sort[i].getDesignation()%></td>
          <td align="left" valign="top"><div align="right"><%=Utilitaire.formaterAr((double)sort[i].getMontant())%><%=" "+sort[i].getIdDevise()%></div></td>
          <td align="left" valign="top"><div align="center"><%=u.findTypeObjet("TYpeSortie",sort[i].getIdTypeSortie(),"%")[0].getVal()%></div></td>
          <td align="center" valign="top"><%=u.findTypeObjet("Beneficiaire",sort[i].getBeneficiaire(),"%")[0].getVal()%></td>
          <td align="center"><a href="<%=lien%>?but=finance/detailSortie.jsp&idSortie=<%=sort[i].getIdSortie()%>"><%=sort[i].getIdSortie()%></a>
          </td>
             <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td width="38" align="center"><a href="<%=lien%>?but=finance/apresSortie.jsp&acte=ANNULER&idSortie=<%=sort[i].getIdSortie()%>">Ann.</a></td>
   <%
                }
   %>
        </tr>
        <%
  }
  %>
      </table>
</td></tr>
</table>
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td height="25"><b>Nombre de r&eacute;sultat :</b> </td>
    <td align="right"><strong>page</strong> <%=pazy%> <b>sur</b>
      <%=nbPage%>
    </td>
  </tr>
  <tr>
    <td width="295" valign="top" height="25">
      <%if(pazy>1){%>
      <a href="<%=lien%>?but=finance/listeSortie.jsp&designation=<%=Utilitaire.remplacePourcentage(designation)%>&pazy=<%=pazy-1%>&datyInf=<%=dateDebut %>&datySup=<%=dateFin%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&idDepense=<%=Utilitaire.remplacePourcentage(idDepense)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&facture=<%=Utilitaire.remplacePourcentage(facture)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
      <%

}
  %>
    </td>
    <td width="305" align="right">
      <%
      if(pazy<nbPage){
      %>
      <a href="<%=lien%>?but=finance/listeSortie.jsp&designation=<%=Utilitaire.remplacePourcentage(designation)%>&pazy=<%=pazy+1%>&datyInf=<%=dateDebut %>&datySup=<%=dateFin%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&idDepense=<%=Utilitaire.remplacePourcentage(idDepense)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&facture=<%=Utilitaire.remplacePourcentage(facture)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">Page
      suivante&gt;&gt;</a>
      <%
     }
       %>
    </td>
  </tr>
</table>
<table width="466" border="0" cellpadding="3" cellspacing="0" align="center">
  <tr>
    <td width="200"></td>
    <td><strong>Nombre enregistrement : </strong></td>
    <td><%=sort.length%></td>
  </tr>
</table>
