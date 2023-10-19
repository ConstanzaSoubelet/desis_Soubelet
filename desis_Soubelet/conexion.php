<?php
try {
    $conexion = new PDO("mysql:host=localhost;dbname=desis_soubelet", "root", "");

    $nombre = $_POST['nombre'];
    $alias = $_POST['alias'];
    $rut = $_POST['rut'];
    $email = $_POST['email'];
    $region = $_POST['region'];
    $comuna = $_POST['comuna'];
    $candidato = $_POST['candidato'];
    $seleccion = implode(', ', $_POST['seleccion']); // Convierte las selecciones en una cadena

    $conexion->beginTransaction();

    $sql = "SELECT COUNT(*) FROM usuarios WHERE rut = :rut";
    $statement = $conexion->prepare($sql);
    $statement->bindParam(':rut', $rut);
    $statement->execute();
    $numero_votos = $statement->fetchColumn();

    if ($numero_votos > 0) {
        echo "Usted ya ha votado anteriormente.";
        exit();
    }

    $sql = "INSERT INTO usuarios (nombre_completo, alias, rut, email, regionid, comunaid, candidatoid, seleccion) VALUES (:nombre, :alias, :rut, :email, :region, :comuna, :candidato, :seleccion)";
    $statement = $conexion->prepare($sql);
    $statement->bindParam(':nombre', $nombre);
    $statement->bindParam(':alias', $alias);
    $statement->bindParam(':rut', $rut);
    $statement->bindParam(':email', $email);
    $statement->bindParam(':region', $region);
    $statement->bindParam(':comuna', $comuna);
    $statement->bindParam(':candidato', $candidato);
    $statement->bindParam(':seleccion', $seleccion);
    $statement->execute();

    echo "DATOS INSERTADOS CORRECTAMENTE";

    $conexion->commit();
} catch (PDOException $e) {
    $conexion->rollBack();
    echo "Error en la base de datos: " . $e->getMessage();
} finally {
    $conexion = null;
}
?>
