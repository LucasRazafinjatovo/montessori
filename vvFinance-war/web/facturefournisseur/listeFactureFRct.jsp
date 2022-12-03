<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureFRct.jsp";
  String lien= null;
  UserEJB u = null;

 Utilitaire utilitR=new Utilitaire();
 ResultatEtSomme factRctRs =  null;

   String num,  dateDebut,  dateFin,  fournisseur,  designation,projet;
  String colonne,ordre;
  String devise=null;
  int pazy=1;
  int nbPage=0;
  int nbParPazy=10;
  int pazy1=0;
  int pazy2=0;
  String nomCol[]=null;

  double sommeEntree=0;
  String apresW=null;
  Entree e= new Entree();
  FactureFournisseur [] factF = null;

    String desiLc="";
  String numLc="";
  	Direction dir[] = null;
                  String numCompte = null;
                String mois2=null;
                String mois1=null;
          String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
        TypeObjet source[] = null;
        TypeObjet tlc[] = null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
          String idLC = "";
        String idType = "";
          int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = "";
        String entite = "";
        String suivant="";
        String precedent="";
 %>
<%
if((request.getParameter("pazy")==null)||(request.getParameter("pazy").compareToIgnoreCase("")==0))
{
  pazy=1;
}
else
  pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
        source = u.findTypeObjet("Beneficiaire","%","%");
        tlc = u.findTypeObjet("TypeEntree","%","%");
        dir = u.findDirection("","","","","");

%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new FactureFournisseur());
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="numFact";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
 dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
 idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
  mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="";
                        apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
                        suivant="&num="+Utilitaire.remplacePourcentage(request.getParameter("num"))+"&fournisseur="+Utilitaire.remplacePourcentage(request.getParameter("fournisseur"))+"&dateDebut="+dateDebut+"&idFact="+Utilitaire.remplacePourcentage(request.getParameter("idFact"))+"&numLc="+Utilitaire.remplacePourcentage(request.getParameter("numLc"))+"&idType="+Utilitaire.remplacePourcentage(idType)+"&numCompte="+Utilitaire.remplacePourcentage(numCompte)+"&mois2="+mois2+"&annee="+Utilitaire.remplacePourcentage(annee)+"&direction="+Utilitaire.remplacePourcentage(direction)+"&entite="+Utilitaire.remplacePourcentage(entite)+"&desiLc="+Utilitaire.remplacePourcentage(request.getParameter("desiLc"))+"&mois1="+Utilitaire.remplacePourcentage(mois1)+"&dateFin="+dateFin+"&designation="+Utilitaire.remplacePourcentage(request.getParameter("designation"))+"&colonne="+colonne+"&ordre="+ordre;
    //findFactureFournisseurPageLc(String nomtable, String id, String fourn, String designation, String numFact, String idLigne, String daty1, String daty2, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage)
                         factRctRs = u.findFactureFournisseurPageLc("FACTURECLIENTLcVue",  request.getParameter("num"),request.getParameter("fournisseur"),request.getParameter("designation"),request.getParameter("idFact"),request.getParameter("numLc"),  dateDebut,  dateFin, request.getParameter("desiLc"),mois1,mois2,annee,direction,entite,idType,numCompte , pazy,colonne,ordre);
                          factF = (FactureFournisseur[])factRctRs.getResultat();
                          nbPage=Utilitaire.calculNbPage(factRctRs.getSommeEtNombre()[2]);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les factures Client</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les recettes)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
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
            </select>
          </td>
          <td class="left">Mois Sup:</td>
          <td><select name="mois2" class="champ" id="mois2">
              <option value="%">Tous</option>
              <%
          for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois2)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
            </select>
          </td>
        </tr>
        <tr>
          <td class="left">Num&eacute;ro LC:</td>
          <td ><input name="idLC" type="text" class="champ" id="idLC2" size="10" value="<%=idLC%>"></td>
          <td class="left">Direction: </td>
          <td>
            <select name="direction" class="champ" id="direction">
              <option value="%">Tous</option>
              <%
for(int i=0;i<dir.length;i++){
%>
              <option value="<%=dir[i].getLibelledir()%>" <%if(dir[i].getLibelledir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getLibelledir()%></option>
              <%
}
%>
            </select>
          </td>
        </tr>
        <tr>
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
          <td class="left">Entit&eacute;:</td>
          <td align="center">
            <div align="left">
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
          </div></td>
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
            </select>
          </td>
          <td class="left">Num Compte:</td>
          <td>
            <input name="numCompte" type="text" class="champ" id="numCompte" size="10" value="<%=numCompte %>"></td>
        </tr>
        <tr>
          <td class="left">Lgn Credit nm :</td>
          <td align="center"><input name="numLc" type="text" class="champ"   id="numLc" value="<%=numLc%>" size="10" maxlength="10" /> </td>
          <td class="left">lib lc :</td>
          <td align="center"><input name="desiLc" type="text" class="champ"   id="desiLc" value="<%=desiLc%>" size="10" /></td>
        </tr>
        <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
        </tr>
        <tr>
          <td class="left">Client :</td>
          <td align="center"><input name="fournisseur" type="text" class="champ"   id="fournisseur" value="<%=Utilitaire.remplacerNull(request.getParameter("fournisseur"))%>"size="10"/>
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">Projet</td>
          <td align="center"><input name="projet" type="text" class="champ"   id="projet" value="<%=Utilitaire.remplacerNull(request.getParameter("projet"))%>"size="10" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
        </tr>
        <tr>
          <td class="left">Designation :</td>
          <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="<%=Utilitaire.remplacerNull(request.getParameter("designation"))%>" />
&nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
          <td class="left">Numero </td>
          <td align="center"><input name="num" type="text" class="champ"   id="num" value="<%=Utilitaire.remplacerNull(num)%>"size="10" maxlength="10" /></td>
        </tr>
        <tr>
          <td class="left">Etat :</td>
          <td align="center"><select name="table" class="champ" id="select2">
            <option value="factureClient">Tous</option>
            <option value="FactureClientVise">Vise</option>
            <option value="FactureClientAVise">A viser</option>
          </select></td>
          <td class="left">&nbsp;</td>
          <td align="center"><input name="idFact" type="text" class="champ"   id="num" value="<%=Utilitaire.remplacerNull(request.getParameter("idFact"))%>"size="10" maxlength="10" /></td>
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
                <option value="<%=nomCol[i]%>" <%if (nomCol[i].compareTo(colonne)==0) out.println("selected");%>><%=nomCol[i]%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre"   id="select5">
                <option value="ASC" <%=(ordre.compareTo("ASC")==0?"selected":"") %>>ASC</option>
                <option value="DESC" <%=(ordre.compareTo("DESC")==0?"selected":"") %>>DESC</option>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">            </td>
            <td align="center"> <input type="reset" name="annuler" value="R&eacute;tablir" class="submit">            </td>
          </tr>
        </table></td>
    </tr>
  </table>


</form><br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF">&nbsp;</td>
          <td width="20%" align="right"><div align="center">Nombre</div></td>
          <td width="20%" align="right"><div align="center">Montant Ttc  </div></td>
          <td width="20%" align="right"><div align="center">Montant Tva </div></td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"><div align="center"><%=factRctRs.getSommeEtNombre()[2]%></div></td>
          <td align="right"> <div align="center"><%=Utilitaire.formaterAr(factRctRs.getSommeEtNombre()[0])%></div></td>

          <td align="right">
            <div align="center"><%=Utilitaire.formaterAr(factRctRs.getSommeEtNombre()[1])%></div></td>
        </tr>

      </table>
    </td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <br>
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="66" align="center" valign="top">Num</td>

          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Clients</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant TTC</strong></div></td>

          <td width="102" align="center" valign="top">Montant Tva</td>
        </tr>
        <%
  for(int i=0;i<factF.length; i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="center"><a href="<%=lien%>?but=facture/visualiserFactureClient.jsp&idBC=<%=factF[i].getIdFactureFournisseur()%>&nature=<%=Constante.factureClient%>"><%=factF[i].getIdFactureFournisseur()%></a></td>

          <td align="center"><%=utilitR.formatterDaty(factF[i].getDaty())%></td>
          <td align="right"><%=factF[i].getDesignation()%></td>
                  <td align="center"><%=factF[i].getIdFournisseur()%></td>
          <td align="right"><%=utilitR.formaterAr((double)factF[i].getMontantTTC())%><%=" "+factF[i].getIdDevise()%></td>
          <td align="center"><%=utilitR.formaterAr(factF[i].calculMontantTva()) %>Ar</td>
          <%
    }
  %>
      </table></td>
</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=factRctRs.getSommeEtNombre()[2]%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b><%=nbPage%></td>
</tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy>1){%>
       <a href="<%=lien%>?but=facturefournisseur/listeFactureFRct.jsp<%=suivant%>&pazy=<%=pazy-1%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
  %></td>
    <td width="305" align="right">
      <%
      if(pazy<nbPage){
      %>
      <a href="<%=lien%>?but=facturefournisseur/listeFactureFRct.jsp<%=suivant%>&pazy=<%=pazy+1%>">Page
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
