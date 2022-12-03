<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="ded.Ded" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!


  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
  String action = null;
  Utilitaire utilitR=new Utilitaire();

  FactureFournisseur[] gen= null;
  String nomCol[]=null;
  String  colonne=null;
  String                ordre=null;
  String         dateDebut=null;
  String        dateFin=null;
  String 	 dateDebutEm=null;
  String       dateFinEm=null;
  String       id = null;
  String         num= null;
  String 		designation=null;
  String         tiers=null;
  String              devise = null;
  String        tva= null;

  String typeObjet = null;
  String numObjet = null;
  double montantTotal=0;
  String nature = null;
    %>
<%

  u=(UserEJB)session.getValue("u");
    lien=(String)session.getValue("lien");

     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{
  nature = request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature=Constante.getObjetFactureF();
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="daty";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  dateDebutEm=request.getParameter("dateDebutEm");if ((dateDebutEm==null)||dateDebutEm.compareTo("")==0) dateDebutEm="";
  dateFinEm=request.getParameter("dateFinEm");if ((dateFinEm==null)||dateFinEm.compareTo("")==0) dateFinEm="";
  id = request.getParameter("id");if ((id==null)||id.compareTo("")==0) id="%";
  num= request.getParameter("num");if ((num==null)||num.compareTo("")==0) num="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  tiers=request.getParameter("tiers");if ((tiers==null)||tiers.compareTo("")==0) tiers="%";
  devise = request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  tva= request.getParameter("tva");if ((tva==null)||tva.compareTo("")==0) tva="%";
  gen=u.findEntFact(nature,id, num,designation,tiers,"%","%","%",dateDebut, dateFin, devise);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister <%=nature%> </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant <%=nature%>)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td>

   <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
        <tr>
          <td class="left">Date d&eacute;but :</td>
          <td align="center"><input name="dateDebut" type="text" class="champ"   id="dateDebut" value="<%=dateDebut%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin:</td>
          <td align="center"><input name="dateFin" type="text" class="champ"   id="dateFin" value="<%=dateFin%>" size="10" />
&nbsp; <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
        </tr>

   <tr>
          <td class="left">id :</td>
          <td align="center"><input name="id" type="text" class="champ"   id="id" value="<%=id%>" size="10" maxlength="10" />
&nbsp; </td>
          <td class="left">Tiers:</td>
          <td align="center"><input name="tiers" type="text" class="champ"   id="tiers" value="<%=tiers%>" size="10" />
&nbsp; </td>
        </tr>

   <tr>
          <td class="left">TVA:</td>
          <td align="center"><input name="tva" type="text" class="champ"   id="tva" value="<%=tva%>" size="10" maxlength="10" />
&nbsp; </td>
          <td class="left">Designation:</td>
          <td align="center"><input name="designation" type="text" class="champ"   id="designation" value="<%=designation%>" size="10" />
</td>
        </tr>

   <tr>
          <td class="left">Devise :</td>
          <td align="center"><input name="devise" type="text" class="champ"   id="devise" value="<%=devise%>" size="10" maxlength="10" />
&nbsp;</td>
          <td class="left">Num <%=nature%>:</td>
          <td align="center"><input name="num" type="text" class="champ"   id="num" value="<%=num%>" size="10" />
&nbsp; </td>
        </tr>


       <tr>
          <td class="left">Date d&eacute;but Em.:</td>
          <td align="center"><input name="dateDebutEm" type="text" class="champ"   id="dateDebutEm" value="<%=dateDebutEm%>" size="10" maxlength="10" />
&nbsp; <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle" /></a> </td>
          <td class="left">Date fin Em.:</td>
          <td align="center"><input name="dateFinEm" type="text" class="champ"   id="dateFinEm" value="<%=dateFinEm%>" size="10" />
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


</form>

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

</table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td> <p align="center"><strong><u>RECAPITULATION RECHERCHE</u></strong></p>


      <br>
      <p align="center"><strong><u>LISTE</u></strong></p><form action="<%=lien%>?but=<%=action%>" method="post">

     <input name="typeObjet" type="hidden" value="<%=Constante.getObjetFactureF()%>"> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
 <td align="center" valign="top">-</td>
  <td  align="center" valign="top">Id.</td>
          <td align="center" valign="top">Date</td>
     <td align="right" valign="top"><div align="center">Tiers</div></td>
                   <td align="right" valign="top"><div align="center">Designation</div></td>

          <td align="right" valign="top"><div align="center"><strong>Montant TTC</strong></div></td>
  <td align="center" valign="top">Montant Tva</td>
                            <td align="center" valign="top">Choix</td>

        </tr>
        <%
          for(int i=0;i<gen.length;i++){
  %>

        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
 <td width="66" align="center" valign="top"><input type="radio" value="" name="choix" onMouseDown="getChoix()"> </td>
          <td align="center"><%=utilitR.formatterDaty(gen[i].getDaty())%></td>
          <td align="right"><div align="center"><%=gen[i].getDesignation()%></div></td>
                  <td align="center"><%=gen[i].getIdFournisseur()%></td>
          <td align="right"><%=utilitR.formaterAr((double)gen[i].getMontantTTC())%>Ar</td>
          <td align="center"><%=utilitR.formaterAr(gen[i].getIdTVA()) %>Ar</td>
    <input type="hidden" name="nombre">
                  <td align="center">

<input name="indice" type="radio" id="numObjet" value=<%=i%> onClick=nombre.value=<%=i%>>
<input type="hidden" name="numObjet<%=i%>" value="<%=0%>">
<input type="hidden" name="montantObjet<%=i%>" value="<%=gen[i].getMontantTTC()%>">
</td>



        <%
          }
  %>
      </table>
     <div align="center">
       <input name="bouton" type="submit" value="choix">
     </div>
      </form></td>
</tr>
</table>
<br>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>