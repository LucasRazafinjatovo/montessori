<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="crieur.*" %>
<script type='text/javascript'>
function getXhr(){
        var xhr = null;

        if (window.XMLHttpRequest || window.ActiveXObject) {
                if (window.ActiveXObject) {
                        try {
                                xhr = new ActiveXObject("Msxml2.XMLHTTP");
                        } catch(e) {
                                xhr = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                } else {
                        xhr = new XMLHttpRequest();
                }
        } else {
                alert("Votre navigateur ne supporte pas l'objet XMLHTTPRequest...");
                return null;
        }

        return xhr;
}
function request(oSelect) {
    var xhr   = getXhr();
    xhr.onreadystatechange = function() {
       if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
             readData(xhr.responseXML);
             document.getElementById("loader").style.display = "none";
       }
    };
    xhr.open("POST", "ajaxCrieur.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var value = oSelect.options[oSelect.selectedIndex].value;
    xhr.send("IdEditor=" + value);
}
function readData(oData) {
    var nodes   = oData.getElementsByTagName("item");
    var oSelect = document.getElementById("nom");
    var oOption, oInner;
    oSelect.innerHTML = "";
    var i=0;
    for(i=0;i<nodes.length;i++){
        oOption = document.createElement("option");
        oInner  = document.createTextNode(nodes[i].getAttribute("name"));
        oOption.value = nodes[i].getAttribute("id");

        oOption.appendChild(oInner);
        oSelect.appendChild(oOption);
    }
}
function checkVendeur(obj)
{
  $.ajax({
    url:'ajaxCrieur.jsp?IdEditor='+obj.value,
    success:function(data)
    {
      $("#nom").html(data);
    }
  });
}

function loadVendeur(req)
{
  $.ajax({
    url:'ajaxCrieur.jsp?IdEditor='+req,
    success:function(data)
    {
      $("#nom").html(data);
    }
  });
}

</script>
<%
RecettecLib rv=new RecettecLib();
String etat="RECETTECRIEURLIB";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
rv.setNomTable(etat);
String listeCrt[]={"grossiste","nom","place","province","numParution","daty","montant","journal","type"};
String listeInt[]={"daty","numParution","montant"};
String libEntete[]={"id","daty","nom","journal","numParution","daty","montant","type"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2,libEntete,8);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("crieur/listeRecette.jsp");
pr.getFormu().getChamp("grossiste").setAutre("onchange='checkVendeur(this)'");

affichage.Champ[] liste=new affichage.Champ[2];
Vendeur ve=new Vendeur();
ve.setNomTable("grossiste");
liste[0]=new Liste("grossiste",ve,"surnom","surnom");
Vendeur cr = new Vendeur();
cr.setNomTable("crieur");
liste[1]=new Liste("nom",cr,"surnom","surnom");
pr.getFormu().changerEnChamp(liste);
String colSomme[]={"montant"};

pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste des recettes</h1>
<form action="<%=pr.getLien()%>?but=crieur/listeRecette.jsp" method="post" name="rechercheVente" id="rechercheVente">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<!--etat : <select name="etat" class="champ" id="etat" >
              <option value="RecetteLibelleType">Tous</option>
              <option value="RecetteLibellenonfacture"  <%if(etat.compareTo("RecetteLibellenonfacture")==0) out.println("selected");%>>a facture</option>
            <option value="RecetteLibellefacture"  <%if(etat.compareTo("RecetteLibellefacture")==0) out.println("selected");%>> facture</option>
<option value="RecetteLibellePaye"  <%if(etat.compareTo("RecetteLibellePaye")==0) out.println("selected");%>> paye</option>
<option value="RecetteLibellenonpaye"  <%if(etat.compareTo("RecetteLibellenonpaye")==0) out.println("selected");%>> impaye</option>
</select>-->
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=crieur/ficheRecette.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>

