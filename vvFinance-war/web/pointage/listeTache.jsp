<%@ page import="user.*" %>
<%@ page import="pointage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.MapUtilisateur" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        String apres="pointage/listeTache.jsp";
        String lien= null;
		TypeObjet[] source=null;
        String datyinf = null,resp="",designation="",donneur="",etat;
         String datySup = null,direction=null,entite=null;

        UserEJB u = null;
        pointage.Tache[] fm=null;
                     int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
	lc.Direction dir[] = null;
        TacheVue[]listeTache=null;

%>
<%
           if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }
         datyinf = request.getParameter("datyInf");if ((datyinf==null)||datyinf.compareTo("")==0) datyinf="01/01/"+String.valueOf(Utilitaire.getAneeEnCours());
         datySup = request.getParameter("datySup");if ((datySup==null)||datySup.compareTo("")==0) datySup="31/12/"+String.valueOf(Utilitaire.getAneeEnCours());
         direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
		 entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
		 designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
		 resp=request.getParameter("resp");if ((resp==null)||resp.compareTo("")==0) resp="%";
		 donneur=request.getParameter("donneur");if ((donneur==null)||donneur.compareTo("")==0) donneur="%";
		 etat=request.getParameter("etat");if ((etat==null)||etat.compareTo("")==0) etat="tacheReste";
        %>
<%
try{

        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
        TypeObjet crt=new TypeObjet();
        crt.setNomTable("Beneficiaire");
        dir = u.findDirection("","","","","");
        source=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by val asc");
        TacheVue crtt = new TacheVue();
        crtt.setNomTable(etat);
        crtt.setDirection(direction);
        crtt.setEntite(entite);
        crtt.setDesignation(designation);
        //crtt.setResp(resp);
		MapUtilisateur ut = u.getUser();
		if(ut.isSuperUser() == true){
			listeTache = u.findTache(crtt,datyinf,datySup," order by datefin,urgence asc");
		}else{
			listeTache = u.findTache(crtt,datyinf,datySup," and upper(resp) = '"+ut.getRefuser()+"' order by datefin,urgence asc ");
		}
}catch(Exception e){
	e.printStackTrace();
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des T&acirc;ches</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les Pointages)</p>
<form action="<%=lien%>?but=pointage/listeTache.jsp" method="post" name="listePointage">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>



<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf" value="<%=datyinf%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin :</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=datySup%>">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">Entit&eacute; :</td>
            <td><select name="entite" class="champ" id="select">
              <option value="%">Tous</option>
              <%
for(int i=0;i<source.length;i++){
%>
              <option value="<%=source[i].getVal()%>" <%if(source[i].getVal().compareTo(entite)==0) out.println(" selected ");%>><%=source[i].getVal()%></option>
              <%
}
%>
            </select></td>
            <td class="left">Direction :</td>
            <td><select name="direction" class="champ" id="select2">
              <option value="%">Tous</option>
              <%
for(int i=0;i<dir.length;i++){
%>
              <option value="<%=dir[i].getLibelledir()%>" <%if(dir[i].getIdDir().compareTo(direction)==0) out.println(" selected ");%>><%=dir[i].getAbbrevDir()%></option>
              <%
}
%>
            </select></td>
          </tr>
          <tr>
            <td class="left">designation :</td>
            <td><input name="designation" type="text" class="champ" id="designation" value="<%=designation%>"></td>
            <td class="left">resp :</td>
            <td><input name="resp" type="text" class="champ" id="resp" value="<%=resp%>"></td>
          </tr>
          <tr>
            <td class="left">donneur :</td>
            <td><input name="donneur" type="text" class="champ" id="donneur" value="<%=donneur%>"></td>
            <td class="left">effectue</td>
            <td><select name="etat" class="champ" id="etat">
<option value="tachereste" <%if(etat.compareToIgnoreCase ("tachelibelle")==0) out.println(" selected ");%>>a faire</option>
<option value="tachelibelle"  <%if(etat.compareToIgnoreCase ("tachelibelle")==0) out.println(" selected ");%>>Tous</option>
              <option value="tachefini" <%if(etat.compareToIgnoreCase ("tachelibelle")==0) out.println(" selected ");%>>fini</option>

                                    </select></td>
          </tr>
        </table>



</td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center">
<input name="Annuler" type="reset" class="submit" value="Annuler">
            </td>
          </tr>
        </table>
        <div align="center"></div></td>
  </tr>
</table>
</form>

<div align="center"><strong><u>LISTE</u></strong>
</div>
<br>
  <br>
<br>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
          <tr class="head">
          <td width="8%" height="19" align="center">Id</td>
          <td width="12%" height="19" align="center">Direction</td>
          <td width="10%" align="center">Entite</td>
          <td width="8%" align="center">Date</td>
          <td align="center" width="50%">Designation</td>
          <td align="center" width="12%">Avancement</td>
        </tr>
<%
  for(int i=0;i<listeTache.length;i++){
    String couleurFond="";
    if((listeTache[i].getPoste().compareToIgnoreCase("tahina")==0)||(listeTache[i].getPoste().compareTo("-")==0))
      couleurFond="#B7B5B2";
%>

        <tr bgcolor='<%=couleurFond%>'>
          <td  height="25" align="center"><div align="center"><a title="dernier message = <%=listeTache[i].getDernmessage() %> depose par <%=listeTache[i].getPoste() %>" href="<%=lien%>?idTache=<%=listeTache[i].getTuppleID()%>&but=pointage/DetailTache.jsp"><%=listeTache[i].getTuppleID()%></a></div></td>
          <td  align="right">
            <div align="center"><%=listeTache[i].getDirection()%>&nbsp;</div></td>
          <td align="right"> <div align="center"><%=listeTache[i].getEntite()%> </div></td>
          <td align="center"><div align="center"><%=Utilitaire.formatterDaty(listeTache[i].getDaty())%></div></td>
          <td align="center"><div align="center"><%=listeTache[i].getDesignation()%> </div></td>
          <td align="center"><div align="center"><%=listeTache[i].getResp()%></div></td>
        </tr>
        <%
  }
  %>

        <tr>
          <td  height="2" align="center"></td>
          <td width="78" align="right"></td>
          <td width="80" align="center"></td>
          <td align="center" width="122"></td>
          <td align="center" width="129"></td>
          <td align="center" width="106"></td>
        </tr>
      </table>


    </td>
</tr>
</table><br>



<br>
<script language="javascript">
var cal1 = new calendar1(document.forms['listePointage'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listePointage'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
