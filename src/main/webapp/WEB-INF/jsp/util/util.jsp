<script>

function paginaPrincipal(param){	
	$("#modal-primeiros-passos").modal("hide");
	 //window.location.href = CONTEXT + "/home"
	abrirPagina("/home", true, param, false)
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
			if(newPage){
           	  form.setAttribute('target', '_blank');
            }
		}
		document.body.appendChild(form);
	    form.submit();
	} 	
}

function fecharModal(id){
	$("#"+id).modal("hide");
}

function sair(){
	window.location.href = "/portariaQrCode/"
}

function esqueciSenha(){
	abrirPagina("/esqueciSenha", false, {}, true)
}
</script>