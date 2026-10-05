        <?php
        session_start();

        $host = "localhost";
        $dbname = "urenregistratie";
        $username = "root";
        $password = "";

        $pdo = new PDO(
            "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
            $username,
            $password
        );

        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $gebruikers = $_SESSION['gebruiker_id'];
        $gebruiker = $_SESSION['gebruiker_id'];
        $pagina = $_GET['pagina'] ?? ($gebruiker === 'HR' ? 'homehr' : ($gebruiker === 'Facturisatie' ? 'homefacturisatie' : 'home'));        $zoeken = $_POST['zoeken'] ?? '';   
        $begindatum = $_POST['begindatum'] ?? '';
        $einddatum = $_POST['einddatum'] ?? '';        

$stmt = $pdo->query("
    SELECT project_id, project_naam 
    FROM projecten
    ORDER BY project_naam
");

$projecten = $stmt->fetchAll(PDO::FETCH_ASSOC);


if (($_POST['actie'] ?? '') === 'uitloggen') {
    session_destroy();
    header("Location: index.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['actie'] ?? '') === 'zoeken') {

    $zoeken = $_POST['zoeken'];

    $stmt = $pdo->prepare("
        SELECT 
            personen.gebruikersnaam,
            uren.project_id,
            uren.aantal_uren,
            uren.werkzaamheden,
            uren.datum
        FROM personen

        INNER JOIN uren 
        ON personen.id = uren.persoon_id

        WHERE personen.gebruikersnaam LIKE ?
        AND uren.datum BETWEEN ? AND ?"
        );

        $stmt->execute([
            "%$zoeken%",
            $begindatum,
            $einddatum
        ]);

    $resultaten = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
if (isset($_POST['registreren'])) {

    $gebruikersnaam = trim($_POST['gebruikersnaam']);
    $wachtwoord = trim($_POST['wachtwoord'], PASSWORD_DEFAULT);
    $gebruiker_id = trim($_POST['gebruiker_id']);

    try {
            $stmt = $pdo->prepare("
                INSERT INTO personen
                (gebruikersnaam, wachtwoord, gebruiker_id)
                VALUES (?, ?, ?)
            ");

            $stmt->execute([
                $gebruikersnaam,
                $wachtwoord,
                $gebruiker_id
            ]);

    } catch (PDOException $e) {

        echo "Registratie mislukt: " . $e->getMessage();

    }
}



        if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['actie'] ?? '') === 'opslaan') {

            if (
                !empty($_POST['project_id']) &&
                !empty($_POST['aantal_uren']) &&
                !empty($_POST['werkzaamheden']) &&
                !empty($_POST['datum'])
            ) {

                $stmt = $pdo->prepare("
                    INSERT INTO uren
                    (persoon_id, project_id, aantal_uren, werkzaamheden, datum)
                    VALUES (?, ?, ?, ?, ?)
                ");

                $stmt->execute([
                    $_SESSION['id'],
                    $_POST['project_id'],
                    $_POST['aantal_uren'],
                    $_POST['werkzaamheden'],
                    $_POST['datum']
                ]);
                
            }

        }
        ?>

    <!DOCTYPE html>
    <html lang="nl">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Urenregistratie</title>
        <link rel="stylesheet" href="style.css">
    </head>

    <body>
    <form method="POST">


    <?php if ($gebruiker === 'Facturisatie') { ?>
    <section class="menu">
               <section class="plaatje">
                <img src="Gilde devops logo (1).png" alt="Gilde devops">
    </section>
    <a href="?pagina=homefacturisatie">home</a>
    <a href="?pagina=projecten">Projecten</a>
    <a href="?pagina=dataophalenallepersonen">data alle medewerkes</a>
    </section>
    <?php } ?> 
      <?php if ($pagina === 'homefacturisatie') { ?>
    <section class="homekolom">
        <section class="hometekst">
            <h1>Home</h1>
        </section>
    </section>

    <section class="homekolom">
        <section class="hometekstkolom">
            <p>Registreer je project_id, gewerkte uren, werkzaamheden en datum. Houd overzicht over je werkzaamheden en besteed minder tijd aan administratie.</p>
        </section>
    </section>
        <section class="buttonuitloghome">
<button type="submit" class="knopuitlog" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        
    </section>

    <?php } ?>
    <?php if($pagina ==='dataophalenallepersonen') { 
$stmt = $pdo->query("
    SELECT * FROM personen
    INNER JOIN uren
    ON personen.id = uren.persoon_id
");

$personen = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<section class="dataophalenallepersonencentreer">
    <section class="dataophalenallepersonenbalk">
<table>
    <tr>
        <th>Gebruiker</th>
        <th>Project</th>
        <th>Uren</th>
        <th>Werkzaamheden</th>
        <th>Datum</th>
    </tr>

    <?php foreach ($personen as $persoon) { ?>
        <tr>
            <td><?= htmlspecialchars($persoon['gebruikersnaam']) ?></td>
            <td><?= htmlspecialchars($persoon['project_id']) ?></td>
            <td><?= htmlspecialchars($persoon['aantal_uren']) ?></td>
            <td><?= htmlspecialchars($persoon['werkzaamheden']) ?></td>
            <td><?= htmlspecialchars($persoon['datum']) ?></td>
        </tr>
    <?php } ?>

</table>
</section>
</section>
        <section class="buttonuitloghome">
<button type="submit" class="knopuitlog" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        
    </section>
    <?php } ?>
    <?php if ($gebruiker === 'HR') { ?>
    <section class="menu">
              <section class="plaatje">
                <img src="Gilde devops logo (1).png" alt="Gilde devops">
    </section>
    <a href="?pagina=homehr">home</a>
    <a href="?pagina=dataophalenperpersoon">data per persoon</a>   
    <a href="?pagina=accountaanmaken">account aanmaken</a>
    <a href="?pagina=projecten">Projecten</a>
    </section>
     
        <?php } ?>
     <?php if ($pagina === 'homehr') { ?>
    <section class="homekolom">
        <section class="hometekst">
            <h1>Home</h1>
        </section>
    </section>
    <section class="homekolom">
        <section class="hometekstkolom">
            <p>Je kan de data per persoon bekijken,account aanmaken en naar projecten gaan. Houd overzicht over je werkzaamheden en besteed minder tijd aan administratie.</p>
        </section>
    </section>
        <section class="buttonuitloghome">
<button type="submit" class="knopuitlog" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        
    </section>
<?php } ?>
  <?php if ($pagina === 'dataophalenperpersoon'){ ?>

<section class="centreerzoekbalkdataperpersoon">
<section class="zoekbalkdataperpersoon">

<p>naam</p>
<input type="text" name="zoeken" placeholder="zoeken">

<p>Begindatum</p>
<input type="date" name="begindatum">

<p>Einddatum</p>
<input type="date" name="einddatum">

<section class="zoekendataophalenperpersoon">       
<button type="submit" name="actie" value="zoeken">
    zoeken
</button>

<button type="submit" class="knopuitlogurenregistreren" name="actie" value="uitloggen" formnovalidate>
    uitloggen
</button>        

</section>
</section>
</section>


<?php if (!empty($resultaten)) { ?>

<section class="centreerresultatendataperpersoon">
<section class="resultatendataperpersoon">

<h2>resultaten</h2>

<table>
    <tr>
        <th>Persoon</th>
        <th>Project</th>
        <th>Uren</th>
        <th>Werkzaamheden</th>
        <th>Datum</th>
    </tr>

<?php 
$urentotaal = 0;

foreach ($resultaten as $rij) { 

    $urentotaal += $rij['aantal_uren'];

?>

<tr>
    <td><?= htmlspecialchars($rij['gebruikersnaam']) ?></td>
    <td><?= htmlspecialchars($rij['project_id']) ?></td>
    <td><?= htmlspecialchars($rij['aantal_uren']) ?></td>
    <td><?= htmlspecialchars($rij['werkzaamheden']) ?></td>
    <td><?= htmlspecialchars($rij['datum']) ?></td>
</tr>

<?php } ?>

</table>


<p>
    Totaal aantal gewerkte uren:
    <?= htmlspecialchars($urentotaal) ?>
</p>


</section>
</section>


<?php } elseif (isset($_POST['actie']) && $_POST['actie'] === 'zoeken') { ?>

<section class="geenresultatendataperpersoon">
    <p>Geen resultaten gevonden.</p>
</section>

<?php } ?>

<?php } ?>
<?php if ($pagina === 'accountaanmaken') { ?>
        <section class="accountaanmakencentreer">
        <section class="accountaanmakenbalk">
    <label for="gebruikersnaam">Naam</label>
    <input type="text" id="gebruikersnaam" name="gebruikersnaam" placeholder="gebruikersnaam" required>
<br><br>
    <label for="wachtwoord">Wachtwoord</label>
    <input type="password" id="wachtwoord" name="wachtwoord" placeholder="wachtwoord" required>
        <br><br>
    <label for="gebruiker_id">wat ben je?</label>
<select id="gebruiker_id" name="gebruiker_id" required>
    <option value="">Kies een rol</option>
    <option value="gebruiker">Gebruiker</option>
    <option value="HR">HR</option>
    <option value="Facturisatie">Facturisatie</option>
</select><br><br>
    <button type="submit" class="knopuitlogurenregistreren" name="registreren">Opslaan</button>'
    <button type="submit" class="knopuitlogurenregistreren" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        

        </section>




<?php } ?>

       
      
    <?php if ($gebruiker === 'gebruiker') { ?>
        <section class="menu">
               <section class="plaatje">
                <img src="Gilde devops logo (1).png" alt="Gilde devops">
    </section>
        <a href="?pagina=home">home</a>
        <a href="?pagina=urenregistreren">uren registreren</a>
        <a href="?pagina=projecten">Projecten</a>
        </section>
           <?php if ($pagina === 'home') { ?>
    <section class="homekolom">
        <section class="hometekst">
            <h1>Home</h1>
        </section>  
    </section>
    <section class="homekolom">
        <section class="hometekstkolom">
            <p>Registreer je project_id, gewerkte uren, werkzaamheden en datum. Houd overzicht over je werkzaamheden en besteed minder tijd aan administratie.</p>
        </section>
    </section>
        <section class="buttonuitloghome">
    <button type="submit" class="knopuitlog" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        
    </section>
<?php } ?>
        <?php if ($pagina === 'urenregistreren') {?>
        <section class="allesinlog">
        <section class="medewerker-urenkleuren">
        <section class="medewerker-urenregistratie">
            <h1>Urenregistratie</h1>

           <label for="project_id">Project</label>

<select name="project_id" id="project_id" required>

    <option value="">Kies een project</option>

    <?php foreach ($projecten as $project) { ?>
        <option value="<?= htmlspecialchars($project['project_id']) ?>">
            <?= htmlspecialchars($project['project_naam']) ?>
        </option>
    <?php } ?>
        </select>
            <br>

            <label>aantal_uren</label>
            <input type="number" name="aantal_uren" step="0.25" min="0"><br>

            <label>werkzaamheden</label>
            <input type="text" name="werkzaamheden"><br>

            <label>datum</label>
            <input type="date" name="datum"><br><br>

            <section class="opslaanuitlogbuttons">

                <button type="submit" class="knopopslaan" name="actie" value="opslaan">
                    opslaan
                </button>
                <button type="submit" class="knopuitlogurenregistreren" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        
            

            </section>
            </section>
            </section>

        <?php } ?>
        <?php } ?>
        <?php if ($pagina === 'projecten') { 
            $projecten = $pdo->query("SELECT project_id, project_naam, omschrijving, productowner FROM projecten");
            ?>
  <section class="allesprojectcentreer">
    <section class="allesproject">
    <table>
                <tr>
                    <th>project id</th>
                    <th>project naam</th>
                    <th>omschrijving</th>
                    <th>productowner</th>
                </tr>

                <?php foreach ($projecten as $project) { ?>
                    <tr>
                        <td><?= htmlspecialchars($project['project_id']) ?></td>
                        <td><?= $project['project_naam'] ?></td>
                        <td><?= $project['omschrijving'] ?></td>
                        <td><?= $project['productowner'] ?></td>
                    </tr>
                <?php } ?>
            </table>
                    
        </section>
        </section>

        <section class="buttonuitlogprojecten">
<button type="submit" class="knopuitlog" name="actie" value="uitloggen" formnovalidate>uitloggen</button>        
    </section>
        <?php } ?>
    </form>
    </body>
    </html>