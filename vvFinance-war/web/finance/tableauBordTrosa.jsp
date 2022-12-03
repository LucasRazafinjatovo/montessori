<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="finance/tableauBordTrosa.jsp";
  String lien= null;
  UserEJB u = null;
  Entree entree[] = null;
  Sortie sort[]= null;
  TypeObjet mp[] =null;
  ResultatGroupe[] rg, rs;
  Caisse caiss[] = null;
  Caisse c[] = null;//asiana an'le caisse rehefa filtrena
  TypeObjet sel=null;
  String  idModePaiement, dateDebut, dateFin;


 %>
<%
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     caiss = u.findCaisse("%","%","%","%") ;

%>
<%
  try{
  idModePaiement=request.getParameter("idModePaiement"); if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="BE011";
  sel=(TypeObjet)Utilitaire.extraire(mp,2,idModePaiement);
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="01/01/2008";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  entree = u.findEntreeLettre("%", dateDebut,dateFin,"%", "trosa","%","%","%", "%", "%", "eta2","%","%","daty","DESC",idModePaiement,"%", "");//n'affiche que les entrees crees seulement, n'affiche pas le annulees
  sort= u.findSortieAgence("%",dateDebut,dateFin,"%","TS018","%", "%", "%","%", "eta2","%","%","daty","DESC", idModePaiement,"%", "", "");//n'affiche que les sorties crees seulement, n'affiche pas le annulees
  rg=AdminEntree.findGroupe(entree,14,3);
  rs=AdminGen.findGroupe(sort,4,3);

  //c=(Caisse[])Utilitaire.extraireTab(caiss,3,idModePaiement);
  c=AdminCaisse.filtreCaisseByResp(caiss,idModePaiement);
  //ireto ny Beneficiaire manana caisse double
  if(idModePaiement.compareToIgnoreCase("BE011")==0) c[0]= new Caisse("CE000026","C Hary VV","%","%");
  else if(idModePaiement.compareToIgnoreCase("BE000060")==0) c[0]= new Caisse("CE000100","Activa","%","%");
  else if(idModePaiement.compareToIgnoreCase("BE005")==0) c[0]= new Caisse("CE000040","C Jrews Info","%","%");
  else if(idModePaiement.compareToIgnoreCase("BE012")==0) c[0]= new Caisse("CE000061","C Ressources","%","%");
  else {
    if(c==null){
          c = new Caisse[1];
          c[0]= new Caisse("%","%","%","%");
     }

  }
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Situation Emprunt</h1>
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
            <td height="25" class="left">Source</td>
            <td align="center"> <select name="idModePaiement" class="champ" id="idModePaiement">
                <!--option value="%">Tous</option-->
                <%
   for(int i=0;i<mp.length;i++){
 %>
                <option value=<%=mp[i].getId()%> <%if(mp[i].getId().compareTo(idModePaiement)==0)out.print("selected");%>><%=mp[i].getVal()%></option>
                <%
   }
 %>
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
          <td width="15%"  height="25" align="center" bgcolor="#C300FF"><strong>Somme de la page</strong></td>
          <td width="25%" align="right"><div align="center">Mt de Entite vers <%=sel.getVal()%></div></td>
          <td width="10%" align="center"><div align="center">Nb de Entite vers <%=sel.getVal()%></div></td>
          <td width="25%" align="center"><div align="center">Mt de <%=sel.getVal()%> vers Entite</div></td>
          <td width="10%" align="center"><strong>Nb de <%=sel.getVal()%> vers Entite </strong></td>
          <td width="20%" align="center">Entr&eacute;e - Sortie </td>
        </tr>

        <tr>
          <td  height="25" align="left"><div align="right">&nbsp;<strong>Total  :</strong></div></td>
          <td align="right"><%=Utilitaire.formaterAr(AdminGen.calculSommeDouble(rg,1))%></td>
          <td align="center"><div align="right"><%=AdminGen.calculSommeDouble(rg,2)%></div></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr(AdminGen.calculSommeDouble(rs,1))%></div></td>
          <td align="center"><%=AdminGen.calculSommeDouble(rs,2)%></td>
          <td align="center"><div align="right"><%=Utilitaire.formaterAr(AdminGen.calculSommeDouble(rg,1)-AdminGen.calculSommeDouble(rs,1))%></div></td>
        </tr>

      </table>
      <div align="center"><br>







        <strong><u>LISTE</u></strong>
      </div>      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="15%" height="19" align="center" valign="top">Entite</td>
          <td width="25%" align="center" valign="top">Mt de Entite vers <%=sel.getVal()%> </td>
          <td width="10%" align="right" valign="top"><div align="center">Nb de Entite vers <%=sel.getVal()%> </div></td>
          <td width="25%" align="right" valign="top"><div align="center">Mt de <%=sel.getVal()%> vers Entite </div></td>
          <td width="10%" align="center" valign="top" >Nb de <%=sel.getVal()%> vers Entite</td>
          <td width="20%" align="center" valign="top">Entr&eacute;e - Sortie </td>
        </tr>
        <%


         for(int i=0;i<mp.length;i++){
                  ResultatGroupe te=null;
                  ResultatGroupe ts=null;

                  te=(ResultatGroupe)Utilitaire.extraire(rg,0,mp[i].getVal());
                  ts=(ResultatGroupe)Utilitaire.extraire(rs,0,mp[i].getId());

                  if(te==null) te=new ResultatGroupe(mp[i].getVal(),0,0);
                  if(ts==null) ts=new ResultatGroupe(mp[i].getVal(),0,0);


  %>
        <tr>
          <td align="center"><!--DWLayoutEmptyCell--><%=te.getNomColonne()%></td>
          <td align="center"><!--DWLayoutEmptyCell-->
              <% if (te.getSomme()!=0) {%>
                <a href="<%=lien %>?but=finance/listeEntree.jsp&idType=trosa&caisse=<%=c[0].getDescCaisse() %>&idModePaiement=<%=mp[i].getVal() %>&dateDebut=<%=dateDebut %>&dateFin=<%=dateFin %>" ><%=Utilitaire.formaterAr(te.getSomme()) %> Ar</a>
              <% } else {%>
                     <%=Utilitaire.formaterAr(te.getSomme()) %> Ar
              <% } %>
          </td>
          <td align="right"><!--DWLayoutEmptyCell--><%=te.getNombre()%></td>
          <td align="right"><!--DWLayoutEmptyCell-->
 <% if (ts.getSomme()!=0) {%>
                <a href="<%=lien %>?but=finance/listeSortie.jsp&idType=TS018&caisse=<%=c[0].getIdCaisse() %>&idModePaiement=<%=mp[i].getId() %>&datyInf=<%=dateDebut %>&datySup=<%=dateFin %>" ><%=Utilitaire.formaterAr(ts.getSomme())%> Ar</a>
              <% } else {%>
                     <%=Utilitaire.formaterAr(ts.getSomme())%> Ar
              <% } %>
</td>
          <td align="right"><!--DWLayoutEmptyCell--><%=ts.getNombre()%></td>
		  <td align="right"><!--DWLayoutEmptyCell--><%=Utilitaire.formaterAr(te.getSomme()-ts.getSomme())%> Ar</td>
        </tr>
        <%
    }
  %>
      </table></td>
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
