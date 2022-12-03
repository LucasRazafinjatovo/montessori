<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="lc/listeFCC.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
        TypeObjet source[] = null;
        TypeObjet tlc[] = null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
        LigneCreditComplet lcc[]= null;
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        int etat=1;
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
                String numCompte = null;
                String colonne = null;
                String mois2=null;
                String mois1=null;
                String sender=null;

                int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
           RgMultiple[] groupeEntite,groupeEntiteMois,groupeDirection,groupeDirectionMois, groupeDesignation;
           double globale[];
           String critere1 = null;
           String critere2 = null;
           String critere3 = null;
           String critere4 = null;
           String critere5 = null;
           String critere1F = null;
           String critere2F = null;
           String critere3F = null;
           String critere4F = null;
           String critere5F = null;
           String critereLc=null;
%>
<%
  sender = request.getParameter("sender");if ((sender==null)||sender.compareTo("")==0) sender="LC";
  nomCol=Utilitaire.getNomColonne(new LigneCredit());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  String tempDir=(String)session.getValue("dir");
  if((tempDir!=null)&&(tempDir.compareToIgnoreCase("%")!=0))
    direction=tempDir;

  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="mois";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
  mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
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
   critere1 = "&etat=opPayelc&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
   critere1F = "&table=facturefournisseuropgroupe&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
   critereLc="&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
 %>
<%

try{
        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
        source = u.findTypeObjet("Beneficiaire","%","%");
        tlc = u.findTypeObjet("TypeSortie","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        lcc = u.findFCC(idLC,designation,mois1,mois2,idType,numCompte,"%","%","%",entite,direction,colonne,ordre, annee,"lignecreditcomplet");
        globale=AdminLigneCreditComplet.getAllSommeMontantLC(lcc);
        int [] numColSommeEntite={3,4,6,5};
        int[] numColGroupeEntite={15};
        groupeEntite=AdminGen.findGroupeMultiple(lcc,numColGroupeEntite,numColSommeEntite);
       int[] numColGroupeEntiteMois={7,15};
        groupeEntiteMois=AdminGen.findGroupeMultiple(lcc,numColGroupeEntiteMois,numColSommeEntite);
        int[] numColGroupeDirection={12};
        groupeDirection=AdminGen.findGroupeMultiple(lcc,numColGroupeDirection,numColSommeEntite);
        int[] numColGroupeDirectionMois={7,12};
        groupeDirectionMois=AdminGen.findGroupeMultiple(lcc,numColGroupeDirectionMois,numColSommeEntite);
		int[] numColGroupeDesignation = {1};
		groupeDesignation = AdminGen.findGroupeMultiple(lcc, numColGroupeDesignation, numColSommeEntite);
		
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
<h1>Lister FCC Depense </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les lignes cr&eacute;dit)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeLC" id="listeLC">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
           <tr>
            <td class="left">Mois Inf:</td>
            <td><select name="mois1" class="champ" id="mois1">
              <%
          for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois1)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
            </select> </td>
            <td class="left">Mois Sup:</td>
            <td><select name="mois2" class="champ" id="mois2">
              <%
          for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois2)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
            </select> </td>
          </tr>
          <tr>
            <td class="left">Num&eacute;ro LC:</td>
            <td ><input name="idLC" type="text" class="champ" id="idLC2" size="10" value="<%=idLC%>"></td>
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
            <select name="idType" class="champ" id="idType" >
                <option value="%">Tous</option>
                <%
          for(int i=0;i<tlc.length;i++){
          %>
                <option value="<%=tlc[i].getVal()%>"  <%if(tlc[i].getVal().compareTo(idType)==0) out.println("selected");%>><%=tlc[i].getVal()%></option>
                <%
                }
                %>
            </select>            </td>
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
<div align="center">
  <div align="center"><strong>TOTAL GLOBALE </strong><br>
  </div>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr class="head">
      <td width="10%" valign="top"><div align="center">Enitit&eacute;</div></td>
      <td width="18%" valign="top"><div align="center">Total Cr&eacute;dit </div></td>
      <td width="18%" height="19" valign="top"><div align="center"><strong>Consomm&eacute;s</strong></div></td>
      <td width="18%" valign="top"><div align="center"><strong>Op vise</strong></div></td>
      <td width="18%" valign="top"><div align="center">Facture vise </div></td>
      <td width="18%" align="center" valign="top"><strong>Facture - Op </strong></td>
    </tr>
    <tr>
      <td align="left" valign="top"><div align="center">TOUS</div></td>
      <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=lc/listeLC2.jsp<%=critere1F %>"><%=Utilitaire.formaterAr(globale[1])%> Ar</a></div></td>
      <td height="19" align="right" valign="top"><%=Utilitaire.formaterAr(globale[2])%> Ar</td>
      <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=ded/listeOP.jsp<%=critere1 %>"><%=Utilitaire.formaterAr(globale[3])%>Ar</a></div></td>
      <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=facturefournisseur/critereEntreFactureOp.jsp<%=critere1F %>"><%=Utilitaire.formaterAr(globale[4])%> Ar</a></div></td>
      <td align="right" valign="top"><%=Utilitaire.formaterAr(globale[4]-globale[3])%>Ar</td>
    </tr>
  </table><br><%if (entite.compareTo("%")==0){%>
  <strong>TOTAL ENTITE </strong><br>
</div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <!--DWLayoutTable-->
  <tr class="head">
    <td width="10%" valign="top"><div align="center">Enitit&eacute;</div></td>
    <td width="18%" valign="top"><div align="center">Total Cr&eacute;dit </div></td>
    <td width="18%" height="19" valign="top"><div align="center"><strong>Consomm&eacute;s</strong></div></td>
    <td width="18%" valign="top"><div align="center"><strong>Op vise</strong></div></td>
    <td width="18%" valign="top"><div align="center">Facture vise</div></td>
    <td width="18%" align="center" valign="top"><strong>Facture - Op </strong></td>
  </tr>
  <%
  for(int i=0;i<groupeEntite.length;i++){
    critere2 = "&etat=opPayelc&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+groupeEntite[i].getColonneGroupe()[0]+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
    critere2F = "&table=facturefournisseuropgroupe&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+groupeEntite[i].getColonneGroupe()[0]+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));

%>
  <tr>
		<td align="left" valign="top">
			<div align="center"><a href="<%=lien %>?but=lc/listeLC2.jsp&entite=<%=(groupeEntite[i].getColonneGroupe()[0])%>&annee=<%=annee%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>"><%=(groupeEntite[i].getColonneGroupe()[0])%></a></div>
		</td>
		<td align="left" valign="top">
			<div align="right"><a href="<%=lien %>?but=lc/listeLC2.jsp<%=critere2F %>"><%=Utilitaire.formaterAr(groupeEntite[i].getSommeGroupe()[0])%>Ar</a></div>
		</td>
		<td width="18%" height="19" align="right" valign="top"><%=Utilitaire.formaterAr(groupeEntite[i].getSommeGroupe()[1])%>Ar</td>
		<td align="left" valign="top"><div align="right"><strong><a href="<%=lien %>?but=ded/listeOP.jsp<%=critere2 %>"><%=Utilitaire.formaterAr(groupeEntite[i].getSommeGroupe()[3])%>Ar</a></strong></div></td>
		<td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=facturefournisseur/critereEntreFactureOp.jsp<%=critere2F %>"><%=Utilitaire.formaterAr(groupeEntite[i].getSommeGroupe()[2])%> Ar</a></div></td>
		<td align="right" valign="top"><%=Utilitaire.formaterAr(groupeEntite[i].getSommeGroupe()[2]-groupeEntite[i].getSommeGroupe()[3])%> Ar</td>
  </tr>
  <%
  }
  %>
</table>
<br>
<%if (mois1.compareTo(mois2)!=0) {%>
<div align="center"><strong>TOTAL PAR ENTITE PAR MOIS</strong><br>
</div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="8%" valign="top"><div align="center">Enitit&eacute;</div></td>
          <td width="17%" valign="top"><div align="center">Total Cr&eacute;dit </div></td>
          <td width="17%" height="19" valign="top"><div align="center"><strong>Consomm&eacute;s</strong></div></td>
          <td width="17%" valign="top"><div align="center"><strong>Op vise </strong></div></td>
          <td width="17%" valign="top"><div align="center">Facture vise</div></td>
          <td width="17%" align="center" valign="top"><strong>Facture - Op </strong></td>
          <td width="7%" valign="top"><div align="center"><strong>Mois</strong></div></td>
        </tr>
  <%
  for(int i=0;i<groupeEntiteMois.length;i++){
    critere3 = "&etat=opPayelc&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+groupeEntiteMois[i].getColonneGroupe()[1]+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+groupeEntiteMois[i].getColonneGroupe()[0]+"&mois2="+groupeEntiteMois[i].getColonneGroupe()[0]+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
    critere3F = "&table=facturefournisseuropgroupe&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+groupeEntiteMois[i].getColonneGroupe()[1]+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+groupeEntiteMois[i].getColonneGroupe()[0]+"&mois2="+groupeEntiteMois[i].getColonneGroupe()[0]+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));

%>
        <tr>
          <td align="left" valign="top"><div align="center"><a href="<%=lien %>?but=lc/listeLC2.jsp&entite=<%=(groupeEntiteMois[i].getColonneGroupe()[1])%>&annee=<%=annee%>&mois1=<%=groupeEntiteMois[i].getColonneGroupe()[0]%>&mois2=<%=groupeEntiteMois[i].getColonneGroupe()[0]%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>"><%=groupeEntiteMois[i].getColonneGroupe()[1]%></a></div></td>
          <td align="left" valign="top"><div align="left">
            <div align="right"><a href="<%=lien %>?but=lc/listeLC2.jsp<%=critere3F %>"><%=Utilitaire.formaterAr(groupeEntiteMois[i].getSommeGroupe()[0])%>Ar</a></div></td>
          <td height="19" align="right" valign="top"><%=Utilitaire.formaterAr(groupeEntiteMois[i].getSommeGroupe()[1])%>Ar</td>
          <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=ded/listeOP.jsp<%=critere3 %>"><%=Utilitaire.formaterAr(groupeEntiteMois[i].getSommeGroupe()[3])%>Ar</a></div></td>
          <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=facturefournisseur/critereEntreFactureOp.jsp<%=critere3F %>"><%=Utilitaire.formaterAr(groupeEntiteMois[i].getSommeGroupe()[2])%>Ar</a></div></td>
          <td align="right" valign="top"><%=Utilitaire.formaterAr(groupeEntiteMois[i].getSommeGroupe()[2]-groupeEntiteMois[i].getSommeGroupe()[3])%>Ar</td>
          <td align="right" valign="top"><div align="center"><%=groupeEntiteMois[i].getColonneGroupe()[0]%></div></td>
        </tr>
        <%}%>
</table>
<p>
    <%}%>
     <%}%>
     <br />

	 
	 
	 
<div align="center"><strong>TOTAL PAR DESIGNATION LC </strong><br>
</div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <!--DWLayoutTable-->
  <tr class="head">
    <td width="10%" valign="top"><div align="center">Designation</div></td>
    <td width="18%" valign="top"><div align="center">Total Cr&eacute;dit </div></td>
    <td width="18%" height="19" valign="top"><div align="center"><strong>Consomm&eacute;s</strong></div></td>
    <td width="18%" valign="top"><div align="center"><strong>Op vise </strong></div></td>
    <td width="18%" valign="top"><div align="center">Facture vise </div></td>
    <td width="18%" align="center" valign="top"><strong>Facture - Op</strong></td>
  </tr>
  <%
  for(int i=0;i<groupeDesignation.length;i++){
    String criteredsc = "&etat=opPayelc&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&designation="+groupeDesignation[i].getColonneGroupe()[0]+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
    String criteredscf = "&table=facturefournisseuropgroupe&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&designation="+groupeDesignation[i].getColonneGroupe()[0]+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));

%>
  <tr>
    <td align="left" valign="top">
		<div align="center">
			<a href="<%=lien %>?but=lc/listeLC2.jsp&designation=<%=(groupeDesignation[i].getColonneGroupe()[0])%>&annee=<%=annee%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>"><%=(groupeDesignation[i].getColonneGroupe()[0])%></a>
		</div>
	</td>
    <td align="left" valign="top">
		<div align="right"><%=Utilitaire.formaterAr(groupeDesignation[i].getSommeGroupe()[0])%>Ar</div>
	</td>
    <td  align="right" valign="top"><%=Utilitaire.formaterAr(groupeDesignation[i].getSommeGroupe()[1])%>Ar</td>
    <td align="left" valign="top">
		<div align="right">
			<strong>
				<a href="<%=lien %>?but=ded/listeOP.jsp<%=criteredsc %>"><%=Utilitaire.formaterAr(groupeDesignation[i].getSommeGroupe()[3])%>Ar</a>
			</strong>
		</div>
	</td>
    <td align="left" valign="top">
		<div align="right">
			<a href="<%=lien %>?but=facturefournisseur/critereEntreFactureOp.jsp<%=criteredscf%>"><%=Utilitaire.formaterAr(groupeDesignation[i].getSommeGroupe()[2])%> Ar</a></div></td>
    <td align="right" valign="top"><%=Utilitaire.formaterAr(groupeDesignation[i].getSommeGroupe()[2]-groupeDesignation[i].getSommeGroupe()[3])%> Ar</td>
  </tr>
  <%
  }
  %>
</table>
	 
	 
	 
	 
	 
	 
	 
	 
	 
     <!-- Pagination -->
  <br />
</p>
<%if (direction.compareTo("%")==0){%>
<div align="center"><strong>TOTAL DIRECTION </strong><br>
</div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <!--DWLayoutTable-->
  <tr class="head">
    <td width="10%" valign="top"><div align="center">Direction</div></td>
    <td width="18%" valign="top"><div align="center">Total Cr&eacute;dit </div></td>
    <td width="18%" height="19" valign="top"><div align="center"><strong>Consomm&eacute;s</strong></div></td>
    <td width="18%" valign="top"><div align="center"><strong>Op vise </strong></div></td>
    <td width="18%" valign="top"><div align="center">Facture vise </div></td>
    <td width="18%" align="center" valign="top"><strong>Facture - Op</strong></td>
  </tr>
  <%
  for(int i=0;i<groupeDirection.length;i++){
    critere4 = "&etat=opPayelc&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+groupeDirection[i].getColonneGroupe()[0]+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
    critere4F = "&table=facturefournisseuropgroupe&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+groupeDirection[i].getColonneGroupe()[0]+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));

%>
  <tr>
    <td align="left" valign="top"><div align="center"><a href="<%=lien %>?but=lc/listeLC2.jsp&direction=<%=(groupeDirection[i].getColonneGroupe()[0])%>&annee=<%=annee%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>"><%=(groupeDirection[i].getColonneGroupe()[0])%></a></div></td>
    <td align="left" valign="top"><div align="right"><%=Utilitaire.formaterAr(groupeDirection[i].getSommeGroupe()[0])%>Ar</div></td>
    <td  align="right" valign="top"><%=Utilitaire.formaterAr(groupeDirection[i].getSommeGroupe()[1])%>Ar</td>
    <td align="left" valign="top"><div align="right"><strong><a href="<%=lien %>?but=ded/listeOP.jsp<%=critere4 %>"><%=Utilitaire.formaterAr(groupeDirection[i].getSommeGroupe()[3])%>Ar</a></strong></div></td>
    <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=facturefournisseur/critereEntreFactureOp.jsp<%=critere4F %>"><%=Utilitaire.formaterAr(groupeDirection[i].getSommeGroupe()[2])%> Ar</a></div></td>
    <td align="right" valign="top"><%=Utilitaire.formaterAr(groupeDirection[i].getSommeGroupe()[2]-groupeDirection[i].getSommeGroupe()[3])%> Ar</td>
  </tr>
  <%
  }
  %>
</table>
<br>
<%if (mois1.compareTo(mois2)!=0) {%>
    <div align="center"><strong>TOTAL PAR DIRECTION PAR MOIS </strong><br>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
      <!--DWLayoutTable-->
      <tr class="head">
        <td width="8%" valign="top"><div align="center">Direction</div></td>
        <td width="17%" valign="top"><div align="center">Total Cr&eacute;dit </div></td>
        <td width="17%" height="19" valign="top"><div align="center"><strong>Consomm&eacute;s</strong></div></td>
        <td width="17%" valign="top"><div align="center"><strong>Op vise </strong></div></td>
        <td width="17%" valign="top"><div align="center">Facture vise</div></td>
        <td width="17%" align="center" valign="top"><strong>Facture - Op </strong></td>
        <td width="7%" valign="top"><div align="center"><strong>Mois</strong></div></td>
  </tr>
  <%
  for(int i=0;i<groupeDirectionMois.length;i++){
    critere5 = "&etat=opPayelc&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+groupeDirectionMois[i].getColonneGroupe()[1]+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+groupeDirectionMois[i].getColonneGroupe()[0]+"&mois2="+groupeDirectionMois[i].getColonneGroupe()[0]+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"))+"&etat="+etat;
    critere5F = "&table=facturefournisseuropgroupe&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+groupeDirectionMois[i].getColonneGroupe()[1]+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&mois1="+groupeDirectionMois[i].getColonneGroupe()[0]+"&mois2="+groupeDirectionMois[i].getColonneGroupe()[0]+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"));
%>

  <tr>
          <td align="left" valign="top"><a href="<%=lien %>?but=lc/listeLC2.jsp&direction=<%=(groupeDirectionMois[i].getColonneGroupe()[1])%>&annee=<%=annee%>&idType=<%=Utilitaire.remplacePourcentage(idType)%>&mois1=<%=groupeDirectionMois[i].getColonneGroupe()[0]%>&mois2=<%=groupeDirectionMois[i].getColonneGroupe()[0]%>"><%=groupeDirectionMois[i].getColonneGroupe()[1]%></a></td>
          <td align="left" valign="top"><div align="left"><a href="<%=lien %>?but=lc/listeLC2.jsp<%=critere5F %>"><%=Utilitaire.formaterAr(groupeDirectionMois[i].getSommeGroupe()[0])%>Ar</a></td>
          <td align="right" valign="top"><%=Utilitaire.formaterAr(groupeDirectionMois[i].getSommeGroupe()[1])%>Ar</td>
          <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=ded/listeOP.jsp<%=critere5 %>"><%=Utilitaire.formaterAr(groupeDirectionMois[i].getSommeGroupe()[3])%>Ar</a></div></td>
          <td align="left" valign="top"><div align="right"><a href="<%=lien %>?but=facturefournisseur/critereEntreFactureOp.jsp<%=critere5F %>"><%=Utilitaire.formaterAr(groupeDirectionMois[i].getSommeGroupe()[2])%>Ar</a></div></td>
          <td align="right" valign="top"><%=Utilitaire.formaterAr(groupeDirectionMois[i].getSommeGroupe()[2]-groupeDirectionMois[i].getSommeGroupe()[3])%>Ar</td>
          <td align="right" valign="top"><%=groupeDirectionMois[i].getColonneGroupe()[0]%></td>
  </tr>
  <%}%>
</table>
<p>
  <%}%><%}%>
</p>
<p>&nbsp; </p>
<p align="center">&nbsp;</p>
