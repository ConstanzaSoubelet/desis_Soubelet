
<?php 
// Conexión a la base de datos usando PDO
$conexion = new PDO("mysql:host=localhost;dbname=desis_soubelet", "root", "");

// Recuperar la región seleccionada desde la solicitud AJAX
$region = $_POST['region'];

// Consulta SQL para obtener las comunas de la región seleccionada
$consulta = "SELECT comunaid, nombre FROM comunas WHERE regionid = :region";
$statement = $conexion->prepare($consulta);
$statement->bindParam(':region', $region);
$statement->execute();

$cadena = "<label>Comuna</label> 
<select id='comuna' name='comuna' class='comuna'>"; // Utiliza el mismo nombre del select en tu HTML

while ($fila = $statement->fetch(PDO::FETCH_ASSOC)) {
    $cadena .= "<option value='" . $fila['comunaid'] . "'>" . utf8_encode($fila['nombre']) . "</option>";
}

echo $cadena . "</select>";
?>
