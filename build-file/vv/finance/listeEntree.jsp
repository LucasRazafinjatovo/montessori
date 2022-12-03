<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="finance/listeEntree.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet te[] = null;
  TypeObjet dev[] = null;
  facture.Client clt[] = null;
  TypeObjet mp[] =null;
  Caisse caiss[] = null;
  Entree entree[] = null;
  String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  String designation=null;
  historique.MapUtilisateur ut=null;
  String client, idType, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire, idLigne;
  String colonne,ordre;
  String devise=null;
  int pazy=0;
   int nbParPazy=Parametre.getNbParPage();
   int indiceDebut=0;
   int indiceFin=Parametre.getNbParPage();
   int nbPage=0;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     dev = u.findTypeObjet("Devise","%","%");
     caiss = u.findCaisse("%","%","%","%");
     ut=u.getUser();
%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new Entree());
  client=request.getParameter("client");if ((client==null)||client.compareTo("")==0) client="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
 // devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  parution=request.getParameter("parution");if ((parution==null)||parution.compareTo("")==0) parution="%";
  numPiece=request.getParameter("numPiece");if ((numPiece==null)||numPiece.compareTo("")==0) numPiece="%";
  numero=request.getParameter("numero");if ((numero==null)||numero.compareTo("")==0) numero="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  idModePaiement=request.getParameter("idModePaiement"); if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="01/01/2008";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
    projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
  partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
  idLigne = request.getParameter("idLigne");if ((idLigne==null)||idLigne.compareTo("")==0) idLigne="%";
  apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
  

  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
 // public Entree[] findEntreeLettre( idEntree, daty1, daty2, client, typeEntree, designation, idModePaiement, numPiece, String idDevise, String idCaisse, String idEtat, String agence, String parution, String colonne, String ordre, String prj, String part, String apresWhere) throws Exception, RemoteException;
 //entree = u.findEntreeLettre("%", dateDebut,dateFin,"%", "trosa","%","%","%", "%", "%", "eta2","%","%","daty","DESC",idModePaiement,"%","");//n'affiche que les entrees crees seulement, n'affiche pas le annulees
  entree = u.findEntreeLettre(numero, dateDebut, dateFin, client, idType,designation,idModePaiement,numPiece, "%", caisse, "eta2",agence,parution,colonne,ordre,projet, idLigne, apresW);//n'affiche que les entrees crees seulement, n'affiche pas le annulees
  indiceDebut=Utilitaire.getBornePage(pazy,entree)[0];
  indiceFin=Utilitaire.getBornePage(pazy,entree)[1];
  nbPage=Utilitaire.calculNbPage(entree);
  sommeEntree=AdminEntree.getSommeEntree(entree,indiceDebut,indiceFin);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les recettes</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les recettes)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td align="center"> <input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10">
              &nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
            <td class="left">Date fin:</td>
            <td align="center"> <input name="dateFin" type="text" class="champ" id="dateFin" value="<%=dateFin%>" size="10">
              &nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
            </td>
          </tr>
          <tr>
            <td class="left">Designation :</td>
            <td align="center"> <input name="designation" type="text" class="champ" value="<%=designation%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Type :</td>
            <td align="center"> <select name="idType" class="champ" id="idType">
                <option value="%">Tous</option>
                <%
   for(int i= 0;i<te.length;i++){
  %>
                <option value="<%=te[i].getVal()%>" <%if(te[i].getVal().compareTo(idType)==0)out.println("selected");%>><%=te[i].getVal()%></option>
                <%
       }
  %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td align="center"> <select name="caisse" class="champ" id="caisse">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<caiss.length;i++){
 %>
                <option value="<%=caiss[i].getDescCaisse()%>"<%if(caiss[i].getDescCaisse().compareTo(caisse)==0)out.println("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Source</td>
            <td align="center"> <select name="idModePaiement" class="champ" id="idModePaiement">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<mp.length;i++){
 %>
                <option value=<%=mp[i].getVal()%> <%if(mp[i].getVal().compareTo(idModePaiement)==0)out.print("selected");%>><%=mp[i].getVal()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Num&eacute;ro Entr&eacute;e :</td>
            <td align="center"> <input name="numero" type="text" class="champ" id="numero" value="<%=numero%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Num&eacute;ro Piece:</td>
            <td align="center"> <input name="numPiece" type="text" class="champ" id="numPiece" value="<%=numPiece%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Agence :</td>
            <td align="center"> <input name="agence" type="text" class="champ" id="agence" value="<%=agence%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left">Parution :</td>
            <td align="center"> <input name="parution" type="text" class="champ" id="parution" value="<%=parution%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">client :</td>
            <td align="center"> <input name="client" type="text" class="champ" id="client" value="<%=client%>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left" >ID Ligne :</td>
            <td align="center"> <input name="idLigne" type="text" class="champ" id="idLigne" value="<%=idLigne %>">
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            
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
            <td align="center"> <select name="colonne"   id="select4">
                <%
   for(int i=0;i<nomCol.length;i++){
 %>
                <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo(colonne)==0) out.println("selected");%>><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre"   id="select5">
                <option value="ASC" <%if (ordre.compareTo("ASC")==0) out.println("selected");%>>ASC</option>
                <option value="DESC" <%if (ordre.compareTo("DESC")==0) out.println("selected");%>>DESC</option>
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
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>


</form>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>

      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="137"  height="25" align="center" bgcolor="#C300FF"><strong>Somme de la page</strong></td>
          <td width="150" align="right">&nbsp;</td>
          <td width="57" align="center"><div align="right"></div></td>
          <td width="162" align="center"><div align="right"></div></td>
          <td width="90" align="center"><strong> </strong></td>
        </tr>
        <%
    for(int k=0;k<dev.length;k++)
    {
    %>
        <tr class="head">
          <td width="123"  height="25" align="center" bgcolor="#C300FF"><div align="right"><strong><%=dev[k].getVal()%></strong></div></td>
          <td width="153" align="right">&nbsp;</td>
          <td width="69" align="center"><div align="right"></div></td>
          <td width="138" align="center"><div align="right"></div></td>
          <td width="113" align="center"><strong> </strong></td>
        </tr>
        <tr>
          <td  height="25" align="left"><div align="right">&nbsp;<strong>Total <%=dev[k].getVal()%> :</strong></div></td>
          <td align="right"><%=Utilitaire.formaterAr((double)AdminEntree.getSommeEntreeByDevise(entree,dev[k].getId()))%><%=dev[k].getId()%></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><div align="right"></div></td>
          <td align="center"><strong> Nb</strong> :<%=AdminEntree.getNombreEntreeByDevise(entree,dev[k].getId())%> </td>
        </tr>
        <%}%>
      </table>
      <br>







   <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="15%" height="19" align="center" valign="top">Piece</td>
          <td width="15%" align="center" valign="top">Date</td>
          <td width="30%" align="right" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="20%" align="right" valign="top"><div align="center"><strong>Montant</strong></div></td>
          <td width="10%" align="center" valign="top" ><strong>Numéro</strong></td>
          <td width="0%" align="center" valign="top"></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td width="10%" valign="top"></td>
          <%
                }
   %>
        </tr>
        <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr>
          <td align="center"><%=entree[i].getNumpiece()%></td>

          <td align="center"><%=Utilitaire.formatterDaty(entree[i].getDaty())%></td>
          <td align="right"><a href="<%=lien%>?but=finance/detailEntree.jsp&idEntree=<%=entree[i].getIdEntree()%>"><%=entree[i].getDesignation()%></a></td>
          <td align="right"><%=Utilitaire.formaterAr((double)entree[i].getMontant())%><%=" "+entree[i].getIdDevise()%></td>
          <td align="center"><a href="<%=lien%>?but=finance/detailEntree.jsp&idEntree=<%=entree[i].getIdEntree()%>"><%=entree[i].getTuppleID()%></a></td>
          <%
      if(ut.getIdrole().compareTo("admin")==0 || ut.getIdrole().compareTo("dg")==0)
                {
   %>
          <td align="center"><a href="<%=lien%>?but=finance/apresEntree.jsp&acte=ANNULER&idEntree=<%=entree[i].getIdEntree()%>">Ann</a></td>
          <%
                }
          %>
        </tr>
        <%
    }
  %>
      </table></td>
</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=entree.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=entree.length/nbParPazy+1%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=finance/listeEntree.jsp&pazy=<%=pazy-1%>&client=<%=Utilitaire.remplacePourcentage(client)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&numero=<%=Utilitaire.remplacePourcentage(numero)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&designation<%=Utilitaire.remplacePourcentage(designation)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right">
      <%
      if(pazy<nbPage){
      %>
      <a href="<%=lien%>?but=finance/listeEntree.jsp&pazy=<%=pazy%>&client=<%=Utilitaire.remplacePourcentage(client)%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&numPiece=<%=Utilitaire.remplacePourcentage(numPiece)%>&numero=<%=Utilitaire.remplacePourcentage(numero)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&parution=<%=Utilitaire.remplacePourcentage(parution)%>&agence=<%=Utilitaire.remplacePourcentage(agence)%>&designation<%=Utilitaire.remplacePourcentage(designation)%>&colonne=<%=colonne%>&ordre=<%=ordre%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>

<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
