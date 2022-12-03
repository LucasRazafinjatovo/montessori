	<link href="../style/style.css" rel="stylesheet" type="text/css">
	  <br>
	  <div align="center">&nbsp;<span class="ajouttitre">Pointage</span><br>
  <br>
</div>
<form action="apresPointage.jsp" method="post">
<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table border="0" cellpadding="3" cellspacing="0" align="center" class="monographe">
          <!--DWLayoutTable-->
          <tr>
          <td width="158" height="23" valign="top" class="left">Identifiant :</td>
            <td width="226" align="center" valign="top">&nbsp;
              <input name="identifiant" type="text" size="20" maxlength="50">
            </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Mot de passe :</td>
            <td align="center" valign="top">&nbsp;
              <input name="passe" type="password" size="20" maxlength="50">
            </td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Type :</td>
            <td align="center" valign="top">&nbsp;
              <select name="type">
        <option value="TP000001">Entrée Matin</option>
        <option value="TP000002">Sortie Matin</option>
        <option value="TP000003">Entrée Après-Midi</option>
        <option value="TP000004">Sortie Après-Midi</option>
            </select>
            </td>
        </tr>
<tr>
            <td class="left" height="23"> Agence :</td>

            <td align="center" valign="top"> <select name="agence" class="champ" id="agence">


                <option value="ag001">Ampefiloha</option>

                <option value="ag002">Ambatonakanga</option>

                <option value="ag003">Ambatomitsangana</option>

                <option value="ag004">Ankorondrano</option>

                <option value="ag005" selected="selected">Citic</option>

                <option value="ag006">Andoharanofotsy</option>

                <option value="ag007">Tsaralalàna</option>

              </select></td>
          </tr>
        <tr>
          <td height="23" valign="top" class="left">Observation :</td>
            <td align="center" valign="top">&nbsp;
              <textarea name="remarque" cols="20" rows="5"></textarea>
            </td>
        </tr>
      </table></td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
<input type="submit" name="Submit" value="Valider" class="submit">
          </td>
          <td align="center">
<input type="reset" name="Submit2" value="Restaurer" class="submit">
          </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</form>
<br>
<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
    <td> <span class="remarque">** Cette identification est obligatoire avant
      d'utiliser ce système. </span><br>
      <span class="succes">- Entrez votre identifiant et mot de passe. <br>
      - S'il y a un problème, verifiez d'abord votre saisie, sinon contactez votre
      administrateur.</span></td>
</tr>
</table>






























