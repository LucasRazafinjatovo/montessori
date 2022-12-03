<%@ page import="user.*" %>

<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="paie.Demande_attache" %>
<%@ page import="affichage.*" %>
<%@ page import="paie.DefaultPaieUrl" %>
<%@ page import="java.sql.Connection" %>
<%@page import="java.util.Vector" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script type="text/javascript" src="../jquery-1.7.min.js"></script>
<script type="text/javascript" src="../spin.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
var opts = {
  lines: 13, // The number of lines to draw
  length: 20, // The length of each line
  width: 10, // The line thickness
  radius: 30, // The radius of the inner circle
  corners: 1, // Corner roundness (0..1)
  rotate: 0, // The rotation offset
  direction: 1, // 1: clockwise, -1: counterclockwise
  color: '#000', // #rgb or #rrggbb
  speed: 1, // Rounds per second
  trail: 60, // Afterglow percentage
  shadow: false, // Whether to render a shadow
  hwaccel: false, // Whether to use hardware acceleration
  className: 'spinner', // The CSS class to assign to the spinner
  zIndex: 2e9, // The z-index (defaults to 2000000000)
  top: 'auto', // Top position relative to parent in px
  left: 'auto' // Left position relative to parent in px
};
var target = document.getElementById('loading');
var spinner = new Spinner(opts).spin(target);
});
</script>

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div id="loading">Veuillez patienter s'il vous plaît...</div>
<%
  UserEJB u = null;
  String acte=null;
  String lien=null;
  String paiement="";
  String cheque="";
  String fiche="";
  String bute = "";
  String rajoutLie="";
  String urlAjax = "";
%>
<%
String ordrepaiement = request.getParameter("ordrepaiement");
double montantOP = new Double(request.getParameter("montant")).doubleValue();
Connection con = null;
  try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
  if(con==null)con = new UtilDB().GetConn();
  con.setAutoCommit(false);
  paiement=request.getParameter("attache_multiple");

  String[]rajoutLien=null;
    String val="";
  String tempRajout=request.getParameter("rajoutLien");
  if(tempRajout!=null&&tempRajout.compareToIgnoreCase("")!=0)
  {
    rajoutLien=Utilitaire.split(tempRajout,"-");
  }
  if(bute==null||bute.compareToIgnoreCase("")==0) bute="pub/Pub.jsp";

  String classe=request.getParameter("classe");
  ClassMAPTable t=null;
  if(classe==null||classe.compareToIgnoreCase("")==0) classe="pub.Montant";

  String tailleString = request.getParameter("taille_tableau").replace(',','.');
  int taille = new Double(tailleString).intValue();

  int getRealTaille = 0;
  String sendSolde = "";
  String orp = "";
  if(paiement!=null && paiement.compareToIgnoreCase("")!=0)
  {
    ded.OrdonnerPayement op = new ded.OrdonnerPayement();
    op.setNomTable("ordonnerpayement");
    op.setId(ordrepaiement);
    ded.OrdonnerPayement[] listeOp = (ded.OrdonnerPayement[])CGenUtil.rechercher(op,null,null,"");

    orp +="&id="+listeOp[0].getId()+"&ded_id="+listeOp[0].getDed_Id()+"&dateorp="+listeOp[0].getDaty()+"&montant="+listeOp[0].getMontant()+"&remarque="+listeOp[0].getRemarque();

    double sommeMontant  = 0;
    for(int i=0;i<taille;i++)
    {

      String id = request.getParameter("identifiant"+i);
      if(id!=null && id.compareToIgnoreCase("")!=0)
      {
        String employe = request.getParameter("employe"+i);
        String montant = request.getParameter("montant"+i);
        String date_saisie = request.getParameter("daty"+i);
        String motif = request.getParameter("motif"+i);

        java.sql.Date daty = new java.sql.Date(new Integer(date_saisie.substring(0,4)).intValue()-1900,new Integer(date_saisie.substring(5,7)).intValue()-1,new Integer(date_saisie.substring(8,10)).intValue());
        Demande_attache demande = new Demande_attache(ordrepaiement,id,employe,new Double(montant).doubleValue(),daty,motif);

        sommeMontant = sommeMontant + demande.getMontant();
        demande.construirePK(con);
        demande.insertToTable(con);
        sendSolde+="&iddemande"+getRealTaille+"="+id;
        getRealTaille++;
      }
    }
    if(sommeMontant!=montantOP)throw new Exception("La somme des montants de la solde n'est pas le meme que le montant de l'OP");
    con.commit();
  }
  %>
          <script type="text/javascript">
          $.ajax({
          url: '<%=DefaultPaieUrl.urlPaie%>/datademande?taille=<%=getRealTaille%><%=orp%><%=sendSolde%>',
          complete:function(data)
           {
           parent.window.opener.location.href = "<%=DefaultPaieUrl.urlRecette%>/modeleAdmin.jsp?but=ded/visualiserOP.jsp&id=<%=ordrepaiement%>";
              window.close();

           }
          });
          </script>
 <%
                      }
                      catch (Exception e){
                      e.printStackTrace();
                      con.rollback();
           %>

          <script type="text/javascript"> alert("<%=e.getMessage()%>");history.back(); </script>
                          <%
                            return;
                    }
                    finally
                    {
                      if(con!=null)con.close();
                    }
%>
</html>



