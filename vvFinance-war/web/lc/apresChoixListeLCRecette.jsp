<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="lc/apresChoixListeLCRecette.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        Champ nomCol[]=null;
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
		 String numObjet=null;
		 String typeObjet=null;
		 String montantObjet=null;
		 String[]idLcArecup=null;

        TypeObjet source[] =null;
        TypeObjet tlc[] =null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
        UnionIntraTable[] lcc= null;
		LigneCreditComplet lccAchoix[]= null;
        double lesMontants[] = null;
        String typeLigne[] = {"Recette","D�pense"};
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
                String numCompte = null;
                String colonne = null;
                String mois2=null;String mois1=null;
                String chemin=null;

             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
           FactureFournisseur bc[] = null;

%>
<%
  //nomCol=utilitaire.Utilitaire.getNomColonne(new LigneCredit());
  nomCol=ListeColonneTable.getFromListe(new LigneCreditComplet(),null);
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idLigne";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
   mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet="%";
	idLcArecup=request.getParameterValues("idLC");
montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";

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
        tlc = u.findTypeObjet("TypeEntreeliste","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        UnionIntraTableUtil uit=new UnionIntraTableUtil();
        uit.setNomTable("factureClientlcdetail");
        lcc = (UnionIntraTable[])uit.rechercher(2,numObjet);
        FactureFournisseur crt=new FactureFournisseur();
        crt.setIdFactureFournisseur(numObjet);
        crt.setNomTable("FACTURECLIENTLETTRE");
        bc=(FactureFournisseur[])CGenUtil.rechercher(crt, null,null,"");
        //bc=u.findFactureFournisseur("FACTURECLIENTLETTRE", numObjet, "", "", "%","%","daty","asc", "");
        if(bc.length==0) throw new Exception("Facture client non existante");
        lccAchoix=u.findFCC(idLC,designation,mois1,mois2,idType,numCompte,"%","%","%",entite,direction,colonne,ordre, annee,"lignecreditRecetteComplet");
        lesMontants = AdminLigneCreditComplet.getAllSommeMontantLC(lccAchoix);
        indiceDebut=Utilitaire.getBornePage(pazy,lccAchoix)[0];
        indiceFin=Utilitaire.getBornePage(pazy,lccAchoix)[1];
        nbPage=Utilitaire.calculNbPage(lccAchoix);
}
catch (Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<script type="text/javascript">

 function getChoix(){
  setTimeout("document.frmChoix.submit()",800);
}
function calculere(i)
{
var c;
var somme=0;
for(c=0;c<i;c++)
{
  var ge=document.getElementsByName("montant"+c)[0];
  var reg=new RegExp("[%]", "g");
  if(ge.value.indexOf("%")!=-1)
  {
    var tableau=ge.value.split(reg);
    ge.value=parseFloat(document.getElementsByName("montantObjet")[0].value)*parseFloat(tableau[0])/100;
  }
  somme=somme+parseFloat(eval(ge.value));
  ge.value=eval(ge.value);
}
var h=document.getElementsByName("total")[0];
h.value=somme;
}
</script>


<link href="style.css" rel="stylesheet" type="text/css">
<form action="<%=lien%>?but=lc/updateLCRecetteJointure.jsp" method="POST" name="frmListe" id="frmListe">
  <p align="center"><strong><u>LISTE SELECTION </u></strong></p>
  <p align="center"><u><strong><a title="montant=<%=bc[0].getMontantTTC()%> et client = <%=bc[0].getIdFournisseur()%>" href=<%=lien%>?but=facture/visualiserFactureClient.jsp&idBC=<%=numObjet%>&nature=<%=Constante.objetFactureClient%>>Voir d&eacute;tails facture Client num <%=numObjet%></a></strong></u></p>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr class="head">
      <td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
      <td width="10%" align="center" valign="top"><strong>Entite</strong></td>

      <td width="7%" valign="top"><div align="center"><strong>Montant</strong></div></td>
      <td width="5%" valign="top"><div align="center"><strong>ID LC</strong></div></td>
<td width="6%" valign="top"><div align="center"><strong>Suppr</strong></div></td>
    </tr>
    <%
  for(int i=0;i<lcc.length;i++){
  %>
    <tr>
      <td align="left" valign="top"><div align="left"><%=lcc[i].getRemarque()%></div></td>

  <input name="idLC<%=i%>" type="hidden" class="champ" value=<%=lcc[i].getId2()%>>
      <td align="right" valign="top"><div align="center"><%=lcc[i].getEtat()%></div></td>
      <td align="right" valign="top"><div align="center">
  <%if (lcc[i].estIlModifiable()==true) {%>
          <input name="montant<%=i%>" type="text" class="champ" value=<%=lcc[i].getMontantMere()%> >
  <%}
  else{
%>
    <input name="montant<%=i%>" type="text" class="champ" value=<%=lcc[i].getMontantMere()%> disabled="disabled">
    <%}%>
      </div></td>
      <td align="right"><div align="center"><a href="<%=lien %>?but=lc/visualiserDetailLCRecette.jsp&numObjet=<%=lcc[i].getId2()%>"><%=lcc[i].getId2()%></a> </div></td>
     <td align="right"><div align="center"><a href="<%=lien %>?but=lc/updateLCRecetteJointure.jsp&idUnion=<%=lcc[i].getId()%>&acte=delete&numObjet=<%=lcc[i].getId1()%>">X</a> </div></td>

    </tr>
    <%
  }
  %>
  </table>
  <div align="center">
    <input type="hidden" name="acte" value="update">
  <input type="hidden" name="nb" value="<%=lcc.length%>">
    <input name="submit" type="submit" value="enregistrer" onClick="acte.value='update'">
    <input type="hidden" name="numObjet" value="<%=numObjet%>">
    <input type="hidden" name="montantObjet" value="<%=bc[0].getMontantTTC() %>">
    <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
	<input type="hidden" name="avecOp" value="<%=request.getParameter("avecOp")%>">
    <input name="submit" type="submit" value="valider" onClick="acte.value='svalide'">
  <input name="calculer" type="button" value="calculer" onClick='calculere(<%=lcc.length%>)'>
  <input name="total" type="text" value="0">
  </div>
</form>
<h1>&nbsp;</h1>
<h1>Lister les lignes cr&eacute;dit</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les lignes cr&eacute;dit)</p>
<form action="<%=lien %>?but=lc/apresChoixListeLCRecette.jsp&numObjet=<%=numObjet%>" method="post" name="listeLC" id="listeLC">
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
            <td class="left">Mois 1:</td>
            <td ><select name="mois1" class="champ" id="mois1">
                <option value="%">Tous</option>
              <%
          for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois1)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
              </select></td>
            <td class="left">Mois 2:</td>
            <td><select name="mois2" class="champ" id="mois2">
              <option value="%">Tous</option>
              <%
          for(int i=0;i<mois.length;i++){
          %>
              <option value="<%=moisRang[i]%>" <%if(moisRang[i].compareTo(mois2)==0)out.print(" selected");%>><%=mois[i]%></option>
              <%
                }
                %>
            </select></td>
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
            <td class="left">Direction: </td>
            <td align="center"> <div align="left">
              <select name="direction" class="champ" id="select2">
                <option value="%">Tous</option>
                <%
for(int i=0;i<dir.length;i++){
%>
                <option value="<%=dir[i].getIdDir()%>" <%if(dir[i].getIdDir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getAbbrevDir()%></option>
                <%
}
%>
              </select>

              </div></td>
          </tr>
          <tr>
            <td class="left">Num Compte:</td>
            <td><input name="numCompte" type="text" class="champ" id="numCompte3" size="10" value="<%=numCompte %>"> </td>
            <td class="left">Entit&eacute;:</td>
            <td><select name="entite" class="champ" id="select">
              <option value="%">Tous</option>
              <%
for(int i=0;i<source.length;i++){
%>
              <option value="<%=source[i].getVal()%>" <%if(source[i].getVal().compareTo(entite)==0) out.println(" selected ");%>><%=source[i].getVal()%></option>
              <%
}
%>
            </select> </td>
          </tr>
          <tr>
            <td class="left">Type LC: </td>
            <td><select name="idType" class="champ" id="idType" >
              <option value="%">Tous</option>
              <%
          for(int i=0;i<tlc.length;i++){
          %>
              <option value="<%=tlc[i].getVal()%>"  <%if(tlc[i].getVal().compareTo(idType)==0) out.println("selected");%>><%=tlc[i].getVal()%></option>
              <%
                }
                %>
            </select></td>
            <td class="left">&nbsp;</td>
            <td>&nbsp;</td>
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
                <option value="<%=nomCol[i].getNomColonne()%>"<%if (nomCol[i].getNomColonne().compareTo(colonne)==0) out.println("selected");%>><%=nomCol[i].getNomColonne()%></option>
                <%
   }
 %>
              </select> &nbsp;
            </td>
            <td class="left"><div align="center">Ordre :</div></td>
            <td align="center"> <select name="ordre" class="champ" id="ordre">
                <option value="ASC" <%=(ordre.compareTo("ASC")==0?"selected":"") %>>Croissante</option>
                <option value="DESC" <%=(ordre.compareTo("DESC")==0?"selected":"") %>>D�croissante</option>
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

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF"><strong>Type LC</strong></td>
          <td width="20%" align="right">Cr�d Init</td>
          <td width="20%" align="right">Cr�d Modif</td>
          <td width="20%" align="right">Mont Eng</td>
          <td width="20%" align="right">Cr�d Dispo</td>
          <td width="10%" align="right"><strong>Nbr LC</strong></td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"><%=utilitaire.Utilitaire.formaterAr(lesMontants[0]) %> </td>
          <td align="right"><%=utilitaire.Utilitaire.formaterAr(lesMontants[1]) %> </td>
          <td align="right"><%=utilitaire.Utilitaire.formaterAr(lesMontants[2]) %> </td>
          <td align="right"><%=utilitaire.Utilitaire.formaterAr(lesMontants[1]-lesMontants[2]) %> </td>
          <td align="right"><strong><%=utilitaire.Utilitaire.formaterAr(lesMontants[5]) %></strong></td>
        </tr>

      </table>
    </td>
  </tr>
</table>
 <br />



   <form action="<%=lien%>?but=lc/saveLCJointureRecette.jsp" method="POST" name="frmChoix" id="frmChoix">
     <p align="center"><strong><u>LISTE Choix </u></strong></p>
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
       <!--DWLayoutTable-->
       <tr class="head">
         <td width="5%" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
         <td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
         <td width="12%" height="19" valign="top"><div align="center"><strong>Cr&eacute;dit Actuel</strong></div></td>
         <td width="12%" valign="top"><div align="center"><strong>Mont Eng</strong></div></td>
         <td width="10%" valign="top"><div align="center"><strong>Type</strong></div></td>
         <td width="10%" align="center" valign="top"><strong>Direction</strong></td>
         <td width="13%" valign="top"><div align="center"><strong>Mois</strong></div></td>
         <td width="11%" valign="top"><div align="center"><strong>ID LC</strong></div></td>
       </tr>
       <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
       <tr>
         <td align="left" valign="top"><div align="center">
           <span class="tdc1">
           <input name="idLC" onMouseDown="getChoix()" class="radio"  type="checkbox" value="<%=lccAchoix[i].getIdLigne()%>">
         </span> </div></td>
         <td align="left" valign="top"><div align="left"><%=lccAchoix[i].getDesignation()%></div></td>
         <td align="right" valign="top"><%=utilitaire.Utilitaire.formaterAr(lccAchoix[i].getCreditModifier())%></td>
         <td align="right" valign="top"><div align="right">
             <%
             if(lccAchoix[i].getMontantEng() != 0){
                %>
             <a href="<%=lien+"?but=finance/listeSortie.jsp&idLigne="+lccAchoix[i].getIdLigne() %>" title="Cliquer ici pour afficher les d&eacute;tails"><%=Utilitaire.formaterAr(lccAchoix[i].getMontantEng())  %></a>
             <% } else {out.println(Utilitaire.formaterAr(lccAchoix[i].getMontantEng())); }%>
         </div></td>
         <td align="right" valign="top"><div align="center"><%=lccAchoix[i].getTypeLC()%></div></td>
         <td align="right" valign="top"><div align="center"><%=lccAchoix[i].getAbbrevdir()%></div></td>
         <td align="right" valign="top"><div align="center"><%=lccAchoix[i].getMois()%></div></td>
         <td align="right"><div align="center"><a href="<%=lien %>?but=lc/visualiserDetailLC.jsp&numObjet=<%=lccAchoix[i].getIdLigne()%>"><%=lccAchoix[i].getIdLigne()%></a> </div></td>
       </tr>
       <%
  }
  %>
     </table>
     <div align="center">
       <input type="hidden" name="acte" value="ajout">
       <input type="hidden" name="numObjet" value="<%=numObjet%>">
       <input type="hidden" name="montantObjet" value="<%=montantObjet%>">
       <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
  <input name="bouton" type="submit" value="choix">
     </div>
   </form>
   <br />
   <!-- Pagination -->
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
       <tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=lcc.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%=Math.floor(lcc.length/nbParPazy)+1%></td>
       </tr>
           <tr>
           <td width="295" valign="top" height="25">
               <%if(pazy>1){%>
               <a href="<%=lien %>?but=lc/apresChoixListeLCRecette.jsp&pazy=<%=(pazy-1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>">&lt;&lt;Page
                     pr&eacute;c&eacute;dente</a>
               <%
               }

          %></td>
          <td width="305" align="right">
            <%
            if(pazy<nbPage){
            %>
            <a href="<%=lien %>?but=lc/apresChoixListeLCRecette.jsp&pazy=<%=(pazy+1)%>&numCompte=<%=Utilitaire.remplacePourcentage(numCompte) %>&entite=<%=Utilitaire.remplacePourcentage(entite) %>&designation=<%=Utilitaire.remplacePourcentage(designation) %>&mois=<%=Utilitaire.remplacePourcentage(mois2) %>&annee=<%=Utilitaire.remplacePourcentage(annee) %>&direction=<%=Utilitaire.remplacePourcentage(direction) %>&idType=<%=Utilitaire.remplacePourcentage(idType) %>&colonne=<%=colonne%>&ordre=<%=ordre%>&numObjet=<%=numObjet%>&typeObjet=<%=typeObjet%>&montantObjet=<%=montantObjet%>">&lt;&lt;Page
            suivante&gt;&gt;</a>
           <%
           }
             %></td>
         </tr>
</table>
<script language="JavaScript">
  <!--
//-->
 function getChoix(){
                document.forms["frmChoix"].submit();
}
 </script>