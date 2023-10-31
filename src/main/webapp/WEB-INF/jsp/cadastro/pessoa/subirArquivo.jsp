<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-subir-documento">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">SUBIR DOCUMENTO - ${dados.PARAMETROS.usuario}</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-incluir-usuario')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formDocumentos" id="pessoaDocumentos" name="pessoaDocumentos" action="${pageContext.request.contextPath}/documentosUpload" target="_blank" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-12 col-lg-12">
							<label for="documento"><b>Documento (RG/CPF):</b></label> 
							<input class="form-control" type="file" id="documento" name="documento" accept=".pdf">
						</div>
						<div class="col-12 col-sm-12 col-md-12 col-lg-12">
							<label for="foto"><b>Foto:</b></label> 
							<input class="form-control" type="file" id="foto" name="foto" accept="image/png, image/jpeg">
						</div>
						<input type="hidden" id="pessoa" name="pessoa" value="${dados.PARAMETROS.id}" />
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarDocumentos(${dados.PARAMETROS.id})">Salvar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
function salvarDocumentos(){
	//event.preventDefault();
    var form = $('#pessoaDocumentos')[0]
    var data = new FormData(form)

    $.ajax({
    	type: "POST",
        enctype: 'multipart/form-data',
        url: '${pageContext.request.contextPath}/documentosUpload',
        data: data,
        processData: false,
        contentType: false,
        cache: false
    }).always(function(data){
    	console.log(data)
		if(data.id == 0){
			$("#modal-subir-documento").modal('hide')
		}
    })
}
</script>
</body>