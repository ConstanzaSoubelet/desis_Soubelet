$(document).ready(function () {
    $('#region').val(1);
    recargarLista();

    $('#region').change(function () {
        recargarLista();
    });
})

function recargarLista() {
    $.ajax({
        type: "POST",
        url: "conexion_regionComuna.php",
        data: "region=" + $('#region').val(),
        success: function (r) {
            $('#comuna').html(r);
        }
    });
}
