function validarFormulario() {
  var nombre, alias, rut, email;
  nombre = document.getElementById("nombre").value;
  alias = document.getElementById("alias").value;
  email = document.getElementById("email").value;
  rut = document.getElementById("rut").value;
  expresion = /\w+@\w+\.+[a-z]/;

  if (nombre === "") {
      alert("El campo Nombre y Apellido está vacío");
      return false;
  } else if (alias.length < 6 || !/^[A-Za-z0-9]+$/.test(alias)) {
      alert("El campo Alias debe contener al menos 6 caracteres alfanuméricos");
      return false;
  } else if (!expresion.test(email)) {
      alert("Ingresa un Email con el formato estándar example@example.com");
      return false; }
}

function validaRut(rut) {
  // Despejar Puntos
  var valor = rut.value.replace('.','');
  // Despejar Guión
  valor = valor.replace('-','');
  
  // Aislar Cuerpo y Dígito Verificador
  cuerpo = valor.slice(0,-1);
  dv = valor.slice(-1).toUpperCase();
  
  // Formatear RUN
  rut.value = cuerpo + '-'+ dv
  
  // Si no cumple con el mínimo ej. (n.nnn.nnn)
  if(cuerpo.length < 7) { rut.setCustomValidity("RUT Incompleto"); return false;}
  
  // Calcular Dígito Verificador
  suma = 0;
  multiplo = 2;
  
  // Para cada dígito del Cuerpo
  for(i=1;i<=cuerpo.length;i++) {
  
      // Obtener su Producto con el Múltiplo Correspondiente
      index = multiplo * valor.charAt(cuerpo.length - i);
      
      // Sumar al Contador General
      suma = suma + index;
      
      // Consolidar Múltiplo dentro del rango [2,7]
      if(multiplo < 7) { multiplo = multiplo + 1; } else { multiplo = 2; }

  }
  
  // Calcular Dígito Verificador en base al Módulo 11
  dvEsperado = 11 - (suma % 11);
  
  // Casos Especiales (0 y K)
  dv = (dv == 'K')?10:dv;
  dv = (dv == 0)?11:dv;
  
  // Validar que el Cuerpo coincide con su Dígito Verificador
  if(dvEsperado != dv) { rut.setCustomValidity("RUT Inválido"); return false; }
  
  // Si todo sale bien, eliminar errores (decretar que es válido)
  rut.setCustomValidity(''); // RUT válido

}
