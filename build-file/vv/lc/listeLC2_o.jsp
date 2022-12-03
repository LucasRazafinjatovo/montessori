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
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();

        TypeObjet source[] =null;
        TypeObjet tlc[] =null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
        LigneCreditComplet lcc[]= null;
        double lesMontants[] = null;
        String typeLigne[] = {"Recette","Dépense"};
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
		String paruInf,paruSup;
                String numCompte = null;
                String colonne = null;
                String mois2=null;String mois1=null;
                String chemin=null;

             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
           String suivant = null;

%>
<%
  nomCol=Utilitaire.getNomColonne(new LigneCreditComplet());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  String tempDir=(String)session.getValue("dir");
  System.out.println("DIR LIB=== "+tempDir);
  if((tempDir!=null)&&(tempDir.compareToIgnoreCase("%")!=0))
    direction=tempDir;
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idLigne";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
   mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
   paruInf=request.getParameter("paruInf");if ((paruInf==null)||paruInf.compareTo("")==0) paruInf= "";
   paruSup=request.getParameter("paruSup");if ((paruSup==null)||paruSup.compareTo("")==0) paruSup= "";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  suivant = "&mois2="+Utilitaire.remplacePourcentage(request.getParameter("mois2"))+"&nature="+Utilitaire.remplacePourcentage(request.getParameter("nature"))+"&idOP="+Utilitaire.remplacePourcentage(request.getParameter("idOP"))+"&idDed="+Utilitaire.remplacePourcentage(request.getParameter("idDed"))+"&dateDebut="+Utilitaire.remplacePourcentage(request.getParameter("dateDebut"))+"&dateFin="+Utilitaire.remplacePourcentage(request.getParameter("dateFin"))+"&fournisseur="+Utilitaire.remplacePourcentage(request.getParameter("fournisseur"))+"&designationDed="+Utilitaire.remplacePourcentage(request.getParameter("designationDed"))+"&designation="+Utilitaire.remplacePourcentage(request.getParameter("designation"))+"&idType="+Utilitaire.remplacePourcentage(request.getParameter("idType"))+"&idLC="+Utilitaire.remplacePourcentage(request.getParameter("idLC"))+"&direction="+Utilitaire.remplacePourcentage(request.getParameter("direction"))+"&entite="+Utilitaire.remplacePourcentage(request.getParameter("entite"));
  suivant = suivant+"&ordre="+Utilitaire.remplacePourcentage(request.getParameter("ordre"))+"&numCompte="+Utilitaire.remplacePourcentage(request.getParameter("numCompte"))+"&colonne="+Utilitaire.remplacePourcentage(request.getParameter("colonne"))+"&mois1="+Utilitaire.remplacePourcentage(request.getParameter("mois1"))+"&annee="+Utilitaire.remplacePourcentage(request.getParameter("annee"))+"&etat="+Utilitaire.remplacePourcentage(request.getParameter("etat"))+"&indiceSelection="+Utilitaire.remplacePourcentage(request.getParameter("indiceSelection"))+"&numObjet="+Utilitaire.remplacePourcentage(request.getParameter("numObjet"))+"&typeObjet="+Utilitaire.remplacePourcentage(request.getParameter("typeObjet"))+"&montantObjet="+Utilitaire.remplacePourcentage(request.getParameter("montantObjet"));
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
   TypeObjet crt=new TypeObjet();

        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
        crt.setNomTable("Beneficiaire");
        source=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by val asc");
        //source = u.findTypeObjet("Beneficiaire","%","%");
        crt.setNomTable("typesortieliste");
        tlc=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by val asc");
        //tlc = u.findTypeObjet("typesortieliste","%","%");
        crt.setNomTable("comptecompta");
        compte=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by val asc");
        //compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        lcc=u.findFCCParution(idLC,designation,mois1,mois2,idType,numCompte,"%","%","%",entite,direction,colonne,ordre, annee,paruInf,paruSup,"lignecreditcomplet");

        lesMontants = AdminLigneCreditComplet.getAllSommeMontantLC(lcc);
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
<form action="<%=lien %>?but=lc/listeLC2.jsp" method="post" name="listeLC" id="listeLC">
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
            <td class="left">Parution inf  :</td>
            <td>
              <input name="paruInf" type="text" class="champ" id="paruInf" value="<%=paruInf%>"></td>
            <td class="left">Parution sup :</td>
            <td>
              <input name="paruSup" type="text" class="champ" id="paruSup" size="10" value="<%=paruSup%>"></td>
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

<table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="rigth" bgcolor="#C300FF"><strong>Type LC</strong></td>
          <td width="20%" align="center">Crédit</td>
          <td width="20%" align="center">Consommes</td>
          <td width="20%" align="center">Op vise</td>
 <td width="20%" align="center">Factures</td>
          <td width="20%" align="center">Fact - Op</td>
          <td width="10%" align="center"><strong>Nbr LC</strong></td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[1]) %> </td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[2]) %> </td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[3]) %> </td>
 <td align="right"><%=Utilitaire.formaterAr(lesMontants[4]) %> </td>
          <td align="right"><%=Utilitaire.formaterAr(lesMontants[4]-lesMontants[3]) %> </td>
          <td align="right"><strong><%=lesMontants[5] %></strong></td>
        </tr>

      </table>
    </td>
  </tr>
</table>
 <br />



   <form action="apreschoixLC.jsp" methode="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="25%" valign="top"><div align="center">D&eacute;signation</div></td>
          <td width="12%" height="19" valign="top"><div align="center"><strong>Crédit</strong></div></td>
          <td width="12%" valign="top"><div align="center"><strong>consomme</strong></div></td>
 <td width="12%" valign="top"><div align="center"><strong>op vise</strong></div></td>
 <td width="12%" valign="top"><div align="center"><strong>fact vise</strong></div></td>
          <td width="10%" valign="top"><div align="center"><strong>Type</strong></div></td>
          <td width="10%" align="center" valign="top"><strong>Direction</strong></td>
          <td width="13%" valign="top"><div align="center"><strong>Mois</strong></div></td>
          <td width="11%" valign="top"><div align="center"><strong>ID LC</strong></div></td>
        </tr>
        <%
  for(int i=indiceDebut;i<indiceFin;i++){
  %>
        <tr>
          <td align="left" valign="top"><div align="left"><%=lcc[i].getDesignation()%></div></td>
          <td align="right" valign="top"><%=Utilitaire.formaterAr(lcc[i].getCreditModifier())%></td>
          <td align="right" valign="top"><div align="right">
                         <%
                              chemin = lien.concat("?but=finance/listeMvtCaisse.jsp&idLC="+lcc[i].getIdLigne());
                %>
                      <a href="<%=chemin %>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(lcc[i].getMontantEng())  %></a>
                      </div>
          </td>
          <td align="right" valign="top"><div align="right">
                         <%
                              chemin = lien.concat("?but=ded/listeOP.jsp&idLC="+lcc[i].getIdLigne());
                %>
                      <a href="<%=chemin %>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(lcc[i].getMontantVis() )  %></a>
                      </div>
          </td>
          <td align="right" valign="top"><div align="right">
                         <%
                              chemin = lien.concat("?but=facturefournisseur/critereEntreFactureOp.jsp&idLC="+lcc[i].getIdLigne());
                %>
                      <a href="<%=chemin %>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(lcc[i].getMontantFac())  %></a>
                      </div>
          </td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getTypeLC()%></div></td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getAbbrevdir()%></div></td>
          <td align="right" valign="top"><div align="center"><%=lcc[i].getMois()%></div></td>
          <td align="right"><div align="center"><a href="<%=lien %>?but=lc/visualiserDetailLC.jsp&numObjet=<%=lcc[i].getIdLigne()%>" title="idLigne =<%=lcc[i].getIdLigne()%> enttite = <%=lcc[i].getEntite() %> annee=<%=lcc[i].getAnnee()%>"><%=lcc[i].getIdLigne()%></a> </div></td>

        </tr>
        <%
  }
  %>
     </table>
   </form>
   <br />
   <!-- Pagination -->
   <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
        <tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=lcc.length%></td><td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%=Math.floor(lcc.length/nbParPazy)+1%></td>
        </tr>
            <tr>
            <td width="295" valign="top" height="25">
                <%if(pazy>1){%>
                <a href="<%=lien %>?but=lc/listeLC2.jsp<%=suivant%>&pazy=<%=(pazy-1)%>">&lt;&lt;Page
                      pr&eacute;c&eacute;dente</a>
                <%
                }

           %></td>
           <td width="305" align="right">
             <%
             if(pazy<nbPage){
             %>
             <a href="<%=lien %>?but=lc/listeLC2.jsp<%=suivant%>&pazy=<%=(pazy+1)%>">Page
             suivante&gt;&gt;</a>
             <%
            }
              %></td>
          </tr>
</table>

<br />
<%
        if(request.getParameter("acte")!=null){
                LigneCreditComplet l = u.findLCComplet(request.getParameter("idLCDetail"),"","","","","","","","","","idLigne","ASC","","lignecreditcomplet")[0];
                %>
                <p align="center"><strong><u>Détail Ligne Crédit</u></strong></p>
      <table width="75%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
              <tr>
              <td width="40%" height="25" class="left">Id Ligne Crédit:</td>
              <td><%=l.getIdLigne() %></td>
              </tr>
                <tr>
              <td height="25" class="left">Désignation:</td>
              <td><%=l.getDesignation() %></td>
              </tr>
              <tr>
              <td height="25" class="left">Type d'utilisation:</td>
              <td><%=l.getTypeLC() %></td>
              </tr>
              <tr>
              <td height="25" class="left">Crédit Initial:</td>
              <td><%=Utilitaire.formaterAr(l.getCreditInitial()) %></td>
              </tr>
              <tr>
              <td height="25" class="left">Crédit Actuel:</td>
              <td><%=Utilitaire.formaterAr(l.getCreditModifier()) %></td>
              </tr>
              <tr>
              <td height="25" class="left">Crédit Dispo:</td>
              <td><%=Utilitaire.formaterAr(l.getCreditModifier()-l.getMontantEng()) %></td>
              </tr>
              <tr>
              <td height="25" class="left">Montant Engagé:</td>
              <td>
              <% if(l.getTypeLC().compareToIgnoreCase("Recette")==0)
                              chemin = lien.concat("?but=finance/listeEntree.jsp&idLigne="+l.getIdLigne());
                       else
                              chemin = lien.concat("?but=finance/listeSortie.jsp&idLigne="+l.getIdLigne());
             if(l.getMontantEng() != 0){
                %>
                      <a href="<%=chemin %>" title="Cliquer ici pour afficher les détails"><%=Utilitaire.formaterAr(l.getMontantEng())  %></a>
                      <% } else {out.println(Utilitaire.formaterAr(l.getMontantEng())); }%>
              </td>
              </tr>
              <tr>
              <td height="25" class="left">Montant Visa:</td>
              <td><%=Utilitaire.formaterAr(l.getMontantVis()) %></td>
              </tr>
              <tr>
              <td height="25" class="left">Montant Facturé:</td>
              <td><%=Utilitaire.formaterAr(l.getMontantFac()) %></td>
              </tr>
              <tr>
              <td height="25" class="left">Direction:</td>
              <td><%=l.getLibelledir()+" ("+l.getAbbrevdir()+")" %></td>
              </tr>
              <tr>
              <td height="25" class="left">Entité:</td>
              <td><%=l.getEntite() %></td>
              </tr>
              <tr>
              <td height="25" class="left">Num Compte:</td>
              <td><%=l.getNumCompte()+ " ("+l.getDescCompte()+")" %></td>
              </tr>
              <tr>
              <td height="25" class="left">Excercice:</td>
              <td><%=l.getMois()+ " "+l.getAnnee() %></td>
              </tr>
                <tr>
              <td height="25" class="left">Remarque:</td>
              <td><%=l.getParution() %></td>
              </tr>
</table>
                <%
        }
%>

