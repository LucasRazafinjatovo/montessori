<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="ded/listeOR.jsp";
        String nomFichier="ded/listeOR.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
        Champ champCol[]=null;
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
         String numObjet=null;
                 String typeObjet=null;
        String montantObjet=null;
        TypeObjet source[] =null;
        TypeObjet tlc[] =null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
Oppaye op[] = null;
        double lesMontants[] = null;
        String typeLigne[] = {"Recette","Dépense"};
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;String nature2=null;
String idOP = null;
                String numCompte = null;
                String colonne = null;
                String mois2=null;String mois1=null;
                String chemin=null;
        String dateDebut,dateFin,fournisseur,designationDed;
             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
           String id = null;
           String idDed = null;
           String compteDet = null;
           String etat = null;
           String nature = null;
           int nbResultat=0;
	   double montantTot=0,reste=0;
           String suivant="";


%>
<%
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="OrdonnerPayement";
  nomCol=Utilitaire.getNomColonne(new OrdonnerPayement());
  champCol=ListeColonneTable.getFromListe(new Oppaye(),null);
  idOP=request.getParameter("idOP");if ((idOP==null)||idOP.compareTo("")==0) idOP="%";
  idDed=request.getParameter("idDed");if ((idDed==null)||idDed.compareTo("")==0) idDed="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  designationDed=request.getParameter("designationDed");if ((designationDed==null)||designationDed.compareTo("")==0) designationDed="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  String tempDir=(String)session.getValue("dirlib");
  if((tempDir!=null)&&(tempDir.compareToIgnoreCase("")!=0))
    direction=tempDir;
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];

  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
   mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  etat = request.getParameter("etat");if ((etat==null)||etat.compareTo("")==0) etat="orPayelc";
  String indiceSelection=request.getParameter("indice");

  numObjet=request.getParameter("numObjet");
  typeObjet=request.getParameter("typeObjet");
  montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";

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
        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
        source = u.findTypeObjet("Beneficiaire","%","%");
        tlc = u.findTypeObjet("TypeEntree","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");

        Oppaye crt=new Oppaye();

        crt.setNomTable(etat);
        crt.setId(idOP);
        crt.setDed_Id(idDed);
        crt.setIdLigne(idLC);
        crt.setRemarque(designation);
        if(etat.compareTo("%")!=0)
          crt.setEtat(Utilitaire.stringToInt(etat));
        String apresWhere=" and annee like'"+annee+"' and iddirection like '"+direction+"' and identite like '"+entite+"' and idTypeligne like '"+idType+"'";
        String[]colInt={"daty","mois"};
        String[]valInt={dateDebut,dateFin,mois1,mois2};

//       ResultatEtSomme rsOP=u.findOpPage("orvalide",idOP, idDed, idLC, dateDebut, dateFin,"%",etat,"%", pazy);
        //ResultatEtSomme rsOP=u.findOpPageLc("orLc",idOP, idDed, idLC, dateDebut, dateFin,etat,designation,mois1,mois2,annee,direction,entite,idType,numCompte, pazy);
        String[] nomColSomme={"montant","paye"};
        Calendar a=Calendar.getInstance();
        ResultatEtSomme rsOP=CGenUtil.rechercherPage(crt, colInt, valInt, pazy, apresWhere, nomColSomme,colonne,ordre);
        op=(Oppaye[])rsOP.getResultat();
	   nbResultat=(int)rsOP.getSommeEtNombre()[2];
	   montantTot=rsOP.getSommeEtNombre()[0];
           reste=montantTot-rsOP.getSommeEtNombre()[1];
       nbPage=Utilitaire.calculNbPage(nbResultat);
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
<h1>Lister les Ordres de recettes </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les lignes cr&eacute;dit)</p>
<form action="<%=lien %>?but=<%=nomFichier%>" method="post" name="listeLC" id="listeLC">

  <div align="left">
    <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
	<input type="hidden" name="numObjet" value="<%=numObjet%>">
              <input type="hidden" name="montantObjet" value="<%=montantObjet%>">
    <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
      <tr>
        <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
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
                for(int i=-1;i<2;i++){

                %>
                <option <% if(Integer.parseInt(annee) == (anneeEnCours + i)) out.println("selected");%>><%= (anneeEnCours + i) %></option>
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
                <option value="<%=dir[i].getLibelledir()%>" <%if(dir[i].getLibelledir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getLibelledir()%></option>
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
            <td class="left">etat</td>
            <td>
                        <select name="etat" class="champ" id="etat" >
              <option value="orPayelc">Tous</option>
              <option value="orPayelcAViser"  <%if(etat.compareTo("orPayelcAViser")==0) out.println("selected");%>>non vise</option>
            <option value="orPayelc"  <%if(etat.compareTo("orPayelc")==0) out.println("selected");%>> vise</option>
            </select>

              </td>
          </tr>
 <tr>
            <td class="left">id Facture : </td>
            <td><input name="idDed" type="text" class="champ" id="idDed" value="<%=idDed%>"></td>
            <td class="left">idOP</td>
            <td><input name="idOP" type="text" class="champ" id="idOP" value="<%=idOP%>"></td>
          </tr>
		   <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
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
                    for(int i=0;i<champCol.length;i++){
                  %>
                                   <option value="<%=champCol[i].getNomColonne() %>" <%if(champCol[i].getNomColonne().compareTo(colonne)==0) out.println("selected");%>><%=champCol[i].getNomColonne()%></option>
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
  </div>
</form>
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF">&nbsp;</td>
          <td width="20%" align="right"><div align="center">Nombre</div></td>
          <td width="20%" align="right"><div align="center">Montant  </div></td>
          <td width="20%" align="right"><div align="center">Reste </div></td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"><div align="center"><%=nbResultat%></div></td>
          <td align="right"> <div align="center"><%=Utilitaire.formaterAr(montantTot)%></div></td>

          <td align="right">
            <div align="center"><%=Utilitaire.formaterAr(reste)%></div></td>
        </tr>

      </table>
    </td>
  </tr>
</table>
 <br />



      <p align="center"><strong><u>LISTE</u></strong></p>
 <input name="nature" type="hidden" value="<%=nature%>">
    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="66" align="center" valign="top">id</td>
          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">id Facture </div></td>
          <td width="153" align="right" valign="top"><div align="center">id Ligne </div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant </strong></div></td>
  <td width="102" align="center" valign="top">Designation</td>
  <td width="102" align="center" valign="top">Paye</td>


        </tr>
        <%
  for(int i=0;i<op.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="center"><a href="<%=lien%>?but=ded/visualiserOR.jsp&idOP=<%=op[i].getId()%>"><%=op[i].getId()%></a></td>
          <td align="center"><%=Utilitaire.formatterDaty(op[i].getDaty())%></td>
          <td align="right"><a href="<%=lien%>?but=facture/visualiserFactureClient.jsp&idBC=<%=op[i].getDed_Id()%>&nature=FACTURECLIENT"><%=op[i].getDed_Id()%></a></td>
                  <td align="center"><a href="<%=lien%>?but=lc/visualiserDetailLCRecette.jsp&numObjet=<%=op[i].getIdLigne()%>"><%=op[i].getIdLigne()%></a></td>
          <td align="right"><%=Utilitaire.formaterAr((double)op[i].getMontant())%></td>
          <td align="center"><%=op[i].getRemarque() %></td>
		  <td align="center"><%=Utilitaire.formaterAr(op[i].getPaye() ) %></td>
        <%
    }
  %>
</table>
   <br />
   <!-- Pagination -->


<br />


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td height="25"><b>Nombre de r&eacute;sultat :</b> <%=nbResultat%></td>
    <td align="right"><strong>page</strong> <%=pazy%> <b>sur</b> <%=nbPage%></td>
  </tr>
  <tr>
    <td width="295" valign="top" height="25">
      <%if(pazy>1){%>
<!--    <a href="<%=lien %>?but=ded/listeOR.jsp&pazy=<%=(pazy-1)%>&idOP=<%=Utilitaire.remplacePourcentage(idOP)%>&idDed=<%=Utilitaire.remplacePourcentage(idDed)%>&dateDebut=<%=Utilitaire.remplacePourcentage(dateDebut)%>&dateFin=<%=Utilitaire.remplacePourcentage(dateFin)%>&idLC=<%=Utilitaire.remplacePourcentage(idLC)%>">&lt;&lt;Page pr&eacute;c&eacute;dente</a> -->
        <a href="<%=lien %>?but=ded/listeOR.jsp<%=suivant%>&pazy=<%=pazy-1%>">&lt;&lt;Page pr&eacute;c&eacute;dente</a>
  <%
                }

           %></td>
    <td width="305" align="right">
      <%
             if(pazy<nbPage){
             %>
      <a href="<%=lien %>?but=ded/listeOR.jsp<%=suivant%>&pazy=<%=pazy+1%>">Page suivante&gt;&gt;</a>
      <%
            }
              %></td>
  </tr>
</table>
