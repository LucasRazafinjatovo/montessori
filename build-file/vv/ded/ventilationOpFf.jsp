<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="lc/apresChoixListeLC.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
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
        String typeLigne[] = {"Recette","Dépense"};
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
                String chemin=null;String idDED=null;

             int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
           OrdonnerPayement[] op = null;

%>
<%
  nomCol=Utilitaire.getNomColonne(new LigneCredit());
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
	idDED=request.getParameter("idDED");
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
        op=((OrdonnerPayement[])u.findOpPage("ordonnerPayement", numObjet, "%", "%", "","","","","%",1).getResultat());
        if(op.length==0)throw new Exception("Ordonner recette non existante");
        source = u.findTypeObjet("Beneficiaire","%","%");
        tlc = u.findTypeObjet("TypeSortieliste","%","%");
        compte = u.findTypeObjet("comptecompta","%","%");
        dir = u.findDirection("","","","","");
        UnionIntraTableUtil uit=new UnionIntraTableUtil();
        uit.setNomTable("OpFFlcLettre");
        lcc=(UnionIntraTable[])uit.rechercher(2,numObjet);
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
<!--
 function getChoix(){
  setTimeout("document.frmListe.submit()",800);
}
//-->
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
<form action="<%=lien%>?but=ded/updateVentilationOpFf.jsp" method="POST" name="frmListe" id="frmListe">
  <p align="center"><strong><u>LISTE SELECTION </u></strong></p>
  <p align="center"><u><strong><a href=<%=lien%>?but=ded/visualiserOP.jsp&idOP=<%=numObjet%>>Voir d&eacute;tails op num <%=numObjet%></a></strong></u></p>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
    <!--DWLayoutTable-->
    <tr class="head">
<td width="25%" valign="top"><div align="center">id</div></td>
      <td width="25%" valign="top"><div align="center">id jointure FF LC</div></td>

      <td width="7%" valign="top"><div align="center"><strong>Montant</strong></div></td>
    </tr>
    <%
  for(int i=0;i<lcc.length;i++){
  %>
    <tr>
    <td align="left" valign="top"><div align="center"><%=lcc[i].getRemarque() %></div></td>
     <td align="left" valign="top"><div align="center"><a href=<%=lien%>?but=lc/visualiserUnionIntra.jsp&nomTable=FactureFournisseurLc&refDet=<%=lcc[i].getId2()%>><%=lcc[i].getId2()%></a></div></td>

  <input name="idLC<%=i%>" type="hidden" class="champ" value=<%=lcc[i].getId2()%>>
      <td align="right" valign="top"><div align="center">
  <%
  if((lcc[i].getMontantMere()==0)&&(lcc.length==1))
  {
  %>
          <input name="montant<%=i%>" type="text" class="champ" value=<%=op[0].getMontant()%>>
  <%}
  else
{
%>
        <input name="montant<%=i%>" type="text" class="champ" value=<%=lcc[i].getMontantMere() %>>
  <%}%>

      </div></td>
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
    <input type="hidden" name="montantObjet" value="<%=op[0].getMontant()%>">
    <input type="hidden" name="typeObjet" value="<%=typeObjet%>">
    <input name="submit" type="submit" value="valider" onClick="acte.value='svalide'">
  <input name="calculer" type="button" value="calculer" onClick='calculere(<%=lcc.length%>)'>
  <input name="total" type="text" value="0">
  </div>
</form>
<h1>&nbsp;</h1>
<h1>
  <script language="JavaScript">
  <!--
//-->
 function getChoix(){
                document.forms["frmChoix"].submit();
}
  </script>
</h1>
