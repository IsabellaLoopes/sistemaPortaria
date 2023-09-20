<script>
function paginaPrincipal(){	
	$("#modal-primeiros-passos").modal("hide");
	 window.location.href = CONTEXT + "/home"
}

function abrirPagina(url, params = {}){				
	window.location.href = CONTEXT + url;
}

function abrirPagina(url, tipo=false, params={}, newPage=false){
	if ( url != null && url != "" ) {
		
		url = CONTEXT + url;
		let form = document.createElement("form");
		form.action = url;
		if(tipo){
			form.method = 'post';
			for (var i in params) {
	          if (params.hasOwnProperty(i)) {
	              var input = document.createElement('input');
	              input.type = 'hidden';
	              input.name = i;
	              input.value = params[i];
	              if(newPage){
	            	  form.setAttribute('target', '_blank');
	              }
	              form.appendChild(input);
	          }
	      	}
		} else {
			form.method = 'get';
		}
		document.body.appendChild(form);
	    form.submit();
	} 	
}
</script>