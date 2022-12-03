<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="ded/listeChoixDed.jsp";
        String nomFichier="ded/listeChoixDed.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
                 String numObjet=null;
                 String typeObjet=null;
        String montantObjet=null;
        TypeObjet source[] =null;
        TypeObjet tlc[] =null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
OrdonnerPayement op[] = null;
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
        String idDED,dateDebut,dateFin,fournisseur,designationDed;
             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
           String id = null;
String idDed = null;
           String compteDet = null;
           String etat = null;

%>
<%
nature2=request.getParameter("nature2");if ((nature2==null)||nature2.compareTo("")==0) nature2="ded";
  nomCol=Utilitaire.getNomColonne(new DedLc());
  idOP=request.getParameter("idOP");if ((idOP==null)||idOP.compareTo("")==0) idOP="%";
  idDED=request.getParameter("idDed");if ((idDED==null)||idDED.compareTo("")==0) idDED="%";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  designationDed=request.getParameter("designationDed");if ((designationDed==null)||designationDed.compareTo("")==0) designationDed="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="id";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
   mois2=request.getParameter("mois2");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  String indiceSelection=request.getParameter("indice");

  numObjet=request.getParameter("numObjet");
  typeObjet=request.getParameter("typeObjet");
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
        tlc = u.findTypeObjet("TypeLigneCredit","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        System.out.println(idOP+"  "+idDED+"  "+idLC+" ||  "+dateDebut+"  || "+dateFin);
        ResultatEtSomme rsOP=u.findOpPage(idOP, idDED, idLC, dateDebut, dateFin,"%","%","%", pazy);
System.out.println("apres RS");
       op=(OrdonnerPayement[])rsOP.getResultat();

System.out.println("op");
        nbPage=Utilitaire.calculNbPage(op);
System.out.println("nbPage===W>"+nbPage);

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
<h1>Lister les Ordres de paiement </h1>
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
 <tr>
            <td class="left">idDed: </td>
            <td><input name="idDed" type="text" class="champ" id="idDed" value="<%=idDED%>"></td>
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
  </div>
</form><br>
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num <%=typeObjet%></td>
    <td width="73%"><div align="center"><%=numObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Nature de l'objet</td>
    <td><div align="center"><%=typeObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><%=Utilitaire.formaterAr(Utilitaire.stringToDouble(montantObjet))%> Ar </div></td>
  </tr>
</table><br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>::RECAPITULATION::</u></strong></p>

      <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="10%" align="right" bgcolor="#C300FF"><strong>Type LC</strong></td>
          <td width="20%" align="right">Nombre</td>
          <td width="20%" align="right">Montant  </td>
        </tr>
        <tr class="head" >
          <td align="right" bgcolor="#C300FF"><div align="right"><strong>Total:</strong></div></td>
          <td align="right"></td>
          <td align="right"> </td>

        </tr>

      </table>
    </td>
  </tr>
</table>
 <br />



   <form action="<%=lien%>?but=ded/apresListeChoixOP.jsp" method="POST" name="frmListe" id="frmListe">
      <p align="center"><strong><u>LISTE</u></strong></p>
    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
    <td width="66" align="center" valign="top"></td>
          <td width="66" align="center" valign="top">Date</td>
                   <td width="153" align="right" valign="top"><div align="center">id Ded </div></td>
          <td width="153" align="right" valign="top"><div align="center">id Ligne </div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>Montant </strong></div></td>
  <td width="102" align="center" valign="top">Remarque</td>
  <td width="102" align="center" valign="top">etat</td>


        </tr>
        <%
  for(int i=0;i<op.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
  <td align="center"><input name="idLC" class="radio"  type='checkbox' value="<%=op[i].getId()%>"></td>
          <td align="center"><%=Utilitaire.formatterDaty(op[i].getDaty())%></td>
          <td align="right"><%=op[i].getIdDed()%></td>
                  <td align="center"><%=op[i].getIdLigne()%></td>
          <td align="right"><%=Utilitaire.formaterAr((double)op[i].getMontant())%></td>
          <td align="center"><%=Utilitaire.formaterAr(op[i].getRemarque()) %></td>
		  <td align="center"><%=Utilitaire.formaterAr(op[i].getEtat()) %></td>
    <input type="hidden" name="nombre">



        <%
    }
  %>
      </table>
     <div align="center">

 <input type="submit" value="selectionner">
        <input type="hidden" name="numObjet" value="<%=numObjet%>">
                <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
                <input type="hidden" name="montantObjet" value="<%=montantObjet%>">
  <input type="hidden" name="nature2" value="<%=nature2%>">
     </div>
   </form>
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