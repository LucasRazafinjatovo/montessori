<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="lc.Direction" %>
<%@ page import="java.net.InetAddress" %>
<%!
  UserEJB u=null;
  String username=null;
  String pwd=null;
  historique.MapUtilisateur ut=null;
  String lien;
  String ip=null;
  String host=null;
  String mot_vide="";
  String mot_avec_espace="mot espace";
  String mot="mot";
  String mot_null=null;

%>

<%
  try
{

  username=request.getParameter("identifiant");
  pwd=request.getParameter("passe");

  u=UserEJBClient.getInterface();
  u.testLogin(username,pwd);

  session.setAttribute("u", u);
  ut=u.getUser();
  Direction crd=new Direction();
  crd.setIdDir(ut.getAdruser());
  Direction[] ret=(Direction[])(CGenUtil.rechercher(crd,null,null,""));
  if(ret.length>0)
  {
    session.setAttribute("dirlib",ret[0].getLibelledir());
    u.setIdDirection(ret[0].getLibelledir());
  }
  if(ut.isSuperUser()==true)
  {
    session.setAttribute("dir","%");
    session.setAttribute("dirlib","");
    lien="modeleAdmin.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
  }
  //lien="modele"+ut.getIdrole()+ut.getAdruser()+".jsp";
  //session.setAttribute("lien", lien);
  else if(ut.getIdrole().compareTo("directeur")==0)
  {
    lien="modeleDir.jsp";
    session.setAttribute("lien", lien);
    session.setAttribute("dir",ut.getAdruser());
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
  }
  else
  {
	System.out.println(ut.getAdruser()+" =============== ");
    session.setAttribute("dir","%");
    session.setAttribute("dirlib","");
    if(ut.getIdrole().compareTo("adminCompta")==0)
    {
      lien="modeleAdminCompta.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getAdruser().compareTo("9")==0)
    {
      lien="modeleSpeed.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("adminFacture")==0)
    {
      lien="modeleAdminFacture.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	
    if(ut.getIdrole().compareTo("assistante")==0)
   {
     lien="modeleAssist.jsp";
     session.setAttribute("lien", lien);
     out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("paie")==0)
   {
     lien="modeleCaisse.jsp";
     session.setAttribute("lien", lien);
     out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("visa")==0)
   {
     lien="modeleVisa.jsp";
     session.setAttribute("lien", lien);
     out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("redcaisse")==0)
    {
    lien="modeleControleCaisse.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("virement")==0)
    {
      lien="modeleControleVirement.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("budget")==0)
    {
      lien="modeleBudget.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("controlegazety")==0)
    {
      lien="modeleControleGazety.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("assistpub")==0)
    {
      lien="modelePub.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("admin")==0)
    {
      lien="modeleAdmin.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }

    if(ut.getIdrole().compareTo("facture")==0)
    {
      lien="modeleFacture.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }

    if(ut.getIdrole().compareTo("compta")==0)
    {
      lien="modeleCompta.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("saisiedist")==0)
    {
      lien="modelesaisie.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("cadredist")==0)
    {
      lien="modeleCadreDist.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("dirdist")==0)
   {
     lien="modeleDirDist.jsp";
     session.setAttribute("lien", lien);
     out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("saisiecom")==0)
   {
     lien="modeleSaisieCom.jsp";
     session.setAttribute("lien", lien);
     out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
   if(ut.getIdrole().compareTo("commercial")==0)
  {
    lien="modeleCommercial.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("dircom")==0)
  {
    lien="modeleDirCom.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }

    if(ut.getIdrole().compareTo("saisiestock")==0)
  {
    lien="modeleSaisieStock.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("drl")==0)
  {
    lien="modeleDrl.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("saisiepp")==0)
  {
    lien="modeleSaisiePp.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("dirpp")==0)
  {
    lien="modeleDirPp.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("saisiedep")==0)
  {
    lien="modeleSaisieDep.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("visadep")==0)
  {
    lien="modeleVisaDep.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("controlepp")==0)
  {
    lien="modeleControlePp.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("controledist")==0)
  {
    lien="modeleControleDist.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("reddist")==0)
  {
    lien="modeleControleDdist.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("redpub")==0)
  {
    lien="modeleControlePub.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("finance")==0)
  {
    lien="modeleFinance.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("caisse")==0)
  {
    lien="modeleCaisse.jsp";
    session.setAttribute("lien", lien);
    out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("controle")==0)
    {
      lien="modeleControle.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("pilotage")==0)
    {
      lien="modeleControle.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("saisie")==0&&(ut.getAdruser().compareToIgnoreCase("DIR000001"))==0)
    {
      lien="modelesaisieDIR000001.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("pointage")==0)
    {
      lien="modelePointage.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=pointage/pointage.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("saisie")==0)
    {
      lien="modelesaisie.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("assistCom")==0)
    {
      lien="modeleCommercial.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("controlPub")==0)
    {
      lien="modeleControlePub.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    if(ut.getIdrole().compareTo("assistDist")==0)
    {
      lien="modeleDist.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
	if(ut.getIdrole().compareTo("saisieclient")==0)
    {
      lien="modeleClient.jsp";
      session.setAttribute("lien", lien);
      out.println("<script language='JavaScript'> document.location.replace('"+lien+"?but=etudiant/listeEtudiant.jsp'); </script>");
    }
    else
    {
      throw new Exception("Tena nisy blem");
    }
  }

}catch (Exception e){

  e.printStackTrace();
  %>
    <script language="JavaScript">
      alert("Login ou mot de passe erroné");
  document.location.replace("modele.jsp?but=index.jsp");
    </script>
    <%
      return;
}
 %>


