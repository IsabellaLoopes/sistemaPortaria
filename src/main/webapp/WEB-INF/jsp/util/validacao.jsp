<script>
function validar(id){
	let valida = 0;
	$(id+" .validar").each(function(){
	    $(this).val()
	    let element = $(id + " #"+this.id);
	    
	    if($(this).val() == '' || $(this).val() == null || $(this).val() == 0 || $(this).val() == undefined || $(this).val() == []){
			$(this).addClass("border-danger")
			if(element != '' && element != undefined && element != null){
				$(element).addClass("border-danger")
			}
			valida += 1;
		}

	})
	
	if(valida > 0){
		Swal.fire({
			  title: 'Preencha os campos!',
			  text: 'Informe os campos obrigatórios que estão em vermelho!',
			  icon: 'error',
			  confirmButtonText: 'Ok'
			});
		return false;
	} 
	else{
		return true;
	}
}
</script>