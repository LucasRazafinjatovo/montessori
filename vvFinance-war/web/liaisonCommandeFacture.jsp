<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*"%>
<%@ page import="facture.*"%>

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
  Utilitaire utilitaire=new Utilitaire();
  UserEJB u = null;
  String acte=null;
  String lien=null;
  String bute=null;
  String idcmd=null;
  String daty=null;
  String datylivraison=null;
  Tva tva = null;

  try
{
          lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          tva = u.loadTva(utilitaire.dateDuJour());
          idcmd=request.getParameter("idcmd");
          System.out.println("Ty ary le commande "+idcmd);
          Commande cd=new Commande();
          cd.setIdcmd(idcmd);
          Commande[] listeCmd=(Commande[])CGenUtil.rechercher(cd,null,null,"");
          DemandeDevis de=new DemandeDevis();
          de.setIdDevis(listeCmd[0].getIddevis());
          DemandeDevis[] listeDev=(DemandeDevis[])CGenUtil.rechercher(de,null,null,"");

          DemandeDevisRecto dem=new DemandeDevisRecto();
          dem.setIdDevis(listeCmd[0].getIddevis());
          DemandeDevisRecto[] listedem=(DemandeDevisRecto[])CGenUtil.rechercher(dem,null,null,"");

          Article art=new Article();
          art.setIdArticle(listeDev[0].getIdArticle());
          Article[] listeArt=(Article[])CGenUtil.rechercher(art,null,null,"");
          String punitaire=new String();
          if(listeDev[0].getIdCodeRV().compareToIgnoreCase("CODE1")==0){//recto
            punitaire=String.valueOf(listeArt[0].getPrixRecto());
          }
          else{
            punitaire=String.valueOf(listeArt[0].getPrixRectoVerso());
          }


          String taille=request.getParameter("taille");
          bute=request.getParameter("bute");
          daty=utilitaire.convertDatyFormtoRealDatyFormat(request.getParameter("daty"));

          datylivraison=utilitaire.convertDatyFormtoRealDatyFormat(request.getParameter("datylivraison"));
         // System.out.println("daty form "+daty+" daty livr form "+datylivraison);
          //public String createFactureMere(String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim, String respe, String entite, String parution)
          String idfactmere=u.createFactureMere(daty,daty,datylivraison,listeDev[0].getIdClient(),listeCmd[0].getRemarque(),String.valueOf(tva.getValTva()),"Ar","Ar","0","scat14","typ02","agb24","BE000060","");
         // public String createFactureFille(String idFactureMere, String refObj, String des, String qte, String unite, String pu, String reductionF)
          u.createFactureFille(idfactmere,"scat14",listedem[0].getArticle(),String.valueOf(listedem[0].getNombreImpression()),"unt5",punitaire,"0");
          //public String finaliseFactureUpdate(String idFact, String daty, String periodeDebut, String periodeFin, String idClient, String noteExplicative, String idTva, String idFactureEn, String idDeviseEn, String reduction, String idSCatService, String idTypePaim)
          String idfact=u.finaliseFactureUpdate(idfactmere,daty,daty,datylivraison,listeDev[0].getIdClient(),listeCmd[0].getRemarque(),String.valueOf(tva.getValTva()),"Ar","Ar","0","scat14","typ02");
%>
           <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>"); </script>
                    <%

                      }catch (Exception e){
                      e.printStackTrace();
           %>

          <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
                          <%
                            return;
                    }
                          %>

</html>
