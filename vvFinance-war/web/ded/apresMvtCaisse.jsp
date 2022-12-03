<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.*" %>
<%@ page import="utilitaire.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
                UserEJB u = null;
                String acte=null;
                String id=null;
                String lien=null;
                finance.Entree entree = null;
                String rep = null;
                int retour = 0;
                String idEntree=null;
                String numFact=null;
                String typa=null;
                String nomClient=null;
                String nature=null;

                String numObjet=null;
                String typeObjet = null;
                String mvt=null;
                OrdonnerPayement[] op = null;
                String mvmax = null;
                String[] g = null;
                String idmvtor = null;
%>
<%
                acte=request.getParameter("acte");
                out.println("acte = "+acte);

                try
                {
                        lien =(String)session.getValue("lien");
                        u =(UserEJB)session.getAttribute("u");
                        nature=request.getParameter("nature");
                        numObjet=request.getParameter("numObjet");
                        typeObjet = request.getParameter("typeObjet");
                        mvmax=u.getMaxId("mvtcaisse");
                        g=Utilitaire.split(mvmax,"MVT");
                        idmvtor="SMOR"+g[0]+1;

                        if (acte.compareTo("INSERT")==0)
                        {
                                if(typeObjet.compareTo(Constante.getObjetOp())==0){
                                  mvt=u.createMvtCaisseDepense(request.getParameter("daty"),"",request.getParameter("designation"), request.getParameter("debit"), request.getParameter("debitinitial"),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),request.getParameter("typeMvt"), request.getParameter("numObjet"),idmvtor);
                                  String benef=request.getParameter("beneficiaire");if(benef.compareTo("")==0) benef="benef1";
                                  String etatpiece=request.getParameter("etatpiece");
                                  u.assocOPMvtCaisse(request.getParameter("numObjet"),mvt,benef,etatpiece);
                                  //System.out.print("typeObjet:"+idmvtor+":Constante.getObjetOp():"+mvt+"numObjet:"+numObjet);

                                  u.saveMvtOr(idmvtor,mvt,numObjet);

                                } else {
                                        String mode = request.getParameter("idMode");
                                        String idEtablissement = request.getParameter("etablissement");
                                        String numeroCheque = request.getParameter("numPiece");
                                        if(!"pay2".equalsIgnoreCase(mode)){
                                                numeroCheque = "-";
                                                idEtablissement = "-";
                                        }

                                    String[] numObjets = Utilitaire.split(numObjet,"<br/>");
                                    OrdonnerPayement o = new OrdonnerPayement();
                                    o.setNomTable("orapayer");
                                    String retour=null;
                                    String[] lmvt=new String[numObjets.length];
                                    int k=0;
                                    for(int j=0;j< numObjets.length;j++){
                                      OrdonnerPayement[] lop=(OrdonnerPayement[])CGenUtil.rechercher(o,null,null," and id='"+numObjets[j]+"'");
                                      retour = u.createMvtCaisseRecette(request.getParameter("daty"),"",request.getParameter("designation"), ""+lop[0].getMontant(),request.getParameter("idDevise"), request.getParameter("idMode"),request.getParameter("idCaisse"),request.getParameter("remarque"),request.getParameter("agence"), request.getParameter("tiers"), request.getParameter("numPiece"),request.getParameter("typeMvt"), numObjets[j], numeroCheque, idEtablissement,idmvtor);
                                      lmvt[k]=retour;k++;
                                    }
                                    u.saveMvtOr(idmvtor,lmvt[0],numObjet);

                             }
                                //out.println("daty sdf"+request.getParameter("dateemission"));
                        }

%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=finance/listeMvtCaisseSansLc.jsp");</script>
<%

        }catch (Exception e){
                        e.printStackTrace();
 %>
        <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
<%
                        return;
                }
%>
        <head>
                <title>Document sans titre</title>
                <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        </head>

        <body>
                <table width="425" border="0" cellspacing="0">
                  <tr>
                        <td><div align="justify"></div></td>
                  </tr>
                </table>
        </body>
</html>