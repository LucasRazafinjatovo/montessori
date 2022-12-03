<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Date"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.*" %>
<%@ page import="lc.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="ded.OrdonnerPayement" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String id = null;
        String lien = null;
        finance.Entree entree = null;
        String rep = null;
        int retour = 0;
        String idEntree = null;
        String numFact = null;
        String typa = null;
        String nomClient = null;
        String nature = null;
        String typeOp = null;
        FactureFournisseur ff = null;
        String lc = "";
        String [] idop;
        String [] date_decaler;

    %>
    <%
        out.println("apres facture");
        acte = request.getParameter("acte");
        idop=request.getParameterValues("idop");
           date_decaler=request.getParameterValues("date_decaler");
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            nature = request.getParameter("nature");
            typeOp = request.getParameter("typeOp");
            if (typeOp == null) {
                typeOp = "facture";
            }
            lc = request.getParameter("lc");
            if (acte.compareToIgnoreCase("attacherorprev") == 0) {
                String idor = (String) session.getValue("oraattacher");
                String[] listor = {idor};
                String[] idprev = request.getParameterValues("id");
                session.removeAttribute("oraattacher");
                String res = "";
                for (int i = 0; i < idprev.length; i++) {
                    res = u.attcherOrRCPrev(idprev[i], listor);
                }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOR.jsp&idOP=<%=idor%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("insertavecprev") == 0) {
            ff = u.createOrSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("resp"), request.getParameter("remarque"));
            String[] listor = {ff.getRemarque()};
            String res = u.attcherOrRCPrev(request.getParameter("idprev"), listor);
            if (res.compareToIgnoreCase("yes") == 0) {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOrFcLc.jsp&numObjet=<%=ff.getRemarque()%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=ff.getMontantTTC()%>&avecOp=<%=ff.getRemarque()%>&typeor=<%=request.getParameter("typeor")%>");</script>
    <%
    } else {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=res%>");</script>
    <%
            }
        }
        if (acte.compareToIgnoreCase("rcpub") == 0) {

            String idmontant = request.getParameter("listepub");
            session.removeAttribute("listeannonce");
            String idor = request.getParameter("idor");
            String montant = request.getParameter("montant");
            String[] temp = Utilitaire.split(idmontant, ",");
            u.updateORFacture(idor, montant);
            u.attacherORPUB(temp, idor);
            UnionIntraTableUtil uit = new UnionIntraTableUtil();
            uit.setNomTable("OrFclc");
            UnionIntraTable[] lcc = (UnionIntraTable[]) uit.rechercher(2, idor);
            u.devaliderUnionIntraTable(lcc, "OrFclc");
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOrFcLc.jsp&numObjet=<%=idor%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=montant%>&avecOp=<%=idor%>&direction=<%=request.getParameter("direction")%>");</script>
    <%
        }

        if (acte.compareToIgnoreCase("dupliquer") == 0) {
            int n_dupl = Integer.parseInt(request.getParameter("nbPR"));
            String numObjet = request.getParameter("numObjet");
            String[] montantTab = new String[n_dupl];

            String[] lmois = new String[n_dupl];
            String[] lannee = new String[n_dupl];
            String[] ldate = new String[n_dupl];
            for (int i = 0; i < n_dupl; i++) {
                lmois[i] = request.getParameter("mois" + i);
                lannee[i] = request.getParameter("annee" + i);
                ldate[i] = request.getParameter("date" + i);
                montantTab[i] = request.getParameter("montant" + i);
            }

            u.dupliquerOR(numObjet, montantTab, n_dupl, lmois, lannee, ldate);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/listeOR_o.jsp&premier=true");
    </script>
    <%}
        if (acte.compareTo("INSERT") == 0) {
            if (typeOp.compareToIgnoreCase(Constante.typeOpFacture) == 0) {
                rep = u.creerOR(request.getParameter("daty"), request.getParameter("idDed"), request.getParameter("montantTTC"), request.getParameter("remarque"));

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOrFcLc.jsp&numObjet=<%=rep%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=request.getParameter("montantTTC")%>&avecOp=<%=rep%>&direction=<%=request.getParameter("direction")%>");</script>
    <%
        }
        if (typeOp.compareToIgnoreCase(Constante.typeOpNormale) == 0) {
            ff = u.createOrSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("resp"), request.getParameter("remarque"));
            if ((lc != null) && lc.startsWith("LC")) {
                String[] idLcArecup = {lc};
                String[] montantTab = {request.getParameter("montantTTC")};
                u.mapperOrFactureClientLCTableau(ff.getRemarque(), idLcArecup, "facture or auto", montantTab);
            }
            if (request.getParameter("typeor").compareToIgnoreCase("dist") == 0) {
                String nbrechoix = request.getParameter("nbrechoix");
                String listerecette = request.getParameter("listerecette");
                int nb = Utilitaire.stringToInt(nbrechoix);

                String[] g = Utilitaire.split(listerecette, ",");
                RecetteLibelleType p = new RecetteLibelleType();
                p.setNomTable("RecetteLibellenonfacture");
                System.out.println(" ====== lenth ======= " + g.length + " : " + listerecette);
                u.insertMereFille("venteFacture", g, ff.getIdFactureFournisseur(), "-", "", "0");
                /*for (int i = 0; i < g.length; i++) {
                    u.insertMereFille("venteFacture", g[i], ff.getIdFactureFournisseur(), "-", "", "0");
                }*/
            }
            if (request.getParameter("rcpub") != null && request.getParameter("rcpub").compareToIgnoreCase("rcpub") == 0) {
                String idmontant = (String) session.getValue("pub");
                String[] temp = Utilitaire.split(idmontant, ",");
                u.attacherORPUB(temp, ff.getIdFactureFournisseur());
                session.removeAttribute("pub");
            }


    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOrFcLc.jsp&numObjet=<%=ff.getRemarque()%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=ff.getMontantTTC()%>&avecOp=<%=ff.getRemarque()%>&typeor=<%=request.getParameter("typeor")%>");</script>
    <%
            }
        }
        if (acte.compareToIgnoreCase("attacherORRecette") == 0) {
            u.attacherRecetteFacture((String) session.getAttribute("idt"), request.getParameter("idor"), request.getParameter("montant"), request.getParameter("daty"));
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ventilationOrFcLc.jsp&numObjet=<%=request.getParameter("idor")%>&typeObjet=<%=Constante.getObjetFactureF()%>&montantObjet=<%=request.getParameter("montant")%>&typeor=<%=request.getParameter("typeor")%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("autre") == 0) {
            ff = u.createOrSimple(request.getParameter("daty"), request.getParameter("montantTTC"), request.getParameter("tva"), request.getParameter("fournisseur"), request.getParameter("idDevise"), request.getParameter("resp"), request.getParameter("remarque"));
            if ((lc != null) && lc.startsWith("LC")) {
                String[] idLcArecup = {lc};
                String[] montantTab = {request.getParameter("montantTTC")};
                u.mapperOrFactureClientLCTableau(ff.getRemarque(), idLcArecup, "facture or auto", montantTab);
            }
            OrdonnerPayement op = ((OrdonnerPayement[]) u.findOpPage("ordonnerRecetteLibelle", ff.getIdFactureFournisseur(), "%", "%", "", "", "", "", "%", 1).getResultat())[0];
            u.viserOr(request.getParameter("daty"), request.getParameter("remarque"), op.getId());
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/visualiserOR.jsp&idOP=<%=op.getId()%>");</script>
    <%
        }
        if(acte.compareTo("ANNULATIONORRESTE") == 0){
               String[] idop = request.getParameterValues("checkIdOP");
               if(idop.length == 0){
                    throw new Exception("Veuillez choisir au moins un element");
                }
                HashMap<String,String> remarque = new HashMap<String,String>();
               for(int i = 0; i < idop.length; i++){
                    String rmq = (request.getParameter("remarque_"+idop[i]) != null && !request.getParameter("remarque_"+idop[i]).isEmpty()) ?request.getParameter("remarque_"+idop[i]) : "Aucune" ;
                    remarque.put(idop[i],rmq );
               }
               u.annulerORReste(idop, remarque);%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/ordonnerrecettereste-annuler.jsp");</script>
                
       <% }
        if (acte.compareTo("decaler")==0)
          {
              u.decalerOR(idop, date_decaler);
               %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=ded/or_a_decaler.jsp");</script>
    <%
          }
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>");</script>
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
                <td><div align="justify"></div>
                </td>
            </tr>
        </table>
    </body>
</html>




