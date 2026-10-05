<?php
session_start();

$pdo = new PDO(
    "mysql:host=localhost;dbname=urenregistratie;charset=utf8mb4",
    "root",
    ""
);

$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $gebruikersnaam = $_POST['gebruikersnaam'];
    $wachtwoord = $_POST['wachtwoord'];

    $stmt = $pdo->prepare("
        SELECT * FROM personen
        WHERE gebruikersnaam = ?
    ");

    $stmt->execute([$gebruikersnaam]);

    $gebruiker = $stmt->fetch(PDO::FETCH_ASSOC);


    if ($gebruiker && $gebruiker['wachtwoord'] === $wachtwoord) {

        $_SESSION['ingelogd_als'] = $gebruiker['gebruikersnaam'];
        $_SESSION['gebruiker_id'] = $gebruiker['gebruiker_id'];
        $_SESSION['id'] = $gebruiker['id'];   

        if ($gebruiker['gebruiker_id'] == 'gebruiker' || $gebruiker['gebruiker_id'] == 'HR' || $gebruiker['gebruiker_id'] == 'Facturisatie') {
        header("Location: index.sq.php");
        exit;
}
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Inloggen</title>
</head>

<body>

<form action="" method="POST">

    <section class="gildelogo">
        <img src="Gilde devops logo (1).png" alt="logo">
    </section>

    <section class="inloggen">
        <section class="inlogkleuren">

            <section class="inlog"> 
                <h1>Inloggen</h1>
            </section>

         

            <section class="gebruikersnaam">
                <input type="text" name="gebruikersnaam"placeholder="Gebruikersnaam"required>
            </section>

            <section class="wachtwoord">
                <input type="password" name="wachtwoord"placeholder="Wachtwoord"required>
            </section>

            <section class="versturen">
                <button type="submit" class="btn">Inloggen</button>
            </section>

        </section>
    </section>

</form>

</body>
</html>
